/// App environment configuration
enum Environment { development, staging, production }

class AppConfig {
  static late Environment _environment;
  static late _EnvironmentConfig _config;

  static Environment get environment => _environment;
  static String get apiBaseUrl => _config.apiBaseUrl;
  static String get apiVersion => _config.apiVersion;
  static String get fullApiUrl => '$apiBaseUrl/$apiVersion';
  static bool get enableLogging => _config.enableLogging;
  static bool get enableCrashReporting => _config.enableCrashReporting;

  /// Initialize config based on environment
  static void init(Environment env) {
    _environment = env;
    _config = _getConfig(env);
  }

  static _EnvironmentConfig _getConfig(Environment env) {
    switch (env) {
      case Environment.development:
        return _DevelopmentConfig();
      case Environment.staging:
        return _StagingConfig();
      case Environment.production:
        return _ProductionConfig();
    }
  }
}

abstract class _EnvironmentConfig {
  String get apiBaseUrl;
  String get apiVersion => 'v1';
  bool get enableLogging => true;
  bool get enableCrashReporting => true;
}

/// Development environment
class _DevelopmentConfig extends _EnvironmentConfig {
  @override
  String get apiBaseUrl => 'http://localhost:3000/api';

  @override
  bool get enableLogging => true;

  @override
  bool get enableCrashReporting => false;
}

/// Staging environment
class _StagingConfig extends _EnvironmentConfig {
  @override
  String get apiBaseUrl => 'https://staging-api.jobmap.app/api';

  @override
  bool get enableLogging => true;

  @override
  bool get enableCrashReporting => true;
}

/// Production environment
class _ProductionConfig extends _EnvironmentConfig {
  @override
  String get apiBaseUrl => 'https://api.jobmap.app/api';

  @override
  bool get enableLogging => false;

  @override
  bool get enableCrashReporting => true;
}
