import 'package:bloc/bloc.dart';
import '../../domain/entities/education_entities.dart';
import '../../domain/usecases/education_usecases.dart';
import '../../../../core/network/app_exception.dart';
import 'education_event.dart';
import 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final GetEducationsUseCase getEducationsUseCase;
  final CreateEducationUseCase createEducationUseCase;
  final UpdateEducationUseCase updateEducationUseCase;
  final DeleteEducationUseCase deleteEducationUseCase;

  EducationBloc({
    required this.getEducationsUseCase,
    required this.createEducationUseCase,
    required this.updateEducationUseCase,
    required this.deleteEducationUseCase,
  }) : super(const EducationInitial()) {
    on<LoadEducationsEvent>(_onLoadEducations);
    on<CreateEducationEvent>(_onCreateEducation);
    on<UpdateEducationEvent>(_onUpdateEducation);
    on<DeleteEducationEvent>(_onDeleteEducation);
    on<RefreshEducationsEvent>(_onRefreshEducations);
  }

  Future<void> _onLoadEducations(
    LoadEducationsEvent event,
    Emitter<EducationState> emit,
  ) async {
    emit(const EducationLoading());
    try {
      final educations = await getEducationsUseCase(event.careerProfileId);
      emit(EducationsLoaded(educations: educations));
    } on AppException catch (e) {
      emit(EducationError(message: e.message));
    } catch (e) {
      emit(EducationError(message: 'Failed to load educations: $e'));
    }
  }

  Future<void> _onCreateEducation(
    CreateEducationEvent event,
    Emitter<EducationState> emit,
  ) async {
    final currentState = state;
    final List<Education> previousEducations =
        currentState is EducationsLoaded ? currentState.educations : <Education>[];

    try {
      emit(EducationCreating(currentEducations: previousEducations));

      final newEducation = await createEducationUseCase(
        event.careerProfileId,
        event.school,
        event.degree,
        fieldOfStudy: event.fieldOfStudy,
        startDate: event.startDate,
        endDate: event.endDate,
        currentlyStudying: event.currentlyStudying,
        description: event.description,
      );

      final updatedEducations = [...previousEducations, newEducation];
      emit(EducationCreated(educations: updatedEducations));
    } on AppException catch (e) {
      emit(EducationError(
        message: e.message,
        previousEducations: previousEducations,
      ));
    } catch (e) {
      emit(EducationError(
        message: 'Failed to create education: $e',
        previousEducations: previousEducations,
      ));
    }
  }

  Future<void> _onUpdateEducation(
    UpdateEducationEvent event,
    Emitter<EducationState> emit,
  ) async {
    final currentState = state;
    final List<Education> previousEducations =
        currentState is EducationsLoaded ? currentState.educations : <Education>[];

    try {
      emit(EducationUpdating(currentEducations: previousEducations));

      final updatedEducation = await updateEducationUseCase(
        event.educationId,
        school: event.school,
        degree: event.degree,
        fieldOfStudy: event.fieldOfStudy,
        startDate: event.startDate,
        endDate: event.endDate,
        currentlyStudying: event.currentlyStudying,
        description: event.description,
      );

      final updatedEducations = previousEducations.map((e) {
        return e.id == event.educationId ? updatedEducation : e;
      }).toList();

      emit(EducationUpdated(educations: updatedEducations));
    } on AppException catch (e) {
      emit(EducationError(
        message: e.message,
        previousEducations: previousEducations,
      ));
    } catch (e) {
      emit(EducationError(
        message: 'Failed to update education: $e',
        previousEducations: previousEducations,
      ));
    }
  }

  Future<void> _onDeleteEducation(
    DeleteEducationEvent event,
    Emitter<EducationState> emit,
  ) async {
    final currentState = state;
    final List<Education> previousEducations =
        currentState is EducationsLoaded ? currentState.educations : <Education>[];

    try {
      emit(EducationDeleting(currentEducations: previousEducations));

      await deleteEducationUseCase(event.educationId);

      final updatedEducations =
          previousEducations.where((e) => e.id != event.educationId).toList();

      emit(EducationDeleted(educations: updatedEducations));
    } on AppException catch (e) {
      emit(EducationError(
        message: e.message,
        previousEducations: previousEducations,
      ));
    } catch (e) {
      emit(EducationError(
        message: 'Failed to delete education: $e',
        previousEducations: previousEducations,
      ));
    }
  }

  Future<void> _onRefreshEducations(
    RefreshEducationsEvent event,
    Emitter<EducationState> emit,
  ) async {
    try {
      final educations = await getEducationsUseCase(event.careerProfileId);
      emit(EducationsLoaded(educations: educations));
    } on AppException catch (e) {
      emit(EducationError(message: e.message));
    } catch (e) {
      emit(EducationError(message: 'Failed to refresh educations: $e'));
    }
  }
}
