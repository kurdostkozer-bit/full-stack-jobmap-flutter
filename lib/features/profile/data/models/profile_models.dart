import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entities.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

/// Career Profile Response model (from API)
@freezed
class CareerProfileResponse with _$CareerProfileResponse {
  const factory CareerProfileResponse({
    required String id,
    required String userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? bio,
    String? headline,
    String? location,
    String? website,
    String? linkedinUrl,
    String? githubUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CareerProfileResponse;

  factory CareerProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$CareerProfileResponseFromJson(json);
}

extension CareerProfileResponseX on CareerProfileResponse {
  /// Convert to domain entity
  CareerProfile toDomain() {
    return CareerProfile(
      id: id,
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
      bio: bio,
      headline: headline,
      location: location,
      website: website,
      linkedinUrl: linkedinUrl,
      githubUrl: githubUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Update Profile Request model
@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
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
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

extension UpdateProfileRequestX on UpdateProfileRequest {
  /// Convert to JSON for API
  Map<String, dynamic> toApiJson() {
    return {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (bio != null) 'bio': bio,
      if (headline != null) 'headline': headline,
      if (location != null) 'location': location,
      if (website != null) 'website': website,
      if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      if (githubUrl != null) 'githubUrl': githubUrl,
    };
  }
}
