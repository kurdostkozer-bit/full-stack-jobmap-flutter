import 'package:dio/dio.dart';

import '../app_exception.dart';

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const TimeoutException(),
          ),
        );
        return;

      case DioExceptionType.connectionError:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(),
          ),
        );
        return;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;

        switch (statusCode) {
          case 401:
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: const UnauthorizedException(),
              ),
            );
            return;

          case 403:
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: const ForbiddenException(),
              ),
            );
            return;

          case 404:
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: const NotFoundException(),
              ),
            );
            return;

          case 422:
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: ValidationException(
                  'Validation failed.',
                ),
              ),
            );
            return;

          default:
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: const ServerException(),
              ),
            );
            return;
        }

      default:
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: const UnknownException(),
          ),
        );
    }
  }
}