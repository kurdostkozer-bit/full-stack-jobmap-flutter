import { Injectable, NotFoundException } from '@nestjs/common';
import { NotificationsRepository } from '../repositories/notifications.repository';
import { NotificationResponseDto } from '../dto/notification-response.dto';
import { CreateNotificationDto } from '../dto/create-notification.dto';
import { NotificationMapper } from '../mappers/notification.mapper';

@Injectable()
export class NotificationsService {
  constructor(private readonly notificationsRepository: NotificationsRepository) {}

  async createNotification(dto: CreateNotificationDto): Promise<NotificationResponseDto> {
    const notification = await this.notificationsRepository.create(dto);
    return NotificationMapper.toResponse(notification);
  }

  async getNotifications(
    userId: string,
    limit: number = 50,
    offset: number = 0,
  ): Promise<NotificationResponseDto[]> {
    const notifications = await this.notificationsRepository.findByUserId(
      userId,
      limit,
      offset,
    );
    return notifications.map(NotificationMapper.toResponse);
  }

  async getUnreadNotifications(userId: string): Promise<NotificationResponseDto[]> {
    const notifications = await this.notificationsRepository.findUnreadByUserId(userId);
    return notifications.map(NotificationMapper.toResponse);
  }

  async getNotificationById(id: string): Promise<NotificationResponseDto> {
    const notification = await this.notificationsRepository.findById(id);

    if (!notification) {
      throw new NotFoundException('Notification not found.');
    }

    return NotificationMapper.toResponse(notification);
  }

  async markAsRead(id: string): Promise<NotificationResponseDto> {
    const notification = await this.notificationsRepository.markAsRead(id);

    if (!notification) {
      throw new NotFoundException('Notification not found.');
    }

    return NotificationMapper.toResponse(notification);
  }

  async markAllAsRead(userId: string): Promise<void> {
    await this.notificationsRepository.markAllAsRead(userId);
  }

  async deleteNotification(id: string): Promise<void> {
    const deleted = await this.notificationsRepository.delete(id);

    if (!deleted) {
      throw new NotFoundException('Notification not found.');
    }
  }

  async deleteAllNotifications(userId: string): Promise<void> {
    await this.notificationsRepository.deleteAllByUserId(userId);
  }

  async getUnreadCount(userId: string): Promise<number> {
    return this.notificationsRepository.getUnreadCount(userId);
  }
}
