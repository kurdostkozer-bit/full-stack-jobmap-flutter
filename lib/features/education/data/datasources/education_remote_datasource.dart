import '../../../../core/network/api_client.dart';
import '../models/education_models.dart';

abstract class EducationRemoteDataSource {
  /// Get all educations for a career profile
  Future<List<EducationResponse>> getEducations(String careerProfileId);

  /// Create a new education
  Future<EducationResponse> createEducation(
    String careerProfileId,
    Map<String, dynamic> educationData,
  );

  /// Update an education
  Future<EducationResponse> updateEducation(
    String educationId,
    Map<String, dynamic> educationData,
  );

  /// Delete an education
  Future<void> deleteEducation(String educationId);
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final ApiClient apiClient;

  EducationRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<EducationResponse>> getEducations(String careerProfileId) async {
    final response = await apiClient.get(
      '/education/career-profile/$careerProfileId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) =>
                  EducationResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          final educations =
              json['educations'] ?? json['data'] ?? json;
          if (educations is List) {
            return educations
                .map((item) =>
                    EducationResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return [];
      },
    );
    return response;
  }

  @override
  Future<EducationResponse> createEducation(
    String careerProfileId,
    Map<String, dynamic> educationData,
  ) async {
    return await apiClient.post(
      '/education',
      data: {
        ...educationData,
        'careerProfileId': careerProfileId,
      },
      fromJson: (json) => EducationResponse.fromJson(json),
    );
  }

  @override
  Future<EducationResponse> updateEducation(
    String educationId,
    Map<String, dynamic> educationData,
  ) async {
    return await apiClient.patch(
      '/education/$educationId',
      data: educationData,
      fromJson: (json) => EducationResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteEducation(String educationId) async {
    await apiClient.delete('/education/$educationId');
  }
}
