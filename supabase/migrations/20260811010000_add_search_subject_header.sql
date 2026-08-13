-- Results-page header: how big this subject is, how far the learner has come,
-- and where to resume. All SQL, no AI — this is the line that makes the search
-- page useful to a returning learner.

-- Official exam weightings, keyed on subjects.syllabus_ref ('1.3').
-- Only ever populate rows that can be pointed at a published syllabus: topic
-- level counts do NOT exist officially, and inventing a split would be handing
-- candidates fabricated guidance about where the marks are.
create table if not exists public.syllabus_weights (
  syllabus_ref   text primary key,
  exam           text        not null,
  question_count integer     not null check (question_count >= 0),
  source_note    text        not null,
  created_at     timestamptz not null default now()
);

alter table public.syllabus_weights enable row level security;

drop policy if exists "Public read syllabus_weights" on public.syllabus_weights;
create policy "Public read syllabus_weights"
  on public.syllabus_weights for select using (true);

drop policy if exists "Admins manage syllabus_weights" on public.syllabus_weights;
create policy "Admins manage syllabus_weights"
  on public.syllabus_weights for all using (public.is_admin());

comment on table public.syllabus_weights is
  'Official per-unit exam question counts. A missing row renders nothing — silence is correct when the weighting is unknown.';

create or replace function public.search_subject_header(p_subject_id uuid)
returns jsonb
language sql
stable
security invoker
set search_path to 'public'
as $$
with
subject as (
  select s.id, s.name, s.name_np, s.slug, s.syllabus_ref
    from subjects s where s.id = p_subject_id
),
-- Every set in the subject, in syllabus order, with its question count.
sets_in_subject as (
  select
    qs.id,
    qs.title,
    t.slug           as topic_slug,
    st.slug          as subtopic_slug,
    s.slug           as subject_slug,
    m.slug           as module_slug,
    t.display_order  as topic_order,
    coalesce(st.display_order, 0) as subtopic_order,
    (select count(*)::int from question_set_questions qsq
      where qsq.question_set_id = qs.id) as q_count
  from question_sets qs
  join topics   t on t.id = qs.topic_id
  join subjects s on s.id = t.subject_id
  join modules  m on m.id = s.module_id
  left join subtopics st on st.id = qs.subtopic_id
  where t.subject_id = p_subject_id
),
-- The learner's attempts on those sets. submitted_at is the completion signal.
my_attempts as (
  select a.set_id,
         bool_or(a.submitted_at is not null)  as completed,
         bool_or(a.submitted_at is null)      as in_progress,
         max(a.started_at)                    as last_started
    from attempts a
    join sets_in_subject sis on sis.id = a.set_id
   where a.user_id = auth.uid()
   group by a.set_id
),
-- Priority 1: something already open. Priority 2: the next untouched set in
-- syllabus order. Priority 3 falls out of the same ordering when nothing is
-- attempted at all, which is the brand-new learner.
resume_candidate as (
  select sis.id, sis.title, sis.q_count,
         sis.module_slug, sis.subject_slug, sis.topic_slug, sis.subtopic_slug,
         case when ma.in_progress then 'in_progress' else 'next' end as reason
    from sets_in_subject sis
    left join my_attempts ma on ma.set_id = sis.id
   where coalesce(ma.completed, false) = false
   order by
     (case when coalesce(ma.in_progress, false) then 0 else 1 end),
     ma.last_started desc nulls last,
     sis.topic_order, sis.subtopic_order, sis.title
   limit 1
)
select jsonb_build_object(
  'subject', (select to_jsonb(s) from subject s),
  'totals', jsonb_build_object(
    'sets',      (select count(*)          from sets_in_subject),
    'questions', (select coalesce(sum(q_count), 0) from sets_in_subject),
    'topics',    (select count(*) from topics where subject_id = p_subject_id)
  ),
  'progress', jsonb_build_object(
    'completed_sets', (select count(*) from my_attempts where completed),
    'started_sets',   (select count(*) from my_attempts)
  ),
  'resume', (select to_jsonb(rc) from resume_candidate rc),
  'exam', (
    select to_jsonb(w) - 'created_at' - 'syllabus_ref'
      from syllabus_weights w
      join subject s on s.syllabus_ref = w.syllabus_ref
  )
);
$$;

comment on function public.search_subject_header(uuid) is
  'Counts, the caller''s progress, and their resume point for one subject. Used by the search results header.';

grant execute on function public.search_subject_header(uuid) to authenticated;
