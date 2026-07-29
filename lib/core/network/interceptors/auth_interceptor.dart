import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication interceptor with token refresh support
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Dio? dio; // For token refresh calls
  bool _isRefreshing = false;

  AuthInterceptor({
    required this.secureStorage,
    this.dio,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await secureStorage.read(key: 'auth_token');
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      debugPrint('Error reading token: $e');
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - attempt token refresh
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await secureStorage.read(key: 'refresh_token');
        
        if (refreshToken != null && dio != null && !_isRefreshing) {
          _isRefreshing = true;

          try {
            // Attempt to refresh token
            final response = await dio!.post(
              'auth/refresh-token',
              data: {'refreshToken': refreshToken},
            );

            // Save new tokens
            final newToken = response.data['token'];
            final newRefreshToken = response.data['refreshToken'];

            await secureStorage.write(key: 'auth_token', value: newToken);
            await secureStorage.write(
              key: 'refresh_token',
              value: newRefreshToken,
            );

            // Retry original request with new token
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            
            _isRefreshing = false;

            // Retry original request
            return handler.resolve(
              await dio!.request(
                err.requestOptions.path,
                options: Options(
                  method: err.requestOptions.method,
                  headers: err.requestOptions.headers,
                ),
                data: err.requestOptions.data,
                queryParameters: err.requestOptions.queryParameters,
              ),
            );
          } on DioException catch (refreshErr) {
            // Token refresh failed
            _isRefreshing = false;
            
            // Clear tokens and force logout
            await secureStorage.delete(key: 'auth_token');
            await secureStorage.delete(key: 'refresh_token');
            
            debugPrint('Token refresh failed: ${refreshErr.message}');
            return handler.next(err);
          }
        } else {
          // No refresh token or already refreshing, clear stored token
          if (!_isRefreshing) {
            await secureStorage.delete(key: 'auth_token');
            await secureStorage.delete(key: 'refresh_token');
          }
          debugPrint('No refresh token available or already refreshing');
        }
      } catch (e) {
        debugPrint('Error handling 401: $e');
      }
    }
    return handler.next(err);
  }
}
