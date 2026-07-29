import 'package:equatable/equatable.dart';
import '../../domain/entities/education_entities.dart';

abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class EducationInitial extends EducationState {
  const EducationInitial();
}

/// Loading educations
class EducationLoading extends EducationState {
  const EducationLoading();
}

/// Educations loaded successfully
class EducationsLoaded extends EducationState {
  final List<Education> educations;

  const EducationsLoaded({required this.educations});

  @override
  List<Object?> get props => [educations];
}

/// Creating new education
class EducationCreating extends EducationState {
  final List<Education> currentEducations;

  const EducationCreating({required this.currentEducations});

  @override
  List<Object?> get props => [currentEducations];
}

/// Education created successfully
class EducationCreated extends EducationState {
  final List<Education> educations;
  final String message;

  const EducationCreated({
    required this.educations,
    this.message = 'Education added successfully',
  });

  @override
  List<Object?> get props => [educations, message];
}

/// Updating education
class EducationUpdating extends EducationState {
  final List<Education> currentEducations;

  const EducationUpdating({required this.currentEducations});

  @override
  List<Object?> get props => [currentEducations];
}

/// Education updated successfully
class EducationUpdated extends EducationState {
  final List<Education> educations;
  final String message;

  const EducationUpdated({
    required this.educations,
    this.message = 'Education updated successfully',
  });

  @override
  List<Object?> get props => [educations, message];
}

/// Deleting education
class EducationDeleting extends EducationState {
  final List<Education> currentEducations;

  const EducationDeleting({required this.currentEducations});

  @override
  List<Object?> get props => [currentEducations];
}

/// Education deleted successfully
class EducationDeleted extends EducationState {
  final List<Education> educations;
  final String message;

  const EducationDeleted({
    required this.educations,
    this.message = 'Education deleted successfully',
  });

  @override
  List<Object?> get props => [educations, message];
}

/// Error state
class EducationError extends EducationState {
  final String message;
  final List<Education>? previousEducations;

  const EducationError({
    required this.message,
    this.previousEducations,
  });

  @override
  List<Object?> get props => [message, previousEducations];
}

/// Educations cleared
class EducationCleared extends EducationState {
  const EducationCleared();
}
