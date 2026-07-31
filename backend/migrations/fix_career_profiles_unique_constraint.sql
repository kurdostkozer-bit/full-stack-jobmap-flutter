-- Fix Career Profiles UNIQUE constraint to allow soft deletes
-- Problem: UNIQUE on userId prevents creating new profiles after soft delete
-- Solution: Drop old constraint, create partial unique index

-- Drop old UNIQUE constraint (if it exists)
-- Try multiple constraint names that might be used
ALTER TABLE career_profiles DROP CONSTRAINT IF EXISTS "career_profiles_user_id_unique";
ALTER TABLE career_profiles DROP CONSTRAINT IF EXISTS career_profiles_user_id_unique;
ALTER TABLE career_profiles DROP CONSTRAINT IF EXISTS career_profiles_user_id_key;

-- Create partial unique index (only on active profiles)
-- This allows multiple profiles for the same user IF they are all deleted
CREATE UNIQUE INDEX IF NOT EXISTS career_profiles_unique_active_user_idx 
  ON career_profiles(user_id) 
  WHERE is_deleted = false;

