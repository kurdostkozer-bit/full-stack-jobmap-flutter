import { Transform } from 'class-transformer';
import {
  IsBoolean,
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  Max,
  Min,
} from 'class-validator';

const SORT_FIELDS = ['type', 'fileSize', 'createdAt', 'updatedAt'] as const;
const SORT_ORDERS = ['asc', 'desc'] as const;

export class AttachmentQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

  @IsOptional()
  @IsEnum(['RESUME', 'COVER_LETTER', 'CERTIFICATE', 'PORTFOLIO', 'OTHER'])
  type?: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER';

  @IsOptional()
  @Transform(({ value }) => {
    if (typeof value === 'string') return value === 'true';
    return value as boolean | undefined;
  })
  isDefault?: boolean;

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
