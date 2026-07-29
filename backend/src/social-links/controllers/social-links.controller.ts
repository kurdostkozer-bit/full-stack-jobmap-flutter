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

import { CreateSocialLinkDto } from '../dto/create-social-link.dto';
import { SocialLinkQueryDto } from '../dto/social-link-query.dto';
import { SocialLinkResponseDto } from '../dto/social-link-response.dto';
import { UpdateSocialLinkDto } from '../dto/update-social-link.dto';
import { SocialLinksService } from '../services/social-links.service';

@Controller({ path: 'social-links', version: '1' })
export class SocialLinksController {
  constructor(private readonly socialLinksService: SocialLinksService) {}

  @Get()
  findAll(
    @Query() query: SocialLinkQueryDto,
  ): Promise<SocialLinkResponseDto[]> {
    return this.socialLinksService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<SocialLinkResponseDto[]> {
    return this.socialLinksService.findByCareerProfileId(careerProfileId);
  }

  @Get('career-profile/:careerProfileId/platform/:platform')
  async findByCareerProfileIdAndPlatform(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('platform') platform: string,
  ): Promise<SocialLinkResponseDto> {
    const record =
      await this.socialLinksService.findByCareerProfileIdAndPlatform(
        careerProfileId,
        platform,
      );

    if (!record) throw new NotFoundException('Social link not found.');

    return record;
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SocialLinkResponseDto> {
    const record = await this.socialLinksService.findById(id);

    if (!record) throw new NotFoundException('Social link not found.');

    return record;
  }

  @Post()
  create(@Body() dto: CreateSocialLinkDto): Promise<SocialLinkResponseDto> {
    return this.socialLinksService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateSocialLinkDto,
  ): Promise<SocialLinkResponseDto> {
    return this.socialLinksService.update(id, dto);
  }

  @Delete(':id')
  remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<SocialLinkResponseDto> {
    return this.socialLinksService.remove(id);
  }
}
