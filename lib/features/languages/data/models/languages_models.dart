import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/languages_entities.dart';

part 'languages_models.freezed.dart';
part 'languages_models.g.dart';

/// Language Response model (from API)
@freezed
class LanguageResponse with _$LanguageResponse {
  const factory LanguageResponse({
    required String id,
    required String careerProfileId,
    required String name,
    required LanguageProficiency proficiency,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LanguageResponse;

  factory LanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguageResponseFromJson(json);
}

extension LanguageResponseX on LanguageResponse {
  /// Convert to domain entity
  Language toDomain() {
    return Language(
      id: id,
      careerProfileId: careerProfileId,
      name: name,
      proficiency: proficiency,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Language Request model
@freezed
class CreateLanguageRequest with _$CreateLanguageRequest {
  const factory CreateLanguageRequest({
    required String name,
    required LanguageProficiency proficiency,
  }) = _CreateLanguageRequest;

  factory CreateLanguageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLanguageRequestFromJson(json);
}

/// Update Language Request model
@freezed
class UpdateLanguageRequest with _$UpdateLanguageRequest {
  const factory UpdateLanguageRequest({
    String? name,
    LanguageProficiency? proficiency,
  }) = _UpdateLanguageRequest;

  factory UpdateLanguageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLanguageRequestFromJson(json);
}

extension UpdateLanguageRequestX on UpdateLanguageRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (name != null) 'name': name,
      if (proficiency != null) 'proficiency': proficiency,
    };
  }
}
