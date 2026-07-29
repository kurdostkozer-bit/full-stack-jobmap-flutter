import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logging interceptor for API calls
class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('🚀 API Request:');
    debugPrint('URL: ${options.baseUrl}${options.path}');
    debugPrint('Method: ${options.method}');
    debugPrint('Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('Body: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint('✅ API Response:');
    debugPrint('URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Data: ${response.data}');
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('❌ API Error:');
    debugPrint('URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    debugPrint('Status Code: ${err.response?.statusCode}');
    debugPrint('Message: ${err.message}');
    debugPrint('Response: ${err.response?.data}');
    return handler.next(err);
  }
}
