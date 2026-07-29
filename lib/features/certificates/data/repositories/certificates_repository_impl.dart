import '../datasources/certificates_local_datasource.dart';
import '../datasources/certificates_remote_datasource.dart';
import '../models/certificates_models.dart';
import '../../domain/entities/certificates_entities.dart';
import '../../domain/repositories/certificates_repository.dart';

class CertificatesRepositoryImpl implements CertificatesRepository {
  final CertificatesRemoteDataSource remoteDataSource;
  final CertificatesLocalDataSource localDataSource;

  CertificatesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Certificate>> getCertificates(String careerProfileId) async {
    try {
      // Try to get from remote (API)
      final responses = await remoteDataSource.getCertificates(careerProfileId);

      // Cache locally
      await localDataSource.cacheCertificates(careerProfileId, responses);

      // Convert to domain entities
      return responses.map((r) => r.toDomain()).toList();
    } catch (e) {
      // If remote fails, try to get from cache
      final cached = await localDataSource.getCachedCertificates(careerProfileId);
      if (cached != null) {
        return cached.map((r) => r.toDomain()).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Certificate> createCertificate(
    String careerProfileId,
    String name,
    String issuer,
    DateTime issueDate, {
    String? credentialId,
    String? credentialUrl,
    DateTime? expiryDate,
    bool doesNotExpire = false,
  }) async {
    try {
      final request = CreateCertificateRequest(
        name: name,
        issuer: issuer,
        credentialId: credentialId,
        credentialUrl: credentialUrl,
        issueDate: issueDate,
        expiryDate: expiryDate,
        doesNotExpire: doesNotExpire,
      );

      final response = await remoteDataSource.createCertificate(
        careerProfileId,
        request.toJson(),
      );

      // Invalidate cache
      await localDataSource.clearCertificates(careerProfileId);

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Certificate> updateCertificate(
    String certificateId, {
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  }) async {
    try {
      final request = UpdateCertificateRequest(
        name: name,
        issuer: issuer,
        credentialId: credentialId,
        credentialUrl: credentialUrl,
        issueDate: issueDate,
        expiryDate: expiryDate,
        doesNotExpire: doesNotExpire,
      );

      final response = await remoteDataSource.updateCertificate(
        certificateId,
        request.toApiJson(),
      );

      return response.toDomain();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCertificate(String certificateId) async {
    try {
      await remoteDataSource.deleteCertificate(certificateId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Certificate>?> getCachedCertificates(String careerProfileId) async {
    try {
      final cached =
          await localDataSource.getCachedCertificates(careerProfileId);
      return cached?.map((r) => r.toDomain()).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCachedCertificates(String careerProfileId) async {
    try {
      await localDataSource.clearCertificates(careerProfileId);
    } catch (e) {
      print('Error clearing cached certificates: $e');
    }
  }
}
