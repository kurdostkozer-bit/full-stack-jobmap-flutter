import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_entities.freezed.dart';
part 'experience_entities.g.dart';

/// Experience (Job History) entity
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
