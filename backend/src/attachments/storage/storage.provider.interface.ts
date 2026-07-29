export interface StorageProvider {
  upload(
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
  }>;

  delete(storagePath: string): Promise<void>;

  getUrl(storagePath: string): string;
}
