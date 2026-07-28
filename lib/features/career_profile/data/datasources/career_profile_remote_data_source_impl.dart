import 'career_profile_remote_data_source.dart';
import '../models/career_profile_model.dart';

class CareerProfileRemoteDataSourceImpl
    implements CareerProfileRemoteDataSource {

  const CareerProfileRemoteDataSourceImpl();

  @override
  Future<CareerProfileModel?> getCareerProfile(
    String userId,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> createCareerProfile(
    CareerProfileModel profile,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateCareerProfile(
    CareerProfileModel profile,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCareerProfile(
    String careerProfileId,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> activateCareerProfile(
    String careerProfileId,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists(
    String userId,
  ) async {
    throw UnimplementedError();
  }
}