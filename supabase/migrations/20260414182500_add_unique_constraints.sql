-- Migration: Add unique constraints to topics to prevent duplicates and enable ON CONFLICT
ALTER TABLE public.topics 
ADD CONSTRAINT topics_subject_id_name_key UNIQUE (subject_id, name);

ALTER TABLE public.topics 
ADD CONSTRAINT topics_subject_id_syllabus_ref_key UNIQUE (subject_id, syllabus_ref);

-- Ensure syllabus_ref is also unique per subject for subjects
ALTER TABLE public.subjects
ADD CONSTRAINT subjects_syllabus_ref_key UNIQUE (syllabus_ref);
