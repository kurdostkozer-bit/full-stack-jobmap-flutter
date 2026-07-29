import 'package:equatable/equatable.dart';
import '../../domain/entities/languages_entities.dart';

abstract class LanguagesState extends Equatable {
  const LanguagesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LanguagesInitial extends LanguagesState {
  const LanguagesInitial();
}

/// Loading languages
class LanguagesLoading extends LanguagesState {
  const LanguagesLoading();
}

/// Languages loaded successfully
class LanguagesLoaded extends LanguagesState {
  final List<Language> languages;

  const LanguagesLoaded({required this.languages});

  @override
  List<Object?> get props => [languages];
}

/// Creating new language
class LanguageCreating extends LanguagesState {
  final List<Language> currentLanguages;

  const LanguageCreating({required this.currentLanguages});

  @override
  List<Object?> get props => [currentLanguages];
}

/// Language created successfully
class LanguageCreated extends LanguagesState {
  final List<Language> languages;
  final String message;

  const LanguageCreated({
    required this.languages,
    this.message = 'Language added successfully',
  });

  @override
  List<Object?> get props => [languages, message];
}

/// Updating language
class LanguageUpdating extends LanguagesState {
  final List<Language> currentLanguages;

  const LanguageUpdating({required this.currentLanguages});

  @override
  List<Object?> get props => [currentLanguages];
}

/// Language updated successfully
class LanguageUpdated extends LanguagesState {
  final List<Language> languages;
  final String message;

  const LanguageUpdated({
    required this.languages,
    this.message = 'Language updated successfully',
  });

  @override
  List<Object?> get props => [languages, message];
}

/// Deleting language
class LanguageDeleting extends LanguagesState {
  final List<Language> currentLanguages;

  const LanguageDeleting({required this.currentLanguages});

  @override
  List<Object?> get props => [currentLanguages];
}

/// Language deleted successfully
class LanguageDeleted extends LanguagesState {
  final List<Language> languages;
  final String message;

  const LanguageDeleted({
    required this.languages,
    this.message = 'Language deleted successfully',
  });

  @override
  List<Object?> get props => [languages, message];
}

/// Error state
class LanguagesError extends LanguagesState {
  final String message;
  final List<Language>? previousLanguages;

  const LanguagesError({
    required this.message,
    this.previousLanguages,
  });

  @override
  List<Object?> get props => [message, previousLanguages];
}

/// Languages cleared
class LanguagesCleared extends LanguagesState {
  const LanguagesCleared();
}
