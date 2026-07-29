// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_preference_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPreferenceModel _$JobPreferenceModelFromJson(Map<String, dynamic> json) =>
    JobPreferenceModel(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      jobTitles: (json['jobTitles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      industries: (json['industries'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      workEnvironments: (json['workEnvironments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      employmentTypes: (json['employmentTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locations: (json['locations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      minSalary: (json['minSalary'] as num?)?.toInt(),
      maxSalary: (json['maxSalary'] as num?)?.toInt(),
      salaryCurrency: json['salaryCurrency'] as String? ?? 'USD',
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobPreferenceModelToJson(JobPreferenceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'jobTitles': instance.jobTitles,
      'industries': instance.industries,
      'workEnvironments': instance.workEnvironments,
      'employmentTypes': instance.employmentTypes,
      'locations': instance.locations,
      'minSalary': instance.minSalary,
      'maxSalary': instance.maxSalary,
      'salaryCurrency': instance.salaryCurrency,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

JobPreferenceResponseDto _$JobPreferenceResponseDtoFromJson(
  Map<String, dynamic> json,
) => JobPreferenceResponseDto(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  jobTitles: (json['jobTitles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  industries: (json['industries'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  workEnvironments: (json['workEnvironments'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  employmentTypes: (json['employmentTypes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  locations: (json['locations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minSalary: (json['minSalary'] as num?)?.toInt(),
  maxSalary: (json['maxSalary'] as num?)?.toInt(),
  salaryCurrency: json['salaryCurrency'] as String? ?? 'USD',
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$JobPreferenceResponseDtoToJson(
  JobPreferenceResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'jobTitles': instance.jobTitles,
  'industries': instance.industries,
  'workEnvironments': instance.workEnvironments,
  'employmentTypes': instance.employmentTypes,
  'locations': instance.locations,
  'minSalary': instance.minSalary,
  'maxSalary': instance.maxSalary,
  'salaryCurrency': instance.salaryCurrency,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

CreateJobPreferenceDto _$CreateJobPreferenceDtoFromJson(
  Map<String, dynamic> json,
) => CreateJobPreferenceDto(
  careerProfileId: json['careerProfileId'] as String,
  jobTitles: (json['jobTitles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  industries: (json['industries'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  workEnvironments: (json['workEnvironments'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  employmentTypes: (json['employmentTypes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  locations: (json['locations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  minSalary: (json['minSalary'] as num?)?.toInt(),
  maxSalary: (json['maxSalary'] as num?)?.toInt(),
  salaryCurrency: json['salaryCurrency'] as String? ?? 'USD',
);

Map<String, dynamic> _$CreateJobPreferenceDtoToJson(
  CreateJobPreferenceDto instance,
) => <String, dynamic>{
  'careerProfileId': instance.careerProfileId,
  'jobTitles': instance.jobTitles,
  'industries': instance.industries,
  'workEnvironments': instance.workEnvironments,
  'employmentTypes': instance.employmentTypes,
  'locations': instance.locations,
  'minSalary': instance.minSalary,
  'maxSalary': instance.maxSalary,
  'salaryCurrency': instance.salaryCurrency,
};

UpdateJobPreferenceDto _$UpdateJobPreferenceDtoFromJson(
  Map<String, dynamic> json,
) => UpdateJobPreferenceDto(
  jobTitles: (json['jobTitles'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  industries: (json['industries'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  workEnvironments: (json['workEnvironments'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  employmentTypes: (json['employmentTypes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  locations: (json['locations'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  minSalary: (json['minSalary'] as num?)?.toInt(),
  maxSalary: (json['maxSalary'] as num?)?.toInt(),
  salaryCurrency: json['salaryCurrency'] as String?,
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$UpdateJobPreferenceDtoToJson(
  UpdateJobPreferenceDto instance,
) => <String, dynamic>{
  'jobTitles': instance.jobTitles,
  'industries': instance.industries,
  'workEnvironments': instance.workEnvironments,
  'employmentTypes': instance.employmentTypes,
  'locations': instance.locations,
  'minSalary': instance.minSalary,
  'maxSalary': instance.maxSalary,
  'salaryCurrency': instance.salaryCurrency,
  'isActive': instance.isActive,
};
