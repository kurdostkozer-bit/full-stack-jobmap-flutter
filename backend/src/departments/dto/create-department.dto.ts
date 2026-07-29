import { IsUUID, IsString, IsOptional } from 'class-validator';

export class CreateDepartmentDto {
  @IsUUID()
  companyId: string;

  @IsString()
  name: string;

  @IsString()
  slug: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsUUID()
  managerUserId?: string;
}
