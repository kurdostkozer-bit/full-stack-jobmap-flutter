import '../entities/profile_entities.dart';
import '../repositories/profile_repository.dart';

/// Get current user's career profile
class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<CareerProfile> call() {
    return repository.getProfile();
  }
}

/// Update career profile
class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});

  Future<CareerProfile> call({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
  }) {
    return repository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
      bio: bio,
      headline: headline,
      location: location,
      website: website,
      linkedinUrl: linkedinUrl,
      githubUrl: githubUrl,
    );
  }
}

/// Get cached profile from local storage
class GetCachedProfileUseCase {
  final ProfileRepository repository;

  GetCachedProfileUseCase({required this.repository});

  Future<CareerProfile?> call() {
    return repository.getCachedProfile();
  }
}
