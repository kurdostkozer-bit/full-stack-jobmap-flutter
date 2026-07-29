import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/job_preference_entities.dart';

part 'job_preference_models.g.dart';

@JsonSerializable()
class JobPreferenceModel extends JobPreferenceEntity {
  JobPreferenceModel({
    required super.id,
    required super.careerProfileId,
    required super.jobTitles,
    required super.industries,
    required super.workEnvironments,
    required super.employmentTypes,
    required super.locations,
    super.minSalary,
    super.maxSalary,
    super.salaryCurrency = 'USD',
    super.isActive = true,
    required super.createdAt,
    required super.updatedAt,
  });

  factory JobPreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$JobPreferenceModelFromJson(json);

  factory JobPreferenceModel.fromEntity(JobPreferenceEntity entity) =>
      JobPreferenceModel(
        id: entity.id,
        careerProfileId: entity.careerProfileId,
        jobTitles: entity.jobTitles,
        industries: entity.industries,
        workEnvironments: entity.workEnvironments,
        employmentTypes: entity.employmentTypes,
        locations: entity.locations,
        minSalary: entity.minSalary,
        maxSalary: entity.maxSalary,
        salaryCurrency: entity.salaryCurrency,
        isActive: entity.isActive,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => _$JobPreferenceModelToJson(this);

  JobPreferenceEntity toEntity() => JobPreferenceEntity(
        id: id,
        careerProfileId: careerProfileId,
        jobTitles: jobTitles,
        industries: industries,
        workEnvironments: workEnvironments,
        employmentTypes: employmentTypes,
        locations: locations,
        minSalary: minSalary,
        maxSalary: maxSalary,
        salaryCurrency: salaryCurrency,
        isActive: isActive,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class JobPreferenceResponseDto {
  final String id;
  final String careerProfileId;
  final List<String> jobTitles;
  final List<String> industries;
  final List<String> workEnvironments;
  final List<String> employmentTypes;
  final List<String> locations;
  final int? minSalary;
  final int? maxSalary;
  final String? salaryCurrency;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobPreferenceResponseDto({
    required this.id,
    required this.careerProfileId,
    required this.jobTitles,
    required this.industries,
    required this.workEnvironments,
    required this.employmentTypes,
    required this.locations,
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency = 'USD',
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobPreferenceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$JobPreferenceResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JobPreferenceResponseDtoToJson(this);

  JobPreferenceModel toModel() => JobPreferenceModel(
        id: id,
        careerProfileId: careerProfileId,
        jobTitles: jobTitles,
        industries: industries,
        workEnvironments: workEnvironments,
        employmentTypes: employmentTypes,
        locations: locations,
        minSalary: minSalary,
        maxSalary: maxSalary,
        salaryCurrency: salaryCurrency,
        isActive: isActive,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class CreateJobPreferenceDto {
  final String careerProfileId;
  final List<String> jobTitles;
  final List<String> industries;
  final List<String> workEnvironments;
  final List<String> employmentTypes;
  final List<String> locations;
  final int? minSalary;
  final int? maxSalary;
  final String? salaryCurrency;

  CreateJobPreferenceDto({
    required this.careerProfileId,
    required this.jobTitles,
    required this.industries,
    required this.workEnvironments,
    required this.employmentTypes,
    required this.locations,
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency = 'USD',
  });

  factory CreateJobPreferenceDto.fromJson(Map<String, dynamic> json) =>
      _$CreateJobPreferenceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateJobPreferenceDtoToJson(this);

  factory CreateJobPreferenceDto.fromEntity(JobPreferenceEntity entity) =>
      CreateJobPreferenceDto(
        careerProfileId: entity.careerProfileId,
        jobTitles: entity.jobTitles,
        industries: entity.industries,
        workEnvironments: entity.workEnvironments,
        employmentTypes: entity.employmentTypes,
        locations: entity.locations,
        minSalary: entity.minSalary,
        maxSalary: entity.maxSalary,
        salaryCurrency: entity.salaryCurrency,
      );
}

@JsonSerializable()
class UpdateJobPreferenceDto {
  final List<String>? jobTitles;
  final List<String>? industries;
  final List<String>? workEnvironments;
  final List<String>? employmentTypes;
  final List<String>? locations;
  final int? minSalary;
  final int? maxSalary;
  final String? salaryCurrency;
  final bool? isActive;

  UpdateJobPreferenceDto({
    this.jobTitles,
    this.industries,
    this.workEnvironments,
    this.employmentTypes,
    this.locations,
    this.minSalary,
    this.maxSalary,
    this.salaryCurrency,
    this.isActive,
  });

  factory UpdateJobPreferenceDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateJobPreferenceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateJobPreferenceDtoToJson(this);
}
