import { IsOptional, IsString, IsUUID, MaxLength } from 'class-validator';

export class CareerProfileQueryDto {
  @IsOptional()
  @IsString()
  @MaxLength(100)
  search?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  profileStatus?: string;

  @IsOptional()
  @IsString()
  @MaxLength(50)
  privacyLevel?: string;

  @IsOptional()
  @IsUUID()
  userId?: string;
}
