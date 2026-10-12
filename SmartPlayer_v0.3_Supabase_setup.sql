-- SmartPlayer v0.3: private cloud library
-- Run only inside your own Supabase project > SQL Editor.
-- The GitHub Pages frontend uses a publishable (anon) key, NEVER the service_role/secret key.
create table if not exists public.smartplayer_libraries (
  user_id uuid primary key references auth.users(id) on delete cascade,
  songs jsonb not null default '{"songs":[],"tombstones":[]}'::jsonb,
  revision bigint not null default 1,
  updated_at timestamptz not null default now(),
  constraint smartplayer_libraries_songs_is_object check (jsonb_typeof(songs) = 'object')
);
alter table public.smartplayer_libraries enable row level security;
drop policy if exists "Read only own library" on public.smartplayer_libraries;
create policy "Read only own library" on public.smartplayer_libraries
  for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Insert only own library" on public.smartplayer_libraries;
create policy "Insert only own library" on public.smartplayer_libraries
  for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Update only own library" on public.smartplayer_libraries;
create policy "Update only own library" on public.smartplayer_libraries
  for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
revoke all on table public.smartplayer_libraries from anon;
grant select, insert, update on table public.smartplayer_libraries to authenticated;
-- No public policy exists. An unauthenticated visitor cannot read/write the library.
-- In Supabase Dashboard > Authentication > Providers > Email, keep email confirmation enabled.
-- Optional: turn off "Allow new users to sign up" after creating the personal account.
