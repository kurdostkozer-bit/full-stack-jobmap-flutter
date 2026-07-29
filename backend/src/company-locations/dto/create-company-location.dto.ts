import { IsUUID, IsString, IsOptional, IsBoolean } from 'class-validator';

export class CreateCompanyLocationDto {
  @IsUUID()
  companyId: string;

  @IsString()
  name: string;

  @IsString()
  address: string;

  @IsString()
  city: string;

  @IsString()
  country: string;

  @IsOptional()
  @IsString()
  postalCode?: string;

  @IsOptional()
  @IsString()
  latitude?: string;

  @IsOptional()
  @IsString()
  longitude?: string;

  @IsOptional()
  @IsBoolean()
  isHeadquarters?: boolean;
}
