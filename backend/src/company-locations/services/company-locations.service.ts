import { Injectable, NotFoundException } from '@nestjs/common';
import { CompanyLocationsRepository } from '../repositories/company-locations.repository';
import { CompanyLocationResponseDto } from '../dto/company-location-response.dto';
import { CreateCompanyLocationDto } from '../dto/create-company-location.dto';
import { UpdateCompanyLocationDto } from '../dto/update-company-location.dto';
import { CompanyLocationQueryDto } from '../dto/company-location-query.dto';
import { CompanyLocationMapper } from '../mappers/company-location.mapper';

@Injectable()
export class CompanyLocationsService {
  constructor(private readonly companyLocationsRepository: CompanyLocationsRepository) {}

  async create(
    dto: CreateCompanyLocationDto,
    userId: string,
  ): Promise<CompanyLocationResponseDto> {
    const location = await this.companyLocationsRepository.create(dto, userId);
    return CompanyLocationMapper.toResponse(location);
  }

  async findById(id: string): Promise<CompanyLocationResponseDto> {
    const location = await this.companyLocationsRepository.findById(id);
    if (!location) {
      throw new NotFoundException('Company location not found');
    }
    return CompanyLocationMapper.toResponse(location);
  }

  async findByCompanyId(companyId: string): Promise<CompanyLocationResponseDto[]> {
    const locations = await this.companyLocationsRepository.findByCompanyId(companyId);
    return locations.map((l) => CompanyLocationMapper.toResponse(l));
  }

  async findAll(query?: CompanyLocationQueryDto): Promise<CompanyLocationResponseDto[]> {
    const locations = await this.companyLocationsRepository.findAll(query);
    return locations.map((l) => CompanyLocationMapper.toResponse(l));
  }

  async update(
    id: string,
    dto: UpdateCompanyLocationDto,
    userId: string,
  ): Promise<CompanyLocationResponseDto> {
    const location = await this.companyLocationsRepository.update(id, dto, userId);
    if (!location) {
      throw new NotFoundException('Company location not found');
    }
    return CompanyLocationMapper.toResponse(location);
  }

  async delete(id: string, userId: string): Promise<CompanyLocationResponseDto> {
    const location = await this.companyLocationsRepository.softDelete(id, userId);
    if (!location) {
      throw new NotFoundException('Company location not found');
    }
    return CompanyLocationMapper.toResponse(location);
  }
}
