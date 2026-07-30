import { pgTable, uuid, timestamp, foreignKey, unique, index } from 'drizzle-orm/pg-core';
import { careerProfiles } from './career-profiles.schema';
import { jobs } from './jobs.schema';

export const savedJobs = pgTable(
  'saved_jobs',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id')
      .notNull()
      .references(() => careerProfiles.id, { onDelete: 'cascade' }),

    jobId: uuid('job_id')
      .notNull()
      .references(() => jobs.id, { onDelete: 'cascade' }),

    savedAt: timestamp('saved_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    uniqueSavedJob: unique('unique_saved_job').on(table.careerProfileId, table.jobId),
    careerProfileIdx: index('saved_jobs_career_profile_idx').on(table.careerProfileId),
    jobIdx: index('saved_jobs_job_idx').on(table.jobId),
  }),
);
