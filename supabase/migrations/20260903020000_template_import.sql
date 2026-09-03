alter table public.letter_templates add column if not exists content_html text;
alter table public.letter_templates add column if not exists source_filename text;
alter table public.letter_templates add column if not exists variables jsonb not null default '[]'::jsonb;
