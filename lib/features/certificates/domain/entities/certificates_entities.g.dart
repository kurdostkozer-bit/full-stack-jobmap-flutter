// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertificateImpl _$$CertificateImplFromJson(Map<String, dynamic> json) =>
    _$CertificateImpl(
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

Map<String, dynamic> _$$CertificateImplToJson(_$CertificateImpl instance) =>
    <String, dynamic>{
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
