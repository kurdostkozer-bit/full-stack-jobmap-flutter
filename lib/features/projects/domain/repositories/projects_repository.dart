import '../entities/projects_entities.dart';

/// Abstract repository for project operations
abstract class ProjectsRepository {
  /// Get all projects for a career profile
  Future<List<Project>> getProjects(String careerProfileId);

  /// Create a new project
  Future<Project> createProject(
    String careerProfileId,
    String title,
    List<String> technologies, {
    String? description,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently = false,
    String? imageUrl,
  });

  /// Update a project
  Future<Project> updateProject(
    String projectId, {
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  });

  /// Delete a project
  Future<void> deleteProject(String projectId);

  /// Get cached projects
  Future<List<Project>?> getCachedProjects(String careerProfileId);

  /// Clear cached projects
  Future<void> clearCachedProjects(String careerProfileId);
}
