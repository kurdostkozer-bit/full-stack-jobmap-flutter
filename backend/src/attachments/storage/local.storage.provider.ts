import { Injectable } from '@nestjs/common';
import { promises as fs } from 'fs';
import { join } from 'path';

import { StorageProvider } from './storage.provider.interface';

@Injectable()
export class LocalStorageProvider implements StorageProvider {
  private readonly uploadDir = join(process.cwd(), 'uploads');
  private readonly baseUrl = process.env.UPLOAD_BASE_URL || 'http://localhost:3000/uploads';

  async upload(
    file: {
      originalname: string;
      mimetype: string;
      size: number;
      buffer: Buffer;
    },
    careerProfileId: string,
  ): Promise<{
    storedFileName: string;
    storagePath: string;
    fileUrl: string;
  }> {
    // Create directory structure: uploads/careerProfileId/timestamp-random-originalName
    const careerProfileDir = join(this.uploadDir, careerProfileId);
    const timestamp = Date.now();
    const random = Math.random().toString(36).substring(2, 10);
    const storedFileName = `${timestamp}-${random}-${file.originalname}`;
    const storagePath = join(careerProfileDir, storedFileName);

    try {
      // Create directory if it doesn't exist
      await fs.mkdir(careerProfileDir, { recursive: true });

      // Write file to disk
      await fs.writeFile(storagePath, file.buffer);

      // Generate URL
      const fileUrl = `${this.baseUrl}/${careerProfileId}/${storedFileName}`;

      return {
        storedFileName,
        storagePath,
        fileUrl,
      };
    } catch (error) {
      throw new Error(`Failed to upload file: ${(error as Error).message}`);
    }
  }

  async delete(storagePath: string): Promise<void> {
    try {
      await fs.unlink(storagePath);
    } catch (error) {
      // File might not exist, but don't throw error
      if ((error as NodeJS.ErrnoException).code !== 'ENOENT') {
        throw new Error(`Failed to delete file: ${(error as Error).message}`);
      }
    }
  }

  getUrl(storagePath: string): string {
    const relativePath = storagePath
      .replace(this.uploadDir, '')
      .replace(/\\/g, '/')
      .substring(1);
    return `${this.baseUrl}/${relativePath}`;
  }
}
