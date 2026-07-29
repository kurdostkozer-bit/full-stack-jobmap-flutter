import 'package:freezed_annotation/freezed_annotation.dart';

part 'languages_entities.freezed.dart';
part 'languages_entities.g.dart';

/// Language proficiency levels
enum LanguageProficiency {
  @JsonValue('BEGINNER')
  beginner,
  @JsonValue('INTERMEDIATE')
  intermediate,
  @JsonValue('ADVANCED')
  advanced,
  @JsonValue('FLUENT')
  fluent,
}

/// Language entity
@freezed
class Language with _$Language {
  const factory Language({
    required String id,
    required String careerProfileId,
    required String name,
    required LanguageProficiency proficiency,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}
