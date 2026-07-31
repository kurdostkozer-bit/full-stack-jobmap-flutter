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
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { Request } from 'express';
import { RecruitersService } from '../services/recruiters.service';
import { RecruiterResponseDto } from '../dto/recruiter-response.dto';
import { CreateRecruiterDto } from '../dto/create-recruiter.dto';
import { UpdateRecruiterDto } from '../dto/update-recruiter.dto';
import { RecruiterQueryDto } from '../dto/recruiter-query.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
  };
}

@Controller({ path: 'recruiters', version: '1' })
export class RecruitersController {
  constructor(private readonly recruitersService: RecruitersService) {}

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

  @UseGuards(JwtAuthGuard)
  @Post()
  async create(
    @Req() req: AuthenticatedRequest,
    @Body() dto: CreateRecruiterDto,
  ): Promise<RecruiterResponseDto> {
    return this.recruitersService.create(dto, req.user.id);
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  async update(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateRecruiterDto,
  ): Promise<RecruiterResponseDto> {
    // Get recruiter and check ownership
    const recruiter = await this.recruitersService.findById(id);
    if (!recruiter) {
      throw new NotFoundException('Recruiter not found');
    }
    
    // Only creator (createdBy) can update
    if (recruiter.createdBy !== req.user.id) {
      throw new ForbiddenException('Not authorized to update this recruiter');
    }
    
    return this.recruitersService.update(id, dto, req.user.id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  async delete(
    @Req() req: AuthenticatedRequest,
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<RecruiterResponseDto> {
    // Get recruiter and check ownership
    const recruiter = await this.recruitersService.findById(id);
    if (!recruiter) {
      throw new NotFoundException('Recruiter not found');
    }
    
    // Only creator (createdBy) can delete
    if (recruiter.createdBy !== req.user.id) {
      throw new ForbiddenException('Not authorized to delete this recruiter');
    }
    
    return this.recruitersService.delete(id, req.user.id);
  }
}
