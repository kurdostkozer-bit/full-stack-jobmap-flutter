import {
  IsBoolean,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
} from 'class-validator';
import { Transform } from 'class-transformer';

export class EducationQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

  @IsOptional()
  @IsString()
  @MaxLength(150)
  degree?: string;

  @IsOptional()
  @IsString()
  @MaxLength(150)
  fieldOfStudy?: string;

  @IsOptional()
  @Transform(({ value }) => value === 'true')
  @IsBoolean()
  isCurrent?: boolean;
}
