import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateEducationDto } from '../dto/create-education.dto';
import { EducationQueryDto } from '../dto/education-query.dto';
import { EducationResponseDto } from '../dto/education-response.dto';
import { UpdateEducationDto } from '../dto/update-education.dto';
import { EducationMapper } from '../mappers/education.mapper';
import { EducationRepository } from '../repositories/education.repository';

@Injectable()
export class EducationService {
  constructor(private readonly educationRepository: EducationRepository) {}

  async create(dto: CreateEducationDto): Promise<EducationResponseDto> {
    const record = await this.educationRepository.create(dto);
    return EducationMapper.toResponse(record);
  }

  async update(
    id: string,
    dto: UpdateEducationDto,
  ): Promise<EducationResponseDto> {
    const record = await this.educationRepository.update(id, dto);

    if (!record) {
      throw new NotFoundException('Education record not found.');
    }

    return EducationMapper.toResponse(record);
  }

  async findAll(query?: EducationQueryDto): Promise<EducationResponseDto[]> {
    const records = await this.educationRepository.findAll(query);
    return records.map(EducationMapper.toResponse);
  }

  async findById(id: string): Promise<EducationResponseDto | null> {
    const record = await this.educationRepository.findById(id);

    if (!record) {
      return null;
    }

    return EducationMapper.toResponse(record);
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<EducationResponseDto[]> {
    const records =
      await this.educationRepository.findByCareerProfileId(careerProfileId);
    return records.map(EducationMapper.toResponse);
  }

  async remove(id: string): Promise<EducationResponseDto> {
    const record = await this.educationRepository.remove(id);

    if (!record) {
      throw new NotFoundException('Education record not found.');
    }

    return EducationMapper.toResponse(record);
  }
}
