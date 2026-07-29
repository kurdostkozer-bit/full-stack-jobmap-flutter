// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinkModel _$SocialLinkModelFromJson(Map<String, dynamic> json) =>
    SocialLinkModel(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      platform: $enumDecode(_$SocialLinkPlatformEnumMap, json['platform']),
      url: json['url'] as String,
      isVisible: json['isVisible'] as bool? ?? true,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SocialLinkModelToJson(SocialLinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'platform': _$SocialLinkPlatformEnumMap[instance.platform]!,
      'url': instance.url,
      'isVisible': instance.isVisible,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$SocialLinkPlatformEnumMap = {
  SocialLinkPlatform.github: 'github',
  SocialLinkPlatform.linkedin: 'linkedin',
  SocialLinkPlatform.portfolio: 'portfolio',
  SocialLinkPlatform.twitter: 'twitter',
  SocialLinkPlatform.instagram: 'instagram',
  SocialLinkPlatform.codepen: 'codepen',
  SocialLinkPlatform.behance: 'behance',
  SocialLinkPlatform.dribbble: 'dribbble',
  SocialLinkPlatform.medium: 'medium',
  SocialLinkPlatform.devto: 'devto',
  SocialLinkPlatform.youtube: 'youtube',
  SocialLinkPlatform.website: 'website',
  SocialLinkPlatform.other: 'other',
};

SocialLinkResponseDto _$SocialLinkResponseDtoFromJson(
  Map<String, dynamic> json,
) => SocialLinkResponseDto(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  platform: json['platform'] as String,
  url: json['url'] as String,
  isVisible: json['isVisible'] as bool,
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$SocialLinkResponseDtoToJson(
  SocialLinkResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'platform': instance.platform,
  'url': instance.url,
  'isVisible': instance.isVisible,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

CreateSocialLinkDto _$CreateSocialLinkDtoFromJson(Map<String, dynamic> json) =>
    CreateSocialLinkDto(
      careerProfileId: json['careerProfileId'] as String,
      platform: json['platform'] as String,
      url: json['url'] as String,
      isVisible: json['isVisible'] as bool? ?? true,
    );

Map<String, dynamic> _$CreateSocialLinkDtoToJson(
  CreateSocialLinkDto instance,
) => <String, dynamic>{
  'careerProfileId': instance.careerProfileId,
  'platform': instance.platform,
  'url': instance.url,
  'isVisible': instance.isVisible,
};

UpdateSocialLinkDto _$UpdateSocialLinkDtoFromJson(Map<String, dynamic> json) =>
    UpdateSocialLinkDto(
      url: json['url'] as String?,
      isVisible: json['isVisible'] as bool?,
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateSocialLinkDtoToJson(
  UpdateSocialLinkDto instance,
) => <String, dynamic>{
  'url': instance.url,
  'isVisible': instance.isVisible,
  'displayOrder': instance.displayOrder,
};
