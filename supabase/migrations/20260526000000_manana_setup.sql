-- Manana: weekly memory-review podcast + per-question retention model.
--
-- Manana ("reflection" — the second step in the Shravana → Manana → Nididhyasana
-- learning path) sits alongside Shruti ("that which is heard"). Where Shruti is
-- the live tutor voice, Manana is the user's weekly reflective revision: a
-- 2–3 minute personalized audio episode assembled on a Sunday cron from the
-- user's per-question memory stability, stitched together server-side from
-- three audio caches.
--
-- Two product systems are introduced in this migration:
--
--   A. Per-question retention tracking (user_memory_states)
--      Modified Ebbinghaus model. Each (user, question) row carries a stability
--      factor S that grows on correct retrieval and decays on failure. Memory
--      Heat H = exp(-days_since_review / S). This is consumed not just by
--      Manana but by the live dashboard widget — heat is real-time, not a
--      Sunday snapshot.
--
--   B. Manana episode pipeline (manana_episodes + caches)
--      Cron generates one episode per active user per ISO week. Final episode
--      is a single MP3 (server-side ffmpeg concat) for accurate scrubbing,
--      simple playback, and downloadable "walking mode" use later.
--
-- Provider-agnostic audio caching: every cached audio row carries a `provider`
-- column. Gemini is the only provider for now, but the schema accommodates
-- a future ElevenLabs swap without re-migration — caches won't collide
-- across providers because storage paths and hash keys both include provider.

-- ─── A. user_memory_states ──────────────────────────────────────────────────
-- One row per (user, question) pair the user has interacted with. Created
-- lazily on first attempt. Updated on every subsequent attempt via an
-- application-level hook on attempt submission.
--
--   stability         S, in days. 1.0 = "I'll remember for ~1 day."
--                     On correct: S := S * 2.0 (tunable α)
--                     On wrong:   S := max(0.5, S * 0.3) (tunable β)
--   last_reviewed_at  Drives H = exp(-(now - last_reviewed_at)/S) at query time.
--   review_count      Total attempts on this question (correct + wrong).
--   mistake_count     Wrong attempts only — drives the "you struggled with"
--                     narrative independent of stability.
--   last_outcome      Last attempt's correctness. Useful for prompt phrasing
--                     ("you got it right last time" vs "you missed it last time").
CREATE TABLE IF NOT EXISTS public.user_memory_states (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id       UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  stability         REAL NOT NULL DEFAULT 1.0
                      CHECK (stability >= 0.1 AND stability <= 365.0),
  last_reviewed_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  review_count      INTEGER NOT NULL DEFAULT 0 CHECK (review_count >= 0),
  mistake_count     INTEGER NOT NULL DEFAULT 0 CHECK (mistake_count >= 0),
  last_outcome      TEXT NULL CHECK (last_outcome IS NULL OR last_outcome IN ('correct','wrong')),
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, question_id)
);

-- Cron picks the N coldest items per user: ORDER BY H ascending where
-- H = exp(-(now - last_reviewed_at)/stability). Postgres can't index a
-- computed expression involving NOW(), so we index the inputs and compute
-- H in the query. The (user_id, last_reviewed_at) index supports both the
-- "stale per user" scan and the "user's recent activity" lookup.
CREATE INDEX IF NOT EXISTS user_memory_states_user_decay_idx
  ON public.user_memory_states(user_id, last_reviewed_at);

-- ─── B1. manana_episodes ────────────────────────────────────────────────────
-- One row per user per ISO-week. Recovery-safe: cron upserts with status
-- 'queued', transitions to 'generating' on start, then 'ready' or 'failed'.
-- storage_path/duration/bytes nullable until status='ready' (single-MP3
-- output via server-side ffmpeg concat).
CREATE TABLE IF NOT EXISTS public.manana_episodes (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  week_starting       DATE NOT NULL,                          -- Monday of the ISO week
  status              TEXT NOT NULL DEFAULT 'queued'
                        CHECK (status IN ('queued','generating','ready','failed')),
  storage_path        TEXT NULL,                              -- manana-episodes/{user_id}/{week}.mp3 — null until ready
  duration_ms         INTEGER NULL CHECK (duration_ms IS NULL OR duration_ms >= 0),
  bytes               INTEGER NULL CHECK (bytes IS NULL OR bytes >= 0),
  script_json         JSONB NULL,                             -- resolved script (for debug + re-render)
  memory_heat_json    JSONB NULL,                             -- snapshot at generation time
  tts_cost_micro_usd  INTEGER NOT NULL DEFAULT 0 CHECK (tts_cost_micro_usd >= 0),
  llm_cost_micro_usd  INTEGER NOT NULL DEFAULT 0 CHECK (llm_cost_micro_usd >= 0),
  error_message       TEXT NULL,                              -- populated when status='failed'
  generated_at        TIMESTAMPTZ NULL,                       -- set when status transitions to 'ready'
  first_played_at     TIMESTAMPTZ NULL,
  last_played_at      TIMESTAMPTZ NULL,
  play_count          INTEGER NOT NULL DEFAULT 0 CHECK (play_count >= 0),
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, week_starting)
);

CREATE INDEX IF NOT EXISTS manana_episodes_user_idx
  ON public.manana_episodes(user_id, week_starting DESC);
CREATE INDEX IF NOT EXISTS manana_episodes_status_idx
  ON public.manana_episodes(status) WHERE status IN ('queued','generating');

-- ─── B2. manana_static_phrases ──────────────────────────────────────────────
-- Reusable phrase library (greetings, transitions, silences). Keyed by
-- semantic slot ('greeting.evening.np') so script generation references
-- *slots* not text. text_hash gives content-addressed dedup. Storage paths
-- include provider so a future ElevenLabs cohort doesn't collide with
-- existing Gemini MP3s.
--
-- voice is intentionally NOT constrained by CHECK — ElevenLabs voices
-- ('Rachel', 'Adam') aren't enumerable today and forcing a schema change
-- to add one would block experimentation. Application code validates.
CREATE TABLE IF NOT EXISTS public.manana_static_phrases (
  key            TEXT PRIMARY KEY,                            -- e.g. 'greeting.evening.np'
  text           TEXT NOT NULL,
  lang           TEXT NOT NULL CHECK (lang IN ('np','en')),
  provider       TEXT NOT NULL DEFAULT 'gemini',              -- 'gemini' | 'elevenlabs' (validated in app)
  voice          TEXT NOT NULL,                               -- 'Kore' for gemini today
  storage_path   TEXT NOT NULL,                               -- manana-static/{provider}/{hash[:2]}/{hash}.mp3
  duration_ms    INTEGER NOT NULL CHECK (duration_ms >= 0),
  bytes          INTEGER NOT NULL CHECK (bytes >= 0),
  text_hash      TEXT NOT NULL,                               -- sha256(provider|voice|lang|text)
  hit_count      BIGINT NOT NULL DEFAULT 0 CHECK (hit_count >= 0),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX IF NOT EXISTS manana_static_phrases_hash_idx
  ON public.manana_static_phrases(text_hash);

-- ─── B3. manana_dynamic_cache ───────────────────────────────────────────────
-- Content-addressed cache for templated chunks like "You're doing great on
-- [TOPIC]" where the variable part is interpolated at TTS time. Fundamentally
-- different lifecycle from static phrases (no semantic key — text IS the key)
-- and from question audio (versioned per question_id). Kept narrow on purpose:
-- only the LLM's reusable phrasing chunks land here, never full personalized
-- intros containing the user's name.
CREATE TABLE IF NOT EXISTS public.manana_dynamic_cache (
  text_hash       TEXT PRIMARY KEY,                           -- sha256(provider|voice|lang|text)
  text            TEXT NOT NULL,
  lang            TEXT NOT NULL CHECK (lang IN ('np','en')),
  provider        TEXT NOT NULL DEFAULT 'gemini',
  voice           TEXT NOT NULL,
  storage_path    TEXT NOT NULL,                              -- manana-dynamic/{provider}/{hash[:2]}/{hash}.mp3
  duration_ms     INTEGER NOT NULL CHECK (duration_ms >= 0),
  bytes           INTEGER NOT NULL CHECK (bytes >= 0),
  character_count INTEGER NOT NULL CHECK (character_count >= 0),
  hit_count       BIGINT NOT NULL DEFAULT 0 CHECK (hit_count >= 0),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_used_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- LRU-style eviction lookup: oldest unused entries first.
CREATE INDEX IF NOT EXISTS manana_dynamic_cache_lru_idx
  ON public.manana_dynamic_cache(last_used_at);

-- ─── B4. manana_episode_plays ───────────────────────────────────────────────
-- Heartbeat log. Separate from manana_episodes so high-frequency reached_ms
-- updates don't churn the main row's indexes.
CREATE TABLE IF NOT EXISTS public.manana_episode_plays (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  episode_id   UUID NOT NULL REFERENCES public.manana_episodes(id) ON DELETE CASCADE,
  user_id      UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  started_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  reached_ms   INTEGER NOT NULL DEFAULT 0 CHECK (reached_ms >= 0),
  completed    BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX IF NOT EXISTS manana_episode_plays_episode_idx
  ON public.manana_episode_plays(episode_id);
CREATE INDEX IF NOT EXISTS manana_episode_plays_user_idx
  ON public.manana_episode_plays(user_id, started_at DESC);

-- ─── updated_at triggers ─────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.touch_manana_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_user_memory_states_touch ON public.user_memory_states;
CREATE TRIGGER trg_user_memory_states_touch
  BEFORE UPDATE ON public.user_memory_states
  FOR EACH ROW EXECUTE FUNCTION public.touch_manana_updated_at();

DROP TRIGGER IF EXISTS trg_manana_episodes_touch ON public.manana_episodes;
CREATE TRIGGER trg_manana_episodes_touch
  BEFORE UPDATE ON public.manana_episodes
  FOR EACH ROW EXECUTE FUNCTION public.touch_manana_updated_at();

DROP TRIGGER IF EXISTS trg_manana_static_phrases_touch ON public.manana_static_phrases;
CREATE TRIGGER trg_manana_static_phrases_touch
  BEFORE UPDATE ON public.manana_static_phrases
  FOR EACH ROW EXECUTE FUNCTION public.touch_manana_updated_at();

DROP TRIGGER IF EXISTS trg_manana_episode_plays_touch ON public.manana_episode_plays;
CREATE TRIGGER trg_manana_episode_plays_touch
  BEFORE UPDATE ON public.manana_episode_plays
  FOR EACH ROW EXECUTE FUNCTION public.touch_manana_updated_at();

-- ─── RLS ─────────────────────────────────────────────────────────────────────
ALTER TABLE public.user_memory_states     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manana_episodes        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manana_static_phrases  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manana_dynamic_cache   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manana_episode_plays   ENABLE ROW LEVEL SECURITY;

-- user_memory_states: users read their own; updates only via service role
-- (the attempt-submission hook runs server-side with service credentials).
DROP POLICY IF EXISTS user_memory_states_read_own ON public.user_memory_states;
CREATE POLICY user_memory_states_read_own ON public.user_memory_states
  FOR SELECT TO authenticated
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS user_memory_states_admin_write ON public.user_memory_states;
CREATE POLICY user_memory_states_admin_write ON public.user_memory_states
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Episodes: users read their own; writes only via service role (cron) /admin.
DROP POLICY IF EXISTS manana_episodes_read_own ON public.manana_episodes;
CREATE POLICY manana_episodes_read_own ON public.manana_episodes
  FOR SELECT TO authenticated
  USING (user_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS manana_episodes_admin_write ON public.manana_episodes;
CREATE POLICY manana_episodes_admin_write ON public.manana_episodes
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Static phrases: any authenticated user reads (audio is in a public bucket).
-- Only admins write — phrase additions are deliberate brand-voice decisions.
DROP POLICY IF EXISTS manana_static_phrases_read ON public.manana_static_phrases;
CREATE POLICY manana_static_phrases_read ON public.manana_static_phrases
  FOR SELECT TO authenticated
  USING (true);

DROP POLICY IF EXISTS manana_static_phrases_admin_write ON public.manana_static_phrases;
CREATE POLICY manana_static_phrases_admin_write ON public.manana_static_phrases
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Dynamic cache: authenticated read (audio is in a public bucket per static
-- pattern), service-role write via cron. Admin write for ops/backfill.
DROP POLICY IF EXISTS manana_dynamic_cache_read ON public.manana_dynamic_cache;
CREATE POLICY manana_dynamic_cache_read ON public.manana_dynamic_cache
  FOR SELECT TO authenticated
  USING (true);

DROP POLICY IF EXISTS manana_dynamic_cache_admin_write ON public.manana_dynamic_cache;
CREATE POLICY manana_dynamic_cache_admin_write ON public.manana_dynamic_cache
  FOR ALL TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

-- Episode plays: users insert/read own. Server-mediated heartbeat enforces
-- episode-ownership on update.
DROP POLICY IF EXISTS manana_episode_plays_rw_own ON public.manana_episode_plays;
CREATE POLICY manana_episode_plays_rw_own ON public.manana_episode_plays
  FOR ALL TO authenticated
  USING (user_id = auth.uid() OR public.is_admin())
  WITH CHECK (user_id = auth.uid());

-- ─── Storage buckets ─────────────────────────────────────────────────────────
-- Episodes: private. Each MP3 is personal (contains user's name, references
-- their mistakes). Served via signed URLs from an authed API. Path convention
-- {user_id}/{week}.mp3 puts the owner in the first folder for cheap RLS.
INSERT INTO storage.buckets (id, name, public)
VALUES ('manana-episodes', 'manana-episodes', false)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "Users read own manana episodes" ON storage.objects;
CREATE POLICY "Users read own manana episodes" ON storage.objects
  FOR SELECT TO authenticated
  USING (
    bucket_id = 'manana-episodes'
    AND (
      (storage.foldername(name))[1] = auth.uid()::text
      OR public.is_admin()
    )
  );

DROP POLICY IF EXISTS "Admins write manana episodes" ON storage.objects;
CREATE POLICY "Admins write manana episodes" ON storage.objects
  FOR ALL TO authenticated
  USING (bucket_id = 'manana-episodes' AND public.is_admin())
  WITH CHECK (bucket_id = 'manana-episodes' AND public.is_admin());

-- Static phrases: public-read (same model as question-audio). No PII.
INSERT INTO storage.buckets (id, name, public)
VALUES ('manana-static', 'manana-static', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "Public read manana static" ON storage.objects;
CREATE POLICY "Public read manana static" ON storage.objects
  FOR SELECT TO public
  USING (bucket_id = 'manana-static');

DROP POLICY IF EXISTS "Admins write manana static" ON storage.objects;
CREATE POLICY "Admins write manana static" ON storage.objects
  FOR ALL TO authenticated
  USING (bucket_id = 'manana-static' AND public.is_admin())
  WITH CHECK (bucket_id = 'manana-static' AND public.is_admin());

-- Dynamic cache audio: same public-read model. text_hash in path means
-- two users with the same templated chunk hit the same CDN object.
INSERT INTO storage.buckets (id, name, public)
VALUES ('manana-dynamic', 'manana-dynamic', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "Public read manana dynamic" ON storage.objects;
CREATE POLICY "Public read manana dynamic" ON storage.objects
  FOR SELECT TO public
  USING (bucket_id = 'manana-dynamic');

DROP POLICY IF EXISTS "Admins write manana dynamic" ON storage.objects;
CREATE POLICY "Admins write manana dynamic" ON storage.objects
  FOR ALL TO authenticated
  USING (bucket_id = 'manana-dynamic' AND public.is_admin())
  WITH CHECK (bucket_id = 'manana-dynamic' AND public.is_admin());
