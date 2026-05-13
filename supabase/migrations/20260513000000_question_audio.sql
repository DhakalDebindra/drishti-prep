-- Tutor-voice audio support for questions.
--
-- Adds three columns to `questions` to track cached Nepali TTS audio:
--   * audio_version  — bumped whenever any text field changes; appears in
--                      Storage paths so old assets are invalidated by URL change
--   * audio_ready    — true only when all 6 segment files exist for the
--                      current version
--   * audio_voice    — which Gemini voice was used (Kore / Orus / Sulafat).
--                      Assigned at first generation via deterministic hash of
--                      question.id; persists across regenerations so the same
--                      question always sounds like the same tutor.
--
-- Storage layout: q/{question_id}/v{audio_version}/{segment}.wav
--   segments: stem, opt_a, opt_b, opt_c, opt_d, explanation
--
-- The `question-audio` bucket is public-read; only admins can write. Practice
-- pages can play audio via direct public URLs without minting signed URLs.

-- ─── questions: audio tracking columns ───────────────────────────────────────
ALTER TABLE public.questions
  ADD COLUMN IF NOT EXISTS audio_version INTEGER NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS audio_ready   BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS audio_voice   TEXT NULL
    CHECK (audio_voice IS NULL OR audio_voice IN ('Kore','Orus','Sulafat'));

-- Trigger: invalidate audio when any spoken text changes.
-- We bump audio_version (forcing new Storage paths) and clear audio_ready.
-- audio_voice is intentionally preserved so the question keeps the same
-- tutor voice across content edits.
CREATE OR REPLACE FUNCTION public.bump_question_audio_version()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF (NEW.content, NEW.option_a, NEW.option_b, NEW.option_c, NEW.option_d, NEW.explanation)
     IS DISTINCT FROM
     (OLD.content, OLD.option_a, OLD.option_b, OLD.option_c, OLD.option_d, OLD.explanation)
  THEN
    NEW.audio_version := OLD.audio_version + 1;
    NEW.audio_ready   := false;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_bump_question_audio_version ON public.questions;
CREATE TRIGGER trg_bump_question_audio_version
  BEFORE UPDATE ON public.questions
  FOR EACH ROW EXECUTE FUNCTION public.bump_question_audio_version();

CREATE INDEX IF NOT EXISTS idx_questions_audio_ready ON public.questions (audio_ready)
  WHERE audio_ready = false;

-- ─── audio_generation_log: cost + audit trail ────────────────────────────────
CREATE TABLE IF NOT EXISTS public.audio_generation_log (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id     UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  audio_version   INTEGER NOT NULL,
  segment         TEXT NOT NULL
                    CHECK (segment IN ('stem','opt_a','opt_b','opt_c','opt_d','explanation')),
  voice           TEXT NOT NULL,
  model           TEXT NOT NULL,
  bytes           INTEGER CHECK (bytes >= 0),
  duration_ms     INTEGER CHECK (duration_ms >= 0),
  latency_ms      INTEGER CHECK (latency_ms >= 0),
  cost_micro_usd  INTEGER CHECK (cost_micro_usd >= 0),
  requested_by    UUID REFERENCES public.profiles(id),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_audio_log_question
  ON public.audio_generation_log (question_id, audio_version);
CREATE INDEX IF NOT EXISTS idx_audio_log_created
  ON public.audio_generation_log (created_at DESC);

ALTER TABLE public.audio_generation_log ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Admins read audio generation log" ON public.audio_generation_log;
CREATE POLICY "Admins read audio generation log" ON public.audio_generation_log
  FOR SELECT TO authenticated
  USING (public.is_admin());

DROP POLICY IF EXISTS "Admins insert audio generation log" ON public.audio_generation_log;
CREATE POLICY "Admins insert audio generation log" ON public.audio_generation_log
  FOR INSERT TO authenticated
  WITH CHECK (public.is_admin());

-- ─── profiles: user preference ───────────────────────────────────────────────
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS tutor_voice_enabled BOOLEAN NOT NULL DEFAULT false;

-- ─── Storage bucket: question-audio (public-read) ────────────────────────────
INSERT INTO storage.buckets (id, name, public)
VALUES ('question-audio', 'question-audio', true)
ON CONFLICT (id) DO NOTHING;

-- Public can read audio segments (audio URLs are embedded in <audio> tags).
DROP POLICY IF EXISTS "Public read question audio" ON storage.objects;
CREATE POLICY "Public read question audio" ON storage.objects
  FOR SELECT TO public
  USING (bucket_id = 'question-audio');

-- Only admins can upload, replace, or delete audio segments.
DROP POLICY IF EXISTS "Admins upload question audio" ON storage.objects;
CREATE POLICY "Admins upload question audio" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'question-audio' AND public.is_admin());

DROP POLICY IF EXISTS "Admins update question audio" ON storage.objects;
CREATE POLICY "Admins update question audio" ON storage.objects
  FOR UPDATE TO authenticated
  USING (bucket_id = 'question-audio' AND public.is_admin());

DROP POLICY IF EXISTS "Admins delete question audio" ON storage.objects;
CREATE POLICY "Admins delete question audio" ON storage.objects
  FOR DELETE TO authenticated
  USING (bucket_id = 'question-audio' AND public.is_admin());
