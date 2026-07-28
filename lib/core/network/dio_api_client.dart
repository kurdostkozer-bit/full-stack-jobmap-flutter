import 'package:dio/dio.dart';

import 'api_client.dart';

class DioApiClient implements ApiClient {
  final Dio dio;

  const DioApiClient({
    required this.dio,
  });

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );

    return Map<String, dynamic>.from(response.data);
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await dio.post(
      path,
      data: body,
      options: Options(headers: headers),
    );

    return Map<String, dynamic>.from(response.data);
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await dio.put(
      path,
      data: body,
      options: Options(headers: headers),
    );

    return Map<String, dynamic>.from(response.data);
  }

  @override
  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await dio.patch(
      path,
      data: body,
      options: Options(headers: headers),
    );

    return Map<String, dynamic>.from(response.data);
  }

  @override
  Future<void> delete(
    String path, {
    Map<String, String>? headers,
  }) async {
    await dio.delete(
      path,
      options: Options(headers: headers),
    );
  }
}