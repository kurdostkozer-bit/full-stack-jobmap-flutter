-- Rebuild projects table with new fields

DROP TABLE IF EXISTS "projects";

CREATE TABLE "projects" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "career_profile_id" uuid NOT NULL,
  "title" varchar(200) NOT NULL,
  "description" text,
  "role" varchar(150),
  "company" varchar(200),
  "technologies" jsonb DEFAULT '[]',
  "github_url" text,
  "live_url" text,
  "image_url" text,
  "start_date" timestamp with time zone,
  "end_date" timestamp with time zone,
  "is_current" boolean NOT NULL DEFAULT false,
  "display_order" integer NOT NULL DEFAULT 0,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "projects_career_profile_id_idx" ON "projects" ("career_profile_id");
CREATE INDEX "projects_display_order_idx" ON "projects" ("display_order");
CREATE INDEX "projects_is_current_idx" ON "projects" ("is_current");
