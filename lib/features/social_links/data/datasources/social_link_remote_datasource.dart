import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/api_client.dart';
import '../models/social_link_models.dart';

abstract class SocialLinkRemoteDataSource {
  Future<SocialLinkModel> createSocialLink(CreateSocialLinkDto dto);
  Future<List<SocialLinkModel>> getSocialLinks({
    required String careerProfileId,
    int page = 1,
    int limit = 20,
  });
  Future<SocialLinkModel?> getSocialLinkById(String id);
  Future<SocialLinkModel> updateSocialLink(
    String id,
    UpdateSocialLinkDto dto,
  );
  Future<void> deleteSocialLink(String id);
}

class SocialLinkRemoteDataSourceImpl implements SocialLinkRemoteDataSource {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;

  SocialLinkRemoteDataSourceImpl({
    required this.apiClient,
    required this.secureStorage,
  });

  @override
  Future<SocialLinkModel> createSocialLink(CreateSocialLinkDto dto) async {
    try {
      final response = await apiClient.post(
        '/social-links',
        data: dto.toJson(),
      );
      return SocialLinkModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SocialLinkModel>> getSocialLinks({
    required String careerProfileId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await apiClient.get(
        '/career-profiles/$careerProfileId/social-links',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      final List<dynamic> data = response.data['data'] ?? response.data;
      return data
          .map((item) => SocialLinkModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SocialLinkModel?> getSocialLinkById(String id) async {
    try {
      final response = await apiClient.get('/social-links/$id');
      return SocialLinkModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<SocialLinkModel> updateSocialLink(
    String id,
    UpdateSocialLinkDto dto,
  ) async {
    try {
      final response = await apiClient.patch(
        '/social-links/$id',
        data: dto.toJson(),
      );
      return SocialLinkModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSocialLink(String id) async {
    try {
      await apiClient.delete('/social-links/$id');
    } catch (e) {
      rethrow;
    }
  }
}
