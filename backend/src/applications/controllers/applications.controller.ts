import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Param,
  Body,
  UseGuards,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApplicationsService } from '../services/applications.service';
import { ApplicationResponseDto } from '../dto/application-response.dto';
import { CreateApplicationDto } from '../dto/create-application.dto';
import { UpdateApplicationStatusDto } from '../dto/update-application-status.dto';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';

@Controller({ path: 'applications', version: '1' })
export class ApplicationsController {
  constructor(private readonly applicationsService: ApplicationsService) {}

  @UseGuards(JwtAuthGuard)
  @Post('apply')
  async applyToJob(@Body() dto: CreateApplicationDto): Promise<ApplicationResponseDto> {
    return this.applicationsService.applyToJob(dto);
  }

  @UseGuards(JwtAuthGuard)
  @Get('career-profile/:careerProfileId')
  async getApplications(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<ApplicationResponseDto[]> {
    return this.applicationsService.getApplications(careerProfileId);
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getApplication(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ApplicationResponseDto> {
    return this.applicationsService.getApplication(id);
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id/status')
  async updateApplicationStatus(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateApplicationStatusDto,
  ): Promise<ApplicationResponseDto> {
    return this.applicationsService.updateApplicationStatus(id, dto);
  }

  @UseGuards(JwtAuthGuard)
  @Post(':id/withdraw')
  async withdrawApplication(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<ApplicationResponseDto> {
    return this.applicationsService.withdrawApplication(id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  async deleteApplication(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<void> {
    return this.applicationsService.deleteApplication(id);
  }
}
