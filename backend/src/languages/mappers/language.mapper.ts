import { LanguageEntity } from '../entities/language.entity';
import { LanguageResponseDto } from '../dto/language-response.dto';

export class LanguageMapper {
  static toResponse(entity: LanguageEntity): LanguageResponseDto {
    return {
      id: entity.id,
      careerProfileId: entity.careerProfileId,
      language: entity.language,
      proficiencyLevel: entity.proficiencyLevel,
      readingLevel: entity.readingLevel,
      writingLevel: entity.writingLevel,
      speakingLevel: entity.speakingLevel,
      isPrimary: entity.isPrimary,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    };
  }
}
