part of 'job_preference_bloc.dart';

abstract class JobPreferenceState extends Equatable {
  const JobPreferenceState();

  @override
  List<Object?> get props => [];
}

class JobPreferenceInitial extends JobPreferenceState {
  const JobPreferenceInitial();
}

class JobPreferenceLoading extends JobPreferenceState {
  const JobPreferenceLoading();
}

class JobPreferenceLoaded extends JobPreferenceState {
  final JobPreferenceEntity preference;

  const JobPreferenceLoaded(this.preference);

  @override
  List<Object?> get props => [preference];
}

class JobPreferenceCreated extends JobPreferenceState {
  final JobPreferenceEntity preference;

  const JobPreferenceCreated(this.preference);

  @override
  List<Object?> get props => [preference];
}

class JobPreferenceUpdated extends JobPreferenceState {
  final JobPreferenceEntity preference;

  const JobPreferenceUpdated(this.preference);

  @override
  List<Object?> get props => [preference];
}

class JobPreferenceDeleted extends JobPreferenceState {
  const JobPreferenceDeleted();
}

class JobPreferenceError extends JobPreferenceState {
  final String message;

  const JobPreferenceError(this.message);

  @override
  List<Object?> get props => [message];
}

class JobPreferenceEmpty extends JobPreferenceState {
  const JobPreferenceEmpty();
}
