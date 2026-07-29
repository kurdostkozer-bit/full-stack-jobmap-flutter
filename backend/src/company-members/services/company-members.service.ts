import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { CompanyMembersRepository } from '../repositories/company-members.repository';
import { CompanyMemberResponseDto } from '../dto/company-member-response.dto';
import { CreateCompanyMemberDto } from '../dto/create-company-member.dto';
import { UpdateCompanyMemberDto } from '../dto/update-company-member.dto';
import { CompanyMemberQueryDto } from '../dto/company-member-query.dto';
import { CompanyMemberMapper } from '../mappers/company-member.mapper';

@Injectable()
export class CompanyMembersService {
  constructor(private readonly companyMembersRepository: CompanyMembersRepository) {}

  async create(
    dto: CreateCompanyMemberDto,
    userId: string,
  ): Promise<CompanyMemberResponseDto> {
    // Check if member already exists
    const existing = await this.companyMembersRepository.findByCompanyAndUser(
      dto.companyId,
      dto.userId,
    );
    if (existing) {
      throw new ConflictException('User is already a member of this company');
    }

    const member = await this.companyMembersRepository.create(dto, userId);
    return CompanyMemberMapper.toResponse(member);
  }

  async findById(id: string): Promise<CompanyMemberResponseDto> {
    const member = await this.companyMembersRepository.findById(id);
    if (!member) {
      throw new NotFoundException('Company member not found');
    }
    return CompanyMemberMapper.toResponse(member);
  }

  async findByCompanyId(companyId: string): Promise<CompanyMemberResponseDto[]> {
    const members = await this.companyMembersRepository.findByCompanyId(companyId);
    return members.map((m) => CompanyMemberMapper.toResponse(m));
  }

  async findByUserId(userId: string): Promise<CompanyMemberResponseDto[]> {
    const members = await this.companyMembersRepository.findByUserId(userId);
    return members.map((m) => CompanyMemberMapper.toResponse(m));
  }

  async findAll(query?: CompanyMemberQueryDto): Promise<CompanyMemberResponseDto[]> {
    const members = await this.companyMembersRepository.findAll(query);
    return members.map((m) => CompanyMemberMapper.toResponse(m));
  }

  async update(
    id: string,
    dto: UpdateCompanyMemberDto,
    userId: string,
  ): Promise<CompanyMemberResponseDto> {
    const member = await this.companyMembersRepository.update(id, dto, userId);
    if (!member) {
      throw new NotFoundException('Company member not found');
    }
    return CompanyMemberMapper.toResponse(member);
  }

  async delete(id: string, userId: string): Promise<CompanyMemberResponseDto> {
    const member = await this.companyMembersRepository.softDelete(id, userId);
    if (!member) {
      throw new NotFoundException('Company member not found');
    }
    return CompanyMemberMapper.toResponse(member);
  }

  async findByCompanyAndUser(
    companyId: string,
    userId: string,
  ): Promise<CompanyMemberResponseDto | null> {
    const member = await this.companyMembersRepository.findByCompanyAndUser(
      companyId,
      userId,
    );
    return member ? CompanyMemberMapper.toResponse(member) : null;
  }
}
