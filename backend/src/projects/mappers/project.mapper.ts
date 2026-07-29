import { ProjectEntity } from '../entities/project.entity';
import { ProjectResponseDto } from '../dto/project-response.dto';

export class ProjectMapper {
  static toResponse(entity: ProjectEntity): ProjectResponseDto {
    return {
      id: entity.id,
      careerProfileId: entity.careerProfileId,
      title: entity.title,
      description: entity.description,
      role: entity.role,
      company: entity.company,
      technologies: entity.technologies ?? [],
      githubUrl: entity.githubUrl,
      liveUrl: entity.liveUrl,
      imageUrl: entity.imageUrl,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isCurrent: entity.isCurrent,
      displayOrder: entity.displayOrder,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
