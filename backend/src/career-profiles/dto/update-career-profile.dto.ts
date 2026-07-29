import {
  IsBoolean,
  IsInt,
  IsOptional,
  IsString,
  MaxLength,
  Min,
} from 'class-validator';

export class UpdateCareerProfileDto {
  @IsOptional()
  @IsString()
  @MaxLength(160)
  headline?: string;

  @IsOptional()
  @IsString()
  @MaxLength(2000)
  summary?: string;

  @IsOptional()
  @IsString()
  @MaxLength(150)
  professionTitle?: string;

  @IsOptional()
  @IsString()
  @MaxLength(150)
  location?: string;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  preferredJobTitles?: string;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  preferredIndustries?: string;

  @IsOptional()
  @IsInt()
  @Min(0)
  salaryMin?: number;

  @IsOptional()
  @IsInt()
  @Min(0)
  salaryMax?: number;

  @IsOptional()
  @IsString()
  @MaxLength(10)
  currency?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  workPreference?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  remotePreference?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  relocationPreference?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  profileStatus?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  privacyLevel?: string;

  @IsOptional()
  @IsBoolean()
  isPublic?: boolean;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  resumeUrl?: string;
}
