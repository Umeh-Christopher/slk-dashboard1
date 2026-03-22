-- Run this in Supabase SQL Editor

-- Trades table
create table trades (
  id          uuid default gen_random_uuid() primary key,
  created_at  timestamp with time zone default now(),
  pair        text not null,
  direction   text not null check (direction in ('LONG', 'SHORT')),
  entry       numeric not null,
  sl          numeric not null,
  tp1         numeric not null,
  tp2         numeric not null,
  tp3         numeric not null,
  outcome     text check (outcome in ('TP1', 'TP2', 'TP3', 'SL')),
  r_result    numeric,
  trade_date  date not null,
  notes       text,
  screenshot  text
);

-- Allow public read
alter table trades enable row level security;
create policy "Public can read trades" on trades for select using (true);
create policy "Anyone can insert" on trades for insert with check (true);
create policy "Anyone can update" on trades for update using (true);

-- Storage bucket for screenshots
insert into storage.buckets (id, name, public) values ('screenshots', 'screenshots', true);
create policy "Public read screenshots" on storage.objects for select using (bucket_id = 'screenshots');
create policy "Anyone upload screenshots" on storage.objects for insert with check (bucket_id = 'screenshots');
