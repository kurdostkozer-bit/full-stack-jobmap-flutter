import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_session_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _sessionKey = 'auth_session';

  final FlutterSecureStorage secureStorage;

  const AuthLocalDataSourceImpl({
    required this.secureStorage,
  });

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await secureStorage.write(
      key: _sessionKey,
      value: jsonEncode(session.toJson()),
    );
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
  }

  @override
  Future<bool> hasSession() async {
    return await secureStorage.containsKey(
      key: _sessionKey,
    );
  }
}
