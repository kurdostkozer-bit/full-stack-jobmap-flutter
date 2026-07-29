CREATE TABLE "career_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"headline" text,
	"summary" text,
	"profession_title" text,
	"location" text,
	"preferred_job_titles" text,
	"preferred_industries" text,
	"salary_min" integer,
	"salary_max" integer,
	"currency" text DEFAULT 'USD' NOT NULL,
	"work_preference" text DEFAULT 'any' NOT NULL,
	"remote_preference" text DEFAULT 'hybrid' NOT NULL,
	"relocation_preference" text DEFAULT 'open' NOT NULL,
	"profile_status" text DEFAULT 'draft' NOT NULL,
	"privacy_level" text DEFAULT 'private' NOT NULL,
	"profile_completion" integer DEFAULT 0 NOT NULL,
	"resume_url" text,
	"is_public" boolean DEFAULT false NOT NULL,
	"is_deleted" boolean DEFAULT false NOT NULL,
	"deleted_at" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "career_profiles_user_id_unique" UNIQUE("user_id")
);

CREATE INDEX "career_profiles_user_id_idx" ON "career_profiles" ("user_id");
CREATE INDEX "career_profiles_status_idx" ON "career_profiles" ("profile_status");
CREATE INDEX "career_profiles_privacy_idx" ON "career_profiles" ("privacy_level");

ALTER TABLE "skills"
ADD CONSTRAINT "skills_career_profile_id_career_profiles_id_fk"
FOREIGN KEY ("career_profile_id") REFERENCES "career_profiles"("id") ON DELETE CASCADE;
