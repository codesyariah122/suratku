-- Sinkronisasi schema untuk instalasi SuratKu yang memakai versi tabel lama.
-- Aman dijalankan berulang kali melalui Supabase SQL Editor.

alter table public.profiles add column if not exists full_name text;
alter table public.profiles add column if not exists company_name text;
alter table public.profiles add column if not exists company_address text;
alter table public.profiles add column if not exists company_phone text;
alter table public.profiles add column if not exists company_email text;
alter table public.profiles add column if not exists company_city text;
alter table public.profiles add column if not exists signer_name text;
alter table public.profiles add column if not exists signer_title text;
alter table public.profiles add column if not exists logo_url text;
alter table public.profiles add column if not exists updated_at timestamptz not null default now();

alter table public.letters add column if not exists logo_url text;
alter table public.letters add column if not exists header_company text;
alter table public.letters add column if not exists header_details text;
alter table public.letters add column if not exists letter_city text;
alter table public.letters add column if not exists font_family text not null default 'Lora';

-- Meminta PostgREST memuat ulang cache schema setelah kolom ditambahkan.
notify pgrst, 'reload schema';
