import 'package:flutter/foundation.dart';

/// Analytics service (track user events)
abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});
  Future<void> setUserProperty(String name, String value);
  Future<void> logScreenView(String screenName);
  Future<void> logError(String message, {StackTrace? stackTrace});
}

/// Simple analytics implementation
class SimpleAnalyticsService implements AnalyticsService {
  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    debugPrint('📊 Analytics Event: $name ${parameters ?? ''}');
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    debugPrint('👤 User Property: $name = $value');
  }

  @override
  Future<void> logScreenView(String screenName) async {
    debugPrint('📱 Screen View: $screenName');
  }

  @override
  Future<void> logError(String message, {StackTrace? stackTrace}) async {
    debugPrint('❌ Error: $message');
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }
}

/// Firebase analytics implementation (future)
class FirebaseAnalyticsService implements AnalyticsService {
  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    // No-op placeholder implementation. Replace with Firebase Analytics
    // when `firebase_analytics` is added to `pubspec.yaml`.
    debugPrint('FirebaseAnalyticsService.logEvent: $name ${parameters ?? ''}');
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    debugPrint('FirebaseAnalyticsService.setUserProperty: $name = $value');
  }

  @override
  Future<void> logScreenView(String screenName) async {
    debugPrint('FirebaseAnalyticsService.logScreenView: $screenName');
  }

  @override
  Future<void> logError(String message, {StackTrace? stackTrace}) async {
    debugPrint('FirebaseAnalyticsService.logError: $message');
    if (stackTrace != null) debugPrint(stackTrace.toString());
  }
}
