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
    return await apiClient.get(
      '/profile',
      fromJson: (json) => CareerProfileResponse.fromJson(json),
    );
  }

  @override
  Future<CareerProfileResponse> updateProfile(
    Map<String, dynamic> updateData,
  ) async {
    return await apiClient.patch(
      '/profile',
      data: updateData,
      fromJson: (json) => CareerProfileResponse.fromJson(json),
    );
  }
}
