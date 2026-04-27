-- Confirm exactly 4 topics under Current Affairs
select t.id, t.name, t.slug
from topics t
join subjects s on t.subject_id = s.id
where s.slug ilike '%current%' or s.name ilike '%current%' or s.name ilike '%समसाम%';

-- Confirm Current Affairs subject exists and find its ID
select id, name, slug from subjects
where slug ilike '%current%' or name ilike '%current%' or name ilike '%समसाम%';

-- Confirm GK module exists
select id, name, slug from modules where slug = 'gk';

-- Confirm cascade scope: rows that will be deleted
select 'topics' as t, count(*) from topics t
  join subjects s on t.subject_id = s.id
  where s.slug = (select slug from subjects where (slug ilike '%current%' or name ilike '%current%' or name ilike '%समसाम%') limit 1)
union all
select 'question_sets', count(*) from question_sets qs
  join topics t on qs.topic_id = t.id
  join subjects s on t.subject_id = s.id
  where s.slug = (select slug from subjects where (slug ilike '%current%' or name ilike '%current%' or name ilike '%समसाम%') limit 1)
union all
select 'questions', count(*) from questions q
  join question_sets qs on q.set_id = qs.id
  join topics t on qs.topic_id = t.id
  join subjects s on t.subject_id = s.id
  where s.slug = (select slug from subjects where (slug ilike '%current%' or name ilike '%current%' or name ilike '%समसाम%') limit 1)
union all
select 'attempts', count(*) from attempts a
  join question_sets qs on a.set_id = qs.id
  join topics t on qs.topic_id = t.id
  join subjects s on t.subject_id = s.id
  where s.slug = (select slug from subjects where (slug ilike '%current%' or name ilike '%current%' or name ilike '%समसाम%') limit 1);

-- Read live RLS policies on topics
select policyname, cmd, roles, qual, with_check
from pg_policies
where schemaname = 'public' and tablename = 'topics'
order by policyname;

-- Verify FK ON DELETE behaviors
select tc.table_name, kcu.column_name, ccu.table_name as parent, rc.delete_rule
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu on tc.constraint_name = kcu.constraint_name
join information_schema.constraint_column_usage ccu on tc.constraint_name = ccu.constraint_name
join information_schema.referential_constraints rc on tc.constraint_name = rc.constraint_name
where tc.constraint_type = 'FOREIGN KEY'
  and tc.table_schema = 'public'
  and ccu.table_name in ('topics', 'question_sets', 'questions', 'attempts')
order by tc.table_name;
