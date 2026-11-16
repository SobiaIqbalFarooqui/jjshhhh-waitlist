-- jjshhhh waiting list: run once in Supabase → SQL Editor.
-- Safe to re-run: every statement checks before it creates.

create table if not exists public.emails (
  id          bigint generated always as identity primary key,
  email       text not null,
  created_at  timestamptz not null default now()
);

-- One row per address (lower-cased by the page before sending).
-- A repeat sign-up returns HTTP 409, which the page treats as "you're already on the list".
create unique index if not exists emails_email_key on public.emails (lower(email));

-- Basic sanity check so the table can't fill with junk.
do $$ begin
  alter table public.emails add constraint emails_email_format
    check (email ~* '^[^\s@]+@[^\s@]+\.[^\s@]{2,}$' and length(email) <= 320);
exception when duplicate_object then null; end $$;

-- Row-level security: the public (anon) key may only INSERT. Nobody can read the list from the browser.
alter table public.emails enable row level security;

drop policy if exists "anon can join waitlist" on public.emails;
create policy "anon can join waitlist" on public.emails
  for insert to anon
  with check (true);

-- To see sign-ups: Supabase dashboard → Table Editor → emails (or export as CSV from there).
