import '../../../../core/network/api_client.dart';
import '../models/languages_models.dart';

abstract class LanguagesRemoteDataSource {
  /// Get all languages for a career profile
  Future<List<LanguageResponse>> getLanguages(String careerProfileId);

  /// Create a new language
  Future<LanguageResponse> createLanguage(
    String careerProfileId,
    Map<String, dynamic> languageData,
  );

  /// Update a language
  Future<LanguageResponse> updateLanguage(
    String languageId,
    Map<String, dynamic> languageData,
  );

  /// Delete a language
  Future<void> deleteLanguage(String languageId);
}

class LanguagesRemoteDataSourceImpl implements LanguagesRemoteDataSource {
  final ApiClient apiClient;

  LanguagesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<LanguageResponse>> getLanguages(String careerProfileId) async {
    final response = await apiClient.get<List<LanguageResponse>>(
      '/languages/career-profile/$careerProfileId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) =>
                  LanguageResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          final languages =
              json['languages'] ?? json['data'] ?? json;
          if (languages is List) {
            return languages
                .map((item) =>
                    LanguageResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return <LanguageResponse>[];
      },
    );
    return response;
  }

  @override
  Future<LanguageResponse> createLanguage(
    String careerProfileId,
    Map<String, dynamic> languageData,
  ) async {
    return await apiClient.post(
      '/languages',
      data: {
        ...languageData,
        'careerProfileId': careerProfileId,
      },
      fromJson: (json) => LanguageResponse.fromJson(json),
    );
  }

  @override
  Future<LanguageResponse> updateLanguage(
    String languageId,
    Map<String, dynamic> languageData,
  ) async {
    return await apiClient.patch(
      '/languages/$languageId',
      data: languageData,
      fromJson: (json) => LanguageResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteLanguage(String languageId) async {
    await apiClient.delete('/languages/$languageId');
  }
}
