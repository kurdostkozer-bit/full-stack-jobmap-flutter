// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillResponseImpl _$$SkillResponseImplFromJson(Map<String, dynamic> json) =>
    _$SkillResponseImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      name: json['name'] as String,
      proficiency: (json['proficiency'] as num).toInt(),
      description: json['description'] as String?,
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SkillResponseImplToJson(_$SkillResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'name': instance.name,
      'proficiency': instance.proficiency,
      'description': instance.description,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CreateSkillRequestImpl _$$CreateSkillRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateSkillRequestImpl(
  name: json['name'] as String,
  proficiency: (json['proficiency'] as num).toInt(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$CreateSkillRequestImplToJson(
  _$CreateSkillRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'proficiency': instance.proficiency,
  'description': instance.description,
};

_$UpdateSkillRequestImpl _$$UpdateSkillRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateSkillRequestImpl(
  name: json['name'] as String?,
  proficiency: (json['proficiency'] as num?)?.toInt(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$UpdateSkillRequestImplToJson(
  _$UpdateSkillRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'proficiency': instance.proficiency,
  'description': instance.description,
};
