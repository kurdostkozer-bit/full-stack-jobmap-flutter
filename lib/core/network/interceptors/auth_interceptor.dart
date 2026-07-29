import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Authentication interceptor with token refresh support
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;
  final Dio? dio; // For token refresh calls
  bool _isRefreshing = false;
  final List<RequestInterceptorHandler> _requestQueue = [];

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
      print('Error reading token: $e');
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
        
        if (refreshToken != null && dio != null) {
          // Prevent multiple refresh attempts
          if (_isRefreshing) {
            _requestQueue.add(handler);
            return;
          }

          _isRefreshing = true;

          try {
            // Attempt to refresh token
            final response = await dio!.post(
              '/auth/refresh-token',
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
            
            // Process queued requests
            for (var h in _requestQueue) {
              h.next(err.requestOptions);
            }
            _requestQueue.clear();

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
            _requestQueue.clear();
            
            // Clear tokens and force logout
            await secureStorage.delete(key: 'auth_token');
            await secureStorage.delete(key: 'refresh_token');
            
            print('Token refresh failed: ${refreshErr.message}');
            return handler.next(err);
          }
        } else {
          // No refresh token, clear stored token
          await secureStorage.delete(key: 'auth_token');
          await secureStorage.delete(key: 'refresh_token');
          print('No refresh token available');
        }
      } catch (e) {
        print('Error handling 401: $e');
      }
    }
    return handler.next(err);
  }
}
