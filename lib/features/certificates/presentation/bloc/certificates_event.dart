import 'package:equatable/equatable.dart';

abstract class CertificatesEvent extends Equatable {
  const CertificatesEvent();

  @override
  List<Object?> get props => [];
}

/// Load certificates for a career profile
class LoadCertificatesEvent extends CertificatesEvent {
  final String careerProfileId;

  const LoadCertificatesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}

/// Create a new certificate
class CreateCertificateEvent extends CertificatesEvent {
  final String careerProfileId;
  final String name;
  final String issuer;
  final DateTime issueDate;
  final String? credentialId;
  final String? credentialUrl;
  final DateTime? expiryDate;
  final bool doesNotExpire;

  const CreateCertificateEvent(
    this.careerProfileId,
    this.name,
    this.issuer,
    this.issueDate, {
    this.credentialId,
    this.credentialUrl,
    this.expiryDate,
    this.doesNotExpire = false,
  });

  @override
  List<Object?> get props => [
        careerProfileId,
        name,
        issuer,
        issueDate,
        credentialId,
        credentialUrl,
        expiryDate,
        doesNotExpire,
      ];
}

/// Update a certificate
class UpdateCertificateEvent extends CertificatesEvent {
  final String certificateId;
  final String? name;
  final String? issuer;
  final String? credentialId;
  final String? credentialUrl;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final bool? doesNotExpire;

  const UpdateCertificateEvent(
    this.certificateId, {
    this.name,
    this.issuer,
    this.credentialId,
    this.credentialUrl,
    this.issueDate,
    this.expiryDate,
    this.doesNotExpire,
  });

  @override
  List<Object?> get props => [
        certificateId,
        name,
        issuer,
        credentialId,
        credentialUrl,
        issueDate,
        expiryDate,
        doesNotExpire,
      ];
}

/// Delete a certificate
class DeleteCertificateEvent extends CertificatesEvent {
  final String certificateId;

  const DeleteCertificateEvent(this.certificateId);

  @override
  List<Object?> get props => [certificateId];
}

/// Refresh certificates list
class RefreshCertificatesEvent extends CertificatesEvent {
  final String careerProfileId;

  const RefreshCertificatesEvent(this.careerProfileId);

  @override
  List<Object?> get props => [careerProfileId];
}
