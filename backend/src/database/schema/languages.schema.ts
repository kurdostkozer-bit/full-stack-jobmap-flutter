import {
  boolean,
  index,
  pgEnum,
  pgTable,
  timestamp,
  uuid,
  varchar,
} from 'drizzle-orm/pg-core';

export const languageProficiencyLevelEnum = pgEnum(
  'language_proficiency_level',
  ['NATIVE', 'FLUENT', 'ADVANCED', 'INTERMEDIATE', 'BASIC'],
);

export const languageSkillLevelEnum = pgEnum('language_skill_level', [
  'EXCELLENT',
  'GOOD',
  'FAIR',
  'POOR',
]);

export const languages = pgTable(
  'languages',
  {
    id: uuid('id').defaultRandom().primaryKey(),

    careerProfileId: uuid('career_profile_id').notNull(),

    language: varchar('language', { length: 100 }).notNull(),

    proficiencyLevel:
      languageProficiencyLevelEnum('proficiency_level').notNull(),

    readingLevel: languageSkillLevelEnum('reading_level').notNull(),

    writingLevel: languageSkillLevelEnum('writing_level').notNull(),

    speakingLevel: languageSkillLevelEnum('speaking_level').notNull(),

    isPrimary: boolean('is_primary').notNull().default(false),

    createdAt: timestamp('created_at', { withTimezone: true })
      .defaultNow()
      .notNull(),

    updatedAt: timestamp('updated_at', { withTimezone: true })
      .defaultNow()
      .notNull(),
  },
  (table) => ({
    careerProfileIdIdx: index('languages_career_profile_id_idx').on(
      table.careerProfileId,
    ),
    proficiencyLevelIdx: index('languages_proficiency_level_idx').on(
      table.proficiencyLevel,
    ),
  }),
);
