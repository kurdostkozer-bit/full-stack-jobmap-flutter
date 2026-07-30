part of 'social_auth_bloc.dart';

abstract class SocialAuthState extends Equatable {
  const SocialAuthState();

  @override
  List<Object?> get props => [];
}

class SocialAuthInitial extends SocialAuthState {
  const SocialAuthInitial();
}

class SocialAuthLoading extends SocialAuthState {
  const SocialAuthLoading();
}

class SocialAuthSuccess extends SocialAuthState {
  final AuthSession authSession;

  const SocialAuthSuccess({required this.authSession});

  @override
  List<Object?> get props => [authSession];
}

class SocialAuthFailure extends SocialAuthState {
  final String message;

  const SocialAuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class SocialAuthAuthenticated extends SocialAuthState {
  final User user;

  const SocialAuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class SocialSignOutSuccess extends SocialAuthState {
  const SocialSignOutSuccess();
}
