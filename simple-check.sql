-- =====================================================
-- SIMPLE CHECK - Are initiatives in database?
-- =====================================================

-- 1. Count total initiatives
SELECT COUNT(*) as total FROM public.initiatives;

-- 2. Show first 5 initiatives with county names
SELECT 
  i.title,
  c.name as county_name,
  i.status,
  i.category
FROM public.initiatives i
JOIN public.counties c ON i.county_id = c.id
LIMIT 5;

-- 3. Check what county you selected in the app
-- Replace 'Your County Name' with what you see in the app
SELECT 
  i.*,
  c.name as county
FROM public.initiatives i
JOIN public.counties c ON i.county_id = c.id
WHERE c.name = 'Cluj'  -- CHANGE THIS to your county!
LIMIT 5;

-- =====================================================
