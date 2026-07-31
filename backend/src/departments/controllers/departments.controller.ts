import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  Query,
  ParseUUIDPipe,
  UseGuards,
  Req,
} from '@nestjs/common';
import { Request } from 'express';
import { DepartmentsService } from '../services/departments.service';
import { DepartmentResponseDto } from '../dto/department-response.dto';
import { CreateDepartmentDto } from '../dto/create-department.dto';
import { UpdateDepartmentDto } from '../dto/update-department.dto';
import { DepartmentQueryDto } from '../dto/department-query.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'departments', version: '1' })
export class DepartmentsController {
  constructor(private readonly departmentsService: DepartmentsService) {}

  @UseGuards(JwtAuthGuard)
  @Post()
  async create(
    @Req() req: AuthenticatedRequest,
    @Body() dto: CreateDepartmentDto,
  ): Promise<DepartmentResponseDto> {
    return this.departmentsService.create(dto, req.user.id);
  }

  @Get()
  async findAll(@Query() query: DepartmentQueryDto): Promise<DepartmentResponseDto[]> {
    return this.departmentsService.findAll(query);
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<DepartmentResponseDto[]> {
    return this.departmentsService.findByCompanyId(companyId);
  }

  @Get(':id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<DepartmentResponseDto> {
    return this.departmentsService.findById(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateDepartmentDto,
  ): Promise<DepartmentResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.departmentsService.update(id, dto, userId);
  }

  @Delete(':id')
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<DepartmentResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.departmentsService.delete(id, userId);
  }
}
