-- Profil perusahaan yang dipakai untuk kop surat dan penandatangan default.
alter table public.profiles add column if not exists company_email text;
alter table public.profiles add column if not exists company_city text;
alter table public.profiles add column if not exists signer_name text;
alter table public.profiles add column if not exists signer_title text;

-- Salinan identitas kop disimpan per surat agar surat lama tidak berubah saat profil diperbarui.
alter table public.letters add column if not exists header_company text;
alter table public.letters add column if not exists header_details text;
alter table public.letters add column if not exists letter_city text;
