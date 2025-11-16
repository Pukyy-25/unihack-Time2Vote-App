-- =====================================================
-- GENERATE INITIATIVES FOR ALL COUNTIES
-- 6 initiatives per county (infrastructure, environment, education, health, sports, culture)
-- =====================================================

-- First, let's get the county IDs into a temporary table
DO $$
DECLARE
  county_record RECORD;
  initiative_templates TEXT[] := ARRAY[
    'Modernizare rețea de drumuri locale',
    'Parc ecologic în zona centrală',
    'Renovare școli și grădinițe',
    'Centru medical de urgență 24/7',
    'Complex sportiv multifuncțional',
    'Centru cultural și bibliotecă modernă'
  ];
  descriptions TEXT[] := ARRAY[
    'Modernizarea și asfaltarea drumurilor județene și comunale pentru îmbunătățirea siguranței rutiere și reducerea timpului de deplasare între localități.',
    'Amenajare spații verzi cu zone de relaxare, piste de alergare, locuri de joacă pentru copii și sisteme de colectare selectivă a deșeurilor.',
    'Renovarea infrastructurii educaționale: încălzire modernă, toalete interioare, săli de clasă dotate cu tehnologie, terenuri de sport.',
    'Înființare centru medical de urgență cu dotări moderne, ambulanțe noi și personal medical de gardă pentru intervenții rapide.',
    'Construcție complex sportiv cu sală de sport, teren de fotbal, piscină semi-olimpică, vestiare moderne și tribunale pentru spectatori.',
    'Amenajare centru cultural cu bibliotecă digitală, săli de expoziții, studio de artă, sală de spectacole și spații pentru activități comunitare.'
  ];
  categories TEXT[] := ARRAY['infrastructură', 'mediu', 'educație', 'sănătate', 'sport', 'cultură'];
  idx INTEGER;
BEGIN
  -- Loop through all counties
  FOR county_record IN 
    SELECT id, name FROM public.counties
  LOOP
    -- Insert 6 initiatives for each county
    FOR idx IN 1..6 LOOP
      INSERT INTO public.initiatives (
        title,
        description,
        category,
        county_id,
        location,
        status,
        start_date,
        end_date,
        created_at
      ) VALUES (
        initiative_templates[idx] || ' - ' || county_record.name,
        descriptions[idx],
        categories[idx],
        county_record.id,
        county_record.name,
        'active',
        NOW(),
        NOW() + INTERVAL '30 days',
        NOW()
      );
    END LOOP;
  END LOOP;
  
  RAISE NOTICE 'Generated % initiatives across all counties!', (SELECT COUNT(*) FROM public.counties) * 6;
END $$;

-- Verify the results
SELECT 
  c.name as county,
  COUNT(i.id) as initiative_count,
  STRING_AGG(i.category, ', ') as categories
FROM public.counties c
LEFT JOIN public.initiatives i ON i.county_id = c.id
GROUP BY c.name
ORDER BY c.name;

-- =====================================================
-- INITIATIVES GENERATED!
-- Total: ~300 initiatives (50 counties × 6 initiatives)
-- =====================================================
