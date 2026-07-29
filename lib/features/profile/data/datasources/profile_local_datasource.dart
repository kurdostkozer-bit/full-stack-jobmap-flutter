import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/profile_models.dart';

abstract class ProfileLocalDataSource {
  /// Cache profile locally
  Future<void> cacheProfile(CareerProfileResponse profile);

  /// Get cached profile
  Future<CareerProfileResponse?> getCachedProfile();

  /// Clear cached profile
  Future<void> clearProfile();

  /// Check if profile exists in cache
  Future<bool> hasProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _profileKey = 'profile_cache';

  final FlutterSecureStorage secureStorage;

  ProfileLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> cacheProfile(CareerProfileResponse profile) async {
    try {
      await secureStorage.write(
        key: _profileKey,
        value: jsonEncode(profile.toJson()),
      );
    } catch (e) {
      print('Error caching profile: $e');
      rethrow;
    }
  }

  @override
  Future<CareerProfileResponse?> getCachedProfile() async {
    try {
      final json = await secureStorage.read(key: _profileKey);
      if (json != null) {
        return CareerProfileResponse.fromJson(jsonDecode(json));
      }
    } catch (e) {
      print('Error reading cached profile: $e');
    }
    return null;
  }

  @override
  Future<void> clearProfile() async {
    try {
      await secureStorage.delete(key: _profileKey);
    } catch (e) {
      print('Error clearing profile: $e');
    }
  }

  @override
  Future<bool> hasProfile() async {
    try {
      final profile = await getCachedProfile();
      return profile != null;
    } catch (e) {
      return false;
    }
  }
}
