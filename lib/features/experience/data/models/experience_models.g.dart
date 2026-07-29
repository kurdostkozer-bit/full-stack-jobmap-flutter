// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceResponseImpl _$$ExperienceResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ExperienceResponseImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  jobTitle: json['jobTitle'] as String,
  companyName: json['companyName'] as String,
  companyWebsite: json['companyWebsite'] as String?,
  location: json['location'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrent: json['isCurrent'] as bool,
  description: json['description'] as String?,
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ExperienceResponseImplToJson(
  _$ExperienceResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'jobTitle': instance.jobTitle,
  'companyName': instance.companyName,
  'companyWebsite': instance.companyWebsite,
  'location': instance.location,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrent': instance.isCurrent,
  'description': instance.description,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$CreateExperienceRequestImpl _$$CreateExperienceRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateExperienceRequestImpl(
  jobTitle: json['jobTitle'] as String,
  companyName: json['companyName'] as String,
  companyWebsite: json['companyWebsite'] as String?,
  location: json['location'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrent: json['isCurrent'] as bool,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$CreateExperienceRequestImplToJson(
  _$CreateExperienceRequestImpl instance,
) => <String, dynamic>{
  'jobTitle': instance.jobTitle,
  'companyName': instance.companyName,
  'companyWebsite': instance.companyWebsite,
  'location': instance.location,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrent': instance.isCurrent,
  'description': instance.description,
};

_$UpdateExperienceRequestImpl _$$UpdateExperienceRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateExperienceRequestImpl(
  jobTitle: json['jobTitle'] as String?,
  companyName: json['companyName'] as String?,
  companyWebsite: json['companyWebsite'] as String?,
  location: json['location'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrent: json['isCurrent'] as bool?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$UpdateExperienceRequestImplToJson(
  _$UpdateExperienceRequestImpl instance,
) => <String, dynamic>{
  'jobTitle': instance.jobTitle,
  'companyName': instance.companyName,
  'companyWebsite': instance.companyWebsite,
  'location': instance.location,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrent': instance.isCurrent,
  'description': instance.description,
};
