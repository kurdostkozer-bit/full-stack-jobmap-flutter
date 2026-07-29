import { IsBoolean, IsEnum, IsOptional, IsString } from 'class-validator';

export class UpdateAttachmentDto {
  @IsOptional()
  @IsString()
  fileUrl?: string;

  @IsOptional()
  @IsBoolean()
  isDefault?: boolean;
}
