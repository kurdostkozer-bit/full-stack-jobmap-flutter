import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateProjectDto } from '../dto/create-project.dto';
import { ProjectQueryDto } from '../dto/project-query.dto';
import { ProjectResponseDto } from '../dto/project-response.dto';
import { UpdateProjectDto } from '../dto/update-project.dto';
import { ProjectMapper } from '../mappers/project.mapper';
import { ProjectsRepository } from '../repositories/projects.repository';

@Injectable()
export class ProjectsService {
  constructor(private readonly projectsRepository: ProjectsRepository) {}

  async create(dto: CreateProjectDto): Promise<ProjectResponseDto> {
    const record = await this.projectsRepository.create(dto);
    return ProjectMapper.toResponse(record);
  }

  async update(id: string, dto: UpdateProjectDto): Promise<ProjectResponseDto> {
    const record = await this.projectsRepository.update(id, dto);

    if (!record) throw new NotFoundException('Project not found.');

    return ProjectMapper.toResponse(record);
  }

  async findAll(query?: ProjectQueryDto): Promise<ProjectResponseDto[]> {
    const records = await this.projectsRepository.findAll(query);
    return records.map(ProjectMapper.toResponse);
  }

  async findById(id: string): Promise<ProjectResponseDto | null> {
    const record = await this.projectsRepository.findById(id);
    return record ? ProjectMapper.toResponse(record) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<ProjectResponseDto[]> {
    const records =
      await this.projectsRepository.findByCareerProfileId(careerProfileId);
    return records.map(ProjectMapper.toResponse);
  }

  async remove(id: string): Promise<ProjectResponseDto> {
    const record = await this.projectsRepository.remove(id);

    if (!record) throw new NotFoundException('Project not found.');

    return ProjectMapper.toResponse(record);
  }
}
