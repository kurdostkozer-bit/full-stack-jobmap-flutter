import '../../../../core/network/api_client.dart';
import '../models/projects_models.dart';

abstract class ProjectsRemoteDataSource {
  /// Get all projects for a career profile
  Future<List<ProjectResponse>> getProjects(String careerProfileId);

  /// Create a new project
  Future<ProjectResponse> createProject(
    String careerProfileId,
    Map<String, dynamic> projectData,
  );

  /// Update a project
  Future<ProjectResponse> updateProject(
    String projectId,
    Map<String, dynamic> projectData,
  );

  /// Delete a project
  Future<void> deleteProject(String projectId);
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final ApiClient apiClient;

  ProjectsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ProjectResponse>> getProjects(String careerProfileId) async {
    final response = await apiClient.get(
      '/projects/career-profile/$careerProfileId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) =>
                  ProjectResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          final projects =
              json['projects'] ?? json['data'] ?? json;
          if (projects is List) {
            return projects
                .map((item) =>
                    ProjectResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return [];
      },
    );
    return response;
  }

  @override
  Future<ProjectResponse> createProject(
    String careerProfileId,
    Map<String, dynamic> projectData,
  ) async {
    return await apiClient.post(
      '/projects',
      data: {
        ...projectData,
        'careerProfileId': careerProfileId,
      },
      fromJson: (json) => ProjectResponse.fromJson(json),
    );
  }

  @override
  Future<ProjectResponse> updateProject(
    String projectId,
    Map<String, dynamic> projectData,
  ) async {
    return await apiClient.patch(
      '/projects/$projectId',
      data: projectData,
      fromJson: (json) => ProjectResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteProject(String projectId) async {
    await apiClient.delete('/projects/$projectId');
  }
}
