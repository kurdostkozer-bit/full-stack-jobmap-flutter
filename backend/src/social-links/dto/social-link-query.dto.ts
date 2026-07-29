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
  'platform',
  'displayOrder',
  'visibility',
  'createdAt',
  'updatedAt',
] as const;
const SORT_ORDERS = ['asc', 'desc'] as const;

export class SocialLinkQueryDto {
  @IsOptional()
  @IsUUID()
  careerProfileId?: string;

  @IsOptional()
  @IsEnum([
    'LINKEDIN',
    'GITHUB',
    'GITLAB',
    'STACKOVERFLOW',
    'BEHANCE',
    'DRIBBBLE',
    'PERSONAL_WEBSITE',
    'X',
    'FACEBOOK',
    'INSTAGRAM',
    'YOUTUBE',
    'TELEGRAM',
  ])
  platform?:
    | 'LINKEDIN'
    | 'GITHUB'
    | 'GITLAB'
    | 'STACKOVERFLOW'
    | 'BEHANCE'
    | 'DRIBBBLE'
    | 'PERSONAL_WEBSITE'
    | 'X'
    | 'FACEBOOK'
    | 'INSTAGRAM'
    | 'YOUTUBE'
    | 'TELEGRAM';

  @IsOptional()
  @IsEnum(['PUBLIC', 'PRIVATE'])
  visibility?: 'PUBLIC' | 'PRIVATE';

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
