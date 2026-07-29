import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateLanguageDto } from '../dto/create-language.dto';
import { LanguageQueryDto } from '../dto/language-query.dto';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { UpdateLanguageDto } from '../dto/update-language.dto';
import { LanguageMapper } from '../mappers/language.mapper';
import { LanguagesRepository } from '../repositories/languages.repository';

@Injectable()
export class LanguagesService {
  constructor(private readonly languagesRepository: LanguagesRepository) {}

  async create(dto: CreateLanguageDto): Promise<LanguageResponseDto> {
    const record = await this.languagesRepository.create(dto);
    return LanguageMapper.toResponse(record);
  }

  async update(
    id: string,
    dto: UpdateLanguageDto,
  ): Promise<LanguageResponseDto> {
    const record = await this.languagesRepository.update(id, dto);

    if (!record) throw new NotFoundException('Language not found.');

    return LanguageMapper.toResponse(record);
  }

  async findAll(query?: LanguageQueryDto): Promise<LanguageResponseDto[]> {
    const records = await this.languagesRepository.findAll(query);
    return records.map(LanguageMapper.toResponse);
  }

  async findById(id: string): Promise<LanguageResponseDto | null> {
    const record = await this.languagesRepository.findById(id);
    return record ? LanguageMapper.toResponse(record) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<LanguageResponseDto[]> {
    const records =
      await this.languagesRepository.findByCareerProfileId(careerProfileId);
    return records.map(LanguageMapper.toResponse);
  }

  async remove(id: string): Promise<LanguageResponseDto> {
    const record = await this.languagesRepository.remove(id);

    if (!record) throw new NotFoundException('Language not found.');

    return LanguageMapper.toResponse(record);
  }
}
