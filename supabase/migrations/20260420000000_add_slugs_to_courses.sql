-- Add slug column to subjects
ALTER TABLE public.subjects ADD COLUMN slug text;

-- Add slug column to topics
ALTER TABLE public.topics ADD COLUMN slug text;

-- Generate robust slugs
DO $$
DECLARE
  r RECORD;
  base_slug text;
  final_slug text;
  counter int;
BEGIN
  -- Handle subjects
  FOR r IN SELECT * FROM public.subjects LOOP
    base_slug := trim(both '-' from regexp_replace(lower(r.name), '[^a-z0-9]+', '-', 'g'));
    IF base_slug = '' OR base_slug IS NULL THEN
      base_slug := 'subject-' || left(r.id::text, 8);
    END IF;
    
    final_slug := base_slug;
    counter := 1;
    
    WHILE EXISTS (SELECT 1 FROM public.subjects WHERE slug = final_slug AND module_id IS NOT DISTINCT FROM r.module_id AND id != r.id) LOOP
      final_slug := base_slug || '-' || counter;
      counter := counter + 1;
    END LOOP;
    
    UPDATE public.subjects SET slug = final_slug WHERE id = r.id;
  END LOOP;

  -- Handle topics
  FOR r IN SELECT * FROM public.topics LOOP
    base_slug := trim(both '-' from regexp_replace(lower(r.name), '[^a-z0-9]+', '-', 'g'));
    IF base_slug = '' OR base_slug IS NULL THEN
      base_slug := 'topic-' || left(r.id::text, 8);
    END IF;
    
    final_slug := base_slug;
    counter := 1;
    
    WHILE EXISTS (SELECT 1 FROM public.topics WHERE slug = final_slug AND subject_id = r.subject_id AND id != r.id) LOOP
      final_slug := base_slug || '-' || counter;
      counter := counter + 1;
    END LOOP;
    
    UPDATE public.topics SET slug = final_slug WHERE id = r.id;
  END LOOP;
END $$;

-- Enforce slug constraints
ALTER TABLE public.subjects ALTER COLUMN slug SET NOT NULL;
ALTER TABLE public.subjects ADD CONSTRAINT unique_module_subject_slug UNIQUE (module_id, slug);

ALTER TABLE public.topics ALTER COLUMN slug SET NOT NULL;
ALTER TABLE public.topics ADD CONSTRAINT unique_subject_topic_slug UNIQUE (subject_id, slug);
