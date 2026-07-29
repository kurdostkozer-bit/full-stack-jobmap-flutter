// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      id: json['id'] as String,
      careerProfileId: json['careerProfileId'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      fileSizeBytes: (json['fileSizeBytes'] as num).toInt(),
      fileUrl: json['fileUrl'] as String,
      description: json['description'] as String?,
      category: $enumDecode(_$AttachmentCategoryEnumMap, json['category']),
      isPrimary: json['isPrimary'] as bool? ?? false,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'careerProfileId': instance.careerProfileId,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'fileSizeBytes': instance.fileSizeBytes,
      'fileUrl': instance.fileUrl,
      'description': instance.description,
      'category': _$AttachmentCategoryEnumMap[instance.category]!,
      'isPrimary': instance.isPrimary,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$AttachmentCategoryEnumMap = {
  AttachmentCategory.resume: 'resume',
  AttachmentCategory.coverLetter: 'coverLetter',
  AttachmentCategory.portfolio: 'portfolio',
  AttachmentCategory.certification: 'certification',
  AttachmentCategory.other: 'other',
};

AttachmentResponseDto _$AttachmentResponseDtoFromJson(
  Map<String, dynamic> json,
) => AttachmentResponseDto(
  id: json['id'] as String,
  careerProfileId: json['careerProfileId'] as String,
  fileName: json['fileName'] as String,
  fileType: json['fileType'] as String,
  fileSizeBytes: (json['fileSizeBytes'] as num).toInt(),
  fileUrl: json['fileUrl'] as String,
  description: json['description'] as String?,
  category: json['category'] as String,
  isPrimary: json['isPrimary'] as bool,
  uploadedAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AttachmentResponseDtoToJson(
  AttachmentResponseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'careerProfileId': instance.careerProfileId,
  'fileName': instance.fileName,
  'fileType': instance.fileType,
  'fileSizeBytes': instance.fileSizeBytes,
  'fileUrl': instance.fileUrl,
  'description': instance.description,
  'category': instance.category,
  'isPrimary': instance.isPrimary,
  'createdAt': instance.uploadedAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

CreateAttachmentDto _$CreateAttachmentDtoFromJson(Map<String, dynamic> json) =>
    CreateAttachmentDto(
      careerProfileId: json['careerProfileId'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      fileSizeBytes: (json['fileSizeBytes'] as num).toInt(),
      fileUrl: json['fileUrl'] as String,
      description: json['description'] as String?,
      category: json['category'] as String,
      isPrimary: json['isPrimary'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateAttachmentDtoToJson(
  CreateAttachmentDto instance,
) => <String, dynamic>{
  'careerProfileId': instance.careerProfileId,
  'fileName': instance.fileName,
  'fileType': instance.fileType,
  'fileSizeBytes': instance.fileSizeBytes,
  'fileUrl': instance.fileUrl,
  'description': instance.description,
  'category': instance.category,
  'isPrimary': instance.isPrimary,
};

UpdateAttachmentDto _$UpdateAttachmentDtoFromJson(Map<String, dynamic> json) =>
    UpdateAttachmentDto(
      description: json['description'] as String?,
      isPrimary: json['isPrimary'] as bool?,
    );

Map<String, dynamic> _$UpdateAttachmentDtoToJson(
  UpdateAttachmentDto instance,
) => <String, dynamic>{
  'description': instance.description,
  'isPrimary': instance.isPrimary,
};
