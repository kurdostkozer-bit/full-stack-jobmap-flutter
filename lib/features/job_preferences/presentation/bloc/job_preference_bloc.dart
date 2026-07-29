import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job_preference_entities.dart';
import '../../domain/usecases/job_preference_usecases.dart';

part 'job_preference_event.dart';
part 'job_preference_state.dart';

class JobPreferenceBloc extends Bloc<JobPreferenceEvent, JobPreferenceState> {
  final GetJobPreferenceUseCase getJobPreference;
  final CreateJobPreferenceUseCase createJobPreference;
  final UpdateJobPreferenceUseCase updateJobPreference;
  final DeleteJobPreferenceUseCase deleteJobPreference;

  JobPreferenceBloc({
    required this.getJobPreference,
    required this.createJobPreference,
    required this.updateJobPreference,
    required this.deleteJobPreference,
  }) : super(const JobPreferenceInitial()) {
    on<GetJobPreferenceEvent>(_onGetJobPreference);
    on<CreateJobPreferenceEvent>(_onCreateJobPreference);
    on<UpdateJobPreferenceEvent>(_onUpdateJobPreference);
    on<DeleteJobPreferenceEvent>(_onDeleteJobPreference);
  }

  Future<void> _onGetJobPreference(
    GetJobPreferenceEvent event,
    Emitter<JobPreferenceState> emit,
  ) async {
    emit(const JobPreferenceLoading());
    try {
      final preference = await getJobPreference(event.careerProfileId);
      if (preference != null) {
        emit(JobPreferenceLoaded(preference));
      } else {
        emit(const JobPreferenceEmpty());
      }
    } catch (e) {
      emit(JobPreferenceError(e.toString()));
    }
  }

  Future<void> _onCreateJobPreference(
    CreateJobPreferenceEvent event,
    Emitter<JobPreferenceState> emit,
  ) async {
    emit(const JobPreferenceLoading());
    try {
      final result = await createJobPreference(event.preference);
      emit(JobPreferenceCreated(result));
    } catch (e) {
      emit(JobPreferenceError(e.toString()));
    }
  }

  Future<void> _onUpdateJobPreference(
    UpdateJobPreferenceEvent event,
    Emitter<JobPreferenceState> emit,
  ) async {
    emit(const JobPreferenceLoading());
    try {
      final result = await updateJobPreference(event.id, event.preference);
      emit(JobPreferenceUpdated(result));
    } catch (e) {
      emit(JobPreferenceError(e.toString()));
    }
  }

  Future<void> _onDeleteJobPreference(
    DeleteJobPreferenceEvent event,
    Emitter<JobPreferenceState> emit,
  ) async {
    emit(const JobPreferenceLoading());
    try {
      await deleteJobPreference(event.id);
      emit(const JobPreferenceDeleted());
    } catch (e) {
      emit(JobPreferenceError(e.toString()));
    }
  }
}
