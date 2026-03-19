-- Learner experience foundations: attempts, answers, AI feedback, and future gamification hooks.

-- Ensure question sets have a version we can track across attempts.
ALTER TABLE public.question_sets
    ADD COLUMN IF NOT EXISTS version INTEGER NOT NULL DEFAULT 1;

-- Attempts table: one row per quiz play.
CREATE TABLE IF NOT EXISTS public.attempts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    set_id UUID REFERENCES public.question_sets(id) ON DELETE CASCADE NOT NULL,
    set_version INTEGER NOT NULL DEFAULT 1,
    status TEXT NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'submitted')),
    question_count INTEGER NOT NULL DEFAULT 0 CHECK (question_count >= 0),
    score_raw INTEGER CHECK (score_raw >= 0),
    score_pct NUMERIC(5,2) CHECK (score_pct >= 0 AND score_pct <= 100),
    started_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    submitted_at TIMESTAMPTZ
);

-- Attempt answers: per-question selections with correctness snapshot.
CREATE TABLE IF NOT EXISTS public.attempt_answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    attempt_id UUID REFERENCES public.attempts(id) ON DELETE CASCADE NOT NULL,
    question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,
    selected_option CHAR(1) NOT NULL CHECK (selected_option IN ('A', 'B', 'C', 'D')),
    is_correct BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    CONSTRAINT unique_attempt_question UNIQUE (attempt_id, question_id)
);

-- AI feedback: one row per attempt; cache model/latency/cost.
CREATE TABLE IF NOT EXISTS public.ai_feedback (
    attempt_id UUID PRIMARY KEY REFERENCES public.attempts(id) ON DELETE CASCADE,
    strengths TEXT,
    weak_zones JSONB,
    explanations JSONB,
    model TEXT,
    latency_ms INTEGER CHECK (latency_ms >= 0),
    cost_cents NUMERIC(10,2) CHECK (cost_cents >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- Future gamification hooks on profiles.
ALTER TABLE public.profiles
    ADD COLUMN IF NOT EXISTS current_streak INTEGER NOT NULL DEFAULT 0 CHECK (current_streak >= 0),
    ADD COLUMN IF NOT EXISTS best_streak INTEGER NOT NULL DEFAULT 0 CHECK (best_streak >= 0),
    ADD COLUMN IF NOT EXISTS xp_points INTEGER NOT NULL DEFAULT 0 CHECK (xp_points >= 0);

-- Indexes for fast lookups.
CREATE INDEX IF NOT EXISTS idx_attempts_user_started_at ON public.attempts (user_id, started_at DESC);
CREATE INDEX IF NOT EXISTS idx_attempts_set ON public.attempts (set_id);
CREATE INDEX IF NOT EXISTS idx_attempt_answers_attempt ON public.attempt_answers (attempt_id);
CREATE INDEX IF NOT EXISTS idx_ai_feedback_created_at ON public.ai_feedback (created_at DESC);

-- Enable RLS.
ALTER TABLE public.attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attempt_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_feedback ENABLE ROW LEVEL SECURITY;

-- Attempts policies: owners can CRUD; admins can SELECT.
CREATE POLICY "Attempts readable by owner" ON public.attempts
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Attempts insertable by owner" ON public.attempts
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Attempts updatable by owner" ON public.attempts
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Attempts readable by admins" ON public.attempts
    FOR SELECT USING (EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.is_admin = true));

-- Attempt answers policies: mirror parent attempt ownership.
CREATE POLICY "Attempt answers readable by owner" ON public.attempt_answers
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "Attempt answers insertable by owner" ON public.attempt_answers
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "Attempt answers updatable by owner" ON public.attempt_answers
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "Attempt answers readable by admins" ON public.attempt_answers
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.is_admin = true
        )
    );

-- AI feedback policies: owner/admin visibility; service writes via owner path.
CREATE POLICY "AI feedback readable by owner" ON public.ai_feedback
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "AI feedback insertable by owner" ON public.ai_feedback
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "AI feedback updatable by owner" ON public.ai_feedback
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.attempts a
            WHERE a.id = attempt_id AND a.user_id = auth.uid()
        )
    );

CREATE POLICY "AI feedback readable by admins" ON public.ai_feedback
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.is_admin = true
        )
    );
