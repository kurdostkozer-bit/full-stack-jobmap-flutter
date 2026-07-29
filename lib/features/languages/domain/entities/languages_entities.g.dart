// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageImpl _$$LanguageImplFromJson(Map<String, dynamic> json) =>
    _$LanguageImpl(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      name: json['name'] as String,
      proficiency: $enumDecode(
        _$LanguageProficiencyEnumMap,
        json['proficiency'],
      ),
      displayOrder: (json['displayOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LanguageImplToJson(_$LanguageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'name': instance.name,
      'proficiency': _$LanguageProficiencyEnumMap[instance.proficiency]!,
      'displayOrder': instance.displayOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$LanguageProficiencyEnumMap = {
  LanguageProficiency.beginner: 'BEGINNER',
  LanguageProficiency.intermediate: 'INTERMEDIATE',
  LanguageProficiency.advanced: 'ADVANCED',
  LanguageProficiency.fluent: 'FLUENT',
};
