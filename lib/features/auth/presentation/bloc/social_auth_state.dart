part of 'social_auth_bloc.dart';

abstract class SocialAuthState extends Equatable {
  const SocialAuthState();

  @override
  List<Object?> get props => [];
}

class SocialAuthInitial extends SocialAuthState {
  const SocialAuthInitial();

  @override
  List<Object?> get props => [];
}

class SocialAuthLoading extends SocialAuthState {
  const SocialAuthLoading();

  @override
  List<Object?> get props => [];
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

class SocialSignOutSuccess extends SocialAuthState {
  const SocialSignOutSuccess();

  @override
  List<Object?> get props => [];
}
