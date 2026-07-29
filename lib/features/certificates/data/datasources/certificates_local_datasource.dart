import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/certificates_models.dart';

abstract class CertificatesLocalDataSource {
  /// Cache certificates locally
  Future<void> cacheCertificates(
    String careerProfileId,
    List<CertificateResponse> certificates,
  );

  /// Get cached certificates
  Future<List<CertificateResponse>?> getCachedCertificates(String careerProfileId);

  /// Clear cached certificates
  Future<void> clearCertificates(String careerProfileId);
}

class CertificatesLocalDataSourceImpl implements CertificatesLocalDataSource {
  final FlutterSecureStorage secureStorage;

  CertificatesLocalDataSourceImpl({required this.secureStorage});

  String _getKey(String careerProfileId) => 'certificates_$careerProfileId';

  @override
  Future<void> cacheCertificates(
    String careerProfileId,
    List<CertificateResponse> certificates,
  ) async {
    try {
      final json = certificates.map((e) => e.toJson()).toList();
      await secureStorage.write(
        key: _getKey(careerProfileId),
        value: jsonEncode(json),
      );
    } catch (e) {
      debugPrint('Error caching certificates: $e');
      rethrow;
    }
  }

  @override
  Future<List<CertificateResponse>?> getCachedCertificates(
    String careerProfileId,
  ) async {
    try {
      final json = await secureStorage.read(key: _getKey(careerProfileId));
      if (json != null) {
        final list = jsonDecode(json) as List;
        return list
            .map((item) =>
                CertificateResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error reading cached certificates: $e');
    }
    return null;
  }

  @override
  Future<void> clearCertificates(String careerProfileId) async {
    try {
      await secureStorage.delete(key: _getKey(careerProfileId));
    } catch (e) {
      debugPrint('Error clearing certificates: $e');
    }
  }
}
