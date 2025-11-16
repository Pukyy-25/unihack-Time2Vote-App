-- =====================================================
-- MANUALLY VERIFY ALL USERS
-- Run this to confirm all existing user emails
-- =====================================================

-- Update all users to be verified (only set email_confirmed_at)
UPDATE auth.users 
SET email_confirmed_at = COALESCE(email_confirmed_at, now())
WHERE email_confirmed_at IS NULL;

-- Check the results
SELECT 
  email,
  email_confirmed_at,
  confirmed_at,
  CASE 
    WHEN email_confirmed_at IS NOT NULL THEN 'VERIFIED ✓'
    ELSE 'NOT VERIFIED'
  END as status
FROM auth.users
ORDER BY created_at DESC;

-- =====================================================
-- ALL USERS VERIFIED!
-- =====================================================
