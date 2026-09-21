-- Giveaway entries
create table public.giveaway_entries (
  id bigint generated always as identity primary key,
  full_name text not null,
  email text not null,
  created_at timestamptz default now()
);

-- Prevent public visitors from reading the participant list
alter table public.giveaway_entries enable row level security;

-- Allow visitors to submit an entry
create policy "Anyone can submit giveaway entry"
on public.giveaway_entries
for insert
to anon
with check (
  length(full_name) between 2 and 100
  and length(email) between 5 and 254
);

-- Do NOT create a public SELECT policy.
-- Participant information must remain private.
