CREATE TABLE "projects" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "name" text NOT NULL,
  "description" text,
  "technologies" text,
  "github_url" text,
  "live_url" text,
  "start_date" timestamp with time zone,
  "end_date" timestamp with time zone,
  "is_current" boolean NOT NULL DEFAULT false,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "projects_career_profile_id_idx" ON "projects" ("career_profile_id");
