export class RecruiterResponseDto {
  id: string;
  companyId: string;
  userId: string;
  title?: string;
  phone?: string;
  bio?: string;
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
