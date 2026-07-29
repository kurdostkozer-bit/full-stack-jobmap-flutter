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
import { CompanyMembersService } from '../services/company-members.service';
import { CompanyMemberResponseDto } from '../dto/company-member-response.dto';
import { CreateCompanyMemberDto } from '../dto/create-company-member.dto';
import { UpdateCompanyMemberDto } from '../dto/update-company-member.dto';
import { CompanyMemberQueryDto } from '../dto/company-member-query.dto';

@Controller({ path: 'company-members', version: '1' })
export class CompanyMembersController {
  constructor(private readonly companyMembersService: CompanyMembersService) {}

  @Post()
  async create(
    @Body() dto: CreateCompanyMemberDto,
  ): Promise<CompanyMemberResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyMembersService.create(dto, userId);
  }

  @Get()
  async findAll(
    @Query() query: CompanyMemberQueryDto,
  ): Promise<CompanyMemberResponseDto[]> {
    return this.companyMembersService.findAll(query);
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<CompanyMemberResponseDto[]> {
    return this.companyMembersService.findByCompanyId(companyId);
  }

  @Get('user/:userId')
  async findByUserId(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<CompanyMemberResponseDto[]> {
    return this.companyMembersService.findByUserId(userId);
  }

  @Get(':id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyMemberResponseDto> {
    return this.companyMembersService.findById(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCompanyMemberDto,
  ): Promise<CompanyMemberResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyMembersService.update(id, dto, userId);
  }

  @Delete(':id')
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<CompanyMemberResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.companyMembersService.delete(id, userId);
  }
}
