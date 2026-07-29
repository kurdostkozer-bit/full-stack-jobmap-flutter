import '../repositories/auth_repository.dart';
import '../../data/models/auth_models.dart';

/// Register usecase
class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<AuthResponse> call(
    String email,
    String password,
    String firstName,
    String lastName,
  ) {
    return repository.register(email, password, firstName, lastName);
  }
}

/// Login usecase
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthResponse> call(String email, String password) {
    return repository.login(email, password);
  }
}

/// Verify email usecase
class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase({required this.repository});

  Future<void> call(String email, String code) {
    return repository.verifyEmail(email, code);
  }
}

/// Get current user usecase
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<UserResponse> call() {
    return repository.getCurrentUser();
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

  Future<void> call(String email) {
    return repository.forgotPassword(email);
  }
}

/// Reset password usecase
class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email, String code, String newPassword) {
    return repository.resetPassword(email, code, newPassword);
  }
}

/// Check authentication usecase
class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  Future<bool> call() {
    return repository.isUserAuthenticated();
  }
}

/// Get cached user usecase
class GetCachedUserUseCase {
  final AuthRepository repository;

  GetCachedUserUseCase({required this.repository});

  Future<UserResponse?> call() {
    return repository.getCachedUser();
  }
}
