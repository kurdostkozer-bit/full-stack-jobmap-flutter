import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/education_entities.dart';

part 'education_models.freezed.dart';
part 'education_models.g.dart';

/// Education Response model (from API)
@freezed
class EducationResponse with _$EducationResponse {
  const factory EducationResponse({
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
  }) = _EducationResponse;

  factory EducationResponse.fromJson(Map<String, dynamic> json) =>
      _$EducationResponseFromJson(json);
}

extension EducationResponseX on EducationResponse {
  /// Convert to domain entity
  Education toDomain() {
    return Education(
      id: id,
      careerProfileId: careerProfileId,
      school: school,
      degree: degree,
      fieldOfStudy: fieldOfStudy,
      startDate: startDate,
      endDate: endDate,
      currentlyStudying: currentlyStudying,
      description: description,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Education Request model
@freezed
class CreateEducationRequest with _$CreateEducationRequest {
  const factory CreateEducationRequest({
    required String school,
    required String degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    required bool currentlyStudying,
    String? description,
  }) = _CreateEducationRequest;

  factory CreateEducationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEducationRequestFromJson(json);
}

/// Update Education Request model
@freezed
class UpdateEducationRequest with _$UpdateEducationRequest {
  const factory UpdateEducationRequest({
    String? school,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? currentlyStudying,
    String? description,
  }) = _UpdateEducationRequest;

  factory UpdateEducationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEducationRequestFromJson(json);
}

extension UpdateEducationRequestX on UpdateEducationRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (school != null) 'school': school,
      if (degree != null) 'degree': degree,
      if (fieldOfStudy != null) 'fieldOfStudy': fieldOfStudy,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (currentlyStudying != null) 'currentlyStudying': currentlyStudying,
      if (description != null) 'description': description,
    };
  }
}
