import { pgTable, uuid, text, timestamp, foreignKey, unique, index, varchar } from 'drizzle-orm/pg-core';
import { careerProfiles } from './career-profiles.schema';
import { jobs } from './jobs.schema';

export const applications = pgTable(
  'applications',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id')
      .notNull()
      .references(() => careerProfiles.id, { onDelete: 'cascade' }),

    jobId: uuid('job_id')
      .notNull()
      .references(() => jobs.id, { onDelete: 'cascade' }),

    status: varchar('status', {
      length: 20,
      enum: ['APPLIED', 'UNDER_REVIEW', 'SHORTLISTED', 'REJECTED', 'WITHDRAWN'],
    })
      .default('APPLIED')
      .notNull(),

    appliedAt: timestamp('applied_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    statusUpdatedAt: timestamp('status_updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    notes: text('notes'),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    uniqueApplication: unique('unique_application').on(table.careerProfileId, table.jobId),
    careerProfileIdx: index('applications_career_profile_idx').on(table.careerProfileId),
    jobIdx: index('applications_job_idx').on(table.jobId),
    statusIdx: index('applications_status_idx').on(table.status),
  }),
);
