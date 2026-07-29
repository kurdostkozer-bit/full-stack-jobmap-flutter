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
} from '@nestjs/common';

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
  async create(@Body() dto: CreateJobDto): Promise<JobResponseDto> {
    return this.jobsService.create(dto);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateJobDto,
  ): Promise<JobResponseDto> {
    return this.jobsService.update(id, dto);
  }

  @Delete(':id')
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<JobResponseDto> {
    return this.jobsService.remove(id);
  }
}
