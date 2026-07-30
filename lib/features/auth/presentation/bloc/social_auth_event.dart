part of 'social_auth_bloc.dart';

abstract class SocialAuthEvent extends Equatable {
  const SocialAuthEvent();

  @override
  List<Object?> get props => [];
}

class GoogleSignInRequested extends SocialAuthEvent {
  const GoogleSignInRequested();
}

class SocialSignOutRequested extends SocialAuthEvent {
  const SocialSignOutRequested();
}

class CheckSocialAuthStatus extends SocialAuthEvent {
  const CheckSocialAuthStatus();
}
