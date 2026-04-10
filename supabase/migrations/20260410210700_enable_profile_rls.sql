-- Enable Row Level Security on profiles and allow users to read their own row
alter table public.profiles enable row level security;

create policy "Profiles can select own row"
  on public.profiles
  for select
  using (auth.uid() = id);
