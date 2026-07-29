import 'package:equatable/equatable.dart';
import '../../domain/entities/experience_entities.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ExperienceInitial extends ExperienceState {
  const ExperienceInitial();
}

/// Loading experiences
class ExperienceLoading extends ExperienceState {
  const ExperienceLoading();
}

/// Experiences loaded successfully
class ExperiencesLoaded extends ExperienceState {
  final List<Experience> experiences;

  const ExperiencesLoaded({required this.experiences});

  @override
  List<Object?> get props => [experiences];
}

/// Creating new experience
class ExperienceCreating extends ExperienceState {
  final List<Experience> currentExperiences;

  const ExperienceCreating({required this.currentExperiences});

  @override
  List<Object?> get props => [currentExperiences];
}

/// Experience created successfully
class ExperienceCreated extends ExperienceState {
  final List<Experience> experiences;
  final String message;

  const ExperienceCreated({
    required this.experiences,
    this.message = 'Experience added successfully',
  });

  @override
  List<Object?> get props => [experiences, message];
}

/// Updating experience
class ExperienceUpdating extends ExperienceState {
  final List<Experience> currentExperiences;

  const ExperienceUpdating({required this.currentExperiences});

  @override
  List<Object?> get props => [currentExperiences];
}

/// Experience updated successfully
class ExperienceUpdated extends ExperienceState {
  final List<Experience> experiences;
  final String message;

  const ExperienceUpdated({
    required this.experiences,
    this.message = 'Experience updated successfully',
  });

  @override
  List<Object?> get props => [experiences, message];
}

/// Deleting experience
class ExperienceDeleting extends ExperienceState {
  final List<Experience> currentExperiences;

  const ExperienceDeleting({required this.currentExperiences});

  @override
  List<Object?> get props => [currentExperiences];
}

/// Experience deleted successfully
class ExperienceDeleted extends ExperienceState {
  final List<Experience> experiences;
  final String message;

  const ExperienceDeleted({
    required this.experiences,
    this.message = 'Experience deleted successfully',
  });

  @override
  List<Object?> get props => [experiences, message];
}

/// Error state
class ExperienceError extends ExperienceState {
  final String message;
  final List<Experience>? previousExperiences;

  const ExperienceError({
    required this.message,
    this.previousExperiences,
  });

  @override
  List<Object?> get props => [message, previousExperiences];
}

/// Experiences cleared
class ExperienceCleared extends ExperienceState {
  const ExperienceCleared();
}
