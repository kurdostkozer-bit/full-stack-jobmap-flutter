import 'package:equatable/equatable.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object?> get props => [];
}

/// Load experiences for a career profile
class LoadExperiencesEvent extends ExperienceEvent {
  final String careerProfileId;

  const LoadExperiencesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new experience
class CreateExperienceEvent extends ExperienceEvent {
  final String careerProfileId;
  final String jobTitle;
  final String companyName;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String? description;
  final String? companyWebsite;

  const CreateExperienceEvent(
    this.careerProfileId,
    this.jobTitle,
    this.companyName,
    this.location,
    this.startDate, {
    this.endDate,
    this.isCurrent = false,
    this.description,
    this.companyWebsite,
  });

  @override
  List<Object?> get props => [
        careerProfileId,
        jobTitle,
        companyName,
        location,
        startDate,
        endDate,
        isCurrent,
        description,
        companyWebsite,
      ];
}

/// Update an experience
class UpdateExperienceEvent extends ExperienceEvent {
  final String experienceId;
  final String? jobTitle;
  final String? companyName;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isCurrent;
  final String? description;

  const UpdateExperienceEvent(
    this.experienceId, {
    this.jobTitle,
    this.companyName,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrent,
    this.description,
  });

  @override
  List<Object?> get props => [
        experienceId,
        jobTitle,
        companyName,
        location,
        startDate,
        endDate,
        isCurrent,
        description,
      ];
}

/// Delete an experience
class DeleteExperienceEvent extends ExperienceEvent {
  final String experienceId;

  const DeleteExperienceEvent(this.experienceId);

  @override
  List<Object?> get props => [experienceId];
}

/// Refresh experiences list
class RefreshExperiencesEvent extends ExperienceEvent {
  final String careerProfileId;

  const RefreshExperiencesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
