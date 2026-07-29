import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object?> get props => [];
}

/// Load projects for a career profile
class LoadProjectsEvent extends ProjectsEvent {
  final String careerProfileId;

  const LoadProjectsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new project
class CreateProjectEvent extends ProjectsEvent {
  final String careerProfileId;
  final String title;
  final List<String> technologies;
  final String? description;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrently;
  final String? imageUrl;

  const CreateProjectEvent(
    this.careerProfileId,
    this.title,
    this.technologies, {
    this.description,
    this.role,
    this.startDate,
    this.endDate,
    this.isCurrently = false,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        careerProfileId,
        title,
        technologies,
        description,
        role,
        startDate,
        endDate,
        isCurrently,
        imageUrl,
      ];
}

/// Update a project
class UpdateProjectEvent extends ProjectsEvent {
  final String projectId;
  final String? title;
  final String? description;
  final String? role;
  final List<String>? technologies;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrently;
  final String? imageUrl;

  const UpdateProjectEvent(
    this.projectId, {
    this.title,
    this.description,
    this.role,
    this.technologies,
    this.startDate,
    this.endDate,
    this.isCurrently,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        projectId,
        title,
        description,
        role,
        technologies,
        startDate,
        endDate,
        isCurrently,
        imageUrl,
      ];
}

/// Delete a project
class DeleteProjectEvent extends ProjectsEvent {
  final String projectId;

  const DeleteProjectEvent(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

/// Refresh projects list
class RefreshProjectsEvent extends ProjectsEvent {
  final String careerProfileId;

  const RefreshProjectsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
