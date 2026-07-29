import '../entities/projects_entities.dart';
import '../repositories/projects_repository.dart';

/// Get all projects for a career profile
class GetProjectsUseCase {
  final ProjectsRepository repository;

  GetProjectsUseCase({required this.repository});

  Future<List<Project>> call(String careerProfileId) {
    return repository.getProjects(careerProfileId);
  }
}

/// Create a new project
class CreateProjectUseCase {
  final ProjectsRepository repository;

  CreateProjectUseCase({required this.repository});

  Future<Project> call(
    String careerProfileId,
    String title,
    List<String> technologies, {
    String? description,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    bool isCurrently = false,
    String? imageUrl,
  }) {
    return repository.createProject(
      careerProfileId,
      title,
      technologies,
      description: description,
      role: role,
      startDate: startDate,
      endDate: endDate,
      isCurrently: isCurrently,
      imageUrl: imageUrl,
    );
  }
}

/// Update a project
class UpdateProjectUseCase {
  final ProjectsRepository repository;

  UpdateProjectUseCase({required this.repository});

  Future<Project> call(
    String projectId, {
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  }) {
    return repository.updateProject(
      projectId,
      title: title,
      description: description,
      role: role,
      technologies: technologies,
      startDate: startDate,
      endDate: endDate,
      isCurrently: isCurrently,
      imageUrl: imageUrl,
    );
  }
}

/// Delete a project
class DeleteProjectUseCase {
  final ProjectsRepository repository;

  DeleteProjectUseCase({required this.repository});

  Future<void> call(String projectId) {
    return repository.deleteProject(projectId);
  }
}
