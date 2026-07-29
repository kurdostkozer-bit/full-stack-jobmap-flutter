import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/experience_entities.dart';

part 'experience_models.freezed.dart';
part 'experience_models.g.dart';

/// Experience Response model (from API)
@freezed
class ExperienceResponse with _$ExperienceResponse {
  const factory ExperienceResponse({
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
  }) = _ExperienceResponse;

  factory ExperienceResponse.fromJson(Map<String, dynamic> json) =>
      _$ExperienceResponseFromJson(json);
}

extension ExperienceResponseX on ExperienceResponse {
  /// Convert to domain entity
  Experience toDomain() {
    return Experience(
      id: id,
      careerProfileId: careerProfileId,
      jobTitle: jobTitle,
      companyName: companyName,
      companyWebsite: companyWebsite,
      location: location,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Experience Request model
@freezed
class CreateExperienceRequest with _$CreateExperienceRequest {
  const factory CreateExperienceRequest({
    required String jobTitle,
    required String companyName,
    String? companyWebsite,
    required String location,
    required DateTime startDate,
    DateTime? endDate,
    required bool isCurrent,
    String? description,
  }) = _CreateExperienceRequest;

  factory CreateExperienceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExperienceRequestFromJson(json);
}

/// Update Experience Request model
@freezed
class UpdateExperienceRequest with _$UpdateExperienceRequest {
  const factory UpdateExperienceRequest({
    String? jobTitle,
    String? companyName,
    String? companyWebsite,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
  }) = _UpdateExperienceRequest;

  factory UpdateExperienceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateExperienceRequestFromJson(json);
}

extension UpdateExperienceRequestX on UpdateExperienceRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (jobTitle != null) 'jobTitle': jobTitle,
      if (companyName != null) 'companyName': companyName,
      if (companyWebsite != null) 'companyWebsite': companyWebsite,
      if (location != null) 'location': location,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (isCurrent != null) 'isCurrent': isCurrent,
      if (description != null) 'description': description,
    };
  }
}
