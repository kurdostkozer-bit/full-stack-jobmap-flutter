import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app_localizations.dart';

class LocalizationService {
  static const String _languageKey = 'app_language';
  static const String _defaultLanguage = 'en';
  
  static LocalizationService? _instance;

  final FlutterSecureStorage _secureStorage;
  String _currentLanguage = _defaultLanguage;

  LocalizationService._internal({required this._secureStorage});

  static LocalizationService get instance {
    return _instance ??
        (throw Exception('LocalizationService not initialized'));
  }

  static Future<void> initialize(FlutterSecureStorage secureStorage) async {
    _instance ??= LocalizationService._internal(secureStorage: secureStorage);
    await _instance!._initializeLanguage();
  }

  String get currentLanguage => _currentLanguage;

  bool get isArabic => _currentLanguage == 'ar';

  bool get isRTL => AppLocalizations.isRTL(_currentLanguage);

  Future<void> _initializeLanguage() async {
    final savedLanguage = await _getLanguage();
    _currentLanguage = savedLanguage;
  }

  Future<void> setLanguage(String languageCode) async {
    if (['en', 'ar', 'ku', 'tr'].contains(languageCode)) {
      _currentLanguage = languageCode;
      await _saveLanguage(languageCode);
    }
  }

  String translate(String key) {
    return AppLocalizations.get(key, _currentLanguage);
  }

  Future<String> _getLanguage() async {
    try {
      final language = await _secureStorage.read(key: _languageKey);
      return language ?? _defaultLanguage;
    } catch (e) {
      return _defaultLanguage;
    }
  }

  Future<void> _saveLanguage(String languageCode) async {
    try {
      await _secureStorage.write(key: _languageKey, value: languageCode);
    } catch (e) {
      rethrow;
    }
  }
}
