import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
  UseGuards,
  Req,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Request } from 'express';
import { SavedJobsService } from '../services/saved-jobs.service';
import { SavedJobResponseDto } from '../dto/saved-job-response.dto';
import { CreateSavedJobDto } from '../dto/create-saved-job.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { CareerProfilesService } from '../../career-profiles/services/career-profiles.service';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'saved-jobs', version: '1' })
export class SavedJobsController {
  constructor(
    private readonly savedJobsService: SavedJobsService,
    private readonly careerProfilesService: CareerProfilesService,
  ) {}

  @UseGuards(JwtAuthGuard)
  @Post('save')
  async saveJob(
    @Req() req: AuthenticatedRequest,
    @Body() dto: CreateSavedJobDto,
  ): Promise<SavedJobResponseDto> {
    // Verify profile belongs to user
    const profile = await this.careerProfilesService.findById(dto.careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    return this.savedJobsService.saveJob(dto.careerProfileId, dto.jobId);
  }

  @UseGuards(JwtAuthGuard)
  @Post(':careerProfileId/jobs/:jobId/unsave')
  @HttpCode(HttpStatus.NO_CONTENT)
  async unsaveJob(
    @Req() req: AuthenticatedRequest,
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('jobId', ParseUUIDPipe) jobId: string,
  ): Promise<void> {
    // Verify profile belongs to user
    const profile = await this.careerProfilesService.findById(careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    return this.savedJobsService.unsaveJob(careerProfileId, jobId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':careerProfileId')
  async getSavedJobs(
    @Req() req: AuthenticatedRequest,
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<SavedJobResponseDto[]> {
    // Verify profile belongs to user
    const profile = await this.careerProfilesService.findById(careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    return this.savedJobsService.getSavedJobs(careerProfileId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':careerProfileId/jobs/:jobId/check')
  async isSaved(
    @Req() req: AuthenticatedRequest,
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('jobId', ParseUUIDPipe) jobId: string,
  ): Promise<{ isSaved: boolean }> {
    // Verify profile belongs to user
    const profile = await this.careerProfilesService.findById(careerProfileId);
    if (!profile || profile.userId !== req.user.id) {
      throw new ForbiddenException('Career profile does not belong to you');
    }

    const isSaved = await this.savedJobsService.isSaved(careerProfileId, jobId);
    return { isSaved };
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteSavedJob(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    await this.savedJobsService.deleteSavedJob(id);
  }
}
