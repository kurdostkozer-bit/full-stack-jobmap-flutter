export class AttachmentResponseDto {
  id!: string;
  careerProfileId!: string;
  type!: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER';
  originalFileName!: string;
  storedFileName!: string;
  mimeType!: string;
  fileSize!: number;
  storageProvider!: 'LOCAL' | 'S3' | 'R2' | 'AZURE' | 'GCS';
  storagePath!: string;
  fileUrl!: string;
  isDefault!: boolean;
  createdAt!: Date;
  updatedAt!: Date;
}
