import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/experience_entities.dart';
import '../../domain/usecases/experience_usecases.dart';
import '../../../../core/network/models/api_exception.dart';
import 'experience_event.dart';
import 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final GetExperiencesUseCase getExperiencesUseCase;
  final CreateExperienceUseCase createExperienceUseCase;
  final UpdateExperienceUseCase updateExperienceUseCase;
  final DeleteExperienceUseCase deleteExperienceUseCase;

  ExperienceBloc({
    required this.getExperiencesUseCase,
    required this.createExperienceUseCase,
    required this.updateExperienceUseCase,
    required this.deleteExperienceUseCase,
  }) : super(const ExperienceInitial()) {
    on<LoadExperiencesEvent>(_onLoadExperiences);
    on<CreateExperienceEvent>(_onCreateExperience);
    on<UpdateExperienceEvent>(_onUpdateExperience);
    on<DeleteExperienceEvent>(_onDeleteExperience);
    on<RefreshExperiencesEvent>(_onRefreshExperiences);
  }

  Future<void> _onLoadExperiences(
    LoadExperiencesEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(const ExperienceLoading());
    try {
      final experiences = await getExperiencesUseCase(event.careerProfileId);
      emit(ExperiencesLoaded(experiences: experiences));
    } on ApiException catch (e) {
      debugPrint('❌ ExperienceBloc: Error - ${e.message}');
      emit(ExperienceError(message: e.message));
    } catch (e) {
      emit(ExperienceError(message: 'Failed to load experiences: $e'));
    }
  }

  Future<void> _onCreateExperience(
    CreateExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    final currentState = state;
    final List<Experience> previousExperiences =
        currentState is ExperiencesLoaded ? currentState.experiences : <Experience>[];

    try {
      emit(ExperienceCreating(currentExperiences: previousExperiences));

      final newExperience = await createExperienceUseCase(
        event.careerProfileId,
        event.jobTitle,
        event.companyName,
        event.location,
        event.startDate,
        endDate: event.endDate,
        isCurrent: event.isCurrent,
        description: event.description,
        companyWebsite: event.companyWebsite,
      );

      final updatedExperiences = [...previousExperiences, newExperience];
      emit(ExperienceCreated(experiences: updatedExperiences));
    } on ApiException catch (e) {
      debugPrint('❌ ExperienceBloc: Error - ${e.message}');
      emit(ExperienceError(
        message: e.message,
        previousExperiences: previousExperiences,
      ));
    } catch (e) {
      emit(ExperienceError(
        message: 'Failed to create experience: $e',
        previousExperiences: previousExperiences,
      ));
    }
  }

  Future<void> _onUpdateExperience(
    UpdateExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    final currentState = state;
    final List<Experience> previousExperiences =
        currentState is ExperiencesLoaded ? currentState.experiences : <Experience>[];

    try {
      emit(ExperienceUpdating(currentExperiences: previousExperiences));

      final updatedExperience = await updateExperienceUseCase(
        event.experienceId,
        jobTitle: event.jobTitle,
        companyName: event.companyName,
        location: event.location,
        startDate: event.startDate,
        endDate: event.endDate,
        isCurrent: event.isCurrent,
        description: event.description,
      );

      final updatedExperiences = previousExperiences.map((e) {
        return e.id == event.experienceId ? updatedExperience : e;
      }).toList();

      emit(ExperienceUpdated(experiences: updatedExperiences));
    } on ApiException catch (e) {
      debugPrint('❌ ExperienceBloc: Error - ${e.message}');
      emit(ExperienceError(
        message: e.message,
        previousExperiences: previousExperiences,
      ));
    } catch (e) {
      emit(ExperienceError(
        message: 'Failed to update experience: $e',
        previousExperiences: previousExperiences,
      ));
    }
  }

  Future<void> _onDeleteExperience(
    DeleteExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    final currentState = state;
    final List<Experience> previousExperiences =
        currentState is ExperiencesLoaded ? currentState.experiences : <Experience>[];

    try {
      emit(ExperienceDeleting(currentExperiences: previousExperiences));

      await deleteExperienceUseCase(event.experienceId);

      final updatedExperiences =
          previousExperiences.where((e) => e.id != event.experienceId).toList();

      emit(ExperienceDeleted(experiences: updatedExperiences));
    } on ApiException catch (e) {
      debugPrint('❌ ExperienceBloc: Error - ${e.message}');
      emit(ExperienceError(
        message: e.message,
        previousExperiences: previousExperiences,
      ));
    } catch (e) {
      emit(ExperienceError(
        message: 'Failed to delete experience: $e',
        previousExperiences: previousExperiences,
      ));
    }
  }

  Future<void> _onRefreshExperiences(
    RefreshExperiencesEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    try {
      final experiences = await getExperiencesUseCase(event.careerProfileId);
      emit(ExperiencesLoaded(experiences: experiences));
    } on ApiException catch (e) {
      debugPrint('❌ ExperienceBloc: Error - ${e.message}');
      emit(ExperienceError(message: e.message));
    } catch (e) {
      emit(ExperienceError(message: 'Failed to refresh experiences: $e'));
    }
  }
}
