import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const jobs = pgTable(
  'jobs',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    companyId: uuid('company_id').notNull(),

    title: text('title').notNull(),

    slug: text('slug').notNull().unique(),

    description: text('description').notNull(),

    requirements: text('requirements'),

    responsibilities: text('responsibilities'),

    employmentType: text('employment_type').notNull(),

    workMode: text('work_mode').notNull().default('onsite'),

    experienceLevel: text('experience_level').notNull(),

    country: text('country'),

    city: text('city'),

    salaryMin: integer('salary_min'),

    salaryMax: integer('salary_max'),

    currency: text('currency').notNull().default('USD'),

    status: text('status').notNull().default('draft'),

    expiresAt: timestamp('expires_at', { withTimezone: true }),

    isActive: boolean('is_active').notNull().default(true),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    companyIdIdx: index('jobs_company_id_idx').on(table.companyId),
    slugIdx: index('jobs_slug_idx').on(table.slug),
    statusIdx: index('jobs_status_idx').on(table.status),
    employmentTypeIdx: index('jobs_employment_type_idx').on(
      table.employmentType,
    ),
    isActiveIdx: index('jobs_is_active_idx').on(table.isActive),
  }),
);
