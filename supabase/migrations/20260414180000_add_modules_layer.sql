-- Step 1: Create modules table
CREATE TABLE IF NOT EXISTS public.modules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,              -- "GK (सामान्य ज्ञान)"
  name_np text,                    -- Nepali name
  slug text NOT NULL UNIQUE,       -- "gk"
  description text,
  is_universal boolean DEFAULT false, 
  exam_levels text[],              -- ['kharidar','nayab_subba','section_officer']
  display_order integer DEFAULT 0,
  is_active boolean DEFAULT true,
  created_at timestamp with time zone DEFAULT now()
);

-- Step 2: Update subjects table
ALTER TABLE public.subjects
ADD COLUMN IF NOT EXISTS module_id uuid REFERENCES public.modules(id) ON DELETE CASCADE,
ADD COLUMN IF NOT EXISTS name_np text,
ADD COLUMN IF NOT EXISTS syllabus_ref text,
ADD COLUMN IF NOT EXISTS display_order integer DEFAULT 0;

-- Step 3: Update topics table
ALTER TABLE public.topics
ADD COLUMN IF NOT EXISTS syllabus_ref text,
ADD COLUMN IF NOT EXISTS display_order integer DEFAULT 0;

-- Step 4: Enable RLS on modules
ALTER TABLE public.modules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read modules" ON public.modules FOR SELECT USING (true);
CREATE POLICY "Admin write modules" ON public.modules FOR ALL
  USING (EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true));

-- Step 5: Seed the Universal GK Module
INSERT INTO public.modules (name, name_np, slug, is_universal, display_order)
VALUES ('GK (General Knowledge)', 'सामान्य ज्ञान (GK)', 'gk', true, 1)
ON CONFLICT (slug) DO UPDATE SET 
  name = EXCLUDED.name,
  name_np = EXCLUDED.name_np,
  is_universal = EXCLUDED.is_universal
RETURNING id;

-- We need the GK module ID for subsequent inserts. 
-- In a migration script, we can use a CTE or a temporary variable if supported, 
-- but here we can just target the slug.

-- Step 6: Migrate and Seed Subjects for GK Module
DO $$
DECLARE
  gk_id uuid;
BEGIN
  SELECT id INTO gk_id FROM public.modules WHERE slug = 'gk';

  -- 1.1 Universe & Solar System
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Universe & Solar System', 'ब्रह्माण्ड सम्बन्धी जानकारी', '1.1', 1)
  ON CONFLICT DO NOTHING;

  -- 1.2 World Geography
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'World Geography', 'विश्वको भूगोल', '1.2', 2)
  ON CONFLICT DO NOTHING;

  -- 1.3 Nepal Geography (Update existing or Insert)
  -- We try to find existing "नेपालको भूगोल"
  UPDATE public.subjects
  SET module_id = gk_id,
      name = 'Nepal Geography',
      name_np = 'नेपालको भूगोल',
      syllabus_ref = '1.3',
      display_order = 3
  WHERE name = 'नेपालको भूगोल' OR name = 'Nepal Geography';
  
  -- If it didn't exist, insert it
  IF NOT FOUND THEN
    INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
    VALUES (gk_id, 'Nepal Geography', 'नेपालको भूगोल', '1.3', 3);
  END IF;

  -- 1.4 World History
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'World History', 'विश्वको इतिहास', '1.4', 4)
  ON CONFLICT DO NOTHING;

  -- 1.5 Nepal History
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Nepal History', 'नेपालको इतिहास', '1.5', 5)
  ON CONFLICT DO NOTHING;

  -- 1.6 Social & Cultural
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Social & Cultural', 'सामाजिक एवं सांस्कृतिक', '1.6', 6)
  ON CONFLICT DO NOTHING;

  -- 1.7 Nepal Economy
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Nepal Economy', 'आर्थिक अवस्था', '1.7', 7)
  ON CONFLICT DO NOTHING;

  -- 1.8 Science, Technology & Health
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Science, Technology & Health', 'विज्ञान प्रविधि र स्वास्थ्य', '1.8', 8)
  ON CONFLICT DO NOTHING;

  -- 1.9 Ecosystem & Environment
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'Ecosystem & Environment', 'पारिस्थितिक पद्धति र वातावरण', '1.9', 9)
  ON CONFLICT DO NOTHING;

  -- 1.10 International Relations
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
  VALUES (gk_id, 'International Relations', 'अन्तर्राष्ट्रिय सम्बन्ध', '1.10', 10)
  ON CONFLICT DO NOTHING;

  -- 1.11 Current Affairs (Update existing or Insert)
  UPDATE public.subjects
  SET module_id = gk_id,
      name = 'Current Affairs',
      name_np = 'समसामाईक घटना', -- Updated as per user's syllabus NP name
      syllabus_ref = '1.11',
      display_order = 11
  WHERE name = 'समसामाईक' OR name = 'Current Affairs';

  IF NOT FOUND THEN
    INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order)
    VALUES (gk_id, 'Current Affairs', 'समसामाईक घटना', '1.11', 11);
  END IF;

END $$;
