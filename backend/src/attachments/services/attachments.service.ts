import { Injectable, NotFoundException } from '@nestjs/common';

import { CreateAttachmentDto } from '../dto/create-attachment.dto';
import { AttachmentQueryDto } from '../dto/attachment-query.dto';
import { AttachmentResponseDto } from '../dto/attachment-response.dto';
import { UpdateAttachmentDto } from '../dto/update-attachment.dto';
import { AttachmentMapper } from '../mappers/attachment.mapper';
import { AttachmentsRepository } from '../repositories/attachments.repository';

@Injectable()
export class AttachmentsService {
  constructor(private readonly attachmentsRepository: AttachmentsRepository) {}

  async create(dto: CreateAttachmentDto): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsRepository.create(dto);
    return AttachmentMapper.toResponse(record);
  }

  async update(
    id: string,
    dto: UpdateAttachmentDto,
  ): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsRepository.update(id, dto);

    if (!record) throw new NotFoundException('Attachment not found.');

    return AttachmentMapper.toResponse(record);
  }

  async findAll(query?: AttachmentQueryDto): Promise<AttachmentResponseDto[]> {
    const records = await this.attachmentsRepository.findAll(query);
    return records.map((record) => AttachmentMapper.toResponse(record));
  }

  async findById(id: string): Promise<AttachmentResponseDto | null> {
    const record = await this.attachmentsRepository.findById(id);
    return record ? AttachmentMapper.toResponse(record) : null;
  }

  async findByCareerProfileId(
    careerProfileId: string,
  ): Promise<AttachmentResponseDto[]> {
    const records = await this.attachmentsRepository.findByCareerProfileId(
      careerProfileId,
    );
    return records.map((record) => AttachmentMapper.toResponse(record));
  }

  async findByCareerProfileIdAndType(
    careerProfileId: string,
    type: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER',
  ): Promise<AttachmentResponseDto[]> {
    const records = await this.attachmentsRepository.findByCareerProfileIdAndType(
      careerProfileId,
      type,
    );
    return records.map((record) => AttachmentMapper.toResponse(record));
  }

  async findDefaultByCareerProfileId(
    careerProfileId: string,
  ): Promise<AttachmentResponseDto | null> {
    const record = await this.attachmentsRepository.findDefaultByCareerProfileId(
      careerProfileId,
    );
    return record ? AttachmentMapper.toResponse(record) : null;
  }

  async setDefault(
    id: string,
    careerProfileId: string,
  ): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsRepository.setDefault(id, careerProfileId);

    if (!record) throw new NotFoundException('Attachment not found.');

    return AttachmentMapper.toResponse(record);
  }

  async remove(id: string): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsRepository.remove(id);

    if (!record) throw new NotFoundException('Attachment not found.');

    return AttachmentMapper.toResponse(record);
  }
}
