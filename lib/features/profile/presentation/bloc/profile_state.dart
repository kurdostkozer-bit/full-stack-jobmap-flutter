import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entities.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

/// Loading profile
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

/// Profile loaded successfully
class ProfileLoaded extends ProfileState {
  final CareerProfile profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

/// Profile update in progress
class ProfileUpdating extends ProfileState {
  final CareerProfile profile;

  const ProfileUpdating({required this.profile});

  @override
  List<Object?> get props => [profile];
}

/// Profile updated successfully
class ProfileUpdated extends ProfileState {
  final CareerProfile profile;
  final String message;

  const ProfileUpdated({
    required this.profile,
    this.message = 'Profile updated successfully',
  });

  @override
  List<Object?> get props => [profile, message];
}

/// Error loading or updating profile
class ProfileError extends ProfileState {
  final String message;
  final CareerProfile? previousProfile; // For rollback UI

  const ProfileError({
    required this.message,
    this.previousProfile,
  });

  @override
  List<Object?> get props => [message, previousProfile];
}

/// Profile cleared (on logout)
class ProfileCleared extends ProfileState {
  const ProfileCleared();
}
