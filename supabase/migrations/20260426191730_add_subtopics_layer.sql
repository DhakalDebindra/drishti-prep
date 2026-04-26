begin;

-- New subtopics table
create table if not exists public.subtopics (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics(id) on delete cascade,
  name text not null,
  name_np text,
  slug text not null,
  description text,
  display_order int not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(topic_id, slug)
);

-- Add nullable subtopic_id to question_sets
alter table public.question_sets
  add column if not exists subtopic_id uuid references public.subtopics(id) on delete set null;

-- Indexes
create index if not exists idx_subtopics_topic_id on public.subtopics(topic_id);
create index if not exists idx_subtopics_display_order on public.subtopics(topic_id, display_order);
create index if not exists idx_question_sets_subtopic_id on public.question_sets(subtopic_id);

-- RLS
alter table public.subtopics enable row level security;

-- Public can read all subtopics
drop policy if exists "Public select subtopics" on public.subtopics;
create policy "Public select subtopics"
on public.subtopics for select
to public
using (true);

-- Admins can insert
drop policy if exists "Admins insert subtopics" on public.subtopics;
create policy "Admins insert subtopics"
on public.subtopics for insert
to public
with check (public.is_admin());

-- Admins can update
drop policy if exists "Admins update subtopics" on public.subtopics;
create policy "Admins update subtopics"
on public.subtopics for update
to public
using (public.is_admin())
with check (public.is_admin());

-- Admins can delete
drop policy if exists "Admins delete subtopics" on public.subtopics;
create policy "Admins delete subtopics"
on public.subtopics for delete
to public
using (public.is_admin());

commit;
