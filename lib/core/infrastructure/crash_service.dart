/// Crash reporting service
abstract class CrashService {
  Future<void> recordException(Object exception, StackTrace? stackTrace);
  Future<void> recordFlutterError(FlutterErrorDetails details);
  Future<void> setUserIdentifier(String userId);
  Future<void> setBreadcrumb(String message);
}

/// Simple crash service (logs to console)
class SimpleCrashService implements CrashService {
  @override
  Future<void> recordException(Object exception, StackTrace? stackTrace) async {
    print('💥 Exception: $exception');
    if (stackTrace != null) {
      print(stackTrace);
    }
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    print('💥 Flutter Error: ${details.exceptionAsString()}');
  }

  @override
  Future<void> setUserIdentifier(String userId) async {
    print('👤 User ID: $userId');
  }

  @override
  Future<void> setBreadcrumb(String message) async {
    print('🔗 Breadcrumb: $message');
  }
}

/// Sentry crash service (future)
class SentryCrashService implements CrashService {
  @override
  Future<void> recordException(Object exception, StackTrace? stackTrace) async {
    // TODO: Implement Sentry
    throw UnimplementedError();
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    // TODO: Implement Sentry Flutter errors
    throw UnimplementedError();
  }

  @override
  Future<void> setUserIdentifier(String userId) async {
    // TODO: Implement Sentry user ID
    throw UnimplementedError();
  }

  @override
  Future<void> setBreadcrumb(String message) async {
    // TODO: Implement Sentry breadcrumbs
    throw UnimplementedError();
  }
}
