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
import { RecruitersService } from '../services/recruiters.service';
import { RecruiterResponseDto } from '../dto/recruiter-response.dto';
import { CreateRecruiterDto } from '../dto/create-recruiter.dto';
import { UpdateRecruiterDto } from '../dto/update-recruiter.dto';
import { RecruiterQueryDto } from '../dto/recruiter-query.dto';

@Controller({ path: 'recruiters', version: '1' })
export class RecruitersController {
  constructor(private readonly recruitersService: RecruitersService) {}

  @Post()
  async create(@Body() dto: CreateRecruiterDto): Promise<RecruiterResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.recruitersService.create(dto, userId);
  }

  @Get()
  async findAll(@Query() query: RecruiterQueryDto): Promise<RecruiterResponseDto[]> {
    return this.recruitersService.findAll(query);
  }

  @Get('company/:companyId')
  async findByCompanyId(
    @Param('companyId', ParseUUIDPipe) companyId: string,
  ): Promise<RecruiterResponseDto[]> {
    return this.recruitersService.findByCompanyId(companyId);
  }

  @Get('user/:userId')
  async findByUserId(
    @Param('userId', ParseUUIDPipe) userId: string,
  ): Promise<RecruiterResponseDto[]> {
    return this.recruitersService.findByUserId(userId);
  }

  @Get(':id')
  async findById(@Param('id', ParseUUIDPipe) id: string): Promise<RecruiterResponseDto> {
    return this.recruitersService.findById(id);
  }

  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateRecruiterDto,
  ): Promise<RecruiterResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.recruitersService.update(id, dto, userId);
  }

  @Delete(':id')
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<RecruiterResponseDto> {
    // TODO: Get userId from auth context
    const userId = 'placeholder-user-id';
    return this.recruitersService.delete(id, userId);
  }
}
