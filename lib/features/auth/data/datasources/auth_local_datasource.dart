import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/auth_models.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthResponse(AuthResponse response);
  Future<AuthResponse?> getAuthResponse();
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<UserResponse?> getCachedUser();
  Future<void> clearAuth();
  Future<bool> hasValidToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _authResponseKey = 'auth_response';
  static const String _userKey = 'user_profile';

  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveAuthResponse(AuthResponse response) async {
    try {
      // Save tokens
      await secureStorage.write(key: _tokenKey, value: response.token);
      await secureStorage.write(
        key: _refreshTokenKey,
        value: response.refreshToken,
      );

      // Save full response and user
      await secureStorage.write(
        key: _authResponseKey,
        value: jsonEncode(response.toJson()),
      );
      await secureStorage.write(
        key: _userKey,
        value: jsonEncode(response.user.toJson()),
      );
    } catch (e) {
      print('Error saving auth response: $e');
      rethrow;
    }
  }

  @override
  Future<AuthResponse?> getAuthResponse() async {
    try {
      final json = await secureStorage.read(key: _authResponseKey);
      if (json != null) {
        return AuthResponse.fromJson(jsonDecode(json));
      }
    } catch (e) {
      print('Error reading auth response: $e');
    }
    return null;
  }

  @override
  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: _tokenKey);
    } catch (e) {
      print('Error reading token: $e');
    }
    return null;
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      print('Error reading refresh token: $e');
    }
    return null;
  }

  @override
  Future<UserResponse?> getCachedUser() async {
    try {
      final json = await secureStorage.read(key: _userKey);
      if (json != null) {
        return UserResponse.fromJson(jsonDecode(json));
      }
    } catch (e) {
      print('Error reading cached user: $e');
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    try {
      await Future.wait([
        secureStorage.delete(key: _tokenKey),
        secureStorage.delete(key: _refreshTokenKey),
        secureStorage.delete(key: _authResponseKey),
        secureStorage.delete(key: _userKey),
      ]);
    } catch (e) {
      print('Error clearing auth: $e');
    }
  }

  @override
  Future<bool> hasValidToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      print('Error checking token: $e');
    }
    return false;
  }
}
