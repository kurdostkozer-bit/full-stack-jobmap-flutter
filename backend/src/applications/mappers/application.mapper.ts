import { ApplicationEntity } from '../entities/application.entity';
import { ApplicationResponseDto } from '../dto/application-response.dto';

export class ApplicationMapper {
  static toResponse(entity: ApplicationEntity): ApplicationResponseDto {
    return {
      id: entity.id,
      careerProfileId: entity.careerProfileId,
      jobId: entity.jobId,
      status: entity.status,
      appliedAt: entity.appliedAt,
      statusUpdatedAt: entity.statusUpdatedAt,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
