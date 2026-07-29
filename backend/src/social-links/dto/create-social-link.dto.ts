import {
  IsEnum,
  IsInt,
  IsOptional,
  IsString,
  IsUUID,
  IsUrl,
  MaxLength,
  Min,
} from 'class-validator';

export class CreateSocialLinkDto {
  @IsUUID()
  careerProfileId!: string;

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
  platform!:
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

  @IsUrl()
  url!: string;

  @IsOptional()
  @IsString()
  @MaxLength(100)
  displayName?: string;

  @IsOptional()
  @IsEnum(['PUBLIC', 'PRIVATE'])
  visibility?: 'PUBLIC' | 'PRIVATE';

  @IsOptional()
  @IsInt()
  @Min(0)
  displayOrder?: number;
}
