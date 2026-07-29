import {
  IsBoolean,
  IsEnum,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator';

import { PROFICIENCY_LEVELS, SKILL_LEVELS } from './create-language.dto';

export class UpdateLanguageDto {
  @IsOptional()
  @IsString()
  @MaxLength(100)
  language?: string;

  @IsOptional()
  @IsEnum(PROFICIENCY_LEVELS)
  proficiencyLevel?: string;

  @IsOptional()
  @IsEnum(SKILL_LEVELS)
  readingLevel?: string;

  @IsOptional()
  @IsEnum(SKILL_LEVELS)
  writingLevel?: string;

  @IsOptional()
  @IsEnum(SKILL_LEVELS)
  speakingLevel?: string;

  @IsOptional()
  @IsBoolean()
  isPrimary?: boolean;
}
