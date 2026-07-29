import {
  boolean,
  index,
  pgTable,
  text,
  timestamp,
  uuid,
} from 'drizzle-orm/pg-core';

export const education = pgTable(
  'education',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    institution: text('institution').notNull(),

    college: text('college'),

    degree: text('degree').notNull(),

    fieldOfStudy: text('field_of_study').notNull(),

    grade: text('grade'),

    gradeType: text('grade_type'),

    country: text('country'),

    city: text('city'),

    description: text('description'),

    startDate: timestamp('start_date', { withTimezone: true }).notNull(),

    endDate: timestamp('end_date', { withTimezone: true }),

    isCurrent: boolean('is_current').notNull().default(false),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('education_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    isCurrentIdx: index('education_is_current_idx').on(table.isCurrent),
  }),
);
