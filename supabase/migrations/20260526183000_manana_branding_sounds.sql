-- Reusable branded sound cues for Manana episode stitching.
-- These are generated once (currently via ElevenLabs sound generation),
-- persisted in storage + Postgres, and reused across all future episodes.

CREATE TABLE IF NOT EXISTS public.manana_branding_sounds (
  key               TEXT PRIMARY KEY,
  provider          TEXT NOT NULL DEFAULT 'elevenlabs',
  model             TEXT NOT NULL,
  prompt            TEXT NOT NULL,
  storage_path      TEXT NOT NULL,
  duration_ms       INTEGER NOT NULL CHECK (duration_ms >= 0),
  bytes             INTEGER NOT NULL CHECK (bytes >= 0),
  prompt_hash       TEXT NOT NULL,
  generation_params JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS manana_branding_sounds_prompt_hash_idx
  ON public.manana_branding_sounds(prompt_hash);

DROP TRIGGER IF EXISTS trg_manana_branding_sounds_touch ON public.manana_branding_sounds;
CREATE TRIGGER trg_manana_branding_sounds_touch
  BEFORE UPDATE ON public.manana_branding_sounds
  FOR EACH ROW EXECUTE FUNCTION public.touch_manana_updated_at();

ALTER TABLE public.manana_branding_sounds ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS manana_branding_sounds_read ON public.manana_branding_sounds;
CREATE POLICY manana_branding_sounds_read ON public.manana_branding_sounds
  FOR SELECT TO authenticated
  USING (true);

DROP POLICY IF EXISTS manana_branding_sounds_admin_write ON public.manana_branding_sounds;
CREATE POLICY manana_branding_sounds_admin_write ON public.manana_branding_sounds
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());
