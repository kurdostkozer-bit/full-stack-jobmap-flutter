part of 'social_link_bloc.dart';

abstract class SocialLinkState extends Equatable {
  const SocialLinkState();

  @override
  List<Object?> get props => [];
}

class SocialLinkInitial extends SocialLinkState {
  const SocialLinkInitial();
}

class SocialLinkLoading extends SocialLinkState {
  const SocialLinkLoading();
}

class SocialLinkSuccess extends SocialLinkState {
  final List<SocialLinkEntity> socialLinks;

  const SocialLinkSuccess(this.socialLinks);

  @override
  List<Object?> get props => [socialLinks];
}

class SocialLinkCreated extends SocialLinkState {
  final SocialLinkEntity socialLink;

  const SocialLinkCreated(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}

class SocialLinkUpdated extends SocialLinkState {
  final SocialLinkEntity socialLink;

  const SocialLinkUpdated(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}

class SocialLinkDeleted extends SocialLinkState {
  const SocialLinkDeleted();
}

class SocialLinkError extends SocialLinkState {
  final String message;

  const SocialLinkError(this.message);

  @override
  List<Object?> get props => [message];
}
