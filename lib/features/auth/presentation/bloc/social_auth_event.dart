part of 'social_auth_bloc.dart';

abstract class SocialAuthEvent extends Equatable {
  const SocialAuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends SocialAuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends SocialAuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String phone;

  const RegisterRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [fullName, email, password, phone];
}

class LogoutRequested extends SocialAuthEvent {
  const LogoutRequested();

  @override
  List<Object?> get props => [];
}
