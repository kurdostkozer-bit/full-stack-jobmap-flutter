import { IsOptional, IsUUID, IsEnum, IsInt, Min } from 'class-validator';

export class CompanyMemberQueryDto {
  @IsOptional()
  @IsUUID()
  companyId?: string;

  @IsOptional()
  @IsUUID()
  userId?: string;

  @IsOptional()
  @IsEnum(['OWNER', 'HR_MANAGER', 'RECRUITER', 'HIRING_MANAGER', 'VIEWER'])
  role?: 'OWNER' | 'HR_MANAGER' | 'RECRUITER' | 'HIRING_MANAGER' | 'VIEWER';

  @IsOptional()
  @IsInt()
  @Min(0)
  skip?: number;

  @IsOptional()
  @IsInt()
  @Min(1)
  take?: number;
}
