CREATE TABLE "experiences" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "job_title" text NOT NULL,
  "company_name" text NOT NULL,
  "employment_type" text NOT NULL,
  "location" text,
  "description" text,
  "start_date" timestamp with time zone NOT NULL,
  "end_date" timestamp with time zone,
  "is_current" boolean NOT NULL DEFAULT false,
  "sort_order" integer NOT NULL DEFAULT 0,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "experiences_career_profile_id_idx" ON "experiences" ("career_profile_id");
CREATE INDEX "experiences_is_current_idx" ON "experiences" ("is_current");
