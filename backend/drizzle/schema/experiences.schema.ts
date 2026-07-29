import {
  boolean,
  index,
  integer,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const experiences = pgTable(
  'experiences',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    jobTitle: text('job_title').notNull(),

    companyName: text('company_name').notNull(),

    employmentType: text('employment_type').notNull(),

    location: text('location'),

    description: text('description'),

    startDate: timestamp('start_date', { withTimezone: true }).notNull(),

    endDate: timestamp('end_date', { withTimezone: true }),

    isCurrent: boolean('is_current').notNull().default(false),

    sortOrder: integer('sort_order').notNull().default(0),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('experiences_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    isCurrentIdx: index('experiences_is_current_idx').on(table.isCurrent),
  }),
);
