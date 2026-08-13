-- Learner-facing content search (Phase A: no embeddings, no AI).
--
-- Nepali inflection is suffixal, so a substring match on a trimmed stem finds
-- the inflected forms too: '%संविधान%' matches संविधानको, संविधानमा, संविधानले.
-- lib/search/normalize.ts trims the suffixes and passes TOKENS, where each
-- token is the list of its acceptable spellings:
--
--   "नेपालको भूगोल"  ->  [["नेपालको","नेपाल"], ["भूगोल"]]
--
-- Matching is AND across tokens, OR within a token's variants. That ordering
-- matters: with plain OR across terms, "नेपाल" alone matches nearly every row
-- on a Nepali exam platform, so "नेपालको भूगोल" returned 155 sets including
-- history-of-education material. Requiring every token collapses that to the
-- 27 sets that are actually about both words.
--
-- A set is a hit either because its own text matches (title/subtopic/topic/
-- subject) or because it CONTAINS matching questions. Without the second rule
-- "सगरमाथा" returned 125 questions and zero sets, because no set is titled
-- सगरमाथा — hiding the very set the learner wanted.
--
-- Access: content tables are world-readable (SELECT USING (true)), so the
-- free/locked decision is NOT made by RLS. It is computed here from
-- has_module_access(), the same rule the rest of the app uses.

create extension if not exists pg_trgm;

-- Trigram indexes turn the `ilike '%term%'` prefilters below into index lookups.
create index if not exists idx_questions_content_trgm
  on public.questions using gin (content gin_trgm_ops);
create index if not exists idx_questions_explanation_trgm
  on public.questions using gin (explanation gin_trgm_ops);
create index if not exists idx_question_sets_title_trgm
  on public.question_sets using gin (title gin_trgm_ops);
create index if not exists idx_subjects_name_trgm
  on public.subjects using gin (name gin_trgm_ops);
create index if not exists idx_subjects_name_np_trgm
  on public.subjects using gin (name_np gin_trgm_ops);
create index if not exists idx_topics_name_trgm
  on public.topics using gin (name gin_trgm_ops);
create index if not exists idx_subtopics_name_trgm
  on public.subtopics using gin (name gin_trgm_ops);
create index if not exists idx_subtopics_name_np_trgm
  on public.subtopics using gin (name_np gin_trgm_ops);

drop function if exists public.dp_term_score(text, text[]);
drop function if exists public.search_content(text[], uuid, uuid, integer, integer, integer);

-- How many of the query's tokens appear in this text. A token counts as present
-- if ANY of its spellings does, so the inflected form and the trimmed stem are
-- interchangeable rather than double-counted.
create or replace function public.dp_tokens_matched(p_text text, p_tokens jsonb)
returns integer
language sql
immutable
parallel safe
as $$
  select coalesce((
    select count(*)::int
      from jsonb_array_elements(p_tokens) as tok
     where p_text is not null
       and exists (
         select 1 from jsonb_array_elements_text(tok) as variant
          where p_text ilike '%' || variant || '%'
       )
  ), 0);
$$;

comment on function public.dp_tokens_matched(text, jsonb) is
  'Counts query tokens present in the text; a token matches if any of its spellings does.';

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
    -- AND mode needs every token; relaxed mode needs just one.
    case when p_require_all
         then coalesce(jsonb_array_length(p_tokens), 0)
         else 1 end as needed,
    -- Flattened spellings as LIKE patterns, for the cheap trigram prefilter
    -- on questions. Callers escape % and _ before passing tokens in.
    coalesce((
      select array_agg('%' || v || '%')
        from jsonb_array_elements(coalesce(p_tokens, '[]'::jsonb)) tok,
             jsonb_array_elements_text(tok) v
    ), array[]::text[]) as patterns
),
set_counts as (
  select question_set_id as set_id, count(*)::int as q_count
    from question_set_questions
   group by question_set_id
),
scored_questions as (
  select
    q.id,
    q.content,
    qs.id     as set_id,
    qs.title  as set_title,
    t.name    as topic_name,
    s.name_np as subject_name_np,
    not public.has_module_access(m.id) as locked,
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
    -- Cheap trigram prefilter first; the exact AND gate is applied below.
    and (q.content     ilike any (pp.patterns)
      or q.explanation ilike any (pp.patterns))
),
hit_questions as (
  select * from scored_questions where tokens_hit >= (select needed from params)
),
-- Coverage: how many matching questions each set holds.
q_by_set as (
  select set_id, count(*)::int as match_count
    from hit_questions
   group by set_id
),
scored_sets as (
  select
    qs.id,
    qs.title,
    st.name        as subtopic_name,
    st.name_np     as subtopic_name_np,
    st.slug        as subtopic_slug,
    t.id           as topic_id,
    t.name         as topic_name,
    t.slug         as topic_slug,
    s.id           as subject_id,
    s.name         as subject_name,
    s.name_np      as subject_name_np,
    s.slug         as subject_slug,
    m.id           as module_id,
    m.name         as module_name,
    m.slug         as module_slug,
    coalesce(sc.q_count, 0)  as q_count,
    coalesce(qm.match_count, 0) as match_count,
    not public.has_module_access(m.id) as locked,
    -- Tokens found anywhere in this set's own text, for the AND gate.
    public.dp_tokens_matched(
      concat_ws(' ', qs.title, st.name, st.name_np, t.name, s.name, s.name_np),
      p_tokens) as tokens_hit,
    -- A set actually named for the query beats one that merely sits under a
    -- matching topic, which beats one that only shares a subject. Question
    -- coverage is capped so a big set cannot outrank an exact title match.
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
  select * from scored_sets
   where tokens_hit >= (select needed from params)
      or match_count > 0
),
scored_topics as (
  select
    t.id,
    t.name,
    t.slug    as topic_slug,
    t.display_order,
    s.id      as subject_id,
    s.name    as subject_name,
    s.name_np as subject_name_np,
    s.slug    as subject_slug,
    m.slug    as module_slug,
    public.dp_tokens_matched(
      concat_ws(' ', t.name, s.name, s.name_np), p_tokens) as tokens_hit,
    (select count(*)::int from question_sets qs where qs.topic_id = t.id) as set_count,
    (select coalesce(sum(sc2.q_count), 0)::int
       from question_sets qs2
       left join set_counts sc2 on sc2.set_id = qs2.id
      where qs2.topic_id = t.id) as q_count
  from topics t
  join subjects s on s.id = t.subject_id
  join modules  m on m.id = s.module_id
  where (select token_count from params) > 0
    and (p_subject_id is null or s.id = p_subject_id)
    and (p_topic_id   is null or t.id = p_topic_id)
),
matched_topics as (
  -- An empty topic is never a useful destination, however well it matches.
  select * from scored_topics
   where tokens_hit >= (select needed from params)
     and set_count > 0
),
matched_subjects as (
  select
    s.id, s.name, s.name_np, s.slug, s.syllabus_ref,
    public.dp_tokens_matched(concat_ws(' ', s.name, s.name_np), p_tokens) as tokens_hit
  from subjects s
  where (select token_count from params) > 0
    and public.dp_tokens_matched(concat_ws(' ', s.name, s.name_np), p_tokens)
        >= (select needed from params)
    and (p_subject_id is null or s.id = p_subject_id)
)
select jsonb_build_object(
  'counts', jsonb_build_object(
    'subjects',  (select count(*) from matched_subjects),
    'topics',    (select count(*) from matched_topics),
    'sets',      (select count(*) from hit_sets),
    'questions', (select count(*) from hit_questions)
  ),
  'subjects', coalesce((
    select jsonb_agg(x order by x_hit desc)
    from (
      select to_jsonb(ms) - 'tokens_hit' as x, ms.tokens_hit as x_hit
      from matched_subjects ms
      order by ms.tokens_hit desc
      limit 3
    ) sub
  ), '[]'::jsonb),
  'topics', coalesce((
    select jsonb_agg(x order by x_order)
    from (
      select to_jsonb(mt) - 'tokens_hit' as x, mt.display_order as x_order
      from matched_topics mt
      order by mt.display_order
      limit 20
    ) sub
  ), '[]'::jsonb),
  'sets', coalesce((
    select jsonb_agg(x order by x_score desc, x_title)
    from (
      select (to_jsonb(hs) - 'tokens_hit') - 'score' as x,
             hs.score as x_score, hs.title as x_title
      from hit_sets hs
      order by hs.score desc, hs.title
      limit  greatest(p_set_limit, 0)
      offset greatest(p_set_offset, 0)
    ) sub
  ), '[]'::jsonb),
  'questions', coalesce((
    select jsonb_agg(x order by x_score desc)
    from (
      select (to_jsonb(hq) - 'tokens_hit') - 'score' as x, hq.score as x_score
      from hit_questions hq
      order by hq.score desc
      limit greatest(p_q_limit, 0)
    ) sub
  ), '[]'::jsonb)
);
$$;

comment on function public.search_content(jsonb, uuid, uuid, integer, integer, integer, boolean) is
  'Learner-facing content search. Takes normalised Nepali tokens (each token a list of spellings), '
  'matches AND across tokens / OR within a token, and returns grouped, scored, access-aware '
  'results as JSON in a single round trip. p_require_all=false relaxes to OR for the retry pass.';

grant execute on function public.dp_tokens_matched(text, jsonb) to anon, authenticated;
grant execute on function public.search_content(jsonb, uuid, uuid, integer, integer, integer, boolean) to anon, authenticated;
