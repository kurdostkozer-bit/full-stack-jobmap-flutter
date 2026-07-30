import 'package:dio/dio.dart';
import 'models/api_exception.dart';

/// Base API client with common methods
class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  /// GET request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// POST request
  Future<T> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
        path,
        data: data,
      );
      return _handleResponse(response, fromJson);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// PUT request
  Future<T> put<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.put<Map<String, dynamic>>(
        path,
        data: data,
      );
      return _handleResponse(response, fromJson);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// PATCH request
  Future<T> patch<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.patch<Map<String, dynamic>>(
        path,
        data: data,
      );
      return _handleResponse(response, fromJson);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// DELETE request
  Future<T> delete<T>(
    String path, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await dio.delete<Map<String, dynamic>>(path);
      return _handleResponse(response, fromJson);
    } catch (e) {
      throw _handleException(e);
    }
  }

  /// Handle successful response
  T _handleResponse<T>(
    Response<dynamic> response,
    T Function(dynamic)? fromJson,
  ) {
    if (response.statusCode == null || response.statusCode! > 299) {
      throw ApiException(
        message: 'HTTP Error: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }

    final data = response.data;

    // If fromJson is provided, use it to convert data
    if (fromJson != null) {
      try {
        return fromJson(data);
      } catch (e) {
        throw ApiException(
          message: 'Failed to parse response: $e',
          statusCode: response.statusCode,
          originalException: Exception(e),
        );
      }
    }

    // Otherwise return data as is
    return data as T;
  }

  /// Handle exception
  ApiException _handleException(dynamic exception) {
    if (exception is ApiException) {
      return exception;
    } else if (exception is DioException) {
      return ApiException.fromDioException(exception);
    } else if (exception is Exception) {
      return ApiException.fromException(exception);
    } else {
      return ApiException(message: 'Unknown error: $exception');
    }
  }
}
