-- =====================================================
-- DISABLE RLS ON PROFILES - Simple fix for signup
-- =====================================================

-- Disable RLS on profiles table to allow signup
ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;

-- =====================================================
-- PROFILES RLS DISABLED - Signups will now work
-- =====================================================
