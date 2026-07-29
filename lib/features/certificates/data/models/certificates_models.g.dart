// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertificateResponseImpl _$$CertificateResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CertificateResponseImpl(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  name: json['name'] as String,
  issuer: json['issuer'] as String,
  credentialId: json['credentialId'] as String?,
  credentialUrl: json['credentialUrl'] as String?,
  issueDate: DateTime.parse(json['issueDate'] as String),
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
  doesNotExpire: json['doesNotExpire'] as bool,
  verificationStatus: $enumDecode(
    _$CertificateVerificationStatusEnumMap,
    json['verificationStatus'],
  ),
  displayOrder: (json['displayOrder'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$CertificateResponseImplToJson(
  _$CertificateResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'name': instance.name,
  'issuer': instance.issuer,
  'credentialId': instance.credentialId,
  'credentialUrl': instance.credentialUrl,
  'issueDate': instance.issueDate.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'doesNotExpire': instance.doesNotExpire,
  'verificationStatus':
      _$CertificateVerificationStatusEnumMap[instance.verificationStatus]!,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$CertificateVerificationStatusEnumMap = {
  CertificateVerificationStatus.pending: 'PENDING',
  CertificateVerificationStatus.verified: 'VERIFIED',
  CertificateVerificationStatus.rejected: 'REJECTED',
};

_$CreateCertificateRequestImpl _$$CreateCertificateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateCertificateRequestImpl(
  name: json['name'] as String,
  issuer: json['issuer'] as String,
  credentialId: json['credentialId'] as String?,
  credentialUrl: json['credentialUrl'] as String?,
  issueDate: DateTime.parse(json['issueDate'] as String),
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
  doesNotExpire: json['doesNotExpire'] as bool,
);

Map<String, dynamic> _$$CreateCertificateRequestImplToJson(
  _$CreateCertificateRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'issuer': instance.issuer,
  'credentialId': instance.credentialId,
  'credentialUrl': instance.credentialUrl,
  'issueDate': instance.issueDate.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'doesNotExpire': instance.doesNotExpire,
};

_$UpdateCertificateRequestImpl _$$UpdateCertificateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UpdateCertificateRequestImpl(
  name: json['name'] as String?,
  issuer: json['issuer'] as String?,
  credentialId: json['credentialId'] as String?,
  credentialUrl: json['credentialUrl'] as String?,
  issueDate: json['issueDate'] == null
      ? null
      : DateTime.parse(json['issueDate'] as String),
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
  doesNotExpire: json['doesNotExpire'] as bool?,
);

Map<String, dynamic> _$$UpdateCertificateRequestImplToJson(
  _$UpdateCertificateRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'issuer': instance.issuer,
  'credentialId': instance.credentialId,
  'credentialUrl': instance.credentialUrl,
  'issueDate': instance.issueDate?.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'doesNotExpire': instance.doesNotExpire,
};
