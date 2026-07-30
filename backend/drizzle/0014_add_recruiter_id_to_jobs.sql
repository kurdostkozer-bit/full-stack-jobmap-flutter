-- Add recruiter_id column to jobs table
ALTER TABLE "jobs" ADD COLUMN "recruiter_id" uuid NOT NULL DEFAULT gen_random_uuid();

-- Create index on recruiter_id
CREATE INDEX "jobs_recruiter_id_idx" ON "jobs" ("recruiter_id");

-- Add foreign key constraint
ALTER TABLE "jobs" ADD CONSTRAINT "jobs_recruiter_id_fk" FOREIGN KEY ("recruiter_id") REFERENCES "recruiters"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- Remove the default since it was just for migration
ALTER TABLE "jobs" ALTER COLUMN "recruiter_id" DROP DEFAULT;
