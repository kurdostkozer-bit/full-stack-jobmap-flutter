import '../../domain/entities/profile_entities.dart';

/// Career Profile Response model (from API) - matches backend CareerProfileResponseDto
class CareerProfileResponse {
  final String id;
  final String userId;
  final String? headline;
  final String? summary;
  final String? professionTitle;
  final String? location;
  final String? preferredJobTitles;
  final String? preferredIndustries;
  final int? salaryMin;
  final int? salaryMax;
  final String? currency;
  final String? workPreference;
  final String? remotePreference;
  final String? relocationPreference;
  final String? profileStatus;
  final String? privacyLevel;
  final int? profileCompletion;
  final String? resumeUrl;
  final bool? isPublic;
  final bool? isDeleted;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  CareerProfileResponse({
    required this.id,
    required this.userId,
    this.headline,
    this.summary,
    this.professionTitle,
    this.location,
    this.preferredJobTitles,
    this.preferredIndustries,
    this.salaryMin,
    this.salaryMax,
    this.currency,
    this.workPreference,
    this.remotePreference,
    this.relocationPreference,
    this.profileStatus,
    this.privacyLevel,
    this.profileCompletion,
    this.resumeUrl,
    this.isPublic,
    this.isDeleted,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CareerProfileResponse.fromJson(Map<String, dynamic> json) {
    return CareerProfileResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      headline: json['headline'] as String?,
      summary: json['summary'] as String?,
      professionTitle: json['professionTitle'] as String?,
      location: json['location'] as String?,
      preferredJobTitles: json['preferredJobTitles'] as String?,
      preferredIndustries: json['preferredIndustries'] as String?,
      salaryMin: json['salaryMin'] as int?,
      salaryMax: json['salaryMax'] as int?,
      currency: json['currency'] as String?,
      workPreference: json['workPreference'] as String?,
      remotePreference: json['remotePreference'] as String?,
      relocationPreference: json['relocationPreference'] as String?,
      profileStatus: json['profileStatus'] as String?,
      privacyLevel: json['privacyLevel'] as String?,
      profileCompletion: json['profileCompletion'] as int?,
      resumeUrl: json['resumeUrl'] as String?,
      isPublic: json['isPublic'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'headline': headline,
      'summary': summary,
      'professionTitle': professionTitle,
      'location': location,
      'preferredJobTitles': preferredJobTitles,
      'preferredIndustries': preferredIndustries,
      'salaryMin': salaryMin,
      'salaryMax': salaryMax,
      'currency': currency,
      'workPreference': workPreference,
      'remotePreference': remotePreference,
      'relocationPreference': relocationPreference,
      'profileStatus': profileStatus,
      'privacyLevel': privacyLevel,
      'profileCompletion': profileCompletion,
      'resumeUrl': resumeUrl,
      'isPublic': isPublic,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

extension CareerProfileResponseX on CareerProfileResponse {
  /// Convert to domain entity
  CareerProfile toDomain() {
    return CareerProfile(
      id: id,
      userId: userId,
      firstName: null,
      lastName: null,
      email: null,
      phoneNumber: null,
      profileImageUrl: null,
      bio: summary,
      headline: headline,
      location: location,
      website: null,
      linkedinUrl: null,
      githubUrl: null,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Update Profile Request model
class UpdateProfileRequest {
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

  UpdateProfileRequest({
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

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      bio: json['bio'] as String?,
      headline: json['headline'] as String?,
      location: json['location'] as String?,
      website: json['website'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
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

extension UpdateProfileRequestX on UpdateProfileRequest {
  /// Convert to JSON for API - map to backend fields
  Map<String, dynamic> toApiJson() {
    return {
      if (headline != null) 'headline': headline,
      if (bio != null) 'summary': bio,
      if (location != null) 'location': location,
    };
  }
}
