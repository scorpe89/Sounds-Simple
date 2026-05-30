create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  username text unique,
  display_name text,
  created_at timestamptz not null default now()
);

create table if not exists public.friends (
  id uuid primary key default gen_random_uuid(),
  requester_id uuid not null references auth.users(id) on delete cascade,
  addressee_id uuid not null references auth.users(id) on delete cascade,
  status text not null default 'pending' check (status in ('pending', 'accepted', 'blocked')),
  created_at timestamptz not null default now(),
  unique (requester_id, addressee_id)
);

create table if not exists public.shared_playlists (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  recipient_id uuid references auth.users(id) on delete cascade,
  name text not null,
  manifest jsonb not null,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.friends enable row level security;
alter table public.shared_playlists enable row level security;

create policy "Users can read their own profile"
on public.profiles for select
using (auth.uid() = id);

create policy "Users can update their own profile"
on public.profiles for update
using (auth.uid() = id);

create policy "Users can insert their own profile"
on public.profiles for insert
with check (auth.uid() = id);

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, username, display_name)
  values (
    new.id,
    new.email,
    nullif(new.raw_user_meta_data ->> 'username', ''),
    nullif(new.raw_user_meta_data ->> 'display_name', '')
  )
  on conflict (id) do update
  set
    email = excluded.email,
    username = excluded.username,
    display_name = excluded.display_name;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

create policy "Users can read their friend rows"
on public.friends for select
using (auth.uid() = requester_id or auth.uid() = addressee_id);

create policy "Users can create friend requests"
on public.friends for insert
with check (auth.uid() = requester_id);

create policy "Users can update friend rows they are part of"
on public.friends for update
using (auth.uid() = requester_id or auth.uid() = addressee_id);

create policy "Users can read shared playlists they own or receive"
on public.shared_playlists for select
using (auth.uid() = owner_id or auth.uid() = recipient_id);

create policy "Users can share playlists they own"
on public.shared_playlists for insert
with check (auth.uid() = owner_id);

create policy "Users can delete shared playlists they own or receive"
on public.shared_playlists for delete
using (auth.uid() = owner_id or auth.uid() = recipient_id);
