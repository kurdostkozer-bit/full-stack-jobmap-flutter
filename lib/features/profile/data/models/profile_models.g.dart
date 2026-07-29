// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CareerProfileResponseImpl _$$CareerProfileResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CareerProfileResponseImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
  bio: json['bio'] as String?,
  headline: json['headline'] as String?,
  location: json['location'] as String?,
  website: json['website'] as String?,
  linkedinUrl: json['linkedinUrl'] as String?,
  githubUrl: json['githubUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$CareerProfileResponseImplToJson(
  _$CareerProfileResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'profileImageUrl': instance.profileImageUrl,
  'bio': instance.bio,
  'headline': instance.headline,
  'location': instance.location,
  'website': instance.website,
  'linkedinUrl': instance.linkedinUrl,
  'githubUrl': instance.githubUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$UpdateProfileRequestImpl _$$UpdateProfileRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProfileRequestImpl(
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

Map<String, dynamic> _$$UpdateProfileRequestImplToJson(
  _$UpdateProfileRequestImpl instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'profileImageUrl': instance.profileImageUrl,
  'bio': instance.bio,
  'headline': instance.headline,
  'location': instance.location,
  'website': instance.website,
  'linkedinUrl': instance.linkedinUrl,
  'githubUrl': instance.githubUrl,
};
