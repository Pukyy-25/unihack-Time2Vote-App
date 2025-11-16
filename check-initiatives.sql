-- =====================================================
-- CHECK INITIATIVES IN DATABASE
-- =====================================================

-- Check total initiatives
SELECT COUNT(*) as total_initiatives FROM public.initiatives;

-- Check initiatives by county (first 10)
SELECT 
  c.name as county,
  COUNT(i.id) as initiative_count
FROM public.counties c
LEFT JOIN public.initiatives i ON i.county_id = c.id
GROUP BY c.name
ORDER BY initiative_count DESC
LIMIT 10;

-- Check sample initiatives
SELECT 
  i.title,
  i.category,
  i.status,
  c.name as county_name,
  i.created_at
FROM public.initiatives i
JOIN public.counties c ON i.county_id = c.id
LIMIT 10;

-- Check if there are any RLS issues
SELECT 
  tablename,
  rowsecurity
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'initiatives';

-- =====================================================
