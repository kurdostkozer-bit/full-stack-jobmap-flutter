import {
  IsBoolean,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';

export class ExperienceQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  employmentType?: string;

  @IsOptional()
  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  isCurrent?: boolean;
}
