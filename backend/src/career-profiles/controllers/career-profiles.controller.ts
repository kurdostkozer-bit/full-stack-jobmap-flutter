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
  Req,
  UseGuards,
} from '@nestjs/common';
import { Request } from 'express';

import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { CreateCareerProfileDto } from '../dto/create-career-profile.dto';
import { CareerProfileQueryDto } from '../dto/career-profile-query.dto';
import { CareerProfileResponseDto } from '../dto/career-profile-response.dto';
import { UpdateCareerProfileDto } from '../dto/update-career-profile.dto';
import { CareerProfilesService } from '../services/career-profiles.service';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({
  path: 'career-profiles',
  version: '1',
})
export class CareerProfilesController {
  constructor(private readonly careerProfilesService: CareerProfilesService) {}

  @Get()
  async findAll(
    @Query() query: CareerProfileQueryDto,
  ): Promise<CareerProfileResponseDto[]> {
    return this.careerProfilesService.findAll(query);
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  async findMe(
    @Req() req: AuthenticatedRequest,
  ): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesService.findByUserId(req.user.id);

    if (!profile) {
      throw new NotFoundException('Career profile not found');
    }

    return profile;
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesService.findById(id);

    if (!profile) {
      throw new NotFoundException('Career profile not found');
    }

    return profile;
  }

  @UseGuards(JwtAuthGuard)
  @Post('me')
  async createMe(
    @Req() req: AuthenticatedRequest,
    @Body() dto: CreateCareerProfileDto,
  ): Promise<CareerProfileResponseDto> {
    return this.careerProfilesService.create(req.user.id, dto);
  }

  @UseGuards(JwtAuthGuard)
  @Patch('me')
  async updateMe(
    @Req() req: AuthenticatedRequest,
    @Body() dto: UpdateCareerProfileDto,
  ): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesService.findByUserId(req.user.id);

    if (!profile) {
      throw new NotFoundException('Career profile not found');
    }

    return this.careerProfilesService.update(profile.id, dto);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('me')
  async removeMe(
    @Req() req: AuthenticatedRequest,
  ): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesService.findByUserId(req.user.id);

    if (!profile) {
      throw new NotFoundException('Career profile not found');
    }

    return this.careerProfilesService.remove(profile.id);
  }
}
