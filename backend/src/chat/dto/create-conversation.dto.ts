import { IsArray, IsUUID, IsOptional, IsString, ArrayMinSize } from 'class-validator';

export class CreateConversationDto {
  @IsArray()
  @IsUUID('all', { each: true })
  @ArrayMinSize(2)
  participantIds: string[];

  @IsOptional()
  @IsString()
  title?: string;
}
