sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = 'No internet connection.',
  ]);
}

class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'Request timed out.',
  ]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Unauthorized.',
  ]);
}

class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'Access denied.',
  ]);
}

class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Resource not found.',
  ]);
}

class ValidationException extends AppException {
  const ValidationException(
    super.message,
  );
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'Internal server error.',
  ]);
}

class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Something went wrong.',
  ]);
}