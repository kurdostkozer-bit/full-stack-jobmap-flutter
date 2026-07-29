part of 'job_preference_bloc.dart';

abstract class JobPreferenceEvent extends Equatable {
  const JobPreferenceEvent();

  @override
  List<Object?> get props => [];
}

class GetJobPreferenceEvent extends JobPreferenceEvent {
  final String careerProfileId;

  const GetJobPreferenceEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

class CreateJobPreferenceEvent extends JobPreferenceEvent {
  final JobPreferenceEntity preference;

  const CreateJobPreferenceEvent(this.preference);

  @override
  List<Object?> get props => [preference];
}

class UpdateJobPreferenceEvent extends JobPreferenceEvent {
  final String id;
  final JobPreferenceEntity preference;

  const UpdateJobPreferenceEvent({
    required this.id,
    required this.preference,
  });

  @override
  List<Object?> get props => [id, preference];
}

class DeleteJobPreferenceEvent extends JobPreferenceEvent {
  final String id;

  const DeleteJobPreferenceEvent(this.id);

  @override
  List<Object?> get props => [id];
}
