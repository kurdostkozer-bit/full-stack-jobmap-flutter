import { ExperienceEntity } from '../entities/experience.entity';
import { ExperienceResponseDto } from '../dto/experience-response.dto';

export class ExperienceMapper {
  static toResponse(experience: ExperienceEntity): ExperienceResponseDto {
    return {
      id: experience.id,
      careerProfileId: experience.careerProfileId,
      jobTitle: experience.jobTitle,
      companyName: experience.companyName,
      employmentType: experience.employmentType,
      location: experience.location,
      description: experience.description,
      startDate: experience.startDate,
      endDate: experience.endDate,
      isCurrent: experience.isCurrent,
      sortOrder: experience.sortOrder,
      createdAt: experience.createdAt,
      updatedAt: experience.updatedAt,
    };
  }
}
