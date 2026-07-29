import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_entities.freezed.dart';
part 'skill_entities.g.dart';

/// Skill entity
@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String careerProfileId,
    required String name,
    required int proficiency, // 1-5 (Beginner, Intermediate, Advanced, Expert, Master)
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
