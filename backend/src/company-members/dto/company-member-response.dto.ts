export class CompanyMemberResponseDto {
  id: string;
  companyId: string;
  userId: string;
  role: string;
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
