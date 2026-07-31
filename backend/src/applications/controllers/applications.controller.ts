import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  UseGuards,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
  Req,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Request } from 'express';
import { ApplicationsService } from '../services/applications.service';
import { ApplicationResponseDto } from '../dto/application-response.dto';
import { CreateApplicationDto } from '../dto/create-application.dto';
import { UpdateApplicationStatusDto } from '../dto/update-application-status.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { CareerProfilesService } from '../../career-profiles/services/career-profiles.service';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'applications', version: '1' })
export class ApplicationsController {
  constructor(
    private readonly applicationsService: ApplicationsService,
    private readonly careerProfilesService: CareerProfilesService,
  ) {}

  @UseGuards(JwtAuthGuard)
  @Post('apply')
  async applyToJob(
    @Req() req: AuthenticatedRequest,
    @Body() dto: CreateApplicationDto,
  ): Promise<ApplicationResponseDto> {
    // Verify career profile belongs to authenticated user
    const profile = await this.careerProfilesService.findById(dto.careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    return this.applicationsService.applyToJob(dto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('career-profile/:careerProfileId')
  async getApplications(
    @Req() req: AuthenticatedRequest,
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<ApplicationResponseDto[]> {
    // Verify career profile belongs to authenticated user
    const profile = await this.careerProfilesService.findById(careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    return this.applicationsService.getApplications(careerProfileId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getApplication(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ApplicationResponseDto> {
    const application = await this.applicationsService.getApplication(id);
    
    // Verify application belongs to authenticated user's career profile
    const profile = await this.careerProfilesService.findById(
      application.careerProfileId,
    );
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Application does not belong to you');
    }

    return application;
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id/status')
  async updateApplicationStatus(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateApplicationStatusDto,
  ): Promise<ApplicationResponseDto> {
    const application = await this.applicationsService.getApplication(id);
    
    // Verify application belongs to authenticated user's career profile
    const profile = await this.careerProfilesService.findById(
      application.careerProfileId,
    );
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Not authorized to update this application');
    }

    return this.applicationsService.updateApplicationStatus(id, dto);
  }

  @UseGuards(JwtAuthGuard)
  @Post(':id/withdraw')
  async withdrawApplication(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ApplicationResponseDto> {
    const application = await this.applicationsService.getApplication(id);
    
    // Verify application belongs to authenticated user's career profile
    const profile = await this.careerProfilesService.findById(
      application.careerProfileId,
    );
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Not authorized to withdraw this application');
    }

    return this.applicationsService.withdrawApplication(id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteApplication(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    const application = await this.applicationsService.getApplication(id);
    
    // Verify application belongs to authenticated user's career profile
    const profile = await this.careerProfilesService.findById(
      application.careerProfileId,
    );
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Not authorized to delete this application');
    }

    return this.applicationsService.deleteApplication(id);
  }
}
