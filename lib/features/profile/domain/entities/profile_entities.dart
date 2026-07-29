import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entities.freezed.dart';
part 'profile_entities.g.dart';

/// Career Profile entity (Main profile with user info)
@freezed
class CareerProfile with _$CareerProfile {
  const factory CareerProfile({
    required String id,
    required String userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CareerProfile;

  factory CareerProfile.fromJson(Map<String, dynamic> json) =>
      _$CareerProfileFromJson(json);
}

/// Skill entity
@freezed
class Skill with _$Skill {
  const factory Skill({
    required String id,
    required String careerProfileId,
    required String name,
    required int proficiency, // 1-5
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

/// Experience entity
@freezed
class Experience with _$Experience {
  const factory Experience({
    required String id,
    required String careerProfileId,
    required String jobTitle,
    required String companyName,
    String? companyWebsite,
    required String location,
    required DateTime startDate,
    DateTime? endDate,
    required bool isCurrent,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

/// Education entity
@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String careerProfileId,
    required String schoolName,
    required String fieldOfStudy,
    required String degreeType, // Bachelor, Master, PhD, etc.
    DateTime? startDate,
    DateTime? endDate,
    String? grade,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

/// Language entity
@freezed
class Language with _$Language {
  const factory Language({
    required String id,
    required String careerProfileId,
    required String name,
    required String proficiency, // Native, Fluent, Intermediate, Basic
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

/// Project entity
@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String careerProfileId,
    required String title,
    String? description,
    List<String>? technologies,
    String? projectUrl,
    String? imageUrl,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    required bool isCurrent,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

/// Certificate entity
@freezed
class Certificate with _$Certificate {
  const factory Certificate({
    required String id,
    required String careerProfileId,
    required String name,
    required String issuer,
    String? credentialId,
    String? credentialUrl,
    required DateTime issueDate,
    DateTime? expiryDate,
    required bool doesNotExpire,
    required String verificationStatus, // PENDING, VERIFIED, REJECTED
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Certificate;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}
