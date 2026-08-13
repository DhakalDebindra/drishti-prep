-- Phase B: "Chat with DrishtiPrep AI".
--
-- The AI answers ONLY from DrishtiPrep content. This migration provides the two
-- halves of that: storage for the conversation, and the query that gathers the
-- material a lesson may be built from.
--
-- The material query is where the access rule is enforced. Locked question
-- bodies are never returned, so they can never reach the model's prompt — a
-- prompt instruction is not access control.

create table if not exists public.ask_threads (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid        not null references auth.users(id) on delete cascade,
  title           text        not null,
  created_at      timestamptz not null default now(),
  last_message_at timestamptz not null default now()
);

create index if not exists idx_ask_threads_user
  on public.ask_threads (user_id, last_message_at desc);

create table if not exists public.ask_messages (
  id         uuid primary key default gen_random_uuid(),
  thread_id  uuid        not null references public.ask_threads(id) on delete cascade,
  role       text        not null check (role in ('user', 'assistant')),
  -- Plain text for a user turn; the rendered lesson text for an assistant turn.
  content    text        not null,
  -- Which sections were emitted, in order, with their bodies. Sections are
  -- decided in application code from the retrieved material — never by the
  -- model — so a heading it has no sources for is never offered to it.
  sections   jsonb       not null default '[]',
  sources    jsonb       not null default '[]',
  route      text,       -- 'lesson' | 'insufficient' | 'error'
  created_at timestamptz not null default now()
);

create index if not exists idx_ask_messages_thread
  on public.ask_messages (thread_id, created_at);

create table if not exists public.ask_recommendations (
  id         uuid primary key default gen_random_uuid(),
  message_id uuid        not null references public.ask_messages(id) on delete cascade,
  set_id     uuid        not null references public.question_sets(id) on delete cascade,
  rank       smallint    not null,
  is_locked  boolean     not null default false,
  opened     boolean     not null default false,
  created_at timestamptz not null default now()
);

create index if not exists idx_ask_recommendations_message
  on public.ask_recommendations (message_id, rank);

alter table public.ask_threads          enable row level security;
alter table public.ask_messages         enable row level security;
alter table public.ask_recommendations  enable row level security;

-- A learner's conversations are their own. RLS is the gate: the API routes use
-- the anon key plus the caller's cookies, so these policies are what actually
-- enforce ownership.
drop policy if exists "Own ask threads" on public.ask_threads;
create policy "Own ask threads" on public.ask_threads
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "Own ask messages" on public.ask_messages;
create policy "Own ask messages" on public.ask_messages
  for all using (
    exists (select 1 from public.ask_threads t
             where t.id = thread_id and t.user_id = auth.uid())
  ) with check (
    exists (select 1 from public.ask_threads t
             where t.id = thread_id and t.user_id = auth.uid())
  );

drop policy if exists "Own ask recommendations" on public.ask_recommendations;
create policy "Own ask recommendations" on public.ask_recommendations
  for all using (
    exists (select 1 from public.ask_messages m
             join public.ask_threads t on t.id = m.thread_id
            where m.id = message_id and t.user_id = auth.uid())
  ) with check (
    exists (select 1 from public.ask_messages m
             join public.ask_threads t on t.id = m.thread_id
            where m.id = message_id and t.user_id = auth.uid())
  );

-- Material for one lesson.
--
-- Returns the full text of matching questions the caller may actually read,
-- plus metadata the section gates need (paper_ref / exam_year decide whether a
-- past-paper section is even offered to the model). Locked sets come back as
-- titles and counts only — never bodies.
create or replace function public.ask_material(
  p_tokens jsonb,
  p_limit  integer default 14
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
    coalesce((
      select array_agg('%' || v || '%')
        from jsonb_array_elements(coalesce(p_tokens, '[]'::jsonb)) tok,
             jsonb_array_elements_text(tok) v
    ), array[]::text[]) as patterns
),
scored as (
  select
    q.id,
    q.content,
    q.option_a, q.option_b, q.option_c, q.option_d,
    q.correct_option,
    q.explanation,
    q.exam_year,
    q.paper_ref,
    qs.id     as set_id,
    qs.title  as set_title,
    t.id      as topic_id,
    t.name    as topic_name,
    st.name   as subtopic_name,
    s.id      as subject_id,
    s.name_np as subject_name_np,
    m.id      as module_id,
    m.name    as module_name,
    public.has_module_access(m.id) as accessible,
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
    and (q.content     ilike any (pp.patterns)
      or q.explanation ilike any (pp.patterns))
),
matched as (
  select * from scored where tokens_hit >= (select token_count from params)
),
-- Only material the learner may read is eligible to enter the prompt.
readable as (
  select * from matched where accessible
),
locked_sets as (
  select set_id as id, set_title as title, module_name, count(*)::int as match_count
    from matched
   where not accessible
   group by set_id, set_title, module_name
   order by count(*) desc
   limit 3
)
select jsonb_build_object(
  'total_matched', (select count(*) from readable),
  'locked_count',  (select count(*) from matched where not accessible),
  'questions', coalesce((
    select jsonb_agg(to_jsonb(r) - 'tokens_hit' - 'score' - 'accessible' order by r.score desc)
      from (select * from readable order by score desc limit greatest(p_limit, 0)) r
  ), '[]'::jsonb),
  'locked_sets', coalesce((select jsonb_agg(to_jsonb(l)) from locked_sets l), '[]'::jsonb),
  'topics', coalesce((
    select jsonb_agg(distinct jsonb_build_object('id', topic_id, 'name', topic_name))
      from readable
  ), '[]'::jsonb),
  -- Whether a past-paper section may be offered at all. Only ~1.5% of questions
  -- carry exam_year and ~13% carry paper_ref, so this gate is usually false —
  -- which is exactly why the model must never be handed that heading blind.
  'has_paper_ref', coalesce((
    select bool_or(paper_ref is not null or exam_year is not null) from readable
  ), false)
);
$$;

comment on function public.ask_material(jsonb, integer) is
  'Gathers readable question material for one AI lesson. Locked content is returned as titles and counts only, never bodies, so it cannot reach the prompt.';

grant execute on function public.ask_material(jsonb, integer) to authenticated;
