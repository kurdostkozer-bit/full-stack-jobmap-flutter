part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Check if user is authenticated on app start
class CheckAuthEvent extends AuthEvent {
  const CheckAuthEvent();
}

/// Register event
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}

/// Verify email event
class VerifyEmailEvent extends AuthEvent {
  final String email;
  final String code;

  const VerifyEmailEvent({required this.email, required this.code});

  @override
  List<Object?> get props => [email, code];
}

/// Login event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Get current user event
class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent();
}

/// Logout event
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Forgot password event
class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Reset password event
class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String code;
  final String newPassword;

  const ResetPasswordEvent({
    required this.email,
    required this.code,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, code, newPassword];
}
