-- Migration: Seed Nepal Constitution Subject and Topics under GK Module
DO $$
DECLARE
  gk_module_id uuid;
  constitution_subject_id uuid;
BEGIN
  -- 1. Get GK Module ID
  SELECT id INTO gk_module_id FROM public.modules WHERE slug = 'gk';

  -- 2. Create Nepal Constitution Subject under GK (1.12)
  INSERT INTO public.subjects (module_id, name, name_np, syllabus_ref, display_order, slug)
  VALUES (gk_module_id, 'Nepal Constitution', 'नेपालको संविधान', '1.12', 12, 'nepal-constitution')
  ON CONFLICT (syllabus_ref) DO UPDATE SET
    name = EXCLUDED.name,
    name_np = EXCLUDED.name_np,
    module_id = EXCLUDED.module_id,
    display_order = EXCLUDED.display_order
  RETURNING id INTO constitution_subject_id;

  -- 3. Create Topics for Nepal Constitution (1.12.x)
  INSERT INTO public.topics (subject_id, name, syllabus_ref, slug, display_order) VALUES
  (constitution_subject_id, 'नेपालको संवैधानिक इतिहास (Sovereign Development of Nepal)', '1.12.1', 'nepal-constitutional-history', 1),
  (constitution_subject_id, 'वर्तमान संविधानको सामान्य परिचय र प्रारम्भिक (Preliminary)', '1.12.2', 'preliminary-constitution-intro', 2),
  (constitution_subject_id, 'नागरिकता सम्बन्धी व्यवस्था (Citizenship)', '1.12.3', 'citizenship-provisions', 3),
  (constitution_subject_id, 'मौलिक हक र कर्तव्य (Fundamental Rights and Duties)', '1.12.4', 'fundamental-rights-duties', 4),
  (constitution_subject_id, 'राज्यका निर्देशक सिद्धान्त, नीति र दायित्व (Directive Principles and Policies)', '1.12.5', 'directive-principles-policies', 5),
  (constitution_subject_id, 'राज्यको संरचना र राज्य शक्तिको बाँडफाँड (State Structure and Power Sharing)', '1.12.6', 'state-structure-power-sharing', 6),
  (constitution_subject_id, 'संघीय, प्रादेशिक र स्थानीय कार्यपालिका (Executives)', '1.12.7', 'executives-federal-provincial-local', 7),
  (constitution_subject_id, 'व्यवस्थापिका र आर्थिक कार्यप्रणाली (Legislative and Financial Procedures)', '1.12.8', 'legislative-financial-procedures', 8),
  (constitution_subject_id, 'न्यायपालिका (Judiciary)', '1.12.9', 'judiciary', 9),
  (constitution_subject_id, 'संवैधानिक निकायहरू (Constitutional Bodies)', '1.12.10', 'constitutional-bodies', 10),
  (constitution_subject_id, 'विविध व्यवस्थाहरू (Miscellaneous)', '1.12.11', 'miscellaneous-provisions', 11)
  ON CONFLICT (subject_id, syllabus_ref) DO UPDATE SET
    name = EXCLUDED.name,
    display_order = EXCLUDED.display_order;

END $$;
