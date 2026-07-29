import { Injectable, NotFoundException } from '@nestjs/common';

import { ProfileMapper } from '../entities/profile.mapper';
import { ProfileResponseDto } from '../dto/profile-response.dto';
import { UpdateProfileDto } from '../dto/update-profile.dto';
import { ProfilesRepository } from '../repositories/profiles.repository';

@Injectable()
export class ProfilesService {
  constructor(private readonly profilesRepository: ProfilesRepository) {}

  async create(userId: string): Promise<ProfileResponseDto> {
    const profile = await this.profilesRepository.create(userId);

    return ProfileMapper.toResponse(profile);
  }

  async update(
    userId: string,
    dto: UpdateProfileDto,
  ): Promise<ProfileResponseDto> {
    const profile = await this.profilesRepository.update(userId, dto);

    if (!profile) {
      throw new NotFoundException('Profile not found.');
    }

    return ProfileMapper.toResponse(profile);
  }

  async findAll(): Promise<ProfileResponseDto[]> {
    const profiles = await this.profilesRepository.findAll();

    return profiles.map((profile) => ProfileMapper.toResponse(profile));
  }

  async findById(id: string): Promise<ProfileResponseDto | null> {
    const profile = await this.profilesRepository.findById(id);

    if (!profile) {
      return null;
    }

    return ProfileMapper.toResponse(profile);
  }

  async findByUserId(userId: string): Promise<ProfileResponseDto | null> {
    const profile = await this.profilesRepository.findByUserId(userId);

    if (!profile) {
      return null;
    }

    return ProfileMapper.toResponse(profile);
  }
}
