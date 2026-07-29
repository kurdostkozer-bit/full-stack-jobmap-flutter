// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceImpl _$$ExperienceImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceImpl(
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

Map<String, dynamic> _$$ExperienceImplToJson(_$ExperienceImpl instance) =>
    <String, dynamic>{
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
