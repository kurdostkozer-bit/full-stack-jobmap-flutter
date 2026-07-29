import '../../../../core/network/api_client.dart';
import '../models/skill_models.dart';

abstract class SkillRemoteDataSource {
  /// Get all skills for a career profile
  Future<List<SkillResponse>> getSkills(String careerProfileId);

  /// Create a new skill
  Future<SkillResponse> createSkill(
    String careerProfileId,
    Map<String, dynamic> skillData,
  );

  /// Update a skill
  Future<SkillResponse> updateSkill(
    String skillId,
    Map<String, dynamic> skillData,
  );

  /// Delete a skill
  Future<void> deleteSkill(String skillId);
}

class SkillRemoteDataSourceImpl implements SkillRemoteDataSource {
  final ApiClient apiClient;

  SkillRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<SkillResponse>> getSkills(String careerProfileId) async {
    final response = await apiClient.get<List<SkillResponse>>(
      '/profile/skills',
      queryParameters: {'careerProfileId': careerProfileId},
      fromJson: (json) {
        // Handle both single item and list responses
        if (json is List) {
          return json
              .map((item) => SkillResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          // Check if response has a 'skills' or 'data' key
          final skills = json['skills'] ?? json['data'] ?? json;
          if (skills is List) {
            return skills
                .map((item) => SkillResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return [];
      },
    );
    return response;
  }

  @override
  Future<SkillResponse> createSkill(
    String careerProfileId,
    Map<String, dynamic> skillData,
  ) async {
    return await apiClient.post(
      '/profile/skills',
      data: skillData,
      fromJson: (json) => SkillResponse.fromJson(json),
    );
  }

  @override
  Future<SkillResponse> updateSkill(
    String skillId,
    Map<String, dynamic> skillData,
  ) async {
    return await apiClient.patch(
      '/profile/skills/$skillId',
      data: skillData,
      fromJson: (json) => SkillResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteSkill(String skillId) async {
    await apiClient.delete('/profile/skills/$skillId');
  }
}
