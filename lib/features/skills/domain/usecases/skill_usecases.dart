import '../entities/skill_entities.dart';
import '../repositories/skill_repository.dart';

/// Get all skills for a career profile
class GetSkillsUseCase {
  final SkillRepository repository;

  GetSkillsUseCase({required this.repository});

  Future<List<Skill>> call(String careerProfileId) {
    return repository.getSkills(careerProfileId);
  }
}

/// Create a new skill
class CreateSkillUseCase {
  final SkillRepository repository;

  CreateSkillUseCase({required this.repository});

  Future<Skill> call(
    String careerProfileId,
    String name,
    int proficiency, {
    String? description,
  }) {
    return repository.createSkill(
      careerProfileId,
      name,
      proficiency,
      description: description,
    );
  }
}

/// Update a skill
class UpdateSkillUseCase {
  final SkillRepository repository;

  UpdateSkillUseCase({required this.repository});

  Future<Skill> call(
    String skillId, {
    String? name,
    int? proficiency,
    String? description,
  }) {
    return repository.updateSkill(
      skillId,
      name: name,
      proficiency: proficiency,
      description: description,
    );
  }
}

/// Delete a skill
class DeleteSkillUseCase {
  final SkillRepository repository;

  DeleteSkillUseCase({required this.repository});

  Future<void> call(String skillId) {
    return repository.deleteSkill(skillId);
  }
}
