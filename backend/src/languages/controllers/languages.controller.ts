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

import { CreateLanguageDto } from '../dto/create-language.dto';
import { LanguageQueryDto } from '../dto/language-query.dto';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { UpdateLanguageDto } from '../dto/update-language.dto';
import { LanguagesService } from '../services/languages.service';

@Controller({ path: 'languages', version: '1' })
export class LanguagesController {
  constructor(private readonly languagesService: LanguagesService) {}

  @Get()
  findAll(@Query() query: LanguageQueryDto): Promise<LanguageResponseDto[]> {
    return this.languagesService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<LanguageResponseDto[]> {
    return this.languagesService.findByCareerProfileId(careerProfileId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<LanguageResponseDto> {
    const record = await this.languagesService.findById(id);

    if (!record) throw new NotFoundException('Language not found.');

    return record;
  }

  @Post()
  create(@Body() dto: CreateLanguageDto): Promise<LanguageResponseDto> {
    return this.languagesService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateLanguageDto,
  ): Promise<LanguageResponseDto> {
    return this.languagesService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id', ParseUUIDPipe) id: string): Promise<LanguageResponseDto> {
    return this.languagesService.remove(id);
  }
}
