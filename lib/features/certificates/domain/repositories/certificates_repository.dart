import '../entities/certificates_entities.dart';

/// Abstract repository for certificate operations
abstract class CertificatesRepository {
  /// Get all certificates for a career profile
  Future<List<Certificate>> getCertificates(String careerProfileId);

  /// Create a new certificate
  Future<Certificate> createCertificate(
    String careerProfileId,
    String name,
    String issuer,
    DateTime issueDate, {
    String? credentialId,
    String? credentialUrl,
    DateTime? expiryDate,
    bool doesNotExpire = false,
  });

  /// Update a certificate
  Future<Certificate> updateCertificate(
    String certificateId, {
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  });

  /// Delete a certificate
  Future<void> deleteCertificate(String certificateId);

  /// Get cached certificates
  Future<List<Certificate>?> getCachedCertificates(String careerProfileId);

  /// Clear cached certificates
  Future<void> clearCachedCertificates(String careerProfileId);
}
