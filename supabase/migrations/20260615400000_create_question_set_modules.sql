-- Junction table: a question set can belong to multiple modules
-- question_set_modules(question_set_id, module_id, subtopic_id)
--   module_id    = the module this set is accessible from
--   subtopic_id  = the navigation anchor in THAT module's hierarchy
--                  (same as question_sets.subtopic_id for primary module;
--                   a Nimavi subtopic for cross-linked sets)

CREATE TABLE public.question_set_modules (
  question_set_id uuid NOT NULL REFERENCES public.question_sets(id) ON DELETE CASCADE,
  module_id       uuid NOT NULL REFERENCES public.modules(id)       ON DELETE CASCADE,
  subtopic_id     uuid          REFERENCES public.subtopics(id)     ON DELETE SET NULL,
  PRIMARY KEY (question_set_id, module_id)
);

CREATE INDEX idx_qsm_module_subtopic ON public.question_set_modules (module_id, subtopic_id);

ALTER TABLE public.question_set_modules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "qsm_public_read" ON public.question_set_modules FOR SELECT USING (true);
CREATE POLICY "qsm_admin_write" ON public.question_set_modules
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true)
  );

-- Backfill: every existing set registers in its primary module
INSERT INTO public.question_set_modules (question_set_id, module_id, subtopic_id)
SELECT qs.id, s.module_id, qs.subtopic_id
FROM public.question_sets qs
JOIN public.topics  t ON t.id = qs.topic_id
JOIN public.subjects s ON s.id = t.subject_id
ON CONFLICT DO NOTHING;
