import '../../../../core/network/api_client.dart';
import '../models/experience_models.dart';

abstract class ExperienceRemoteDataSource {
  /// Get all experiences for a career profile
  Future<List<ExperienceResponse>> getExperiences(String careerProfileId);

  /// Create a new experience
  Future<ExperienceResponse> createExperience(
    String careerProfileId,
    Map<String, dynamic> experienceData,
  );

  /// Update an experience
  Future<ExperienceResponse> updateExperience(
    String experienceId,
    Map<String, dynamic> experienceData,
  );

  /// Delete an experience
  Future<void> deleteExperience(String experienceId);
}

class ExperienceRemoteDataSourceImpl implements ExperienceRemoteDataSource {
  final ApiClient apiClient;

  ExperienceRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ExperienceResponse>> getExperiences(String careerProfileId) async {
    final response = await apiClient.get(
      '/profile/experience',
      queryParameters: {'careerProfileId': careerProfileId},
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) =>
                  ExperienceResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          final experiences =
              json['experiences'] ?? json['data'] ?? json;
          if (experiences is List) {
            return experiences
                .map((item) =>
                    ExperienceResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return [];
      },
    );
    return response;
  }

  @override
  Future<ExperienceResponse> createExperience(
    String careerProfileId,
    Map<String, dynamic> experienceData,
  ) async {
    return await apiClient.post(
      '/profile/experience',
      data: experienceData,
      fromJson: (json) => ExperienceResponse.fromJson(json),
    );
  }

  @override
  Future<ExperienceResponse> updateExperience(
    String experienceId,
    Map<String, dynamic> experienceData,
  ) async {
    return await apiClient.patch(
      '/profile/experience/$experienceId',
      data: experienceData,
      fromJson: (json) => ExperienceResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteExperience(String experienceId) async {
    await apiClient.delete('/profile/experience/$experienceId');
  }
}
