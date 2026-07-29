import { IsOptional, IsString, IsUUID, MaxLength } from 'class-validator';

export class SkillQueryDto {
  @IsOptional()
  @IsString()
  @MaxLength(100)
  name?: string;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  category?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  level?: string;

  @IsOptional()
  @IsUUID()
  careerProfileId?: string;
}
