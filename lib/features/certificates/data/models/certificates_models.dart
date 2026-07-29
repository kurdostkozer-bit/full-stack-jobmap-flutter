import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/certificates_entities.dart';

part 'certificates_models.freezed.dart';
part 'certificates_models.g.dart';

/// Certificate Response model (from API)
@freezed
class CertificateResponse with _$CertificateResponse {
  const factory CertificateResponse({
    required String id,
    required String careerProfileId,
    required String name,
    required String issuer,
    String? credentialId,
    String? credentialUrl,
    required DateTime issueDate,
    DateTime? expiryDate,
    required bool doesNotExpire,
    required CertificateVerificationStatus verificationStatus,
    required int displayOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CertificateResponse;

  factory CertificateResponse.fromJson(Map<String, dynamic> json) =>
      _$CertificateResponseFromJson(json);
}

extension CertificateResponseX on CertificateResponse {
  /// Convert to domain entity
  Certificate toDomain() {
    return Certificate(
      id: id,
      careerProfileId: careerProfileId,
      name: name,
      issuer: issuer,
      credentialId: credentialId,
      credentialUrl: credentialUrl,
      issueDate: issueDate,
      expiryDate: expiryDate,
      doesNotExpire: doesNotExpire,
      verificationStatus: verificationStatus,
      displayOrder: displayOrder,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Create Certificate Request model
@freezed
class CreateCertificateRequest with _$CreateCertificateRequest {
  const factory CreateCertificateRequest({
    required String name,
    required String issuer,
    String? credentialId,
    String? credentialUrl,
    required DateTime issueDate,
    DateTime? expiryDate,
    required bool doesNotExpire,
  }) = _CreateCertificateRequest;

  factory CreateCertificateRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCertificateRequestFromJson(json);
}

/// Update Certificate Request model
@freezed
class UpdateCertificateRequest with _$UpdateCertificateRequest {
  const factory UpdateCertificateRequest({
    String? name,
    String? issuer,
    String? credentialId,
    String? credentialUrl,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? doesNotExpire,
  }) = _UpdateCertificateRequest;

  factory UpdateCertificateRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCertificateRequestFromJson(json);
}

extension UpdateCertificateRequestX on UpdateCertificateRequest {
  /// Convert to JSON for API (only include non-null fields)
  Map<String, dynamic> toApiJson() {
    return {
      if (name != null) 'name': name,
      if (issuer != null) 'issuer': issuer,
      if (credentialId != null) 'credentialId': credentialId,
      if (credentialUrl != null) 'credentialUrl': credentialUrl,
      if (issueDate != null) 'issueDate': issueDate,
      if (expiryDate != null) 'expiryDate': expiryDate,
      if (doesNotExpire != null) 'doesNotExpire': doesNotExpire,
    };
  }
}
