CREATE TABLE "languages" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "language" text NOT NULL,
  "reading" text NOT NULL,
  "writing" text NOT NULL,
  "speaking" text NOT NULL,
  "is_native" boolean NOT NULL DEFAULT false,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "languages_career_profile_id_idx" ON "languages" ("career_profile_id");
