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

import { CreateEducationDto } from '../dto/create-education.dto';
import { EducationQueryDto } from '../dto/education-query.dto';
import { EducationResponseDto } from '../dto/education-response.dto';
import { UpdateEducationDto } from '../dto/update-education.dto';
import { EducationService } from '../services/education.service';

@Controller({
  path: 'education',
  version: '1',
})
export class EducationController {
  constructor(private readonly educationService: EducationService) {}

  @Get()
  async findAll(
    @Query() query: EducationQueryDto,
  ): Promise<EducationResponseDto[]> {
    return this.educationService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  async findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<EducationResponseDto[]> {
    return this.educationService.findByCareerProfileId(careerProfileId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<EducationResponseDto> {
    const record = await this.educationService.findById(id);

    if (!record) {
      throw new NotFoundException('Education record not found.');
    }

    return record;
  }

  @Post()
  async create(@Body() dto: CreateEducationDto): Promise<EducationResponseDto> {
    return this.educationService.create(dto);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateEducationDto,
  ): Promise<EducationResponseDto> {
    return this.educationService.update(id, dto);
  }

  @Delete(':id')
  async remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<EducationResponseDto> {
    return this.educationService.remove(id);
  }
}
