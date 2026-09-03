-- Jalankan migration ini melalui Supabase SQL Editor sebelum memakai dashboard.
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  company_name text,
  company_address text,
  company_phone text,
  updated_at timestamptz not null default now()
);

create table if not exists public.letters (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  type text not null default 'resmi',
  subject text not null,
  letter_number text,
  letter_date date not null default current_date,
  attachment text,
  recipient_name text not null,
  recipient_title text,
  recipient_company text,
  recipient_address text,
  body text not null,
  closing text,
  sender_name text not null,
  sender_title text,
  status text not null default 'draft' check (status in ('draft', 'final')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.letters enable row level security;

create policy "profiles_select_own" on public.profiles for select using (auth.uid() = id);
create policy "profiles_insert_own" on public.profiles for insert with check (auth.uid() = id);
create policy "profiles_update_own" on public.profiles for update using (auth.uid() = id);
create policy "letters_select_own" on public.letters for select using (auth.uid() = user_id);
create policy "letters_insert_own" on public.letters for insert with check (auth.uid() = user_id);
create policy "letters_update_own" on public.letters for update using (auth.uid() = user_id);
create policy "letters_delete_own" on public.letters for delete using (auth.uid() = user_id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data ->> 'full_name', ''))
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
for each row execute procedure public.handle_new_user();
