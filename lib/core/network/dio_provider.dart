import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Dio provider - creates and configures Dio instances
class DioProvider {
  static Dio createDio({
    required String baseUrl,
    required FlutterSecureStorage secureStorage,
    bool enableLogging = true,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    // Add auth interceptor (with dio instance for token refresh)
    dio.interceptors.add(
      AuthInterceptor(
        secureStorage: secureStorage,
        dio: dio,
      ),
    );
    
    if (enableLogging) {
      dio.interceptors.add(LoggingInterceptor());
    }

    return dio;
  }
}

