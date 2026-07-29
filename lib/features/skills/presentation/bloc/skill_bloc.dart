import 'package:bloc/bloc.dart';
import '../../domain/entities/skill_entities.dart';
import '../../domain/usecases/skill_usecases.dart';
import '../../../../core/network/app_exception.dart';
import 'skill_event.dart';
import 'skill_state.dart';

class SkillBloc extends Bloc<SkillEvent, SkillState> {
  final GetSkillsUseCase getSkillsUseCase;
  final CreateSkillUseCase createSkillUseCase;
  final UpdateSkillUseCase updateSkillUseCase;
  final DeleteSkillUseCase deleteSkillUseCase;

  String? _currentCareerProfileId;

  SkillBloc({
    required this.getSkillsUseCase,
    required this.createSkillUseCase,
    required this.updateSkillUseCase,
    required this.deleteSkillUseCase,
  }) : super(const SkillInitial()) {
    on<LoadSkillsEvent>(_onLoadSkills);
    on<CreateSkillEvent>(_onCreateSkill);
    on<UpdateSkillEvent>(_onUpdateSkill);
    on<DeleteSkillEvent>(_onDeleteSkill);
    on<RefreshSkillsEvent>(_onRefreshSkills);
  }

  /// Handle LoadSkillsEvent
  Future<void> _onLoadSkills(
    LoadSkillsEvent event,
    Emitter<SkillState> emit,
  ) async {
    _currentCareerProfileId = event.careerProfileId;
    emit(const SkillLoading());
    try {
      final skills = await getSkillsUseCase(event.careerProfileId);
      emit(SkillsLoaded(skills: skills));
    } on AppException catch (e) {
      emit(SkillError(message: e.message));
    } catch (e) {
      emit(SkillError(message: 'Failed to load skills: $e'));
    }
  }

  /// Handle CreateSkillEvent
  Future<void> _onCreateSkill(
    CreateSkillEvent event,
    Emitter<SkillState> emit,
  ) async {
    final currentState = state;
    final previousSkills = currentState is SkillsLoaded ? currentState.skills : [];

    try {
      emit(SkillCreating(currentSkills: previousSkills));

      final newSkill = await createSkillUseCase(
        event.careerProfileId,
        event.name,
        event.proficiency,
        description: event.description,
      );

      final updatedSkills = [...previousSkills, newSkill];
      emit(SkillCreated(skills: updatedSkills));
    } on AppException catch (e) {
      emit(SkillError(
        message: e.message,
        previousSkills: previousSkills,
      ));
    } catch (e) {
      emit(SkillError(
        message: 'Failed to create skill: $e',
        previousSkills: previousSkills,
      ));
    }
  }

  /// Handle UpdateSkillEvent
  Future<void> _onUpdateSkill(
    UpdateSkillEvent event,
    Emitter<SkillState> emit,
  ) async {
    final currentState = state;
    final previousSkills = currentState is SkillsLoaded ? currentState.skills : [];

    try {
      emit(SkillUpdating(currentSkills: previousSkills));

      final updatedSkill = await updateSkillUseCase(
        event.skillId,
        name: event.name,
        proficiency: event.proficiency,
        description: event.description,
      );

      final updatedSkills = previousSkills.map((s) {
        return s.id == event.skillId ? updatedSkill : s;
      }).toList();

      emit(SkillUpdated(skills: updatedSkills));
    } on AppException catch (e) {
      emit(SkillError(
        message: e.message,
        previousSkills: previousSkills,
      ));
    } catch (e) {
      emit(SkillError(
        message: 'Failed to update skill: $e',
        previousSkills: previousSkills,
      ));
    }
  }

  /// Handle DeleteSkillEvent
  Future<void> _onDeleteSkill(
    DeleteSkillEvent event,
    Emitter<SkillState> emit,
  ) async {
    final currentState = state;
    final previousSkills = currentState is SkillsLoaded ? currentState.skills : [];

    try {
      emit(SkillDeleting(currentSkills: previousSkills));

      await deleteSkillUseCase(event.skillId);

      final updatedSkills = previousSkills
          .where((s) => s.id != event.skillId)
          .toList();

      emit(SkillDeleted(skills: updatedSkills));
    } on AppException catch (e) {
      emit(SkillError(
        message: e.message,
        previousSkills: previousSkills,
      ));
    } catch (e) {
      emit(SkillError(
        message: 'Failed to delete skill: $e',
        previousSkills: previousSkills,
      ));
    }
  }

  /// Handle RefreshSkillsEvent
  Future<void> _onRefreshSkills(
    RefreshSkillsEvent event,
    Emitter<SkillState> emit,
  ) async {
    _currentCareerProfileId = event.careerProfileId;
    try {
      final skills = await getSkillsUseCase(event.careerProfileId);
      emit(SkillsLoaded(skills: skills));
    } on AppException catch (e) {
      emit(SkillError(message: e.message));
    } catch (e) {
      emit(SkillError(message: 'Failed to refresh skills: $e'));
    }
  }
}
