import { RecruiterEntity } from '../entities/recruiter.entity';
import { RecruiterResponseDto } from '../dto/recruiter-response.dto';

export class RecruiterMapper {
  static toResponse(entity: RecruiterEntity): RecruiterResponseDto {
    const dto = new RecruiterResponseDto();
    dto.id = entity.id;
    dto.companyId = entity.companyId;
    dto.userId = entity.userId;
    dto.title = entity.title;
    dto.phone = entity.phone;
    dto.bio = entity.bio;
    dto.createdBy = entity.createdBy;
    dto.updatedBy = entity.updatedBy;
    dto.createdAt = entity.createdAt;
    dto.updatedAt = entity.updatedAt;
    dto.deletedAt = entity.deletedAt;
    return dto;
  }
}
