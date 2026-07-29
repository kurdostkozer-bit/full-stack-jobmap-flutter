import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/skill_entities.dart';

part 'skill_models.freezed.dart';
part 'skill_models.g.dart';

/// Skill Response model (from API)
@freezed
class SkillResponse with _$SkillResponse {
  const factory SkillResponse({
    required String id,
    required String careerProfileId,
    required String name,
    required int proficiency,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SkillResponse;

  factory SkillResponse.fromJson(Map<String, dynamic> json) =>
      _$SkillResponseFromJson(json);
}

extension SkillResponseX on SkillResponse {
  /// Convert to domain entity
  Skill toDomain() {
    return Skill(
      id: id,
      careerProfileId: careerProfileId,
      name: name,
      proficiency: proficiency,
      description: description,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Skill Request model
@freezed
class CreateSkillRequest with _$CreateSkillRequest {
  const factory CreateSkillRequest({
    required String name,
    required int proficiency,
    String? description,
  }) = _CreateSkillRequest;

  factory CreateSkillRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSkillRequestFromJson(json);
}

/// Update Skill Request model
@freezed
class UpdateSkillRequest with _$UpdateSkillRequest {
  const factory UpdateSkillRequest({
    String? name,
    int? proficiency,
    String? description,
  }) = _UpdateSkillRequest;

  factory UpdateSkillRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSkillRequestFromJson(json);
}

extension UpdateSkillRequestX on UpdateSkillRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (name != null) 'name': name,
      if (proficiency != null) 'proficiency': proficiency,
      if (description != null) 'description': description,
    };
  }
}
