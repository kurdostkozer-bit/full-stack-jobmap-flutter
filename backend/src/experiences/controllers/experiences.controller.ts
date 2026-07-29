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

import { CreateExperienceDto } from '../dto/create-experience.dto';
import { ExperienceQueryDto } from '../dto/experience-query.dto';
import { ExperienceResponseDto } from '../dto/experience-response.dto';
import { UpdateExperienceDto } from '../dto/update-experience.dto';
import { ExperiencesService } from '../services/experiences.service';

@Controller({
  path: 'experiences',
  version: '1',
})
export class ExperiencesController {
  constructor(private readonly experiencesService: ExperiencesService) {}

  @Get()
  async findAll(
    @Query() query: ExperienceQueryDto,
  ): Promise<ExperienceResponseDto[]> {
    return this.experiencesService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  async findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<ExperienceResponseDto[]> {
    return this.experiencesService.findByCareerProfileId(careerProfileId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ExperienceResponseDto> {
    const experience = await this.experiencesService.findById(id);

    if (!experience) {
      throw new NotFoundException('Experience not found.');
    }

    return experience;
  }

  @Post()
  async create(
    @Body() dto: CreateExperienceDto,
  ): Promise<ExperienceResponseDto> {
    return this.experiencesService.create(dto);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateExperienceDto,
  ): Promise<ExperienceResponseDto> {
    return this.experiencesService.update(id, dto);
  }

  @Delete(':id')
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ExperienceResponseDto> {
    return this.experiencesService.remove(id);
  }
}
