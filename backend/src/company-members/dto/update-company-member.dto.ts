import { IsEnum, IsOptional } from 'class-validator';

export class UpdateCompanyMemberDto {
  @IsOptional()
  @IsEnum(['OWNER', 'HR_MANAGER', 'RECRUITER', 'HIRING_MANAGER', 'VIEWER'])
  role?: 'OWNER' | 'HR_MANAGER' | 'RECRUITER' | 'HIRING_MANAGER' | 'VIEWER';
}
