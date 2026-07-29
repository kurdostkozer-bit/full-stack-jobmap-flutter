import 'package:bloc/bloc.dart';
import '../../domain/entities/projects_entities.dart';
import '../../domain/usecases/projects_usecases.dart';
import '../../../../core/network/app_exception.dart';
import 'projects_event.dart';
import 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  final GetProjectsUseCase getProjectsUseCase;
  final CreateProjectUseCase createProjectUseCase;
  final UpdateProjectUseCase updateProjectUseCase;
  final DeleteProjectUseCase deleteProjectUseCase;

  ProjectsBloc({
    required this.getProjectsUseCase,
    required this.createProjectUseCase,
    required this.updateProjectUseCase,
    required this.deleteProjectUseCase,
  }) : super(const ProjectsInitial()) {
    on<LoadProjectsEvent>(_onLoadProjects);
    on<CreateProjectEvent>(_onCreateProject);
    on<UpdateProjectEvent>(_onUpdateProject);
    on<DeleteProjectEvent>(_onDeleteProject);
    on<RefreshProjectsEvent>(_onRefreshProjects);
  }

  Future<void> _onLoadProjects(
    LoadProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    emit(const ProjectsLoading());
    try {
      final projects = await getProjectsUseCase(event.careerProfileId);
      emit(ProjectsLoaded(projects: projects));
    } on AppException catch (e) {
      emit(ProjectsError(message: e.message));
    } catch (e) {
      emit(ProjectsError(message: 'Failed to load projects: $e'));
    }
  }

  Future<void> _onCreateProject(
    CreateProjectEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    final currentState = state;
    final List<Project> previousProjects = currentState is ProjectsLoaded 
        ? currentState.projects 
        : <Project>[];

    try {
      emit(ProjectCreating(currentProjects: previousProjects));

      final newProject = await createProjectUseCase(
        event.careerProfileId,
        event.title,
        event.technologies,
        description: event.description,
        role: event.role,
        startDate: event.startDate,
        endDate: event.endDate,
        isCurrently: event.isCurrently,
        imageUrl: event.imageUrl,
      );

      final updatedProjects = [...previousProjects, newProject];
      emit(ProjectCreated(projects: updatedProjects));
    } on AppException catch (e) {
      emit(ProjectsError(
        message: e.message,
        previousProjects: previousProjects,
      ));
    } catch (e) {
      emit(ProjectsError(
        message: 'Failed to create project: $e',
        previousProjects: previousProjects,
      ));
    }
  }

  Future<void> _onUpdateProject(
    UpdateProjectEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    final currentState = state;
    final List<Project> previousProjects =
        currentState is ProjectsLoaded ? currentState.projects : <Project>[];

    try {
      emit(ProjectUpdating(currentProjects: previousProjects));

      final updatedProject = await updateProjectUseCase(
        event.projectId,
        title: event.title,
        description: event.description,
        role: event.role,
        technologies: event.technologies,
        startDate: event.startDate,
        endDate: event.endDate,
        isCurrently: event.isCurrently,
        imageUrl: event.imageUrl,
      );

      final updatedProjects = previousProjects.map((p) {
        return p.id == event.projectId ? updatedProject : p;
      }).toList();

      emit(ProjectUpdated(projects: updatedProjects));
    } on AppException catch (e) {
      emit(ProjectsError(
        message: e.message,
        previousProjects: previousProjects,
      ));
    } catch (e) {
      emit(ProjectsError(
        message: 'Failed to update project: $e',
        previousProjects: previousProjects,
      ));
    }
  }

  Future<void> _onDeleteProject(
    DeleteProjectEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    final currentState = state;
    final List<Project> previousProjects =
        currentState is ProjectsLoaded ? currentState.projects : <Project>[];

    try {
      emit(ProjectDeleting(currentProjects: previousProjects));

      await deleteProjectUseCase(event.projectId);

      final updatedProjects =
          previousProjects.where((p) => p.id != event.projectId).toList();

      emit(ProjectDeleted(projects: updatedProjects));
    } on AppException catch (e) {
      emit(ProjectsError(
        message: e.message,
        previousProjects: previousProjects,
      ));
    } catch (e) {
      emit(ProjectsError(
        message: 'Failed to delete project: $e',
        previousProjects: previousProjects,
      ));
    }
  }

  Future<void> _onRefreshProjects(
    RefreshProjectsEvent event,
    Emitter<ProjectsState> emit,
  ) async {
    try {
      final projects = await getProjectsUseCase(event.careerProfileId);
      emit(ProjectsLoaded(projects: projects));
    } on AppException catch (e) {
      emit(ProjectsError(message: e.message));
    } catch (e) {
      emit(ProjectsError(message: 'Failed to refresh projects: $e'));
    }
  }
}
