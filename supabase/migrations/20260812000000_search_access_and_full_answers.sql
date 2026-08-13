-- Final state of the learner-search functions after live testing.
--
-- Supersedes the function bodies in 20260811000000 and 20260811020000. Three
-- changes, each driven by something found in use rather than in review:
--
-- 1. ACCESS IS SET-LEVEL, VIA THE EXISTING JUNCTION.
--    Every course is becoming paid with access by enrolment, but a purchase is
--    not limited to one course: buying TSC Nimavi also unlocks the Everything
--    GK sets that the TSC syllabus covers, while buying Everything GK unlocks
--    all of it. question_set_modules already models exactly that, so access
--    reads it rather than asking has_module_access(), which can only say
--    "all of GK or none of it".
--
-- 2. LOCKED QUESTION BODIES NEVER LEAVE THE DATABASE.
--    Search now returns full answers — options and explanation. Both courses
--    are free today so `locked` is always false and this was invisible;
--    flipping one to paid in a test transaction showed search returning 18
--    locked questions WITH explanations. Locked matches are now reduced to a
--    per-course count, which sells the course without giving it away.
--
-- 3. FULL ANSWERS FOR CONTENT THE LEARNER CAN READ.
--    A learner searching for a fact wants the fact; a list of stems with the
--    answers withheld sends them away to find what they just asked for.

-- Can the caller read this question set? Their own course, or any course the
-- set is shared into. SECURITY DEFINER so the junction is readable regardless
-- of the caller's RLS.
create or replace function public.has_set_access(
  p_set_id    uuid,
  p_module_id uuid
)
returns boolean
language sql
stable
security definer
set search_path to 'public'
as $$
  select public.has_module_access(p_module_id)
      or exists (
        select 1
          from question_set_modules qsm
         where qsm.question_set_id = p_set_id
           and public.has_module_access(qsm.module_id)
      );
$$;

comment on function public.has_set_access(uuid, uuid) is
  'Access at question-set granularity: the set''s own course, or any course it is shared into via question_set_modules.';

grant execute on function public.has_set_access(uuid, uuid) to anon, authenticated;

create index if not exists idx_question_set_modules_set
  on public.question_set_modules (question_set_id);

create or replace function public.search_content(
  p_tokens      jsonb,
  p_subject_id  uuid    default null,
  p_topic_id    uuid    default null,
  p_set_limit   integer default 10,
  p_set_offset  integer default 0,
  p_q_limit     integer default 10,
  p_require_all boolean default true
)
returns jsonb
language sql
stable
security invoker
set search_path to 'public'
as $$
with
params as (
  select
    coalesce(jsonb_array_length(p_tokens), 0) as token_count,
    case when p_require_all then coalesce(jsonb_array_length(p_tokens), 0) else 1 end as needed,
    coalesce((
      select array_agg('%' || v || '%')
        from jsonb_array_elements(coalesce(p_tokens, '[]'::jsonb)) tok,
             jsonb_array_elements_text(tok) v
    ), array[]::text[]) as patterns
),
set_counts as (
  select question_set_id as set_id, count(*)::int as q_count
    from question_set_questions group by question_set_id
),
scored_questions as (
  select
    q.id, q.content,
    q.option_a, q.option_b, q.option_c, q.option_d,
    q.correct_option, q.explanation,
    qs.id as set_id, qs.title as set_title,
    t.name as topic_name, s.name_np as subject_name_np,
    m.name as module_name, m.slug as module_slug,
    not public.has_set_access(qs.id, m.id) as locked,
    public.dp_tokens_matched(concat_ws(' ', q.content, q.explanation), p_tokens) as tokens_hit,
    public.dp_tokens_matched(q.content, p_tokens) * 3
      + public.dp_tokens_matched(q.explanation, p_tokens) as score
  from questions q
  join question_set_questions qsq on qsq.question_id = q.id
  join question_sets qs on qs.id = qsq.question_set_id
  join topics   t on t.id = qs.topic_id
  join subjects s on s.id = t.subject_id
  join modules  m on m.id = s.module_id
  cross join params pp
  where pp.token_count > 0
    and (p_subject_id is null or s.id = p_subject_id)
    and (p_topic_id   is null or t.id = p_topic_id)
    and (q.content ilike any (pp.patterns) or q.explanation ilike any (pp.patterns))
),
hit_questions as (
  select * from scored_questions where tokens_hit >= (select needed from params)
),
-- The same question is often filed in several sets; listing it twice wastes a
-- screen-reader user's time on identical text.
-- `locked asc` first: dedup runs BEFORE the access filter, so without it a
-- locked duplicate can evict the copy the learner is entitled to read and the
-- question disappears from their results entirely. 1,040 stems in this bank are
-- filed in more than one set, so the collision is common rather than theoretical.
deduped_questions as (
  select distinct on (btrim(content)) *
    from hit_questions
   order by btrim(content), locked asc, score desc
),
readable_questions as (select * from deduped_questions where not locked),
locked_by_course as (
  select module_name, module_slug, count(*)::int as question_count
    from deduped_questions where locked
   group by module_name, module_slug order by count(*) desc
),
q_by_set as (select set_id, count(*)::int as match_count from hit_questions group by set_id),
scored_sets as (
  select
    qs.id, qs.title,
    st.name as subtopic_name, st.name_np as subtopic_name_np, st.slug as subtopic_slug,
    t.id as topic_id, t.name as topic_name, t.slug as topic_slug,
    s.id as subject_id, s.name as subject_name, s.name_np as subject_name_np, s.slug as subject_slug,
    m.id as module_id, m.name as module_name, m.slug as module_slug,
    coalesce(sc.q_count, 0) as q_count,
    coalesce(qm.match_count, 0) as match_count,
    not public.has_set_access(qs.id, m.id) as locked,
    public.dp_tokens_matched(
      concat_ws(' ', qs.title, st.name, st.name_np, t.name, s.name, s.name_np), p_tokens) as tokens_hit,
    public.dp_tokens_matched(qs.title, p_tokens) * 6
      + public.dp_tokens_matched(concat_ws(' ', st.name, st.name_np), p_tokens) * 3
      + public.dp_tokens_matched(t.name, p_tokens) * 2
      + public.dp_tokens_matched(concat_ws(' ', s.name, s.name_np), p_tokens)
      + least(coalesce(qm.match_count, 0), 6) as score
  from question_sets qs
  join topics    t on t.id = qs.topic_id
  join subjects  s on s.id = t.subject_id
  join modules   m on m.id = s.module_id
  left join subtopics  st on st.id = qs.subtopic_id
  left join set_counts sc on sc.set_id = qs.id
  left join q_by_set   qm on qm.set_id = qs.id
  where (select token_count from params) > 0
    and (p_subject_id is null or s.id = p_subject_id)
    and (p_topic_id   is null or t.id = p_topic_id)
),
hit_sets as (
  select * from scored_sets where tokens_hit >= (select needed from params) or match_count > 0
),
scored_topics as (
  select
    t.id, t.name, t.slug as topic_slug, t.display_order,
    s.id as subject_id, s.name as subject_name, s.name_np as subject_name_np,
    s.slug as subject_slug, m.slug as module_slug,
    public.dp_tokens_matched(concat_ws(' ', t.name, s.name, s.name_np), p_tokens) as tokens_hit,
    (select count(*)::int from question_sets qs where qs.topic_id = t.id) as set_count,
    (select coalesce(sum(sc2.q_count), 0)::int
       from question_sets qs2 left join set_counts sc2 on sc2.set_id = qs2.id
      where qs2.topic_id = t.id) as q_count
  from topics t
  join subjects s on s.id = t.subject_id
  join modules  m on m.id = s.module_id
  where (select token_count from params) > 0
    and (p_subject_id is null or s.id = p_subject_id)
    and (p_topic_id   is null or t.id = p_topic_id)
),
matched_topics as (
  select * from scored_topics where tokens_hit >= (select needed from params) and set_count > 0
),
matched_subjects as (
  select s.id, s.name, s.name_np, s.slug, s.syllabus_ref,
         public.dp_tokens_matched(concat_ws(' ', s.name, s.name_np), p_tokens) as tokens_hit
  from subjects s
  where (select token_count from params) > 0
    and public.dp_tokens_matched(concat_ws(' ', s.name, s.name_np), p_tokens) >= (select needed from params)
    and (p_subject_id is null or s.id = p_subject_id)
)
select jsonb_build_object(
  'counts', jsonb_build_object(
    'subjects',  (select count(*) from matched_subjects),
    'topics',    (select count(*) from matched_topics),
    'sets',      (select count(*) from hit_sets),
    'questions', (select count(*) from readable_questions),
    'locked_questions', (select count(*) from deduped_questions where locked)
  ),
  'locked_courses', coalesce((select jsonb_agg(to_jsonb(l)) from locked_by_course l), '[]'::jsonb),
  'subjects', coalesce((select jsonb_agg(x order by x_hit desc) from (
      select to_jsonb(ms) - 'tokens_hit' as x, ms.tokens_hit as x_hit
      from matched_subjects ms order by ms.tokens_hit desc limit 3) sub), '[]'::jsonb),
  'topics', coalesce((select jsonb_agg(x order by x_order) from (
      select to_jsonb(mt) - 'tokens_hit' as x, mt.display_order as x_order
      from matched_topics mt order by mt.display_order limit 20) sub), '[]'::jsonb),
  'sets', coalesce((select jsonb_agg(x order by x_score desc, x_title) from (
      select (to_jsonb(hs) - 'tokens_hit') - 'score' as x, hs.score as x_score, hs.title as x_title
      from hit_sets hs order by hs.score desc, hs.title
      limit greatest(p_set_limit, 0) offset greatest(p_set_offset, 0)) sub), '[]'::jsonb),
  'questions', coalesce((select jsonb_agg(x order by x_score desc) from (
      select (to_jsonb(hq) - 'tokens_hit') - 'score' as x, hq.score as x_score
      from readable_questions hq order by hq.score desc
      limit greatest(p_q_limit, 0)) sub), '[]'::jsonb)
);
$$;

comment on function public.search_content(jsonb, uuid, uuid, integer, integer, integer, boolean) is
  'Learner-facing content search. AND across tokens, OR within a token. Question text is returned ONLY for sets the caller can access; locked matches are reduced to a per-course count.';

create or replace function public.ask_material(
  p_tokens     jsonb,
  p_limit      integer default 14,
  p_min_tokens integer default null
)
returns jsonb
language sql
stable
security invoker
set search_path to 'public'
as $$
with
params as (
  select
    coalesce(jsonb_array_length(p_tokens), 0) as token_count,
    -- Callers step this down when a strict match finds nothing, so a wordy
    -- question degrades gracefully instead of returning silence. Measured on
    -- "सबैभन्दा ठुलो र सानो": 3 tokens = 0 rows, 2 = 99 good, 1 = 1,572 junk.
    least(
      coalesce(p_min_tokens, coalesce(jsonb_array_length(p_tokens), 0)),
      coalesce(jsonb_array_length(p_tokens), 0)
    ) as needed,
    coalesce((
      select array_agg('%' || v || '%')
        from jsonb_array_elements(coalesce(p_tokens, '[]'::jsonb)) tok,
             jsonb_array_elements_text(tok) v
    ), array[]::text[]) as patterns
),
scored as (
  select
    q.id, q.content, q.option_a, q.option_b, q.option_c, q.option_d,
    q.correct_option, q.explanation,
    -- A past-paper claim needs BOTH a year and a reference naming the exam.
    -- 1,537 questions carry an empty-string paper_ref and 35 hold explanation
    -- prose from a bad import; a model set or compilation is a SOURCE, not an
    -- exam, and saying otherwise misleads a candidate about what gets asked.
    (q.exam_year is not null and btrim(coalesce(q.paper_ref, '')) <> '') as is_past_paper,
    case when q.exam_year is not null and btrim(coalesce(q.paper_ref, '')) <> ''
         then q.exam_year end as exam_year,
    case when q.exam_year is not null and btrim(coalesce(q.paper_ref, '')) <> ''
         then q.paper_ref end as paper_ref,
    qs.id as set_id, qs.title as set_title,
    t.id as topic_id, t.name as topic_name, st.name as subtopic_name,
    s.id as subject_id, s.name_np as subject_name_np,
    m.id as module_id, m.name as module_name,
    public.has_set_access(qs.id, m.id) as accessible,
    public.dp_tokens_matched(concat_ws(' ', q.content, q.explanation), p_tokens) as tokens_hit,
    public.dp_tokens_matched(q.content, p_tokens) * 3
      + public.dp_tokens_matched(q.explanation, p_tokens) as score
  from questions q
  join question_set_questions qsq on qsq.question_id = q.id
  join question_sets qs on qs.id = qsq.question_set_id
  join topics    t on t.id = qs.topic_id
  join subjects  s on s.id = t.subject_id
  join modules   m on m.id = s.module_id
  left join subtopics st on st.id = qs.subtopic_id
  cross join params pp
  where pp.token_count > 0
    and (q.content ilike any (pp.patterns) or q.explanation ilike any (pp.patterns))
),
matched as (select * from scored where tokens_hit >= (select needed from params)),
-- Only material the learner may read is eligible to enter the AI prompt.
readable as (select * from matched where accessible),
-- Deduped before the limit: the same stem is often filed in several sets, and
-- repeats would spend the lesson's material budget on facts it already has.
distinct_readable as (
  select distinct on (btrim(content)) *
    from readable
   order by btrim(content), tokens_hit desc, score desc
),
returned as (
  select * from distinct_readable
   order by tokens_hit desc, score desc
   limit greatest(p_limit, 0)
),
locked_sets as (
  select set_id as id, set_title as title, module_name, count(*)::int as match_count
    from matched where not accessible
   group by set_id, set_title, module_name
   order by count(*) desc limit 3
)
select jsonb_build_object(
  'total_matched', (select count(*) from readable),
  'locked_count',  (select count(*) from matched where not accessible),
  'tokens_required', (select needed from params),
  'questions', coalesce((
    select jsonb_agg(to_jsonb(r) - 'tokens_hit' - 'score' - 'accessible'
                     order by r.tokens_hit desc, r.score desc)
      from returned r), '[]'::jsonb),
  'locked_sets', coalesce((select jsonb_agg(to_jsonb(l)) from locked_sets l), '[]'::jsonb),
  'topics', coalesce((
    select jsonb_agg(distinct jsonb_build_object('id', topic_id, 'name', topic_name))
      from returned), '[]'::jsonb),
  'has_paper_ref', coalesce((select bool_or(is_past_paper) from returned), false)
);
$$;

comment on function public.ask_material(jsonb, integer, integer) is
  'Gathers readable question material for one AI lesson. Locked content never returns bodies. Past-paper flags require both exam_year and a non-blank reference.';

grant execute on function public.search_content(jsonb, uuid, uuid, integer, integer, integer, boolean) to anon, authenticated;
grant execute on function public.ask_material(jsonb, integer, integer) to authenticated;
