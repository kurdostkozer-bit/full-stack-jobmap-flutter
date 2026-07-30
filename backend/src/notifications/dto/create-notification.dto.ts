import { IsString, IsEnum, IsOptional, IsUUID } from 'class-validator';

export enum NotificationType {
  JOB_ALERT = 'JOB_ALERT',
  APPLICATION_UPDATE = 'APPLICATION_UPDATE',
  MESSAGE = 'MESSAGE',
  PROFILE_VIEW = 'PROFILE_VIEW',
  SYSTEM = 'SYSTEM',
}

export class CreateNotificationDto {
  @IsUUID()
  userId: string;

  @IsEnum(NotificationType)
  type: NotificationType;

  @IsString()
  title: string;

  @IsString()
  message: string;

  @IsOptional()
  data?: Record<string, any>;
}
