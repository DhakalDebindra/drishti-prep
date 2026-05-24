-- Shruti Dictation: content library + per-user session resume points.
--
-- `dictation_content` stores curated and user-imported source material in the
-- canonical DictationDocument shape produced by apps/web/src/features/shruti.
-- Chunking + normalization happen once at ingest; the `chunked_json` column is
-- the runtime source of truth. Version hashes in `preprocessing` let us
-- invalidate stale rows when normalization or chunking logic changes.
--
-- `dictation_sessions` stores per-user resume state at the logical sentence
-- index — never character offsets, since preprocessing changes text lengths.

CREATE TABLE IF NOT EXISTS public.dictation_content (
  id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id                  UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title                     TEXT NOT NULL,
  language                  TEXT NOT NULL CHECK (language IN ('en','ne','mixed')),
  source_type               TEXT NOT NULL CHECK (source_type IN ('paste','pdf','image','library')),
  category                  TEXT NULL,
  difficulty                TEXT NULL CHECK (difficulty IS NULL OR difficulty IN ('easy','medium','hard')),
  raw_text                  TEXT NOT NULL,
  normalized_text           TEXT NOT NULL,
  gemini_cleaned_text       TEXT NULL,
  tts_ready_text            TEXT NOT NULL,
  chunked_json              JSONB NOT NULL,
  preprocessing             JSONB NOT NULL,
  estimated_duration_sec    INTEGER NOT NULL DEFAULT 0,
  average_ocr_confidence    NUMERIC(4,3) NULL,
  is_public                 BOOLEAN NOT NULL DEFAULT false,
  created_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at                TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS dictation_content_owner_idx
  ON public.dictation_content(owner_id);
CREATE INDEX IF NOT EXISTS dictation_content_public_idx
  ON public.dictation_content(is_public) WHERE is_public = true;

CREATE TABLE IF NOT EXISTS public.dictation_sessions (
  id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                   UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  document_id               UUID NOT NULL REFERENCES public.dictation_content(id) ON DELETE CASCADE,
  global_sentence_index     INTEGER NOT NULL DEFAULT 0 CHECK (global_sentence_index >= 0),
  pace_preset               TEXT NOT NULL DEFAULT 'medium'
    CHECK (pace_preset IN ('slow','medium','fast','sprint','custom')),
  custom_wpm                INTEGER NULL CHECK (custom_wpm IS NULL OR (custom_wpm BETWEEN 40 AND 300)),
  started_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at                TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at              TIMESTAMPTZ NULL,
  UNIQUE (user_id, document_id)
);

CREATE INDEX IF NOT EXISTS dictation_sessions_user_idx
  ON public.dictation_sessions(user_id, updated_at DESC);

-- Auto-updated `updated_at` for both tables.
CREATE OR REPLACE FUNCTION public.touch_dictation_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_dictation_content_touch ON public.dictation_content;
CREATE TRIGGER trg_dictation_content_touch
  BEFORE UPDATE ON public.dictation_content
  FOR EACH ROW EXECUTE FUNCTION public.touch_dictation_updated_at();

DROP TRIGGER IF EXISTS trg_dictation_sessions_touch ON public.dictation_sessions;
CREATE TRIGGER trg_dictation_sessions_touch
  BEFORE UPDATE ON public.dictation_sessions
  FOR EACH ROW EXECUTE FUNCTION public.touch_dictation_updated_at();

-- ─── RLS ─────────────────────────────────────────────────────────────────────
ALTER TABLE public.dictation_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dictation_sessions ENABLE ROW LEVEL SECURITY;

-- Library content: public rows are readable by anyone authenticated; private
-- rows readable by owner only.
DROP POLICY IF EXISTS dictation_content_read ON public.dictation_content;
CREATE POLICY dictation_content_read ON public.dictation_content
  FOR SELECT TO authenticated
  USING (is_public = true OR owner_id = auth.uid());

DROP POLICY IF EXISTS dictation_content_insert ON public.dictation_content;
CREATE POLICY dictation_content_insert ON public.dictation_content
  FOR INSERT TO authenticated
  WITH CHECK (owner_id = auth.uid() AND is_public = false);

DROP POLICY IF EXISTS dictation_content_update ON public.dictation_content;
CREATE POLICY dictation_content_update ON public.dictation_content
  FOR UPDATE TO authenticated
  USING (owner_id = auth.uid())
  WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS dictation_content_delete ON public.dictation_content;
CREATE POLICY dictation_content_delete ON public.dictation_content
  FOR DELETE TO authenticated
  USING (owner_id = auth.uid());

-- Sessions: strictly per-user.
DROP POLICY IF EXISTS dictation_sessions_rw ON public.dictation_sessions;
CREATE POLICY dictation_sessions_rw ON public.dictation_sessions
  FOR ALL TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());
