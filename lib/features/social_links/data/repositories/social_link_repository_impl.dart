import '../../domain/entities/social_link_entities.dart';
import '../../domain/repositories/social_link_repository.dart';
import '../datasources/social_link_local_datasource.dart';
import '../datasources/social_link_remote_datasource.dart';
import '../models/social_link_models.dart';

class SocialLinkRepositoryImpl implements SocialLinkRepository {
  final SocialLinkRemoteDataSource remoteDataSource;
  final SocialLinkLocalDataSource localDataSource;

  SocialLinkRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<SocialLinkEntity> createSocialLink(SocialLinkEntity socialLink) async {
    final dto = CreateSocialLinkDto.fromEntity(socialLink);
    final model = await remoteDataSource.createSocialLink(dto);
    return model.toEntity();
  }

  @override
  Future<List<SocialLinkEntity>> getSocialLinks({
    required String careerProfileId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final models = await remoteDataSource.getSocialLinks(
        careerProfileId: careerProfileId,
        page: page,
        limit: limit,
      );
      await localDataSource.cacheSocialLinks(careerProfileId, models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Try to get cached data on error
      final cached = await localDataSource.getCachedSocialLinks(
        careerProfileId,
      );
      if (cached != null) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<SocialLinkEntity?> getSocialLinkById(String id) async {
    try {
      final model = await remoteDataSource.getSocialLinkById(id);
      return model?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<SocialLinkEntity>> getSocialLinksByCareerProfileId(
    String careerProfileId,
  ) async {
    try {
      final models = await remoteDataSource.getSocialLinks(
        careerProfileId: careerProfileId,
      );
      await localDataSource.cacheSocialLinks(careerProfileId, models);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      // Try to get cached data on error
      final cached = await localDataSource.getCachedSocialLinks(
        careerProfileId,
      );
      if (cached != null) {
        return cached.map((m) => m.toEntity()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<SocialLinkEntity> updateSocialLink(
    String id,
    SocialLinkEntity socialLink,
  ) async {
    final updateDto = UpdateSocialLinkDto(
      url: socialLink.url,
      isVisible: socialLink.isVisible,
      displayOrder: socialLink.displayOrder,
    );
    final model = await remoteDataSource.updateSocialLink(id, updateDto);
    return model.toEntity();
  }

  @override
  Future<SocialLinkEntity> reorderSocialLinks(
    String careerProfileId,
    List<String> linkIds,
  ) async {
    // This is a batch operation - for now returning first link
    // In real scenario, implement batch reorder endpoint
    final links = await getSocialLinks(careerProfileId: careerProfileId);
    if (links.isEmpty) throw Exception('No social links found');
    return links.first;
  }

  @override
  Future<void> deleteSocialLink(String id) async {
    await remoteDataSource.deleteSocialLink(id);
    await localDataSource.clearCache();
  }

  @override
  Future<void> deleteSocialLinksByCareerProfileId(String careerProfileId) async {
    await localDataSource.clearCache();
  }
}
