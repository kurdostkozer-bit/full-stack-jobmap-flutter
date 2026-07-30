import { IsString, IsUUID, IsOptional } from 'class-validator';

export class CreateMessageDto {
  @IsUUID()
  conversationId: string;

  @IsUUID()
  senderId: string;

  @IsString()
  content: string;

  @IsOptional()
  @IsString()
  attachmentUrl?: string;
}
