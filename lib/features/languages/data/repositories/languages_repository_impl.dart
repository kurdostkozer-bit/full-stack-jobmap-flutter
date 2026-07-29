import '../datasources/languages_local_datasource.dart';
import '../datasources/languages_remote_datasource.dart';
import '../models/languages_models.dart';
import '../../domain/entities/languages_entities.dart';
import '../../domain/repositories/languages_repository.dart';

class LanguagesRepositoryImpl implements LanguagesRepository {
  final LanguagesRemoteDataSource remoteDataSource;
  final LanguagesLocalDataSource localDataSource;

  LanguagesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Language>> getLanguages(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getLanguages(careerProfileId);

      // Cache locally
      await localDataSource.cacheLanguages(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedLanguages(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Language> createLanguage(
    String careerProfileId,
    String name,
    LanguageProficiency proficiency,
  ) async {
    try {
      final request = CreateLanguageRequest(
        name: name,
        proficiency: proficiency,
      );

      final response = await remoteDataSource.createLanguage(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache
      await localDataSource.clearLanguages(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Language> updateLanguage(
    String languageId, {
    String? name,
    LanguageProficiency? proficiency,
  }) async {
    try {
      final request = UpdateLanguageRequest(
        name: name,
        proficiency: proficiency,
      );

      final response = await remoteDataSource.updateLanguage(
        languageId,
        request.toApiJson(),
      );

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteLanguage(String languageId) async {
    try {
      await remoteDataSource.deleteLanguage(languageId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Language>?> getCachedLanguages(String careerProfileId) async {
    try {
      final cached =
          await localDataSource.getCachedLanguages(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedLanguages(String careerProfileId) async {
    try {
      await localDataSource.clearLanguages(careerProfileId);
    } catch (e) {
      print('Error clearing cached languages: $e');
    }
  }
}
