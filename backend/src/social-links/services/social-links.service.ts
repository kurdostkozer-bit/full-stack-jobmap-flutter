import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateSocialLinkDto } from '../dto/create-social-link.dto';
import { SocialLinkQueryDto } from '../dto/social-link-query.dto';
import { SocialLinkResponseDto } from '../dto/social-link-response.dto';
import { UpdateSocialLinkDto } from '../dto/update-social-link.dto';
import { SocialLinkMapper } from '../mappers/social-link.mapper';
import { SocialLinksRepository } from '../repositories/social-links.repository';

@Injectable()
export class SocialLinksService {
  constructor(private readonly socialLinksRepository: SocialLinksRepository) {}

  async create(dto: CreateSocialLinkDto): Promise<SocialLinkResponseDto> {
    const record = await this.socialLinksRepository.create(dto);
    return SocialLinkMapper.toResponse(record);
  }

  async update(
    id: string,
    dto: UpdateSocialLinkDto,
  ): Promise<SocialLinkResponseDto> {
    const record = await this.socialLinksRepository.update(id, dto);

    if (!record) throw new NotFoundException('Social link not found.');

    return SocialLinkMapper.toResponse(record);
  }

  async findAll(query?: SocialLinkQueryDto): Promise<SocialLinkResponseDto[]> {
    const records = await this.socialLinksRepository.findAll(query);
    return records.map((record) => SocialLinkMapper.toResponse(record));
  }

  async findById(id: string): Promise<SocialLinkResponseDto | null> {
    const record = await this.socialLinksRepository.findById(id);
    return record ? SocialLinkMapper.toResponse(record) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<SocialLinkResponseDto[]> {
    const records =
      await this.socialLinksRepository.findByCareerProfileId(careerProfileId);
    return records.map((record) => SocialLinkMapper.toResponse(record));
  }

  async findByCareerProfileIdAndPlatform(
    careerProfileId: string,
    platform: string,
  ): Promise<SocialLinkResponseDto | null> {
    const record =
      await this.socialLinksRepository.findByCareerProfileIdAndPlatform(
        careerProfileId,
        platform,
      );
    return record ? SocialLinkMapper.toResponse(record) : null;
  }

  async remove(id: string): Promise<SocialLinkResponseDto> {
    const record = await this.socialLinksRepository.remove(id);

    if (!record) throw new NotFoundException('Social link not found.');

    return SocialLinkMapper.toResponse(record);
  }
}
