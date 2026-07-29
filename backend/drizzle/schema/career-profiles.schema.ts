import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const careerProfiles = pgTable(
  'career_profiles',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    userId: uuid('user_id').notNull().unique(),

    headline: text('headline'),

    summary: text('summary'),

    professionTitle: text('profession_title'),

    location: text('location'),

    preferredJobTitles: text('preferred_job_titles'),

    preferredIndustries: text('preferred_industries'),

    salaryMin: integer('salary_min'),

    salaryMax: integer('salary_max'),

    currency: text('currency').notNull().default('USD'),

    workPreference: text('work_preference').notNull().default('any'),

    remotePreference: text('remote_preference').notNull().default('hybrid'),

    relocationPreference: text('relocation_preference')
      .notNull()
      .default('open'),

    profileStatus: text('profile_status').notNull().default('draft'),

    privacyLevel: text('privacy_level').notNull().default('private'),

    profileCompletion: integer('profile_completion').notNull().default(0),

    resumeUrl: text('resume_url'),

    isPublic: boolean('is_public').notNull().default(false),

    isDeleted: boolean('is_deleted').notNull().default(false),

    deletedAt: timestamp('deleted_at', {
      withTimezone: true,
    }),

    createdAt: timestamp('created_at', {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', {
      withTimezone: true,
    })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    userIdIdx: index('career_profiles_user_id_idx').on(table.userId),
    statusIdx: index('career_profiles_status_idx').on(table.profileStatus),
    privacyIdx: index('career_profiles_privacy_idx').on(table.privacyLevel),
  }),
);

