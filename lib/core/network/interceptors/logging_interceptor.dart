import 'package:dio/dio.dart';

/// Logging interceptor for API calls
class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('🚀 API Request:');
    print('URL: ${options.baseUrl}${options.path}');
    print('Method: ${options.method}');
    print('Headers: ${options.headers}');
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    print('✅ API Response:');
    print('URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    print('Status Code: ${response.statusCode}');
    print('Data: ${response.data}');
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    print('❌ API Error:');
    print('URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
    print('Status Code: ${err.response?.statusCode}');
    print('Message: ${err.message}');
    print('Response: ${err.response?.data}');
    return handler.next(err);
  }
}
