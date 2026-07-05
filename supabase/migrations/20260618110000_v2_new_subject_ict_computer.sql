-- Everything GK v2 — Phase 1a (2/3): new subject 1.9 — सूचना प्रविधि र कम्प्युटर (ICT & Computer)
-- Brand-new subject + 3 topics + 9 subtopics. Purely additive. Idempotent.
-- Fixed UUIDs (b1c00009…) so topic/subtopic inserts can reference the new ids and re-runs are no-ops.

-- Subject 1.9
INSERT INTO public.subjects (id, module_id, name, name_np, slug, syllabus_ref, display_order) VALUES
  ('b1c00009-0000-4000-8000-000000000009',
   (SELECT id FROM public.modules WHERE slug = 'gk'),
   'Information Technology and Computer', 'सूचना प्रविधि र कम्प्युटर', 'ict-computer', '1.9', 9)
ON CONFLICT (id) DO NOTHING;

-- Topics
INSERT INTO public.topics (id, subject_id, name, slug, syllabus_ref, display_order) VALUES
  ('b1c00009-0001-4000-8000-000000000001', 'b1c00009-0000-4000-8000-000000000009', 'कम्प्युटर आधार',          'ict-computer-basics',  '1.9.1', 1),
  ('b1c00009-0002-4000-8000-000000000002', 'b1c00009-0000-4000-8000-000000000009', 'इन्टरनेट र सञ्जाल',       'ict-internet-network', '1.9.2', 2),
  ('b1c00009-0003-4000-8000-000000000003', 'b1c00009-0000-4000-8000-000000000009', 'डिजिटल नेपाल र ई-शासन',   'ict-digital-egov',     '1.9.3', 3)
ON CONFLICT (id) DO NOTHING;

-- Subtopics
INSERT INTO public.subtopics (topic_id, name, slug, display_order) VALUES
  ('b1c00009-0001-4000-8000-000000000001', 'हार्डवेयर र सफ्टवेयर',          'ict-hardware-software', 1),
  ('b1c00009-0001-4000-8000-000000000001', 'अपरेटिङ सिस्टम र अफिस प्याकेज', 'ict-os-office',         2),
  ('b1c00009-0001-4000-8000-000000000001', 'डेटा, फाइल र भण्डारण',          'ict-data-storage',      3),
  ('b1c00009-0002-4000-8000-000000000002', 'इन्टरनेट, इमेल र वेब',          'ict-internet-web',      1),
  ('b1c00009-0002-4000-8000-000000000002', 'नेटवर्किङ',                     'ict-networking',        2),
  ('b1c00009-0002-4000-8000-000000000002', 'साइबर सुरक्षा',                 'ict-cybersecurity',     3),
  ('b1c00009-0003-4000-8000-000000000003', 'डिजिटल भुक्तानी',               'ict-digital-payment',   1),
  ('b1c00009-0003-4000-8000-000000000003', 'विद्युतीय शासन',                'ict-e-governance',      2),
  ('b1c00009-0003-4000-8000-000000000003', 'सूचना प्रविधि नीति र कानून',    'ict-it-policy',         3)
ON CONFLICT (topic_id, slug) DO NOTHING;
