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
} from '@nestjs/common';
import { CompaniesService } from '../services/companies.service';
import { CompanyResponseDto } from '../dto/company-response.dto';
import { CreateCompanyDto } from '../dto/create-company.dto';
import { UpdateCompanyDto } from '../dto/update-company.dto';
import { CompanyQueryDto } from '../dto/company-query.dto';

@Controller({ path: 'companies', version: '1' })
export class CompaniesController {
  constructor(private readonly companiesService: CompaniesService) {}

  @Post()
  async create(
    @Body() dto: CreateCompanyDto,
  ): Promise<CompanyResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companiesService.create(dto, userId);
  }

  @Get()
  async findAll(@Query() query: CompanyQueryDto): Promise<CompanyResponseDto[]> {
    return this.companiesService.findAll(query);
  }

  @Get('by-slug/:slug')
  async findBySlug(@Param('slug') slug: string): Promise<CompanyResponseDto> {
    return this.companiesService.findBySlug(slug);
  }

  @Get(':id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyResponseDto> {
    return this.companiesService.findById(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCompanyDto,
  ): Promise<CompanyResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companiesService.update(id, dto, userId);
  }

  @Delete(':id')
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companiesService.delete(id, userId);
  }
}
