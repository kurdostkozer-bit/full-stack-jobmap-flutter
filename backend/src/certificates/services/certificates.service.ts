import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateCertificateDto } from '../dto/create-certificate.dto';
import { CertificateQueryDto } from '../dto/certificate-query.dto';
import { CertificateResponseDto } from '../dto/certificate-response.dto';
import { UpdateCertificateDto } from '../dto/update-certificate.dto';
import { CertificateMapper } from '../mappers/certificate.mapper';
import { CertificatesRepository } from '../repositories/certificates.repository';

@Injectable()
export class CertificatesService {
  constructor(
    private readonly certificatesRepository: CertificatesRepository,
  ) {}

  async create(dto: CreateCertificateDto): Promise<CertificateResponseDto> {
    const record = await this.certificatesRepository.create(dto);
    return CertificateMapper.toResponse(record);
  }

  async update(
    id: string,
    dto: UpdateCertificateDto,
  ): Promise<CertificateResponseDto> {
    const record = await this.certificatesRepository.update(id, dto);

    if (!record) throw new NotFoundException('Certificate not found.');

    return CertificateMapper.toResponse(record);
  }

  async findAll(
    query?: CertificateQueryDto,
  ): Promise<CertificateResponseDto[]> {
    const records = await this.certificatesRepository.findAll(query);
    return records.map((record) => CertificateMapper.toResponse(record));
  }

  async findById(id: string): Promise<CertificateResponseDto | null> {
    const record = await this.certificatesRepository.findById(id);
    return record ? CertificateMapper.toResponse(record) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<CertificateResponseDto[]> {
    const records =
      await this.certificatesRepository.findByCareerProfileId(careerProfileId);
    return records.map((record) => CertificateMapper.toResponse(record));
  }

  async remove(id: string): Promise<CertificateResponseDto> {
    const record = await this.certificatesRepository.remove(id);

    if (!record) throw new NotFoundException('Certificate not found.');

    return CertificateMapper.toResponse(record);
  }
}
