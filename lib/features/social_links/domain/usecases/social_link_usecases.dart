import '../entities/social_link_entities.dart';
import '../repositories/social_link_repository.dart';

/// Get all social links for a career profile
class GetSocialLinksUseCase {
  final SocialLinkRepository repository;

  GetSocialLinksUseCase(this.repository);

  Future<List<SocialLinkEntity>> call({
    required String careerProfileId,
    int page = 1,
    int limit = 20,
  }) =>
      repository.getSocialLinks(
        careerProfileId: careerProfileId,
        page: page,
        limit: limit,
      );
}

/// Get single social link
class GetSocialLinkUseCase {
  final SocialLinkRepository repository;

  GetSocialLinkUseCase(this.repository);

  Future<SocialLinkEntity?> call(String id) =>
      repository.getSocialLinkById(id);
}

/// Create new social link
class CreateSocialLinkUseCase {
  final SocialLinkRepository repository;

  CreateSocialLinkUseCase(this.repository);

  Future<SocialLinkEntity> call(SocialLinkEntity socialLink) =>
      repository.createSocialLink(socialLink);
}

/// Update social link
class UpdateSocialLinkUseCase {
  final SocialLinkRepository repository;

  UpdateSocialLinkUseCase(this.repository);

  Future<SocialLinkEntity> call(String id, SocialLinkEntity socialLink) =>
      repository.updateSocialLink(id, socialLink);
}

/// Delete social link
class DeleteSocialLinkUseCase {
  final SocialLinkRepository repository;

  DeleteSocialLinkUseCase(this.repository);

  Future<void> call(String id) => repository.deleteSocialLink(id);
}

/// Reorder social links
class ReorderSocialLinksUseCase {
  final SocialLinkRepository repository;

  ReorderSocialLinksUseCase(this.repository);

  Future<SocialLinkEntity> call(
    String careerProfileId,
    List<String> linkIds,
  ) =>
      repository.reorderSocialLinks(careerProfileId, linkIds);
}
