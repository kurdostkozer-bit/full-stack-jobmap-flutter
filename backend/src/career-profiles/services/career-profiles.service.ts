import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';

import { CreateCareerProfileDto } from '../dto/create-career-profile.dto';
import { CareerProfileQueryDto } from '../dto/career-profile-query.dto';
import { CareerProfileResponseDto } from '../dto/career-profile-response.dto';
import { UpdateCareerProfileDto } from '../dto/update-career-profile.dto';
import { CareerProfileMapper } from '../mappers/career-profile.mapper';
import { CareerProfilesRepository } from '../repositories/career-profiles.repository';
import { ReferralsService } from '../../referrals/services/referrals.service';

@Injectable()
export class CareerProfilesService {
  constructor(
    private readonly careerProfilesRepository: CareerProfilesRepository,
    private readonly referralsService: ReferralsService,
  ) {}

  async create(
    userId: string,
    dto: CreateCareerProfileDto,
  ): Promise<CareerProfileResponseDto> {
    // Check if profile already exists
    const existingProfile = await this.careerProfilesRepository.findByUserId(userId);
    if (existingProfile) {
      throw new ConflictException('Career profile already exists for this user');
    }

    try {
      const profile = await this.careerProfilesRepository.create(userId, dto);

      // Trigger referral completion if user was referred
      await this.referralsService.completeReferralOnProfileCreation(userId);

      return CareerProfileMapper.toResponse(profile);
    } catch (error: any) {
      console.error('CareerProfilesService.create() error caught:', {
        code: error.code,
        message: error.message,
        name: error.name,
        detail: error.detail,
      });

      // Fallback: Handle unique constraint violation if somehow missed above
      const errorMessage = (error.message || '').toLowerCase();
      const isDuplicate =
        error.code === '23505' ||
        errorMessage.includes('unique') ||
        errorMessage.includes('duplicate');

      if (isDuplicate) {
        throw new ConflictException('Career profile already exists for this user');
      }

      throw error;
    }
  }

  async update(
    id: string,
    dto: UpdateCareerProfileDto,
  ): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesRepository.update(id, dto);

    if (!profile) {
      throw new NotFoundException('Career profile not found.');
    }

    return CareerProfileMapper.toResponse(profile);
  }

  async findAll(
    query?: CareerProfileQueryDto,
  ): Promise<CareerProfileResponseDto[]> {
    const profiles = await this.careerProfilesRepository.findAll(query);

    // Filter out private profiles (unless explicitly queried with privacyLevel)
    // Default behavior: show only public profiles
    if (!query?.privacyLevel) {
      return profiles
        .filter(p => p.privacyLevel !== 'private')
        .map(profile => CareerProfileMapper.toResponse(profile));
    }

    return profiles.map((profile) => CareerProfileMapper.toResponse(profile));
  }

  async findById(id: string): Promise<CareerProfileResponseDto | null> {
    const profile = await this.careerProfilesRepository.findById(id);

    if (!profile) {
      return null;
    }

    return CareerProfileMapper.toResponse(profile);
  }

  async findByUserId(userId: string): Promise<CareerProfileResponseDto | null> {
    const profile = await this.careerProfilesRepository.findByUserId(userId);

    if (!profile) {
      return null;
    }

    return CareerProfileMapper.toResponse(profile);
  }

  async remove(id: string): Promise<CareerProfileResponseDto> {
    const profile = await this.careerProfilesRepository.remove(id);

    if (!profile) {
      throw new NotFoundException('Career profile not found.');
    }

    return CareerProfileMapper.toResponse(profile);
  }
}
