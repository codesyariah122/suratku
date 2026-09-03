alter table public.profiles add column if not exists logo_url text;
alter table public.letters add column if not exists font_family text not null default 'Lora';
alter table public.letters add column if not exists logo_url text;

create table if not exists public.letter_templates (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  category text not null default 'custom',
  subject text,
  body text,
  closing text,
  font_family text not null default 'Lora',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.letter_templates enable row level security;
create policy "templates_select_own" on public.letter_templates for select using (auth.uid() = user_id);
create policy "templates_insert_own" on public.letter_templates for insert with check (auth.uid() = user_id);
create policy "templates_update_own" on public.letter_templates for update using (auth.uid() = user_id);
create policy "templates_delete_own" on public.letter_templates for delete using (auth.uid() = user_id);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('company-assets', 'company-assets', true, 2097152, array['image/png','image/jpeg','image/webp','image/svg+xml'])
on conflict (id) do nothing;
create policy "company_assets_public_read" on storage.objects for select using (bucket_id = 'company-assets');
create policy "company_assets_insert_own" on storage.objects for insert to authenticated
with check (bucket_id = 'company-assets' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "company_assets_update_own" on storage.objects for update to authenticated
using (bucket_id = 'company-assets' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "company_assets_delete_own" on storage.objects for delete to authenticated
using (bucket_id = 'company-assets' and (storage.foldername(name))[1] = auth.uid()::text);
