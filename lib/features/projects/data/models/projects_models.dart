import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/projects_entities.dart';

part 'projects_models.freezed.dart';
part 'projects_models.g.dart';

/// Project Response model (from API)
@freezed
class ProjectResponse with _$ProjectResponse {
  const factory ProjectResponse({
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
  }) = _ProjectResponse;

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);
}

extension ProjectResponseX on ProjectResponse {
  /// Convert to domain entity
  Project toDomain() {
    return Project(
      id: id,
      careerProfileId: careerProfileId,
      title: title,
      description: description,
      role: role,
      technologies: technologies,
      startDate: startDate,
      endDate: endDate,
      isCurrently: isCurrently,
      imageUrl: imageUrl,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Project Request model
@freezed
class CreateProjectRequest with _$CreateProjectRequest {
  const factory CreateProjectRequest({
    required String title,
    String? description,
    String? role,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    required bool isCurrently,
    String? imageUrl,
  }) = _CreateProjectRequest;

  factory CreateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateProjectRequestFromJson(json);
}

/// Update Project Request model
@freezed
class UpdateProjectRequest with _$UpdateProjectRequest {
  const factory UpdateProjectRequest({
    String? title,
    String? description,
    String? role,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrently,
    String? imageUrl,
  }) = _UpdateProjectRequest;

  factory UpdateProjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProjectRequestFromJson(json);
}

extension UpdateProjectRequestX on UpdateProjectRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (technologies != null) 'technologies': technologies,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (isCurrently != null) 'isCurrently': isCurrently,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}
