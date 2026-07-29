export class CompanyResponseDto {
  id: string;
  name: string;
  slug: string;
  logo?: string;
  coverImage?: string;
  description?: string;
  industry?: string;
  companySize?: string;
  foundedYear?: number;
  website?: string;
  email?: string;
  phone?: string;
  country?: string;
  city?: string;
  address?: string;
  verificationStatus: string;
  status: string;
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
