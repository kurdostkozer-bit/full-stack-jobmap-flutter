import { SavedJobEntity } from '../entities/saved-job.entity';
import { SavedJobResponseDto } from '../dto/saved-job-response.dto';

export class SavedJobMapper {
  static toResponse(entity: SavedJobEntity): SavedJobResponseDto {
    return {
      id: entity.id,
      careerProfileId: entity.careerProfileId,
      jobId: entity.jobId,
      savedAt: entity.savedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
