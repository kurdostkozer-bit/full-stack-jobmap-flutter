import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { CreateJobDto } from '../dto/create-job.dto';
import { JobQueryDto } from '../dto/job-query.dto';
import { JobResponseDto } from '../dto/job-response.dto';
import { UpdateJobDto } from '../dto/update-job.dto';
import { JobMapper } from '../mappers/job.mapper';
import { JobsRepository } from '../repositories/jobs.repository';

@Injectable()
export class JobsService {
  constructor(private readonly jobsRepository: JobsRepository) {}

  async create(dto: CreateJobDto): Promise<JobResponseDto> {
    const existing = await this.jobsRepository.findBySlug(dto.slug);

    if (existing) {
      throw new ConflictException('Job slug already exists.');
    }

    const record = await this.jobsRepository.create(dto);
    return JobMapper.toResponse(record);
  }

  async update(id: string, dto: UpdateJobDto): Promise<JobResponseDto> {
    if (dto.slug) {
      const existing = await this.jobsRepository.findBySlug(dto.slug);

      if (existing && existing.id !== id) {
        throw new ConflictException('Job slug already exists.');
      }
    }

    const record = await this.jobsRepository.update(id, dto);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return JobMapper.toResponse(record);
  }

  async findAll(query?: JobQueryDto): Promise<JobResponseDto[]> {
    const records = await this.jobsRepository.findAll(query);
    return records.map(JobMapper.toResponse);
  }

  async findById(id: string): Promise<JobResponseDto | null> {
    const record = await this.jobsRepository.findById(id);
    return record ? JobMapper.toResponse(record) : null;
  }

  async findBySlug(slug: string): Promise<JobResponseDto | null> {
    const record = await this.jobsRepository.findBySlug(slug);
    return record ? JobMapper.toResponse(record) : null;
  }

  async findByCompanyId(companyId: string): Promise<JobResponseDto[]> {
    const records = await this.jobsRepository.findByCompanyId(companyId);
    return records.map(JobMapper.toResponse);
  }

  async remove(id: string): Promise<JobResponseDto> {
    const record = await this.jobsRepository.remove(id);

    if (!record) {
      throw new NotFoundException('Job not found.');
    }

    return JobMapper.toResponse(record);
  }
}
