import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Query,
  UseGuards,
  ForbiddenException,
  Request,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

import { CreateJobDto } from '../dto/create-job.dto';
import { JobQueryDto } from '../dto/job-query.dto';
import { JobResponseDto } from '../dto/job-response.dto';
import { UpdateJobDto } from '../dto/update-job.dto';
import { JobsService } from '../services/jobs.service';

@Controller({
  path: 'jobs',
  version: '1',
})
export class JobsController {
  constructor(private readonly jobsService: JobsService) {}

  @Get()
  async findAll(@Query() query: JobQueryDto): Promise<JobResponseDto[]> {
    return this.jobsService.findAll(query);
  }

  @Get('slug/:slug')
  async findBySlug(@Param('slug') slug: string): Promise<JobResponseDto> {
    const record = await this.jobsService.findBySlug(slug);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return record;
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<JobResponseDto[]> {
    return this.jobsService.findByCompanyId(companyId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<JobResponseDto> {
    const record = await this.jobsService.findById(id);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return record;
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @HttpCode(HttpStatus.CREATED)
  async create(
    @Body() dto: CreateJobDto,
    @Request() req: any,
  ): Promise<JobResponseDto> {
    // For now, any authenticated user can create jobs
    // TODO: Add role-based check once roles are in JWT payload
    return this.jobsService.create(dto, req.user.id);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateJobDto,
    @Request() req: any,
  ): Promise<JobResponseDto> {
    const record = await this.jobsService.findById(id);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    // Only creator or admin can modify
    if (record.recruiterId !== req.user.id) {
      throw new ForbiddenException('You can only modify your own jobs');
    }

    return this.jobsService.update(id, dto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
    @Request() req: any,
  ): Promise<JobResponseDto> {
    const record = await this.jobsService.findById(id);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    // Only creator can delete
    if (record.recruiterId !== req.user.id) {
      throw new ForbiddenException('You can only delete your own jobs');
    }

    return this.jobsService.remove(id);
  }
}
