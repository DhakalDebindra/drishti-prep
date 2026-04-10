-- Enable RLS and add policies for core content tables

-- Subjects
alter table public.subjects enable row level security;

do $$
begin
  create policy "Public select subjects"
    on public.subjects
    for select
    using (true);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins insert subjects"
    on public.subjects
    for insert
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins update subjects"
    on public.subjects
    for update
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    )
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins delete subjects"
    on public.subjects
    for delete
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

-- Topics
alter table public.topics enable row level security;

do $$
begin
  create policy "Public select topics"
    on public.topics
    for select
    using (true);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins insert topics"
    on public.topics
    for insert
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins update topics"
    on public.topics
    for update
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    )
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins delete topics"
    on public.topics
    for delete
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

-- Question sets
alter table public.question_sets enable row level security;

do $$
begin
  create policy "Public select question_sets"
    on public.question_sets
    for select
    using (true);
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins insert question_sets"
    on public.question_sets
    for insert
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins update question_sets"
    on public.question_sets
    for update
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    )
    with check (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;

do $$
begin
  create policy "Admins delete question_sets"
    on public.question_sets
    for delete
    using (
      exists (select 1 from public.profiles where id = auth.uid() and is_admin = true)
    );
exception
  when duplicate_object then null;
end $$;
