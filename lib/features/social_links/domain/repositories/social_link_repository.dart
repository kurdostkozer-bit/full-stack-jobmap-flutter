import '../entities/social_link_entities.dart';

abstract class SocialLinkRepository {
  // Create
  Future<SocialLinkEntity> createSocialLink(SocialLinkEntity socialLink);

  // Read
  Future<List<SocialLinkEntity>> getSocialLinks({
    required String careerProfileId,
    int page = 1,
    int limit = 20,
  });

  Future<SocialLinkEntity?> getSocialLinkById(String id);

  Future<List<SocialLinkEntity>> getSocialLinksByCareerProfileId(
    String careerProfileId,
  );

  // Update
  Future<SocialLinkEntity> updateSocialLink(
    String id,
    SocialLinkEntity socialLink,
  );

  Future<SocialLinkEntity> reorderSocialLinks(
    String careerProfileId,
    List<String> linkIds,
  );

  // Delete
  Future<void> deleteSocialLink(String id);

  Future<void> deleteSocialLinksByCareerProfileId(String careerProfileId);
}
