import {
  boolean,
  index,
  integer,
  pgEnum,
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

export const attachmentTypeEnum = pgEnum('attachment_type', [
  'RESUME',
  'COVER_LETTER',
  'CERTIFICATE',
  'PORTFOLIO',
  'OTHER',
]);

export const storageProviderEnum = pgEnum('storage_provider', [
  'LOCAL',
  'S3',
  'R2',
  'AZURE',
  'GCS',
]);

export const attachments = pgTable(
  'attachments',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    type: attachmentTypeEnum('type').notNull(),

    originalFileName: varchar('original_file_name', { length: 255 }).notNull(),

    storedFileName: varchar('stored_file_name', { length: 255 }).notNull(),

    mimeType: varchar('mime_type', { length: 100 }).notNull(),

    fileSize: integer('file_size').notNull(),

    storageProvider: storageProviderEnum('storage_provider').notNull().default('LOCAL'),

    storagePath: text('storage_path').notNull(),

    fileUrl: text('file_url').notNull(),

    isDefault: boolean('is_default').notNull().default(false),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('attachments_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    typeIdx: index('attachments_type_idx').on(table.type),
    storageProviderIdx: index('attachments_storage_provider_idx').on(
      table.storageProvider,
    ),
    isDefaultIdx: index('attachments_is_default_idx').on(table.isDefault),
  }),
);
