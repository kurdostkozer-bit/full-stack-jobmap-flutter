import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
  UseGuards,
  Request,
  Query,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { NotificationsService } from '../services/notifications.service';
import { NotificationResponseDto } from '../dto/notification-response.dto';
import { CreateNotificationDto } from '../dto/create-notification.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'notifications', version: '1' })
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @UseGuards(JwtAuthGuard)
  @Post()
  async createNotification(
    @Body() dto: CreateNotificationDto,
  ): Promise<NotificationResponseDto> {
    return this.notificationsService.createNotification(dto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('user/:userId')
  async getNotifications(
    @Param('userId', ParseUUIDPipe) userId: string,
    @Query('limit') limit?: string,
    @Query('offset') offset?: string,
  ): Promise<NotificationResponseDto[]> {
    return this.notificationsService.getNotifications(
      userId,
      limit ? parseInt(limit) : 50,
      offset ? parseInt(offset) : 0,
    );
  }

  @UseGuards(JwtAuthGuard)
  @Get('user/:userId/unread')
  async getUnreadNotifications(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<NotificationResponseDto[]> {
    return this.notificationsService.getUnreadNotifications(userId);
  }

  @UseGuards(JwtAuthGuard)
  @Get('user/:userId/unread-count')
  async getUnreadCount(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<{ count: number }> {
    const count = await this.notificationsService.getUnreadCount(userId);
    return { count };
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getNotificationById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<NotificationResponseDto> {
    return this.notificationsService.getNotificationById(id);
  }

  @UseGuards(JwtAuthGuard)
  @Post(':id/mark-as-read')
  async markAsRead(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<NotificationResponseDto> {
    return this.notificationsService.markAsRead(id);
  }

  @UseGuards(JwtAuthGuard)
  @Post('user/:userId/mark-all-as-read')
  @HttpCode(HttpStatus.NO_CONTENT)
  async markAllAsRead(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<void> {
    return this.notificationsService.markAllAsRead(userId);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteNotification(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.notificationsService.deleteNotification(id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('user/:userId/all')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteAllNotifications(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<void> {
    return this.notificationsService.deleteAllNotifications(userId);
  }
}
