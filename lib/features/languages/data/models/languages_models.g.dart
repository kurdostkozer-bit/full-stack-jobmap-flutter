// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LanguageResponseImpl _$$LanguageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$LanguageResponseImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  name: json['name'] as String,
  proficiency: $enumDecode(_$LanguageProficiencyEnumMap, json['proficiency']),
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$LanguageResponseImplToJson(
  _$LanguageResponseImpl instance,
) => <String, dynamic>{
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

_$CreateLanguageRequestImpl _$$CreateLanguageRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateLanguageRequestImpl(
  name: json['name'] as String,
  proficiency: $enumDecode(_$LanguageProficiencyEnumMap, json['proficiency']),
);

Map<String, dynamic> _$$CreateLanguageRequestImplToJson(
  _$CreateLanguageRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'proficiency': _$LanguageProficiencyEnumMap[instance.proficiency]!,
};

_$UpdateLanguageRequestImpl _$$UpdateLanguageRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateLanguageRequestImpl(
  name: json['name'] as String?,
  proficiency: $enumDecodeNullable(
    _$LanguageProficiencyEnumMap,
    json['proficiency'],
  ),
);

Map<String, dynamic> _$$UpdateLanguageRequestImplToJson(
  _$UpdateLanguageRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'proficiency': _$LanguageProficiencyEnumMap[instance.proficiency],
};
