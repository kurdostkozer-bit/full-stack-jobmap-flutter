import { IsUUID, IsEnum } from 'class-validator';

export class CreateCompanyMemberDto {
  @IsUUID()
  companyId: string;

  @IsUUID()
  userId: string;

  @IsEnum(['OWNER', 'HR_MANAGER', 'RECRUITER', 'HIRING_MANAGER', 'VIEWER'])
  role: 'OWNER' | 'HR_MANAGER' | 'RECRUITER' | 'HIRING_MANAGER' | 'VIEWER';
}
