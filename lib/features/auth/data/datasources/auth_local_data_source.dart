import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  /// Save authenticated session locally.
  Future<void> saveSession(AuthSessionModel session);

  /// Read current saved session.
  Future<AuthSessionModel?> getSession();

  /// Remove current saved session.
  Future<void> clearSession();

  /// Returns true if a session exists.
  Future<bool> hasSession();
}