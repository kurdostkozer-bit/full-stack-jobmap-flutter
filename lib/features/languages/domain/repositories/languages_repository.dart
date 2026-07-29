import '../entities/languages_entities.dart';

/// Abstract repository for language operations
abstract class LanguagesRepository {
  /// Get all languages for a career profile
  Future<List<Language>> getLanguages(String careerProfileId);

  /// Create a new language
  Future<Language> createLanguage(
    String careerProfileId,
    String name,
    LanguageProficiency proficiency,
  );

  /// Update a language
  Future<Language> updateLanguage(
    String languageId, {
    String? name,
    LanguageProficiency? proficiency,
  });

  /// Delete a language
  Future<void> deleteLanguage(String languageId);

  /// Get cached languages
  Future<List<Language>?> getCachedLanguages(String careerProfileId);

  /// Clear cached languages
  Future<void> clearCachedLanguages(String careerProfileId);
}
