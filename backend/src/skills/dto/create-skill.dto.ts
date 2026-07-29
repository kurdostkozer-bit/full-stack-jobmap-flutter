import {
  IsBoolean,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  MaxLength,
  Min,
} from 'class-validator';

export class CreateSkillDto {
  @IsString()
  @MaxLength(100)
  name!: string;

  @IsString()
  @MaxLength(100)
  category!: string;

  @IsString()
  @MaxLength(50)
  level!: string;

  @IsInt()
  @Min(0)
  yearsOfExperience!: number;

  @IsOptional()
  @IsBoolean()
  verified?: boolean;

  @IsUUID()
  careerProfileId!: string;
}
