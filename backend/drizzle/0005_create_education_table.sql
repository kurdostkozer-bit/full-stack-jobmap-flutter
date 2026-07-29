CREATE TABLE "education" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "institution" text NOT NULL,
  "college" text,
  "degree" text NOT NULL,
  "field_of_study" text NOT NULL,
  "grade" text,
  "grade_type" text,
  "country" text,
  "city" text,
  "description" text,
  "start_date" timestamp with time zone NOT NULL,
  "end_date" timestamp with time zone,
  "is_current" boolean NOT NULL DEFAULT false,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "education_career_profile_id_idx" ON "education" ("career_profile_id");
CREATE INDEX "education_is_current_idx" ON "education" ("is_current");
