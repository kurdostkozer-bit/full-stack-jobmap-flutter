import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/attachment_entities.dart';

part 'attachment_models.g.dart';

@JsonSerializable()
class AttachmentModel extends AttachmentEntity {
  AttachmentModel({
    required super.id,
    required super.careerProfileId,
    required super.fileName,
    required super.fileType,
    required super.fileSizeBytes,
    required super.fileUrl,
    super.description,
    required super.category,
    super.isPrimary = false,
    required super.uploadedAt,
    required super.updatedAt,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  factory AttachmentModel.fromEntity(AttachmentEntity entity) =>
      AttachmentModel(
        id: entity.id,
        careerProfileId: entity.careerProfileId,
        fileName: entity.fileName,
        fileType: entity.fileType,
        fileSizeBytes: entity.fileSizeBytes,
        fileUrl: entity.fileUrl,
        description: entity.description,
        category: entity.category,
        isPrimary: entity.isPrimary,
        uploadedAt: entity.uploadedAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  AttachmentEntity toEntity() => AttachmentEntity(
        id: id,
        careerProfileId: careerProfileId,
        fileName: fileName,
        fileType: fileType,
        fileSizeBytes: fileSizeBytes,
        fileUrl: fileUrl,
        description: description,
        category: category,
        isPrimary: isPrimary,
        uploadedAt: uploadedAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class AttachmentResponseDto {
  final String id;
  final String careerProfileId;
  final String fileName;
  final String fileType;
  final int fileSizeBytes;
  final String fileUrl;
  final String? description;
  final String category;
  final bool isPrimary;
  @JsonKey(name: 'createdAt')
  final DateTime uploadedAt;
  final DateTime updatedAt;

  AttachmentResponseDto({
    required this.id,
    required this.careerProfileId,
    required this.fileName,
    required this.fileType,
    required this.fileSizeBytes,
    required this.fileUrl,
    this.description,
    required this.category,
    required this.isPrimary,
    required this.uploadedAt,
    required this.updatedAt,
  });

  factory AttachmentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentResponseDtoToJson(this);

  AttachmentModel toModel() => AttachmentModel(
        id: id,
        careerProfileId: careerProfileId,
        fileName: fileName,
        fileType: fileType,
        fileSizeBytes: fileSizeBytes,
        fileUrl: fileUrl,
        description: description,
        category: AttachmentCategoryX.fromString(category),
        isPrimary: isPrimary,
        uploadedAt: uploadedAt,
        updatedAt: updatedAt,
      );
}

@JsonSerializable()
class CreateAttachmentDto {
  final String careerProfileId;
  final String fileName;
  final String fileType;
  final int fileSizeBytes;
  final String fileUrl;
  final String? description;
  final String category;
  final bool isPrimary;

  CreateAttachmentDto({
    required this.careerProfileId,
    required this.fileName,
    required this.fileType,
    required this.fileSizeBytes,
    required this.fileUrl,
    this.description,
    required this.category,
    this.isPrimary = false,
  });

  factory CreateAttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateAttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAttachmentDtoToJson(this);

  factory CreateAttachmentDto.fromEntity(AttachmentEntity entity) =>
      CreateAttachmentDto(
        careerProfileId: entity.careerProfileId,
        fileName: entity.fileName,
        fileType: entity.fileType,
        fileSizeBytes: entity.fileSizeBytes,
        fileUrl: entity.fileUrl,
        description: entity.description,
        category: entity.category.value,
        isPrimary: entity.isPrimary,
      );
}

@JsonSerializable()
class UpdateAttachmentDto {
  final String? description;
  final bool? isPrimary;

  UpdateAttachmentDto({
    this.description,
    this.isPrimary,
  });

  factory UpdateAttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateAttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAttachmentDtoToJson(this);
}
