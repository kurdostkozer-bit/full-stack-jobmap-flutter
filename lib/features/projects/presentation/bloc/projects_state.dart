import 'package:equatable/equatable.dart';
import '../../domain/entities/projects_entities.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProjectsInitial extends ProjectsState {
  const ProjectsInitial();
}

/// Loading projects
class ProjectsLoading extends ProjectsState {
  const ProjectsLoading();
}

/// Projects loaded successfully
class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  const ProjectsLoaded({required this.projects});

  @override
  List<Object?> get props => [projects];
}

/// Creating new project
class ProjectCreating extends ProjectsState {
  final List<Project> currentProjects;

  const ProjectCreating({required this.currentProjects});

  @override
  List<Object?> get props => [currentProjects];
}

/// Project created successfully
class ProjectCreated extends ProjectsState {
  final List<Project> projects;
  final String message;

  const ProjectCreated({
    required this.projects,
    this.message = 'Project added successfully',
  });

  @override
  List<Object?> get props => [projects, message];
}

/// Updating project
class ProjectUpdating extends ProjectsState {
  final List<Project> currentProjects;

  const ProjectUpdating({required this.currentProjects});

  @override
  List<Object?> get props => [currentProjects];
}

/// Project updated successfully
class ProjectUpdated extends ProjectsState {
  final List<Project> projects;
  final String message;

  const ProjectUpdated({
    required this.projects,
    this.message = 'Project updated successfully',
  });

  @override
  List<Object?> get props => [projects, message];
}

/// Deleting project
class ProjectDeleting extends ProjectsState {
  final List<Project> currentProjects;

  const ProjectDeleting({required this.currentProjects});

  @override
  List<Object?> get props => [currentProjects];
}

/// Project deleted successfully
class ProjectDeleted extends ProjectsState {
  final List<Project> projects;
  final String message;

  const ProjectDeleted({
    required this.projects,
    this.message = 'Project deleted successfully',
  });

  @override
  List<Object?> get props => [projects, message];
}

/// Error state
class ProjectsError extends ProjectsState {
  final String message;
  final List<Project>? previousProjects;

  const ProjectsError({
    required this.message,
    this.previousProjects,
  });

  @override
  List<Object?> get props => [message, previousProjects];
}

/// Projects cleared
class ProjectsCleared extends ProjectsState {
  const ProjectsCleared();
}
