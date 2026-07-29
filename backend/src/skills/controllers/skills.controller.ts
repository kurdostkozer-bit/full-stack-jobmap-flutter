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

import { CreateSkillDto } from '../dto/create-skill.dto';
import { SkillQueryDto } from '../dto/skill-query.dto';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { UpdateSkillDto } from '../dto/update-skill.dto';
import { SkillsService } from '../services/skills.service';

@Controller({
  path: 'skills',
  version: '1',
})
export class SkillsController {
  constructor(private readonly skillsService: SkillsService) {}

  @Get()
  async findAll(@Query() query: SkillQueryDto): Promise<SkillResponseDto[]> {
    return this.skillsService.findAll(query);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkillResponseDto> {
    const skill = await this.skillsService.findById(id);

    if (!skill) {
      throw new NotFoundException('Skill not found');
    }

    return skill;
  }

  @Get('career-profile/:careerProfileId')
  async findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<SkillResponseDto[]> {
    return this.skillsService.findByCareerProfileId(careerProfileId);
  }

  @Post()
  async create(@Body() dto: CreateSkillDto): Promise<SkillResponseDto> {
    return this.skillsService.create(dto);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateSkillDto,
  ): Promise<SkillResponseDto> {
    return this.skillsService.update(id, dto);
  }

  @Delete(':id')
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SkillResponseDto> {
    return this.skillsService.remove(id);
  }
}
