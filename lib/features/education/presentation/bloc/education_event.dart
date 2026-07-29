import 'package:equatable/equatable.dart';

abstract class EducationEvent extends Equatable {
  const EducationEvent();

  @override
  List<Object?> get props => [];
}

/// Load educations for a career profile
class LoadEducationsEvent extends EducationEvent {
  final String careerProfileId;

  const LoadEducationsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new education
class CreateEducationEvent extends EducationEvent {
  final String careerProfileId;
  final String school;
  final String degree;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool currentlyStudying;
  final String? description;

  const CreateEducationEvent(
    this.careerProfileId,
    this.school,
    this.degree, {
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.currentlyStudying = false,
    this.description,
  });

  @override
  List<Object?> get props => [
        careerProfileId,
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        currentlyStudying,
        description,
      ];
}

/// Update an education
class UpdateEducationEvent extends EducationEvent {
  final String educationId;
  final String? school;
  final String? degree;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? currentlyStudying;
  final String? description;

  const UpdateEducationEvent(
    this.educationId, {
    this.school,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.currentlyStudying,
    this.description,
  });

  @override
  List<Object?> get props => [
        educationId,
        school,
        degree,
        fieldOfStudy,
        startDate,
        endDate,
        currentlyStudying,
        description,
      ];
}

/// Delete an education
class DeleteEducationEvent extends EducationEvent {
  final String educationId;

  const DeleteEducationEvent(this.educationId);

  @override
  List<Object?> get props => [educationId];
}

/// Refresh educations list
class RefreshEducationsEvent extends EducationEvent {
  final String careerProfileId;

  const RefreshEducationsEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
