import { AttachmentEntity } from '../entities/attachment.entity';
import { AttachmentResponseDto } from '../dto/attachment-response.dto';

export class AttachmentMapper {
  static toResponse(entity: AttachmentEntity): AttachmentResponseDto {
    const dto = new AttachmentResponseDto();

    dto.id = entity.id;
    dto.careerProfileId = entity.careerProfileId;
    dto.type = entity.type;
    dto.originalFileName = entity.originalFileName;
    dto.storedFileName = entity.storedFileName;
    dto.mimeType = entity.mimeType;
    dto.fileSize = entity.fileSize;
    dto.storageProvider = entity.storageProvider;
    dto.storagePath = entity.storagePath;
    dto.fileUrl = entity.fileUrl;
    dto.isDefault = entity.isDefault;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;

    return dto;
  }
}
