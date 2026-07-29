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

export const certificateVerificationStatusEnum = pgEnum(
  'certificate_verification_status',
  ['PENDING', 'VERIFIED', 'REJECTED'],
);

export const certificates = pgTable(
  'certificates',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    name: varchar('name', { length: 200 }).notNull(),

    issuer: varchar('issuer', { length: 200 }).notNull(),

    credentialId: varchar('credential_id', { length: 200 }),

    credentialUrl: text('credential_url'),

    issueDate: timestamp('issue_date', { withTimezone: true }).notNull(),

    expiryDate: timestamp('expiry_date', { withTimezone: true }),

    doesNotExpire: boolean('does_not_expire').notNull().default(false),

    verificationStatus: certificateVerificationStatusEnum('verification_status')
      .notNull()
      .default('PENDING'),

    displayOrder: integer('display_order').notNull().default(0),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('certificates_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    verificationStatusIdx: index('certificates_verification_status_idx').on(
      table.verificationStatus,
    ),
    displayOrderIdx: index('certificates_display_order_idx').on(
      table.displayOrder,
    ),
  }),
);
