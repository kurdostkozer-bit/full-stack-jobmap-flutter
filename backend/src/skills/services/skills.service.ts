import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateSkillDto } from '../dto/create-skill.dto';
import { SkillQueryDto } from '../dto/skill-query.dto';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { UpdateSkillDto } from '../dto/update-skill.dto';
import { SkillMapper } from '../mappers/skill.mapper';
import { SkillsRepository } from '../repositories/skills.repository';

@Injectable()
export class SkillsService {
  constructor(private readonly skillsRepository: SkillsRepository) {}

  async create(dto: CreateSkillDto): Promise<SkillResponseDto> {
    const skill = await this.skillsRepository.create(dto);

    return SkillMapper.toResponse(skill);
  }

  async update(id: string, dto: UpdateSkillDto): Promise<SkillResponseDto> {
    const skill = await this.skillsRepository.update(id, dto);

    if (!skill) {
      throw new NotFoundException('Skill not found.');
    }

    return SkillMapper.toResponse(skill);
  }

  async findAll(query?: SkillQueryDto): Promise<SkillResponseDto[]> {
    const skills = await this.skillsRepository.findAll(query);

    return skills.map((skill) => SkillMapper.toResponse(skill));
  }

  async findById(id: string): Promise<SkillResponseDto | null> {
    const skill = await this.skillsRepository.findById(id);

    if (!skill) {
      return null;
    }

    return SkillMapper.toResponse(skill);
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<SkillResponseDto[]> {
    const skills =
      await this.skillsRepository.findByCareerProfileId(careerProfileId);

    return skills.map((skill) => SkillMapper.toResponse(skill));
  }

  async remove(id: string): Promise<SkillResponseDto> {
    const skill = await this.skillsRepository.remove(id);

    if (!skill) {
      throw new NotFoundException('Skill not found.');
    }

    return SkillMapper.toResponse(skill);
  }
}
