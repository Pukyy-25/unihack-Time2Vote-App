-- =====================================================
-- CHECK EMAIL CONFIRMATION STATUS
-- Run this to see user email verification status
-- =====================================================

-- View all users and their email confirmation status
SELECT 
  id,
  email,
  email_confirmed_at,
  confirmed_at,
  created_at,
  CASE 
    WHEN email_confirmed_at IS NOT NULL THEN 'VERIFIED'
    ELSE 'NOT VERIFIED'
  END as status
FROM auth.users
ORDER BY created_at DESC;

-- =====================================================
-- If you want to manually verify a specific user:
-- UPDATE auth.users 
-- SET email_confirmed_at = now(), confirmed_at = now()
-- WHERE email = 'user@example.com';
-- =====================================================
