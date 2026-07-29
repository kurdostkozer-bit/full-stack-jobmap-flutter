import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_entities.freezed.dart';
part 'education_entities.g.dart';

/// Education entity
@freezed
class Education with _$Education {
  const factory Education({
    required String id,
    required String careerProfileId,
    required String school,
    required String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    required bool currentlyStudying,
    String? description,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}
