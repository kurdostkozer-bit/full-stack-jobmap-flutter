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

import { CreateProjectDto } from '../dto/create-project.dto';
import { ProjectQueryDto } from '../dto/project-query.dto';
import { ProjectResponseDto } from '../dto/project-response.dto';
import { UpdateProjectDto } from '../dto/update-project.dto';
import { ProjectsService } from '../services/projects.service';

@Controller({ path: 'projects', version: '1' })
export class ProjectsController {
  constructor(private readonly projectsService: ProjectsService) {}

  @Get()
  findAll(@Query() query: ProjectQueryDto): Promise<ProjectResponseDto[]> {
    return this.projectsService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<ProjectResponseDto[]> {
    return this.projectsService.findByCareerProfileId(careerProfileId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ProjectResponseDto> {
    const record = await this.projectsService.findById(id);

    if (!record) throw new NotFoundException('Project not found.');

    return record;
  }

  @Post()
  create(@Body() dto: CreateProjectDto): Promise<ProjectResponseDto> {
    return this.projectsService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateProjectDto,
  ): Promise<ProjectResponseDto> {
    return this.projectsService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', ParseUUIDPipe) id: string): Promise<ProjectResponseDto> {
    return this.projectsService.remove(id);
  }
}
