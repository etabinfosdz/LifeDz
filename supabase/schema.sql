-- ============================================================
-- LifeDz — مخطط قاعدة البيانات (Supabase / PostgreSQL)
-- النسخة الأولى (MVP)
-- ============================================================

-- Extensions
create extension if not exists "uuid-ossp";

-- ----------------------------------------------------------
-- profiles : ملف المستخدم (مرتبط بـ auth.users)
-- ----------------------------------------------------------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  phone text,
  locale text default 'ar',
  created_at timestamptz default now()
);

-- ----------------------------------------------------------
-- family_groups : مجموعات العائلة
-- ----------------------------------------------------------
create table if not exists public.family_groups (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  owner_id uuid references auth.users(id) on delete cascade,
  created_at timestamptz default now()
);

create table if not exists public.family_members (
  id uuid primary key default uuid_generate_v4(),
  group_id uuid references public.family_groups(id) on delete cascade,
  user_id uuid references auth.users(id) on delete cascade,
  role text default 'member', -- owner | member | viewer
  display_name text,
  created_at timestamptz default now()
);

-- ----------------------------------------------------------
-- expense_categories : تصنيفات المصاريف
-- ----------------------------------------------------------
create table if not exists public.expense_categories (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  icon text,
  color text
);

-- ----------------------------------------------------------
-- expenses : المصاريف
-- ----------------------------------------------------------
create table if not exists public.expenses (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  group_id uuid references public.family_groups(id) on delete set null,
  amount numeric(12,2) not null check (amount >= 0),
  category text not null,
  note text,
  spent_at timestamptz default now(),
  created_at timestamptz default now()
);
create index if not exists idx_expenses_user_date on public.expenses(user_id, spent_at);

-- ----------------------------------------------------------
-- reminders : التذكيرات
-- ----------------------------------------------------------
create table if not exists public.reminders (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  group_id uuid references public.family_groups(id) on delete set null,
  title text not null,
  type text default 'general', -- general | medication | appointment | bill | task
  due_at timestamptz not null,
  repeat_rule text, -- none | daily | weekly | monthly
  is_done boolean default false,
  created_at timestamptz default now()
);
create index if not exists idx_reminders_user_due on public.reminders(user_id, due_at);

-- ----------------------------------------------------------
-- shopping_lists / shopping_items : المشتريات
-- ----------------------------------------------------------
create table if not exists public.shopping_lists (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  group_id uuid references public.family_groups(id) on delete set null,
  name text not null default 'قائمة البيت',
  created_at timestamptz default now()
);

create table if not exists public.shopping_items (
  id uuid primary key default uuid_generate_v4(),
  list_id uuid references public.shopping_lists(id) on delete cascade,
  name text not null,
  category text default 'أخرى',
  quantity int default 1,
  is_bought boolean default false,
  created_at timestamptz default now()
);

-- ----------------------------------------------------------
-- family_tasks : مهام العائلة
-- ----------------------------------------------------------
create table if not exists public.family_tasks (
  id uuid primary key default uuid_generate_v4(),
  group_id uuid references public.family_groups(id) on delete cascade,
  created_by uuid references auth.users(id) on delete set null,
  assignee_id uuid references auth.users(id) on delete set null,
  title text not null,
  category text default 'أخرى',
  due_at timestamptz,
  status text default 'todo', -- todo | doing | done
  note text,
  created_at timestamptz default now()
);

-- ----------------------------------------------------------
-- daily_summaries : الملخص اليومي الذكي
-- ----------------------------------------------------------
create table if not exists public.daily_summaries (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  summary_date date not null,
  payload jsonb not null default '{}',
  created_at timestamptz default now(),
  unique(user_id, summary_date)
);

-- ----------------------------------------------------------
-- settings : إعدادات المستخدم
-- ----------------------------------------------------------
create table if not exists public.settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  theme text default 'system', -- system | light | dark
  currency text default 'DZD',
  notifications_enabled boolean default true,
  updated_at timestamptz default now()
);

-- ============================================================
-- Row Level Security (RLS)
-- كل مستخدم يرى ويعدّل بياناته فقط
-- ============================================================
alter table public.profiles enable row level security;
alter table public.expenses enable row level security;
alter table public.reminders enable row level security;
alter table public.shopping_lists enable row level security;
alter table public.shopping_items enable row level security;
alter table public.family_groups enable row level security;
alter table public.family_members enable row level security;
alter table public.family_tasks enable row level security;
alter table public.daily_summaries enable row level security;
alter table public.settings enable row level security;
alter table public.expense_categories enable row level security;

-- Helper policies (user owns row)
create policy "own_profile" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

create policy "own_expenses" on public.expenses
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_reminders" on public.reminders
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_categories" on public.expense_categories
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_lists" on public.shopping_lists
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_list_items" on public.shopping_items
  for all using (
    exists (select 1 from public.shopping_lists l
            where l.id = shopping_items.list_id and l.user_id = auth.uid())
  );

create policy "own_summaries" on public.daily_summaries
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_settings" on public.settings
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own_family_groups" on public.family_groups
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "member_family_members" on public.family_members
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "member_family_tasks" on public.family_tasks
  for all using (
    auth.uid() = created_by or auth.uid() = assignee_id
  ) with check (auth.uid() = created_by);

-- ============================================================
-- Trigger: إنشاء profile تلقائياً عند التسجيل
-- ============================================================
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, new.raw_user_meta_data->>'full_name');
  insert into public.settings (user_id) values (new.id);
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
