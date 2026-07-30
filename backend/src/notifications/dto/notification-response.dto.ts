export class NotificationResponseDto {
  id: string;
  userId: string;
  type: 'JOB_ALERT' | 'APPLICATION_UPDATE' | 'MESSAGE' | 'PROFILE_VIEW' | 'SYSTEM';
  title: string;
  message: string;
  data?: Record<string, any>;
  isRead: boolean;
  readAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}
