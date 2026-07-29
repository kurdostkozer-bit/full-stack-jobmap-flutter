import '../repositories/auth_repository.dart';
import '../entities/auth_session.dart';

/// Register usecase
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<AuthSession> call({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) {
    return repository.register(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
  }
}

/// Login usecase
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthSession> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}

/// Verify email usecase
class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase({required this.repository});

  Future<void> call({
    required String email,
    required String code,
  }) {
    return repository.verifyEmail(email: email, code: code);
  }
}

/// Logout usecase
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> call() {
    return repository.logout();
  }
}

/// Forgot password usecase
class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  Future<void> call({required String email}) {
    return repository.forgotPassword(email: email);
  }
}

/// Reset password usecase
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return repository.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }
}

/// Check authentication usecase
class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  Future<bool> call() {
    return repository.isAuthenticated();
  }
}

/// Get current session usecase
class GetCurrentSessionUseCase {
  final AuthRepository repository;

  GetCurrentSessionUseCase({required this.repository});

  Future<AuthSession?> call() {
    return repository.getCurrentSession();
  }
}

/// Refresh session usecase
class RefreshSessionUseCase {
  final AuthRepository repository;

  RefreshSessionUseCase({required this.repository});

  Future<AuthSession> call({required String refreshToken}) {
    return repository.refreshSession(refreshToken: refreshToken);
  }
}
