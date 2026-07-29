import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateExperienceDto } from '../dto/create-experience.dto';
import { ExperienceQueryDto } from '../dto/experience-query.dto';
import { ExperienceResponseDto } from '../dto/experience-response.dto';
import { UpdateExperienceDto } from '../dto/update-experience.dto';
import { ExperienceMapper } from '../mappers/experience.mapper';
import { ExperiencesRepository } from '../repositories/experiences.repository';

@Injectable()
export class ExperiencesService {
  constructor(private readonly experiencesRepository: ExperiencesRepository) {}

  async create(dto: CreateExperienceDto): Promise<ExperienceResponseDto> {
    const experience = await this.experiencesRepository.create(dto);
    return ExperienceMapper.toResponse(experience);
  }

  async update(
    id: string,
    dto: UpdateExperienceDto,
  ): Promise<ExperienceResponseDto> {
    const experience = await this.experiencesRepository.update(id, dto);

    if (!experience) {
      throw new NotFoundException('Experience not found.');
    }

    return ExperienceMapper.toResponse(experience);
  }

  async findAll(query?: ExperienceQueryDto): Promise<ExperienceResponseDto[]> {
    const experiences = await this.experiencesRepository.findAll(query);
    return experiences.map(ExperienceMapper.toResponse);
  }

  async findById(id: string): Promise<ExperienceResponseDto | null> {
    const experience = await this.experiencesRepository.findById(id);

    if (!experience) {
      return null;
    }

    return ExperienceMapper.toResponse(experience);
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<ExperienceResponseDto[]> {
    const experiences =
      await this.experiencesRepository.findByCareerProfileId(careerProfileId);
    return experiences.map(ExperienceMapper.toResponse);
  }

  async remove(id: string): Promise<ExperienceResponseDto> {
    const experience = await this.experiencesRepository.remove(id);

    if (!experience) {
      throw new NotFoundException('Experience not found.');
    }

    return ExperienceMapper.toResponse(experience);
  }
}
