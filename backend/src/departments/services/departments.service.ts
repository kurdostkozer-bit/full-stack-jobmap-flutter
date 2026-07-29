import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { DepartmentsRepository } from '../repositories/departments.repository';
import { DepartmentResponseDto } from '../dto/department-response.dto';
import { CreateDepartmentDto } from '../dto/create-department.dto';
import { UpdateDepartmentDto } from '../dto/update-department.dto';
import { DepartmentQueryDto } from '../dto/department-query.dto';
import { DepartmentMapper } from '../mappers/department.mapper';

@Injectable()
export class DepartmentsService {
  constructor(private readonly departmentsRepository: DepartmentsRepository) {}

  async create(
    dto: CreateDepartmentDto,
    userId: string,
  ): Promise<DepartmentResponseDto> {
    const department = await this.departmentsRepository.create(dto, userId);
    return DepartmentMapper.toResponse(department);
  }

  async findById(id: string): Promise<DepartmentResponseDto> {
    const department = await this.departmentsRepository.findById(id);
    if (!department) {
      throw new NotFoundException('Department not found');
    }
    return DepartmentMapper.toResponse(department);
  }

  async findByCompanyId(companyId: string): Promise<DepartmentResponseDto[]> {
    const departments = await this.departmentsRepository.findByCompanyId(companyId);
    return departments.map((d) => DepartmentMapper.toResponse(d));
  }

  async findAll(query?: DepartmentQueryDto): Promise<DepartmentResponseDto[]> {
    const departments = await this.departmentsRepository.findAll(query);
    return departments.map((d) => DepartmentMapper.toResponse(d));
  }

  async update(
    id: string,
    dto: UpdateDepartmentDto,
    userId: string,
  ): Promise<DepartmentResponseDto> {
    const department = await this.departmentsRepository.update(id, dto, userId);
    if (!department) {
      throw new NotFoundException('Department not found');
    }
    return DepartmentMapper.toResponse(department);
  }

  async delete(id: string, userId: string): Promise<DepartmentResponseDto> {
    const department = await this.departmentsRepository.softDelete(id, userId);
    if (!department) {
      throw new NotFoundException('Department not found');
    }
    return DepartmentMapper.toResponse(department);
  }
}
