import { Transform } from 'class-transformer';
import {
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  MaxLength,
  Min,
} from 'class-validator';

const SORT_FIELDS = [
  'name',
  'issuer',
  'issueDate',
  'displayOrder',
  'verificationStatus',
  'createdAt',
  'updatedAt',
] as const;
const SORT_ORDERS = ['asc', 'desc'] as const;

export class CertificateQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  search?: string;

  @IsOptional()
  @IsEnum(['PENDING', 'VERIFIED', 'REJECTED'])
  verificationStatus?: 'PENDING' | 'VERIFIED' | 'REJECTED';

  @IsOptional()
  @Transform(({ value }) => {
    if (typeof value === 'string') return value === 'true';
    return value as boolean | undefined;
  })
  doesNotExpire?: boolean;

  @IsOptional()
  @IsEnum(SORT_FIELDS)
  sortBy?: (typeof SORT_FIELDS)[number];

  @IsOptional()
  @IsEnum(SORT_ORDERS)
  sortOrder?: 'asc' | 'desc';

  @IsOptional()
  @Transform(({ value }) => parseInt(value as string, 10))
  @IsInt()
  @Min(1)
  page?: number;

  @IsOptional()
  @Transform(({ value }) => parseInt(value as string, 10))
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number;
}
