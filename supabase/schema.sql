-- Run this entire file in Supabase > SQL Editor > New query.
create extension if not exists pgcrypto;

create table if not exists public.inventory_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  category text not null check (category in ('Ferragens','Alumínios','Parafusos','Matérias')),
  qty integer not null default 0 check (qty >= 0),
  min_qty integer not null default 0 check (min_qty >= 0),
  notes text not null default '',
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique(user_id, name, category)
);

create table if not exists public.stock_movements (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  product_id uuid,
  product_name text not null,
  movement_type text not null check (movement_type in ('Entrada','Saída','Ajuste','Cadastro')),
  quantity integer not null,
  created_at timestamptz not null default now()
);

alter table public.inventory_items enable row level security;
alter table public.stock_movements enable row level security;

drop policy if exists "Users manage their own inventory" on public.inventory_items;
create policy "Users manage their own inventory"
on public.inventory_items for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users manage their own movements" on public.stock_movements;
create policy "Users manage their own movements"
on public.stock_movements for all
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Enable realtime notifications for inventory changes and movement history.
do $$
begin
  alter publication supabase_realtime add table public.inventory_items;
exception when duplicate_object then null;
end $$;

do $$
begin
  alter publication supabase_realtime add table public.stock_movements;
exception when duplicate_object then null;
end $$;
