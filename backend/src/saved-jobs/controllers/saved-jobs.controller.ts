import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
  UseGuards,
  Request,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { SavedJobsService } from '../services/saved-jobs.service';
import { SavedJobResponseDto } from '../dto/saved-job-response.dto';
import { CreateSavedJobDto } from '../dto/create-saved-job.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'saved-jobs', version: '1' })
export class SavedJobsController {
  constructor(private readonly savedJobsService: SavedJobsService) {}

  @UseGuards(JwtAuthGuard)
  @Post('save')
  async saveJob(@Body() dto: CreateSavedJobDto): Promise<SavedJobResponseDto> {
    return this.savedJobsService.saveJob(dto.careerProfileId, dto.jobId);
  }

  @UseGuards(JwtAuthGuard)
  @Post(':careerProfileId/jobs/:jobId/unsave')
  @HttpCode(HttpStatus.NO_CONTENT)
  async unsaveJob(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('jobId', ParseUUIDPipe) jobId: string,
  ): Promise<void> {
    return this.savedJobsService.unsaveJob(careerProfileId, jobId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':careerProfileId')
  async getSavedJobs(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<SavedJobResponseDto[]> {
    return this.savedJobsService.getSavedJobs(careerProfileId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':careerProfileId/jobs/:jobId/check')
  async isSaved(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('jobId', ParseUUIDPipe) jobId: string,
  ): Promise<{ isSaved: boolean }> {
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
