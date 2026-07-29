import 'package:equatable/equatable.dart';
import '../../domain/entities/skill_entities.dart';

abstract class SkillState extends Equatable {
  const SkillState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SkillInitial extends SkillState {
  const SkillInitial();
}

/// Loading skills
class SkillLoading extends SkillState {
  const SkillLoading();
}

/// Skills loaded successfully
class SkillsLoaded extends SkillState {
  final List<Skill> skills;

  const SkillsLoaded({required this.skills});

  @override
  List<Object?> get props => [skills];
}

/// Creating new skill
class SkillCreating extends SkillState {
  final List<Skill> currentSkills;

  const SkillCreating({required this.currentSkills});

  @override
  List<Object?> get props => [currentSkills];
}

/// Skill created successfully
class SkillCreated extends SkillState {
  final List<Skill> skills;
  final String message;

  const SkillCreated({
    required this.skills,
    this.message = 'Skill added successfully',
  });

  @override
  List<Object?> get props => [skills, message];
}

/// Updating skill
class SkillUpdating extends SkillState {
  final List<Skill> currentSkills;

  const SkillUpdating({required this.currentSkills});

  @override
  List<Object?> get props => [currentSkills];
}

/// Skill updated successfully
class SkillUpdated extends SkillState {
  final List<Skill> skills;
  final String message;

  const SkillUpdated({
    required this.skills,
    this.message = 'Skill updated successfully',
  });

  @override
  List<Object?> get props => [skills, message];
}

/// Deleting skill
class SkillDeleting extends SkillState {
  final List<Skill> currentSkills;

  const SkillDeleting({required this.currentSkills});

  @override
  List<Object?> get props => [currentSkills];
}

/// Skill deleted successfully
class SkillDeleted extends SkillState {
  final List<Skill> skills;
  final String message;

  const SkillDeleted({
    required this.skills,
    this.message = 'Skill deleted successfully',
  });

  @override
  List<Object?> get props => [skills, message];
}

/// Error state
class SkillError extends SkillState {
  final String message;
  final List<Skill>? previousSkills; // For rollback UI

  const SkillError({
    required this.message,
    this.previousSkills,
  });

  @override
  List<Object?> get props => [message, previousSkills];
}

/// Skills cleared
class SkillCleared extends SkillState {
  const SkillCleared();
}
