CREATE TABLE "jobs" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL,
  "title" text NOT NULL,
  "slug" text NOT NULL UNIQUE,
  "description" text NOT NULL,
  "requirements" text,
  "responsibilities" text,
  "employment_type" text NOT NULL,
  "work_mode" text NOT NULL DEFAULT 'onsite',
  "experience_level" text NOT NULL,
  "country" text,
  "city" text,
  "salary_min" integer,
  "salary_max" integer,
  "currency" text NOT NULL DEFAULT 'USD',
  "status" text NOT NULL DEFAULT 'draft',
  "expires_at" timestamp with time zone,
  "is_active" boolean NOT NULL DEFAULT true,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL
);

CREATE INDEX "jobs_company_id_idx" ON "jobs" ("company_id");
CREATE INDEX "jobs_slug_idx" ON "jobs" ("slug");
CREATE INDEX "jobs_status_idx" ON "jobs" ("status");
CREATE INDEX "jobs_employment_type_idx" ON "jobs" ("employment_type");
CREATE INDEX "jobs_is_active_idx" ON "jobs" ("is_active");
