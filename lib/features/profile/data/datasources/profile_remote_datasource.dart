import 'package:flutter/foundation.dart';
import '../../../../core/network/api_client.dart';
import '../models/profile_models.dart';

abstract class ProfileRemoteDataSource {
  /// Get current user's career profile from API
  Future<CareerProfileResponse> getProfile();

  /// Update career profile on API
  Future<CareerProfileResponse> updateProfile(
    Map<String, dynamic> updateData,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<CareerProfileResponse> getProfile() async {
    try {
      debugPrint('🌐 ProfileRemoteDataSource: GET /career-profiles/me');
      final response = await apiClient.get(
        '/career-profiles/me',
        fromJson: (json) => CareerProfileResponse.fromJson(json),
      );
      debugPrint('🌐 ProfileRemoteDataSource: Response received successfully');
      return response;
    } catch (e, st) {
      debugPrint('❌ ProfileRemoteDataSource: GET /career-profiles/me failed - $e');
      debugPrint('   StackTrace: $st');
      rethrow;
    }
  }

  @override
  Future<CareerProfileResponse> updateProfile(
    Map<String, dynamic> updateData,
  ) async {
    try {
      debugPrint('🌐 ProfileRemoteDataSource: PATCH /career-profiles/me');
      debugPrint('   Data: $updateData');
      final response = await apiClient.patch(
        '/career-profiles/me',
        data: updateData,
        fromJson: (json) => CareerProfileResponse.fromJson(json),
      );
      debugPrint('🌐 ProfileRemoteDataSource: Update successful');
      return response;
    } catch (e, st) {
      debugPrint('❌ ProfileRemoteDataSource: PATCH /career-profiles/me failed - $e');
      debugPrint('   StackTrace: $st');
      rethrow;
    }
  }
}
