import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_session_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _sessionKey = 'auth_session';
  static const _authTokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage secureStorage;

  const AuthLocalDataSourceImpl({
    required this.secureStorage,
  });

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    // Save full session
    await secureStorage.write(
      key: _sessionKey,
      value: jsonEncode(session.toJson()),
    );
    
    // CRITICAL FIX: Also save tokens individually for interceptor
    if (session.accessToken != null) {
      await secureStorage.write(
        key: _authTokenKey,
        value: session.accessToken!,
      );
    }
    if (session.refreshToken != null) {
      await secureStorage.write(
        key: _refreshTokenKey,
        value: session.refreshToken!,
      );
    }
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    final json = await secureStorage.read(
      key: _sessionKey,
    );

    if (json == null) {
      return null;
    }

    return AuthSessionModel.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> clearSession() async {
    await secureStorage.delete(
      key: _sessionKey,
    );
    // Also clear individual tokens
    await secureStorage.delete(
      key: _authTokenKey,
    );
    await secureStorage.delete(
      key: _refreshTokenKey,
    );
  }

  @override
  Future<bool> hasSession() async {
    return await secureStorage.containsKey(
      key: _sessionKey,
    );
  }
}
