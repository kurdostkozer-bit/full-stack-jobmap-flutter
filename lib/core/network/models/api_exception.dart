import 'package:dio/dio.dart';

/// Custom API Exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalException;
  final StackTrace? stackTrace;

  ApiException({
    required this.message,
    this.statusCode,
    this.originalException,
    this.stackTrace,
  });

  /// Factory constructor for DioException
  factory ApiException.fromDioException(DioException e) {
    String message = 'An error occurred';
    int? statusCode = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (data is Map && data.containsKey('message')) {
          message = data['message'] ?? 'Bad response from server';
        } else {
          message = 'Error: ${e.response?.statusCode}';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.unknown:
        message = e.message ?? 'Unknown error occurred';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error. Check your internet connection.';
        break;
      case DioExceptionType.transformTimeout:
        message = 'Transform timeout. Please try again.';
        break;
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
      originalException: e,
      stackTrace: e.stackTrace,
    );
  }

  /// Factory constructor for generic exceptions
  factory ApiException.fromException(Exception e) {
    return ApiException(
      message: e.toString(),
      originalException: e,
    );
  }

  @override
  String toString() => message;

  /// Check if error is network related
  bool get isNetworkError => originalException is DioException &&
      (originalException as DioException).type ==
          DioExceptionType.connectionError;

  /// Check if error is timeout
  bool get isTimeoutError => originalException is DioException &&
      ((originalException as DioException).type ==
              DioExceptionType.connectionTimeout ||
          (originalException as DioException).type ==
              DioExceptionType.receiveTimeout ||
          (originalException as DioException).type ==
              DioExceptionType.sendTimeout);

  /// Check if error is unauthorized
  bool get isUnauthorized => statusCode == 401;

  /// Check if error is forbidden
  bool get isForbidden => statusCode == 403;

  /// Check if error is not found
  bool get isNotFound => statusCode == 404;

  /// Check if error is server error
  bool get isServerError => statusCode != null && statusCode! >= 500;
}
