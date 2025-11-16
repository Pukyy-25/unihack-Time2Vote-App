-- Drop all RLS policies first
DROP POLICY IF EXISTS initiatives_public_read ON public.initiatives CASCADE;
DROP POLICY IF EXISTS initiatives_admin_county_access ON public.initiatives CASCADE;
DROP POLICY IF EXISTS votes_public_read ON public.votes CASCADE;
DROP POLICY IF EXISTS votes_admin_county_access ON public.votes CASCADE;
DROP POLICY IF EXISTS votes_user_own ON public.votes CASCADE;
DROP POLICY IF EXISTS profiles_public_read ON public.profiles CASCADE;
DROP POLICY IF EXISTS profiles_admin_county_access ON public.profiles CASCADE;
DROP POLICY IF EXISTS profiles_user_own ON public.profiles CASCADE;

-- Disable RLS on all tables
ALTER TABLE public.initiatives DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.votes DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;
