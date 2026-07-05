-- Move demographic subtopics out of Nepal Geography (1.3) → Social & Cultural (1.6)
-- Affected subtopics: जनसंख्या र जनगणना (sets=1), जातजाति र भाषा (sets=0)
-- Target topic: 1.6.1 प्रथा, परम्परा, धर्म र जातजाति (0c2194a0-a5c1-47cc-a8bb-b63285fb27f7)

-- 1. Move जनसंख्या र जनगणना subtopic to Social topic 1.6.1
UPDATE public.subtopics
SET topic_id = '0c2194a0-a5c1-47cc-a8bb-b63285fb27f7'
WHERE id = 'eb1c5b79-5cad-487f-b2ea-711db97bffd2';

-- 2. Move जातजाति र भाषा subtopic to Social topic 1.6.1
UPDATE public.subtopics
SET topic_id = '0c2194a0-a5c1-47cc-a8bb-b63285fb27f7'
WHERE id = 'e221309c-877f-48a2-b703-935e9d8b7c43';

-- 3. Update question_sets.topic_id for all sets under these subtopics
UPDATE public.question_sets
SET topic_id = '0c2194a0-a5c1-47cc-a8bb-b63285fb27f7'
WHERE subtopic_id IN (
  'eb1c5b79-5cad-487f-b2ea-711db97bffd2',  -- जनसंख्या र जनगणना
  'e221309c-877f-48a2-b703-935e9d8b7c43'   -- जातजाति र भाषा
);

-- After this, Nepal Geography प्रशासनिक विभाजन topic only keeps:
-- प्रदेश र जिल्ला + स्थानीय तह — pure administrative/spatial, correct per physical-first design.
