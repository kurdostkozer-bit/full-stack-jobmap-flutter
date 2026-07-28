class NetworkConfig {
  const NetworkConfig._();

  /// Base API URL
  static const String baseUrl = 'https://api.jobmap.app/api/v1';

  /// Connection timeout
  static const Duration connectTimeout = Duration(
    seconds: 30,
  );

  /// Receive timeout
  static const Duration receiveTimeout = Duration(
    seconds: 30,
  );

  /// Send timeout
  static const Duration sendTimeout = Duration(
    seconds: 30,
  );

  /// Default headers
  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}