import '../../../../core/network/api_client.dart';
import '../models/certificates_models.dart';

abstract class CertificatesRemoteDataSource {
  /// Get all certificates for a career profile
  Future<List<CertificateResponse>> getCertificates(String careerProfileId);

  /// Create a new certificate
  Future<CertificateResponse> createCertificate(
    String careerProfileId,
    Map<String, dynamic> certificateData,
  );

  /// Update a certificate
  Future<CertificateResponse> updateCertificate(
    String certificateId,
    Map<String, dynamic> certificateData,
  );

  /// Delete a certificate
  Future<void> deleteCertificate(String certificateId);
}

class CertificatesRemoteDataSourceImpl implements CertificatesRemoteDataSource {
  final ApiClient apiClient;

  CertificatesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CertificateResponse>> getCertificates(String careerProfileId) async {
    final response = await apiClient.get<List<CertificateResponse>>(
      '/certificates/career-profile/$careerProfileId',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) =>
                  CertificateResponse.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (json is Map<String, dynamic>) {
          final certificates =
              json['certificates'] ?? json['data'] ?? json;
          if (certificates is List) {
            return certificates
                .map((item) =>
                    CertificateResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
        return [];
      },
    );
    return response;
  }

  @override
  Future<CertificateResponse> createCertificate(
    String careerProfileId,
    Map<String, dynamic> certificateData,
  ) async {
    return await apiClient.post(
      '/certificates',
      data: {
        ...certificateData,
        'careerProfileId': careerProfileId,
      },
      fromJson: (json) => CertificateResponse.fromJson(json),
    );
  }

  @override
  Future<CertificateResponse> updateCertificate(
    String certificateId,
    Map<String, dynamic> certificateData,
  ) async {
    return await apiClient.patch(
      '/certificates/$certificateId',
      data: certificateData,
      fromJson: (json) => CertificateResponse.fromJson(json),
    );
  }

  @override
  Future<void> deleteCertificate(String certificateId) async {
    await apiClient.delete('/certificates/$certificateId');
  }
}
