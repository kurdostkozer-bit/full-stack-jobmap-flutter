import 'package:equatable/equatable.dart';

abstract class SkillEvent extends Equatable {
  const SkillEvent();

  @override
  List<Object?> get props => [];
}

/// Load skills for a career profile
class LoadSkillsEvent extends SkillEvent {
  final String careerProfileId;

  const LoadSkillsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new skill
class CreateSkillEvent extends SkillEvent {
  final String careerProfileId;
  final String name;
  final int proficiency;
  final String? description;

  const CreateSkillEvent(
    this.careerProfileId,
    this.name,
    this.proficiency, {
    this.description,
  });

  @override
  List<Object?> get props => [careerProfileId, name, proficiency, description];
}

/// Update a skill
class UpdateSkillEvent extends SkillEvent {
  final String skillId;
  final String? name;
  final int? proficiency;
  final String? description;

  const UpdateSkillEvent(
    this.skillId, {
    this.name,
    this.proficiency,
    this.description,
  });

  @override
  List<Object?> get props => [skillId, name, proficiency, description];
}

/// Delete a skill
class DeleteSkillEvent extends SkillEvent {
  final String skillId;

  const DeleteSkillEvent(this.skillId);

  @override
  List<Object?> get props => [skillId];
}

/// Refresh skills list
class RefreshSkillsEvent extends SkillEvent {
  final String careerProfileId;

  const RefreshSkillsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
