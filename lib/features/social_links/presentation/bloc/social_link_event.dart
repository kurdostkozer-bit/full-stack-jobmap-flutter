part of 'social_link_bloc.dart';

abstract class SocialLinkEvent extends Equatable {
  const SocialLinkEvent();

  @override
  List<Object?> get props => [];
}

class GetSocialLinksEvent extends SocialLinkEvent {
  final String careerProfileId;
  final int page;
  final int limit;

  const GetSocialLinksEvent({
    required this.careerProfileId,
    this.page = 1,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [careerProfileId, page, limit];
}

class CreateSocialLinkEvent extends SocialLinkEvent {
  final SocialLinkEntity socialLink;

  const CreateSocialLinkEvent(this.socialLink);

  @override
  List<Object?> get props => [socialLink];
}

class UpdateSocialLinkEvent extends SocialLinkEvent {
  final String id;
  final SocialLinkEntity socialLink;

  const UpdateSocialLinkEvent({
    required this.id,
    required this.socialLink,
  });

  @override
  List<Object?> get props => [id, socialLink];
}

class DeleteSocialLinkEvent extends SocialLinkEvent {
  final String id;

  const DeleteSocialLinkEvent(this.id);

  @override
  List<Object?> get props => [id];
}
