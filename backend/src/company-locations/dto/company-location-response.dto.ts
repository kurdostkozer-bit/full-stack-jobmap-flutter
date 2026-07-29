export class CompanyLocationResponseDto {
  id: string;
  companyId: string;
  name: string;
  address: string;
  city: string;
  country: string;
  postalCode?: string;
  latitude?: string;
  longitude?: string;
  isHeadquarters: boolean;
  createdBy: string;
  updatedBy: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}
