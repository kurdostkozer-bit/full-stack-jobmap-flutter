import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Load profile from API
class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

/// Update profile
class UpdateProfileEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? bio;
  final String? headline;
  final String? location;
  final String? website;
  final String? linkedinUrl;
  final String? githubUrl;

  const UpdateProfileEvent({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.headline,
    this.location,
    this.website,
    this.linkedinUrl,
    this.githubUrl,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        profileImageUrl,
        bio,
        headline,
        location,
        website,
        linkedinUrl,
        githubUrl,
      ];
}

/// Clear profile (on logout)
class ClearProfileEvent extends ProfileEvent {
  const ClearProfileEvent();
}
