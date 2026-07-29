import { Injectable } from '@nestjs/common';
import { and, asc, desc, eq, SQL } from 'drizzle-orm';

import { db } from '../../database/database';
import { attachments } from '../../database/schema';
import { CreateAttachmentDto } from '../dto/create-attachment.dto';
import { AttachmentQueryDto } from '../dto/attachment-query.dto';
import { UpdateAttachmentDto } from '../dto/update-attachment.dto';
import { AttachmentEntity } from '../entities/attachment.entity';

@Injectable()
export class AttachmentsRepository {
  async create(dto: CreateAttachmentDto): Promise<AttachmentEntity> {
    const [record] = await db
      .insert(attachments)
      .values({
        careerProfileId: dto.careerProfileId,
        type: dto.type as
          | 'RESUME'
          | 'COVER_LETTER'
          | 'CERTIFICATE'
          | 'PORTFOLIO'
          | 'OTHER',
        originalFileName: dto.originalFileName,
        storedFileName: dto.storedFileName,
        mimeType: dto.mimeType,
        fileSize: dto.fileSize,
        storageProvider: (dto.storageProvider ?? 'LOCAL') as
          | 'LOCAL'
          | 'S3'
          | 'R2'
          | 'AZURE'
          | 'GCS',
        storagePath: dto.storagePath,
        fileUrl: dto.fileUrl,
        isDefault: dto.isDefault ?? false,
      })
      .returning();

    return record as unknown as AttachmentEntity;
  }

  async update(
    id: string,
    dto: UpdateAttachmentDto,
  ): Promise<AttachmentEntity | null> {
    const updateData: Record<string, unknown> = { updatedAt: new Date() };

    if (dto.fileUrl !== undefined) updateData.fileUrl = dto.fileUrl;
    if (dto.isDefault !== undefined) updateData.isDefault = dto.isDefault;

    const [record] = await db
      .update(attachments)
      .set(updateData)
      .where(eq(attachments.id, id))
      .returning();

    return record ? (record as unknown as AttachmentEntity) : null;
  }

  async findAll(query?: AttachmentQueryDto): Promise<AttachmentEntity[]> {
    const filters: SQL[] = [];

    if (query?.careerProfileId) {
      filters.push(eq(attachments.careerProfileId, query.careerProfileId));
    }

    if (query?.type) {
      filters.push(
        eq(
          attachments.type,
          query.type as
            | 'RESUME'
            | 'COVER_LETTER'
            | 'CERTIFICATE'
            | 'PORTFOLIO'
            | 'OTHER',
        ),
      );
    }

    if (query?.isDefault !== undefined) {
      filters.push(eq(attachments.isDefault, query.isDefault));
    }

    const sortColumn = this.resolveSortColumn(query?.sortBy);
    const orderFn = query?.sortOrder === 'desc' ? desc : asc;

    const page = query?.page ?? 1;
    const limit = query?.limit ?? 20;
    const offset = (page - 1) * limit;

    const baseQuery = db.select().from(attachments);
    const filtered = filters.length > 0 ? baseQuery.where(and(...filters)) : baseQuery;

    const rows = await filtered
      .orderBy(orderFn(sortColumn))
      .limit(limit)
      .offset(offset);

    return rows as unknown as AttachmentEntity[];
  }

  async findById(id: string): Promise<AttachmentEntity | null> {
    const [record] = await db
      .select()
      .from(attachments)
      .where(eq(attachments.id, id));

    return record ? (record as unknown as AttachmentEntity) : null;
  }

  async findByCareerProfileId(careerProfileId: string): Promise<AttachmentEntity[]> {
    const rows = await db
      .select()
      .from(attachments)
      .where(eq(attachments.careerProfileId, careerProfileId))
      .orderBy(desc(attachments.createdAt));

    return rows as unknown as AttachmentEntity[];
  }

  async findByCareerProfileIdAndType(
    careerProfileId: string,
    type: 'RESUME' | 'COVER_LETTER' | 'CERTIFICATE' | 'PORTFOLIO' | 'OTHER',
  ): Promise<AttachmentEntity[]> {
    const rows = await db
      .select()
      .from(attachments)
      .where(
        and(
          eq(attachments.careerProfileId, careerProfileId),
          eq(attachments.type, type),
        ),
      )
      .orderBy(desc(attachments.isDefault), desc(attachments.createdAt));

    return rows as unknown as AttachmentEntity[];
  }

  async findDefaultByCareerProfileId(
    careerProfileId: string,
  ): Promise<AttachmentEntity | null> {
    const [record] = await db
      .select()
      .from(attachments)
      .where(
        and(
          eq(attachments.careerProfileId, careerProfileId),
          eq(attachments.isDefault, true),
        ),
      );

    return record ? (record as unknown as AttachmentEntity) : null;
  }

  async setDefault(
    id: string,
    careerProfileId: string,
  ): Promise<AttachmentEntity | null> {
    // Unset default for all attachments of this profile
    await db
      .update(attachments)
      .set({ isDefault: false, updatedAt: new Date() })
      .where(eq(attachments.careerProfileId, careerProfileId));

    // Set new default
    const [record] = await db
      .update(attachments)
      .set({ isDefault: true, updatedAt: new Date() })
      .where(eq(attachments.id, id))
      .returning();

    return record ? (record as unknown as AttachmentEntity) : null;
  }

  async remove(id: string): Promise<AttachmentEntity | null> {
    const [record] = await db
      .delete(attachments)
      .where(eq(attachments.id, id))
      .returning();

    return record ? (record as unknown as AttachmentEntity) : null;
  }

  private resolveSortColumn(sortBy?: string) {
    switch (sortBy) {
      case 'type':
        return attachments.type;
      case 'fileSize':
        return attachments.fileSize;
      case 'updatedAt':
        return attachments.updatedAt;
      default:
        return attachments.createdAt;
    }
  }
}
