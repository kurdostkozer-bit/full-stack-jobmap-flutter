import { IsArray, IsBoolean, IsEnum, IsInt, IsOptional, IsString, IsUUID, Min } from 'class-validator';

export class CreateJobPreferenceDto {
  @IsUUID()
  careerProfileId!: string;

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  desiredJobTitles?: string[];

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  preferredJobCategories?: string[];

  @IsOptional()
  @IsArray()
  @IsEnum(['ON_SITE', 'REMOTE', 'HYBRID'], { each: true })
  workEnvironments?: ('ON_SITE' | 'REMOTE' | 'HYBRID')[];

  @IsOptional()
  @IsArray()
  @IsEnum(['FULL_TIME', 'PART_TIME', 'CONTRACT', 'INTERNSHIP', 'FREELANCE', 'TEMPORARY'], {
    each: true,
  })
  employmentTypes?: ('FULL_TIME' | 'PART_TIME' | 'CONTRACT' | 'INTERNSHIP' | 'FREELANCE' | 'TEMPORARY')[];

  @IsOptional()
  @IsInt()
  @Min(0)
  minimumSalary?: number;

  @IsOptional()
  @IsInt()
  @Min(0)
  maximumSalary?: number;

  @IsOptional()
  @IsEnum(['USD', 'EUR', 'GBP', 'AED', 'SAR', 'KWD', 'QAR', 'OMR', 'BHD', 'JOD', 'EGP', 'IQD', 'LBP'])
  currency?: 'USD' | 'EUR' | 'GBP' | 'AED' | 'SAR' | 'KWD' | 'QAR' | 'OMR' | 'BHD' | 'JOD' | 'EGP' | 'IQD' | 'LBP';

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  preferredCities?: string[];

  @IsOptional()
  @IsArray()
  @IsString({ each: true })
  preferredCountries?: string[];

  @IsOptional()
  @IsBoolean()
  openToRelocation?: boolean;

  @IsOptional()
  @IsBoolean()
  availableImmediately?: boolean;

  @IsOptional()
  @IsInt()
  @Min(0)
  noticePeriodDays?: number;

  @IsOptional()
  @IsBoolean()
  willingToTravel?: boolean;

  @IsOptional()
  @IsBoolean()
  openToInternationalJobs?: boolean;
}
