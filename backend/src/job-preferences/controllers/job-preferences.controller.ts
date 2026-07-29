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
} from '@nestjs/common';

import { CreateJobPreferenceDto } from '../dto/create-job-preference.dto';
import { JobPreferenceResponseDto } from '../dto/job-preference-response.dto';
import { UpdateJobPreferenceDto } from '../dto/update-job-preference.dto';
import { JobPreferencesService } from '../services/job-preferences.service';

@Controller({ path: 'job-preferences', version: '1' })
export class JobPreferencesController {
  constructor(private readonly jobPreferencesService: JobPreferencesService) {}

  @Post()
  create(@Body() dto: CreateJobPreferenceDto): Promise<JobPreferenceResponseDto> {
    return this.jobPreferencesService.create(dto);
  }

  @Get('career-profile/:careerProfileId')
  async findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<JobPreferenceResponseDto> {
    const record = await this.jobPreferencesService.findByCareerProfileId(careerProfileId);

    if (!record) throw new NotFoundException('Job preferences not found.');

    return record;
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<JobPreferenceResponseDto> {
    const record = await this.jobPreferencesService.findById(id);

    if (!record) throw new NotFoundException('Job preferences not found.');

    return record;
  }

  @Patch('career-profile/:careerProfileId')
  update(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Body() dto: UpdateJobPreferenceDto,
  ): Promise<JobPreferenceResponseDto> {
    return this.jobPreferencesService.update(careerProfileId, dto);
  }

  @Delete('career-profile/:careerProfileId')
  remove(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<JobPreferenceResponseDto> {
    return this.jobPreferencesService.remove(careerProfileId);
  }
}
