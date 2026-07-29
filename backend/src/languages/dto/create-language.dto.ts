import {
  IsBoolean,
  IsEnum,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';

export const PROFICIENCY_LEVELS = [
  'NATIVE',
  'FLUENT',
  'ADVANCED',
  'INTERMEDIATE',
  'BASIC',
] as const;
export const SKILL_LEVELS = ['EXCELLENT', 'GOOD', 'FAIR', 'POOR'] as const;

export class CreateLanguageDto {
  @IsUUID()
  careerProfileId!: string;

  @IsString()
  @MaxLength(100)
  language!: string;

  @IsEnum(PROFICIENCY_LEVELS)
  proficiencyLevel!: string;

  @IsEnum(SKILL_LEVELS)
  readingLevel!: string;

  @IsEnum(SKILL_LEVELS)
  writingLevel!: string;

  @IsEnum(SKILL_LEVELS)
  speakingLevel!: string;

  @IsOptional()
  @IsBoolean()
  isPrimary?: boolean;
}
