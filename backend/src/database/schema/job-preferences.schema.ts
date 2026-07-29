import {
  boolean,
  index,
  integer,
  jsonb,
  pgEnum,
  pgTable,
  text,
  timestamp,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

export const workEnvironmentEnum = pgEnum('work_environment', [
  'ON_SITE',
  'REMOTE',
  'HYBRID',
]);

export const employmentTypeEnum = pgEnum('employment_type', [
  'FULL_TIME',
  'PART_TIME',
  'CONTRACT',
  'INTERNSHIP',
  'FREELANCE',
  'TEMPORARY',
]);

export const currencyEnum = pgEnum('currency', [
  'USD',
  'EUR',
  'GBP',
  'AED',
  'SAR',
  'KWD',
  'QAR',
  'OMR',
  'BHD',
  'JOD',
  'EGP',
  'IQD',
  'LBP',
]);

export const jobPreferences = pgTable(
  'job_preferences',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull().unique(),

    desiredJobTitles: jsonb('desired_job_titles').$type<string[]>().default([]),

    preferredJobCategories: jsonb('preferred_job_categories').$type<string[]>().default([]),

    workEnvironments: jsonb('work_environments')
      .$type<('ON_SITE' | 'REMOTE' | 'HYBRID')[]>()
      .default([]),

    employmentTypes: jsonb('employment_types')
      .$type<('FULL_TIME' | 'PART_TIME' | 'CONTRACT' | 'INTERNSHIP' | 'FREELANCE' | 'TEMPORARY')[]>()
      .default([]),

    minimumSalary: integer('minimum_salary'),

    maximumSalary: integer('maximum_salary'),

    currency: currencyEnum('currency').default('USD'),

    preferredCities: jsonb('preferred_cities').$type<string[]>().default([]),

    preferredCountries: jsonb('preferred_countries').$type<string[]>().default([]),

    openToRelocation: boolean('open_to_relocation').notNull().default(false),

    availableImmediately: boolean('available_immediately').notNull().default(false),

    noticePeriodDays: integer('notice_period_days').default(0),

    willingToTravel: boolean('willing_to_travel').notNull().default(false),

    openToInternationalJobs: boolean('open_to_international_jobs').notNull().default(false),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('job_preferences_career_profile_id_idx').on(
      table.careerProfileId,
    ),
  }),
);
