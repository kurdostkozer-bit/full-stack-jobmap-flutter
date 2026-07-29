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
import { CompanyLocationsService } from '../services/company-locations.service';
import { CompanyLocationResponseDto } from '../dto/company-location-response.dto';
import { CreateCompanyLocationDto } from '../dto/create-company-location.dto';
import { UpdateCompanyLocationDto } from '../dto/update-company-location.dto';
import { CompanyLocationQueryDto } from '../dto/company-location-query.dto';

@Controller({ path: 'company-locations', version: '1' })
export class CompanyLocationsController {
  constructor(private readonly companyLocationsService: CompanyLocationsService) {}

  @Post()
  async create(@Body() dto: CreateCompanyLocationDto): Promise<CompanyLocationResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyLocationsService.create(dto, userId);
  }

  @Get()
  async findAll(
    @Query() query: CompanyLocationQueryDto,
  ): Promise<CompanyLocationResponseDto[]> {
    return this.companyLocationsService.findAll(query);
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<CompanyLocationResponseDto[]> {
    return this.companyLocationsService.findByCompanyId(companyId);
  }

  @Get(':id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyLocationResponseDto> {
    return this.companyLocationsService.findById(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCompanyLocationDto,
  ): Promise<CompanyLocationResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyLocationsService.update(id, dto, userId);
  }

  @Delete(':id')
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyLocationResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyLocationsService.delete(id, userId);
  }
}
