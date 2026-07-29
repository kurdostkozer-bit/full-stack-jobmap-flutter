import 'package:freezed_annotation/freezed_annotation.dart';

part 'certificates_entities.freezed.dart';
part 'certificates_entities.g.dart';

/// Certificate verification status
enum CertificateVerificationStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('VERIFIED')
  verified,
  @JsonValue('REJECTED')
  rejected,
}

/// Certificate entity
@freezed
class Certificate with _$Certificate {
  const factory Certificate({
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
  }) = _Certificate;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}
