-- Execute uma vez no Supabase > SQL Editor > New query.
-- Libera a nova categoria Parafusos e mantém apenas as categorias atuais.
alter table public.inventory_items
  drop constraint if exists inventory_items_category_check;

alter table public.inventory_items
  add constraint inventory_items_category_check
  check (category in ('Ferragens','Pistões','Parafusos'));
