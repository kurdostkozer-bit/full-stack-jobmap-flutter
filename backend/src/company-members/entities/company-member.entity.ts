export class CompanyMemberEntity {
  id: string;
  companyId: string;
  userId: string;
  role: 'OWNER' | 'HR_MANAGER' | 'RECRUITER' | 'HIRING_MANAGER' | 'VIEWER';
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
