import 'package:freezed_annotation/freezed_annotation.dart';

part 'projects_entities.freezed.dart';
part 'projects_entities.g.dart';

/// Project entity
@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String careerProfileId,
    required String title,
    String? description,
    String? role,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    required bool isCurrently,
    String? imageUrl,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
