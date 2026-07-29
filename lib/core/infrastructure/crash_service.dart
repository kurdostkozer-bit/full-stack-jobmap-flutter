import 'package:flutter/foundation.dart';

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
    debugPrint('💥 Exception: $exception');
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    debugPrint('💥 Flutter Error: ${details.exceptionAsString()}');
  }

  @override
  Future<void> setUserIdentifier(String userId) async {
    debugPrint('👤 User ID: $userId');
  }

  @override
  Future<void> setBreadcrumb(String message) async {
    debugPrint('🔗 Breadcrumb: $message');
  }
}

/// Sentry crash service (future)
class SentryCrashService implements CrashService {
  @override
  Future<void> recordException(Object exception, StackTrace? stackTrace) async {
    // No-op placeholder. Replace with Sentry SDK calls when adding
    // `sentry_flutter` dependency.
    debugPrint('SentryCrashService.recordException: $exception');
    if (stackTrace != null) debugPrint(stackTrace.toString());
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    debugPrint('SentryCrashService.recordFlutterError: ${details.exceptionAsString()}');
  }

  @override
  Future<void> setUserIdentifier(String userId) async {
    debugPrint('SentryCrashService.setUserIdentifier: $userId');
  }

  @override
  Future<void> setBreadcrumb(String message) async {
    debugPrint('SentryCrashService.setBreadcrumb: $message');
  }
}
