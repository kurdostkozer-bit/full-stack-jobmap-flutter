import '../entities/languages_entities.dart';
import '../repositories/languages_repository.dart';

/// Get all languages for a career profile
class GetLanguagesUseCase {
  final LanguagesRepository repository;

  GetLanguagesUseCase({required this.repository});

  Future<List<Language>> call(String careerProfileId) {
    return repository.getLanguages(careerProfileId);
  }
}

/// Create a new language
class CreateLanguageUseCase {
  final LanguagesRepository repository;

  CreateLanguageUseCase({required this.repository});

  Future<Language> call(
    String careerProfileId,
    String name,
    LanguageProficiency proficiency,
  ) {
    return repository.createLanguage(careerProfileId, name, proficiency);
  }
}

/// Update a language
class UpdateLanguageUseCase {
  final LanguagesRepository repository;

  UpdateLanguageUseCase({required this.repository});

  Future<Language> call(
    String languageId, {
    String? name,
    LanguageProficiency? proficiency,
  }) {
    return repository.updateLanguage(
      languageId,
      name: name,
      proficiency: proficiency,
    );
  }
}

/// Delete a language
class DeleteLanguageUseCase {
  final LanguagesRepository repository;

  DeleteLanguageUseCase({required this.repository});

  Future<void> call(String languageId) {
    return repository.deleteLanguage(languageId);
  }
}
