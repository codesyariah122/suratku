alter table public.letters add column if not exists font_size smallint not null default 11;
alter table public.letters add column if not exists line_height numeric(3,2) not null default 1.50;
alter table public.letters add column if not exists paragraph_spacing numeric(3,2) not null default 0.75;
alter table public.letters add column if not exists signature_url text;
alter table public.letters add column if not exists stamp_url text;
alter table public.letters add column if not exists show_signature boolean not null default true;
alter table public.letters add column if not exists signature_size smallint not null default 100;

create table if not exists public.letter_versions (
  id uuid primary key default gen_random_uuid(),
  letter_id uuid not null references public.letters(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  label text,
  snapshot jsonb not null,
  created_at timestamptz not null default now()
);

create index if not exists letter_versions_letter_created_idx
  on public.letter_versions(letter_id, created_at desc);

alter table public.letter_versions enable row level security;

drop policy if exists "letter_versions_select_own" on public.letter_versions;
drop policy if exists "letter_versions_insert_own" on public.letter_versions;
drop policy if exists "letter_versions_delete_own" on public.letter_versions;

create policy "letter_versions_select_own" on public.letter_versions
  for select using (auth.uid() = user_id);
create policy "letter_versions_insert_own" on public.letter_versions
  for insert with check (auth.uid() = user_id);
create policy "letter_versions_delete_own" on public.letter_versions
  for delete using (auth.uid() = user_id);
