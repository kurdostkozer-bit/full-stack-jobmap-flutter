import '../entities/certificates_entities.dart';
import '../repositories/certificates_repository.dart';

/// Get all certificates for a career profile
class GetCertificatesUseCase {
  final CertificatesRepository repository;

  GetCertificatesUseCase({required this.repository});

  Future<List<Certificate>> call(String careerProfileId) {
    return repository.getCertificates(careerProfileId);
  }
}

/// Create a new certificate
class CreateCertificateUseCase {
  final CertificatesRepository repository;

  CreateCertificateUseCase({required this.repository});

  Future<Certificate> call(
    String careerProfileId,
    String name,
    String issuer,
    DateTime issueDate, {
    String? credentialId,
    String? credentialUrl,
    DateTime? expiryDate,
    bool doesNotExpire = false,
  }) {
    return repository.createCertificate(
      careerProfileId,
      name,
      issuer,
      issueDate,
      credentialId: credentialId,
      credentialUrl: credentialUrl,
      expiryDate: expiryDate,
      doesNotExpire: doesNotExpire,
    );
  }
}

/// Update a certificate
class UpdateCertificateUseCase {
  final CertificatesRepository repository;

  UpdateCertificateUseCase({required this.repository});

  Future<Certificate> call(
    String certificateId, {
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  }) {
    return repository.updateCertificate(
      certificateId,
      name: name,
      issuer: issuer,
      credentialId: credentialId,
      credentialUrl: credentialUrl,
      issueDate: issueDate,
      expiryDate: expiryDate,
      doesNotExpire: doesNotExpire,
    );
  }
}

/// Delete a certificate
class DeleteCertificateUseCase {
  final CertificatesRepository repository;

  DeleteCertificateUseCase({required this.repository});

  Future<void> call(String certificateId) {
    return repository.deleteCertificate(certificateId);
  }
}
