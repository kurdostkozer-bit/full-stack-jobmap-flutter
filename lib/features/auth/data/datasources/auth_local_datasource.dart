import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthSession(AuthSessionModel session);
  Future<AuthSessionModel?> getAuthSession();
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> clearAuth();
  Future<bool> hasValidToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _authSessionKey = 'auth_session';

  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveAuthSession(AuthSessionModel session) async {
    try {
      // Save tokens
      await secureStorage.write(key: _tokenKey, value: session.accessToken);
      await secureStorage.write(
        key: _refreshTokenKey,
        value: session.refreshToken,
      );

      // Save full session
      await secureStorage.write(
        key: _authSessionKey,
        value: jsonEncode(session.toJson()),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthSessionModel?> getAuthSession() async {
    try {
      final json = await secureStorage.read(key: _authSessionKey);
      if (json != null) {
        return AuthSessionModel.fromJson(jsonDecode(json));
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: _tokenKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await secureStorage.read(key: _refreshTokenKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearAuth() async {
    try {
      await Future.wait([
        secureStorage.delete(key: _tokenKey),
        secureStorage.delete(key: _refreshTokenKey),
        secureStorage.delete(key: _authSessionKey),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> hasValidToken() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
