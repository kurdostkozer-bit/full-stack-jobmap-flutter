import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Query,
} from '@nestjs/common';

import { CreateCertificateDto } from '../dto/create-certificate.dto';
import { CertificateQueryDto } from '../dto/certificate-query.dto';
import { CertificateResponseDto } from '../dto/certificate-response.dto';
import { UpdateCertificateDto } from '../dto/update-certificate.dto';
import { CertificatesService } from '../services/certificates.service';

@Controller({ path: 'certificates', version: '1' })
export class CertificatesController {
  constructor(private readonly certificatesService: CertificatesService) {}

  @Get()
  findAll(
    @Query() query: CertificateQueryDto,
  ): Promise<CertificateResponseDto[]> {
    return this.certificatesService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<CertificateResponseDto[]> {
    return this.certificatesService.findByCareerProfileId(careerProfileId);
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CertificateResponseDto> {
    const record = await this.certificatesService.findById(id);

    if (!record) throw new NotFoundException('Certificate not found.');

    return record;
  }

  @Post()
  create(@Body() dto: CreateCertificateDto): Promise<CertificateResponseDto> {
    return this.certificatesService.create(dto);
  }

  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateCertificateDto,
  ): Promise<CertificateResponseDto> {
    return this.certificatesService.update(id, dto);
  }

  @Delete(':id')
  remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<CertificateResponseDto> {
    return this.certificatesService.remove(id);
  }
}
