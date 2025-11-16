-- =====================================================
-- INSERT INITIATIVES FOR ALL COUNTIES
-- 6 initiatives per county with descriptions
-- =====================================================

-- Get county IDs and insert initiatives
INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  'Modernization of Local Roads - ' || c.name,
  'Modernization and asphalting of county and communal roads to improve road safety and reduce travel time between localities. The project includes repairing damaged sections, installing proper drainage systems, and adding road markings.',
  'infrastructură',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  'Ecological Park in Central Area - ' || c.name,
  'Development of green spaces with relaxation areas, running tracks, playgrounds for children, and selective waste collection systems. The park will include benches, outdoor gym equipment, and bicycle lanes.',
  'mediu',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  'Renovation of Schools and Kindergartens - ' || c.name,
  'Renovation of educational infrastructure: modern heating, indoor toilets, classrooms equipped with technology, sports fields. The project aims to create a better learning environment for students and improved working conditions for teachers.',
  'educație',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  '24/7 Emergency Medical Center - ' || c.name,
  'Establishment of an emergency medical center with modern equipment, new ambulances, and on-call medical staff for rapid interventions. The center will provide emergency care, trauma services, and will be equipped with the latest medical technology.',
  'sănătate',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  'Multifunctional Sports Complex - ' || c.name,
  'Construction of a sports complex with a sports hall, football field, semi-Olympic swimming pool, modern changing rooms, and spectator stands. The complex will host local competitions and provide training facilities for athletes.',
  'sport',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

INSERT INTO public.initiatives (title, description, category, county_id, location, status, start_date, end_date, created_at)
SELECT 
  'Modern Cultural Center and Library - ' || c.name,
  'Development of a cultural center with a digital library, exhibition halls, art studio, performance hall, and spaces for community activities. The center will host cultural events, workshops, and provide educational resources.',
  'cultură',
  c.id,
  c.name,
  'active',
  NOW(),
  NOW() + INTERVAL '30 days',
  NOW()
FROM public.counties c;

-- Verify results
SELECT 
  c.name as county,
  COUNT(i.id) as initiative_count
FROM public.counties c
LEFT JOIN public.initiatives i ON i.county_id = c.id
GROUP BY c.name
ORDER BY c.name
LIMIT 10;

SELECT COUNT(*) as total_initiatives FROM public.initiatives;

-- =====================================================
-- SUCCESS! Initiatives created for all counties
-- =====================================================
