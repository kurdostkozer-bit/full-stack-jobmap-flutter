export class ConversationResponseDto {
  id: string;
  participantIds: string[];
  title?: string;
  lastMessageAt: Date;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}
