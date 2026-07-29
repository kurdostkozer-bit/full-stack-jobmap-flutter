-- Drop old table and recreate with proper enums

DROP TABLE IF EXISTS "languages";

CREATE TYPE "language_proficiency_level" AS ENUM (
  'NATIVE',
  'FLUENT',
  'ADVANCED',
  'INTERMEDIATE',
  'BASIC'
);

CREATE TYPE "language_skill_level" AS ENUM (
  'EXCELLENT',
  'GOOD',
  'FAIR',
  'POOR'
);

CREATE TABLE "languages" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "language" varchar(100) NOT NULL,
  "proficiency_level" "language_proficiency_level" NOT NULL,
  "reading_level" "language_skill_level" NOT NULL,
  "writing_level" "language_skill_level" NOT NULL,
  "speaking_level" "language_skill_level" NOT NULL,
  "is_primary" boolean NOT NULL DEFAULT false,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "languages_career_profile_id_idx" ON "languages" ("career_profile_id");
CREATE INDEX "languages_proficiency_level_idx" ON "languages" ("proficiency_level");
