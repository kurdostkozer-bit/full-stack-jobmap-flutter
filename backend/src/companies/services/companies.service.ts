import { Injectable, NotFoundException, ConflictException, ForbiddenException } from '@nestjs/common';
import { CompaniesRepository } from '../repositories/companies.repository';
import { CompanyResponseDto } from '../dto/company-response.dto';
import { CreateCompanyDto } from '../dto/create-company.dto';
import { UpdateCompanyDto } from '../dto/update-company.dto';
import { CompanyQueryDto } from '../dto/company-query.dto';
import { CompanyMapper } from '../mappers/company.mapper';

@Injectable()
export class CompaniesService {
  constructor(private readonly companiesRepository: CompaniesRepository) {}

  async create(dto: CreateCompanyDto, userId: string): Promise<CompanyResponseDto> {
    // Check if slug already exists
    const existing = await this.companiesRepository.findBySlug(dto.slug);
    if (existing) {
      throw new ConflictException('Company slug already exists');
    }

    const company = await this.companiesRepository.create(dto, userId);
    return CompanyMapper.toResponse(company);
  }

  async findById(id: string): Promise<CompanyResponseDto> {
    const company = await this.companiesRepository.findById(id);
    if (!company) {
      throw new NotFoundException('Company not found');
    }
    return CompanyMapper.toResponse(company);
  }

  async findBySlug(slug: string): Promise<CompanyResponseDto> {
    const company = await this.companiesRepository.findBySlug(slug);
    if (!company) {
      throw new NotFoundException('Company not found');
    }
    return CompanyMapper.toResponse(company);
  }

  async findAll(query?: CompanyQueryDto): Promise<CompanyResponseDto[]> {
    const companies = await this.companiesRepository.findAll(query);
    return companies.map((c) => CompanyMapper.toResponse(c));
  }

  async update(id: string, dto: UpdateCompanyDto, userId: string): Promise<CompanyResponseDto> {
    // First, fetch the company to check ownership
    const company = await this.companiesRepository.findById(id);
    if (!company) {
      throw new NotFoundException('Company not found');
    }
    
    // Check ownership
    if (company.createdBy !== userId) {
      throw new ForbiddenException('You do not have permission to update this company');
    }
    
    const updated = await this.companiesRepository.update(id, dto, userId);
    if (!updated) {
      throw new NotFoundException('Company not found');
    }
    return CompanyMapper.toResponse(updated);
  }

  async delete(id: string, userId: string): Promise<CompanyResponseDto> {
    // First, fetch the company to check ownership
    const company = await this.companiesRepository.findById(id);
    if (!company) {
      throw new NotFoundException('Company not found');
    }
    
    // Check ownership
    if (company.createdBy !== userId) {
      throw new ForbiddenException('You do not have permission to delete this company');
    }
    
    const deleted = await this.companiesRepository.softDelete(id, userId);
    if (!deleted) {
      throw new NotFoundException('Company not found');
    }
    return CompanyMapper.toResponse(deleted);
  }

  async findByCreator(userId: string): Promise<CompanyResponseDto[]> {
    const companies = await this.companiesRepository.findByCreator(userId);
    return companies.map((c) => CompanyMapper.toResponse(c));
  }
}
