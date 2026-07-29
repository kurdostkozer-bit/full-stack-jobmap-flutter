import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
} from 'class-validator';

import { PROFICIENCY_LEVELS, SKILL_LEVELS } from './create-language.dto';

const SORT_FIELDS = [
  'language',
  'proficiencyLevel',
  'createdAt',
  'updatedAt',
] as const;
const SORT_ORDERS = ['asc', 'desc'] as const;

export class LanguageQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

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
  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  isPrimary?: boolean;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  search?: string;

  @IsOptional()
  @IsEnum(SORT_FIELDS)
  sortBy?: (typeof SORT_FIELDS)[number];

  @IsOptional()
  @IsEnum(SORT_ORDERS)
  sortOrder?: 'asc' | 'desc';

  @IsOptional()
  @Transform(({ value }) => parseInt(value, 10))
  @IsInt()
  @Min(1)
  page?: number;

  @IsOptional()
  @Transform(({ value }) => parseInt(value, 10))
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number;
}
