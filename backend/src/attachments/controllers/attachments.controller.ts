import {
  BadRequestException,
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
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';

import { AttachmentQueryDto } from '../dto/attachment-query.dto';
import { AttachmentResponseDto } from '../dto/attachment-response.dto';
import { UpdateAttachmentDto } from '../dto/update-attachment.dto';
import { UploadAttachmentDto } from '../dto/upload-attachment.dto';
import { AttachmentsService } from '../services/attachments.service';
import { LocalStorageProvider } from '../storage/local.storage.provider';

@Controller({ path: 'attachments', version: '1' })
export class AttachmentsController {
  constructor(
    private readonly attachmentsService: AttachmentsService,
    private readonly storageProvider: LocalStorageProvider,
  ) {}

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async upload(
    @UploadedFile() file: { originalname: string; mimetype: string; size: number; buffer: Buffer } | undefined,
    @Body() dto: UploadAttachmentDto,
  ): Promise<AttachmentResponseDto> {
    if (!file) {
      throw new BadRequestException('No file provided');
    }

    const maxSizeInBytes = 50 * 1024 * 1024; // 50MB
    if (file.size > maxSizeInBytes) {
      throw new BadRequestException('File size exceeds 50MB limit');
    }

    try {
      const { storedFileName, storagePath, fileUrl } = await this.storageProvider.upload(
        file,
        dto.careerProfileId,
      );

      const createAttachmentDto = {
        careerProfileId: dto.careerProfileId,
        type: dto.type,
        originalFileName: file.originalname,
        storedFileName,
        mimeType: file.mimetype,
        fileSize: file.size,
        storageProvider: 'LOCAL' as const,
        storagePath,
        fileUrl,
        isDefault: dto.isDefault ?? false,
      };

      return this.attachmentsService.create(createAttachmentDto);
    } catch (error) {
      throw new BadRequestException(`Upload failed: ${(error as Error).message}`);
    }
  }

  @Get()
  findAll(
    @Query() query: AttachmentQueryDto,
  ): Promise<AttachmentResponseDto[]> {
    return this.attachmentsService.findAll(query);
  }

  @Get('career-profile/:careerProfileId')
  findByCareerProfileId(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<AttachmentResponseDto[]> {
    return this.attachmentsService.findByCareerProfileId(careerProfileId);
  }

  @Get('career-profile/:careerProfileId/type/:type')
  findByCareerProfileIdAndType(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
    @Param('type') type: string,
  ): Promise<AttachmentResponseDto[]> {
    const validTypes = ['RESUME', 'COVER_LETTER', 'CERTIFICATE', 'PORTFOLIO', 'OTHER'];
    if (!validTypes.includes(type)) {
      throw new BadRequestException('Invalid attachment type');
    }

    return this.attachmentsService.findByCareerProfileIdAndType(
      careerProfileId,
      type as 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER',
    );
  }

  @Get('career-profile/:careerProfileId/default')
  async findDefault(
    @Param('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsService.findDefaultByCareerProfileId(
      careerProfileId,
    );

    if (!record) throw new NotFoundException('No default attachment found.');

    return record;
  }

  @Get(':id')
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<AttachmentResponseDto> {
    const record = await this.attachmentsService.findById(id);

    if (!record) throw new NotFoundException('Attachment not found.');

    return record;
  }

  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateAttachmentDto,
  ): Promise<AttachmentResponseDto> {
    return this.attachmentsService.update(id, dto);
  }

  @Patch(':id/default')
  setDefault(
    @Param('id', ParseUUIDPipe) id: string,
    @Query('careerProfileId', ParseUUIDPipe) careerProfileId: string,
  ): Promise<AttachmentResponseDto> {
    return this.attachmentsService.setDefault(id, careerProfileId);
  }

  @Delete(':id')
  remove(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<AttachmentResponseDto> {
    return this.attachmentsService.remove(id);
  }
}
