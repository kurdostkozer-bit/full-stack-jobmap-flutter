// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillImpl _$$SkillImplFromJson(Map<String, dynamic> json) => _$SkillImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  name: json['name'] as String,
  proficiency: (json['proficiency'] as num).toInt(),
  description: json['description'] as String?,
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$SkillImplToJson(_$SkillImpl instance) =>
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
