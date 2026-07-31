import {
  IsBoolean,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  Min,
  IsIn,
} from 'class-validator';

export class CreateCareerProfileDto {
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
  @IsIn(['full-time', 'part-time', 'contract', 'freelance', 'internship', 'temporary'])
  workPreference?: string;

  @IsOptional()
  @IsString()
  @IsIn(['remote', 'onsite', 'hybrid'])
  remotePreference?: string;

  @IsOptional()
  @IsString()
  @IsIn(['open', 'not-open', 'willing'])
  relocationPreference?: string;

  @IsOptional()
  @IsString()
  @IsIn(['draft', 'active', 'inactive', 'archived'])
  profileStatus?: string;

  @IsOptional()
  @IsString()
  @IsIn(['private', 'public', 'friends-only'])
  privacyLevel?: string;

  @IsOptional()
  @IsBoolean()
  isPublic?: boolean;

  @IsOptional()
  @IsString()
  @MaxLength(500)
  resumeUrl?: string;
}
