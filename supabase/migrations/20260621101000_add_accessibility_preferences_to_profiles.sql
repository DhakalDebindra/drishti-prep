-- Store account-synced accessibility preferences for the practice experience.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS accessibility_preferences JSONB NOT NULL DEFAULT '{}'::jsonb;

COMMENT ON COLUMN public.profiles.accessibility_preferences IS
  'JSON object storing account-synced accessibility preferences.';
