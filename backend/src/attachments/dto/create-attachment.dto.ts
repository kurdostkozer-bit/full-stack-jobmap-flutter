import { IsEnum, IsInt, IsOptional, IsString, IsUUID, Min } from 'class-validator';

export class CreateAttachmentDto {
  @IsUUID()
  careerProfileId!: string;

  @IsEnum(['RESUME', 'COVER_LETTER', 'CERTIFICATE', 'PORTFOLIO', 'OTHER'])
  type!: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER';

  @IsString()
  originalFileName!: string;

  @IsString()
  storedFileName!: string;

  @IsString()
  mimeType!: string;

  @IsInt()
  @Min(0)
  fileSize!: number;

  @IsOptional()
  @IsEnum(['LOCAL', 'S3', 'R2', 'AZURE', 'GCS'])
  storageProvider?: 'LOCAL' | 'S3' | 'R2' | 'AZURE' | 'GCS';

  @IsString()
  storagePath!: string;

  @IsString()
  fileUrl!: string;

  @IsOptional()
  isDefault?: boolean;
}
