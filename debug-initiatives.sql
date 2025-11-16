-- =====================================================
-- DEBUG: Check why initiatives don't appear
-- =====================================================

-- 1. Check if initiatives exist
SELECT 
  'Total initiatives' as info,
  COUNT(*) as count 
FROM public.initiatives;

-- 2. Check a sample initiative with county info
SELECT 
  i.id,
  i.title,
  i.category,
  i.status,
  i.location,
  c.name as county_name,
  c.id as county_id
FROM public.initiatives i
JOIN public.counties c ON i.county_id = c.id
LIMIT 5;

-- 3. Check RLS policies on initiatives
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies 
WHERE tablename = 'initiatives';

-- 4. Try the exact query the app uses (replace 'Cluj' with your county)
SELECT 
  i.*,
  c.name,
  c.cnp_code
FROM public.initiatives i
INNER JOIN public.counties c ON i.county_id = c.id
WHERE i.status = 'active' 
  AND c.name = 'Cluj'  -- Change this to your county
ORDER BY i.created_at DESC;

-- =====================================================
