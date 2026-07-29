import { IsEnum, IsOptional, IsUUID } from 'class-validator';

export class UploadAttachmentDto {
  @IsUUID()
  careerProfileId!: string;

  @IsEnum(['RESUME', 'COVER_LETTER', 'CERTIFICATE', 'PORTFOLIO', 'OTHER'])
  type!: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER';

  @IsOptional()
  isDefault?: boolean;
}
