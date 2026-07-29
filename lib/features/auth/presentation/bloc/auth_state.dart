part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading state
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authenticated state
class AuthAuthenticated extends AuthState {
  final UserResponse user;
  final String token;

  const AuthAuthenticated({
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [user, token];
}

/// Unauthenticated state
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Email verification needed state
class EmailVerificationNeeded extends AuthState {
  final String email;

  const EmailVerificationNeeded({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Password reset sent state
class PasswordResetSent extends AuthState {
  final String message;

  const PasswordResetSent({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Error state
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Success state (for operations like register, verify, reset)
class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
