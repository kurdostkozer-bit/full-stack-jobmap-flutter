// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EducationResponseImpl _$$EducationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$EducationResponseImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  school: json['school'] as String,
  degree: json['degree'] as String,
  fieldOfStudy: json['fieldOfStudy'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  currentlyStudying: json['currentlyStudying'] as bool,
  description: json['description'] as String?,
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$EducationResponseImplToJson(
  _$EducationResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'school': instance.school,
  'degree': instance.degree,
  'fieldOfStudy': instance.fieldOfStudy,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'currentlyStudying': instance.currentlyStudying,
  'description': instance.description,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$CreateEducationRequestImpl _$$CreateEducationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateEducationRequestImpl(
  school: json['school'] as String,
  degree: json['degree'] as String,
  fieldOfStudy: json['fieldOfStudy'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  currentlyStudying: json['currentlyStudying'] as bool,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$CreateEducationRequestImplToJson(
  _$CreateEducationRequestImpl instance,
) => <String, dynamic>{
  'school': instance.school,
  'degree': instance.degree,
  'fieldOfStudy': instance.fieldOfStudy,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'currentlyStudying': instance.currentlyStudying,
  'description': instance.description,
};

_$UpdateEducationRequestImpl _$$UpdateEducationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateEducationRequestImpl(
  school: json['school'] as String?,
  degree: json['degree'] as String?,
  fieldOfStudy: json['fieldOfStudy'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  currentlyStudying: json['currentlyStudying'] as bool?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$UpdateEducationRequestImplToJson(
  _$UpdateEducationRequestImpl instance,
) => <String, dynamic>{
  'school': instance.school,
  'degree': instance.degree,
  'fieldOfStudy': instance.fieldOfStudy,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'currentlyStudying': instance.currentlyStudying,
  'description': instance.description,
};
