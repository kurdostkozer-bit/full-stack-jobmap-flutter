import '../entities/skill_entities.dart';

/// Abstract repository for skills operations
abstract class SkillRepository {
  /// Get all skills for a career profile
  Future<List<Skill>> getSkills(String careerProfileId);

  /// Create a new skill
  Future<Skill> createSkill(
    String careerProfileId,
    String name,
    int proficiency, {
    String? description,
  });

  /// Update a skill
  Future<Skill> updateSkill(
    String skillId, {
    String? name,
    int? proficiency,
    String? description,
  });

  /// Delete a skill
  Future<void> deleteSkill(String skillId);

  /// Get cached skills
  Future<List<Skill>?> getCachedSkills(String careerProfileId);

  /// Clear cached skills
  Future<void> clearCachedSkills(String careerProfileId);
}
