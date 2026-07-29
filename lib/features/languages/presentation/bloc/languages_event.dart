import 'package:equatable/equatable.dart';
import '../../domain/entities/languages_entities.dart';

abstract class LanguagesEvent extends Equatable {
  const LanguagesEvent();

  @override
  List<Object?> get props => [];
}

/// Load languages for a career profile
class LoadLanguagesEvent extends LanguagesEvent {
  final String careerProfileId;

  const LoadLanguagesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new language
class CreateLanguageEvent extends LanguagesEvent {
  final String careerProfileId;
  final String name;
  final LanguageProficiency proficiency;

  const CreateLanguageEvent(
    this.careerProfileId,
    this.name,
    this.proficiency,
  );

  @override
  List<Object?> get props => [careerProfileId, name, proficiency];
}

/// Update a language
class UpdateLanguageEvent extends LanguagesEvent {
  final String languageId;
  final String? name;
  final LanguageProficiency? proficiency;

  const UpdateLanguageEvent(
    this.languageId, {
    this.name,
    this.proficiency,
  });

  @override
  List<Object?> get props => [languageId, name, proficiency];
}

/// Delete a language
class DeleteLanguageEvent extends LanguagesEvent {
  final String languageId;

  const DeleteLanguageEvent(this.languageId);

  @override
  List<Object?> get props => [languageId];
}

/// Refresh languages list
class RefreshLanguagesEvent extends LanguagesEvent {
  final String careerProfileId;

  const RefreshLanguagesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
