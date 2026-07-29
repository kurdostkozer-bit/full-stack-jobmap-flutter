// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectResponseImpl _$$ProjectResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ProjectResponseImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  role: json['role'] as String?,
  technologies: (json['technologies'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrently: json['isCurrently'] as bool,
  imageUrl: json['imageUrl'] as String?,
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ProjectResponseImplToJson(
  _$ProjectResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'title': instance.title,
  'description': instance.description,
  'role': instance.role,
  'technologies': instance.technologies,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrently': instance.isCurrently,
  'imageUrl': instance.imageUrl,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

_$CreateProjectRequestImpl _$$CreateProjectRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateProjectRequestImpl(
  title: json['title'] as String,
  description: json['description'] as String?,
  role: json['role'] as String?,
  technologies: (json['technologies'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrently: json['isCurrently'] as bool,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$CreateProjectRequestImplToJson(
  _$CreateProjectRequestImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'role': instance.role,
  'technologies': instance.technologies,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrently': instance.isCurrently,
  'imageUrl': instance.imageUrl,
};

_$UpdateProjectRequestImpl _$$UpdateProjectRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateProjectRequestImpl(
  title: json['title'] as String?,
  description: json['description'] as String?,
  role: json['role'] as String?,
  technologies: (json['technologies'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  isCurrently: json['isCurrently'] as bool?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$UpdateProjectRequestImplToJson(
  _$UpdateProjectRequestImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'role': instance.role,
  'technologies': instance.technologies,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
  'isCurrently': instance.isCurrently,
  'imageUrl': instance.imageUrl,
};
