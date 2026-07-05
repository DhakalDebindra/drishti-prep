-- Split Nepal History 1.5.2 into two topics per approved syllabus design
-- Current: आधुनिक इतिहास र प्रमुख राजनीतिक घटनाक्रम (5eb2ebcf, ord=2)
-- New:
--   1.5.2 → नेपालको एकीकरण र राणाकाल (rename existing, ord=2)
--   1.5.3 → २००७ पछिको इतिहास — प्रजातन्त्रदेखि गणतन्त्र (new insert, ord=3)

-- Also: rename 1.5.1 to cleaner keyword slug
UPDATE public.topics
SET name = 'प्राचीन र मध्यकाल'
WHERE id = '4cdada95-4bd2-4fe6-afaf-e8cc2578af63';

-- Rename 1.5.2 to cover only pre-2007 modern history
UPDATE public.topics
SET name = 'नेपालको एकीकरण र राणाकाल', display_order = 2
WHERE id = '5eb2ebcf-f2e0-45a7-b7fd-ee361bfbe2e1';

-- Insert new topic 1.5.3 under Nepal History subject
INSERT INTO public.topics (subject_id, name, slug, syllabus_ref, display_order)
VALUES (
  '0fec5ae2-f64a-45a7-bd46-a576c09212eb',  -- नेपालको इतिहास subject
  '२००७ पछिको इतिहास',
  'nepal-history-post-2007',
  '1.5.3',
  3
);
