import { IsUUID, IsOptional, IsString } from 'class-validator';

export class CreateRecruiterDto {
  @IsUUID()
  companyId: string;

  @IsUUID()
  userId: string;

  @IsOptional()
  @IsString()
  title?: string;

  @IsOptional()
  @IsString()
  phone?: string;

  @IsOptional()
  @IsString()
  bio?: string;
}
