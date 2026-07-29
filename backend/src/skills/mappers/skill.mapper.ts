import { SkillEntity } from '../entities/skill.entity';
import { SkillResponseDto } from '../dto/skill-response.dto';

export class SkillMapper {
  static toResponse(skill: SkillEntity): SkillResponseDto {
    return {
      id: skill.id,
      careerProfileId: skill.careerProfileId,
      name: skill.name,
      category: skill.category,
      level: skill.level,
      yearsOfExperience: skill.yearsOfExperience,
      verified: skill.verified,
      createdAt: skill.createdAt,
      updatedAt: skill.updatedAt,
    };
  }
}
