import 'package:equatable/equatable.dart';
import '../../domain/entities/certificates_entities.dart';

abstract class CertificatesState extends Equatable {
  const CertificatesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CertificatesInitial extends CertificatesState {
  const CertificatesInitial();
}

/// Loading certificates
class CertificatesLoading extends CertificatesState {
  const CertificatesLoading();
}

/// Certificates loaded successfully
class CertificatesLoaded extends CertificatesState {
  final List<Certificate> certificates;

  const CertificatesLoaded({required this.certificates});

  @override
  List<Object?> get props => [certificates];
}

/// Creating new certificate
class CertificateCreating extends CertificatesState {
  final List<Certificate> currentCertificates;

  const CertificateCreating({required this.currentCertificates});

  @override
  List<Object?> get props => [currentCertificates];
}

/// Certificate created successfully
class CertificateCreated extends CertificatesState {
  final List<Certificate> certificates;
  final String message;

  const CertificateCreated({
    required this.certificates,
    this.message = 'Certificate added successfully',
  });

  @override
  List<Object?> get props => [certificates, message];
}

/// Updating certificate
class CertificateUpdating extends CertificatesState {
  final List<Certificate> currentCertificates;

  const CertificateUpdating({required this.currentCertificates});

  @override
  List<Object?> get props => [currentCertificates];
}

/// Certificate updated successfully
class CertificateUpdated extends CertificatesState {
  final List<Certificate> certificates;
  final String message;

  const CertificateUpdated({
    required this.certificates,
    this.message = 'Certificate updated successfully',
  });

  @override
  List<Object?> get props => [certificates, message];
}

/// Deleting certificate
class CertificateDeleting extends CertificatesState {
  final List<Certificate> currentCertificates;

  const CertificateDeleting({required this.currentCertificates});

  @override
  List<Object?> get props => [currentCertificates];
}

/// Certificate deleted successfully
class CertificateDeleted extends CertificatesState {
  final List<Certificate> certificates;
  final String message;

  const CertificateDeleted({
    required this.certificates,
    this.message = 'Certificate deleted successfully',
  });

  @override
  List<Object?> get props => [certificates, message];
}

/// Error state
class CertificatesError extends CertificatesState {
  final String message;
  final List<Certificate>? previousCertificates;

  const CertificatesError({
    required this.message,
    this.previousCertificates,
  });

  @override
  List<Object?> get props => [message, previousCertificates];
}

/// Certificates cleared
class CertificatesCleared extends CertificatesState {
  const CertificatesCleared();
}
