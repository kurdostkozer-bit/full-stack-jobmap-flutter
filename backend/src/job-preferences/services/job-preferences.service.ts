import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateJobPreferenceDto } from '../dto/create-job-preference.dto';
import { JobPreferenceResponseDto } from '../dto/job-preference-response.dto';
import { UpdateJobPreferenceDto } from '../dto/update-job-preference.dto';
import { JobPreferenceMapper } from '../mappers/job-preference.mapper';
import { JobPreferencesRepository } from '../repositories/job-preferences.repository';

@Injectable()
export class JobPreferencesService {
  constructor(private readonly jobPreferencesRepository: JobPreferencesRepository) {}

  async create(dto: CreateJobPreferenceDto): Promise<JobPreferenceResponseDto> {
    const record = await this.jobPreferencesRepository.create(dto);
    return JobPreferenceMapper.toResponse(record);
  }

  async update(
    careerProfileId: string,
    dto: UpdateJobPreferenceDto,
  ): Promise<JobPreferenceResponseDto> {
    const record = await this.jobPreferencesRepository.update(careerProfileId, dto);

    if (!record) throw new NotFoundException('Job preferences not found.');

    return JobPreferenceMapper.toResponse(record);
  }

  async findByCareerProfileId(careerProfileId: string): Promise<JobPreferenceResponseDto | null> {
    const record = await this.jobPreferencesRepository.findByCareerProfileId(careerProfileId);
    return record ? JobPreferenceMapper.toResponse(record) : null;
  }

  async findById(id: string): Promise<JobPreferenceResponseDto | null> {
    const record = await this.jobPreferencesRepository.findById(id);
    return record ? JobPreferenceMapper.toResponse(record) : null;
  }

  async remove(careerProfileId: string): Promise<JobPreferenceResponseDto> {
    const record = await this.jobPreferencesRepository.remove(careerProfileId);

    if (!record) throw new NotFoundException('Job preferences not found.');

    return JobPreferenceMapper.toResponse(record);
  }
}
