alter table public.letters
  add column if not exists paper_size text not null default 'a4';

alter table public.letters
  drop constraint if exists letters_paper_size_check;

alter table public.letters
  add constraint letters_paper_size_check
  check (paper_size in ('a4', 'f4', 'letter', 'legal'));
