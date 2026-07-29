export class DepartmentEntity {
  id: string;
  companyId: string;
  name: string;
  slug: string;
  description?: string;
  managerUserId?: string;
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
