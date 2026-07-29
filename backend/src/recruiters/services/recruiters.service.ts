import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { RecruitersRepository } from '../repositories/recruiters.repository';
import { RecruiterResponseDto } from '../dto/recruiter-response.dto';
import { CreateRecruiterDto } from '../dto/create-recruiter.dto';
import { UpdateRecruiterDto } from '../dto/update-recruiter.dto';
import { RecruiterQueryDto } from '../dto/recruiter-query.dto';
import { RecruiterMapper } from '../mappers/recruiter.mapper';

@Injectable()
export class RecruitersService {
  constructor(private readonly recruitersRepository: RecruitersRepository) {}

  async create(
    dto: CreateRecruiterDto,
    userId: string,
  ): Promise<RecruiterResponseDto> {
    // Check if recruiter already exists
    const existing = await this.recruitersRepository.findByCompanyAndUser(
      dto.companyId,
      dto.userId,
    );
    if (existing) {
      throw new ConflictException('Recruiter already exists for this company');
    }

    const recruiter = await this.recruitersRepository.create(dto, userId);
    return RecruiterMapper.toResponse(recruiter);
  }

  async findById(id: string): Promise<RecruiterResponseDto> {
    const recruiter = await this.recruitersRepository.findById(id);
    if (!recruiter) {
      throw new NotFoundException('Recruiter not found');
    }
    return RecruiterMapper.toResponse(recruiter);
  }

  async findByCompanyId(companyId: string): Promise<RecruiterResponseDto[]> {
    const recruiters = await this.recruitersRepository.findByCompanyId(companyId);
    return recruiters.map((r) => RecruiterMapper.toResponse(r));
  }

  async findByUserId(userId: string): Promise<RecruiterResponseDto[]> {
    const recruiters = await this.recruitersRepository.findByUserId(userId);
    return recruiters.map((r) => RecruiterMapper.toResponse(r));
  }

  async findAll(query?: RecruiterQueryDto): Promise<RecruiterResponseDto[]> {
    const recruiters = await this.recruitersRepository.findAll(query);
    return recruiters.map((r) => RecruiterMapper.toResponse(r));
  }

  async update(
    id: string,
    dto: UpdateRecruiterDto,
    userId: string,
  ): Promise<RecruiterResponseDto> {
    const recruiter = await this.recruitersRepository.update(id, dto, userId);
    if (!recruiter) {
      throw new NotFoundException('Recruiter not found');
    }
    return RecruiterMapper.toResponse(recruiter);
  }

  async delete(id: string, userId: string): Promise<RecruiterResponseDto> {
    const recruiter = await this.recruitersRepository.softDelete(id, userId);
    if (!recruiter) {
      throw new NotFoundException('Recruiter not found');
    }
    return RecruiterMapper.toResponse(recruiter);
  }
}
