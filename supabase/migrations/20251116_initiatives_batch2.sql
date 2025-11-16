-- Batch 2 initiatives - With random deadlines (30-180 days)

WITH admin_user AS (
  SELECT id FROM auth.users WHERE email = 'matei.petrescu.2008@gmail.com'
),
botosani_county AS (
  SELECT id FROM public.counties WHERE name = 'Botoșani'
),
brasov_county AS (
  SELECT id FROM public.counties WHERE name = 'Brașov'
),
braila_county AS (
  SELECT id FROM public.counties WHERE name = 'Brăila'
),
buzau_county AS (
  SELECT id FROM public.counties WHERE name = 'Buzău'
),
caras_county AS (
  SELECT id FROM public.counties WHERE name = 'Caraș-Severin'
),
cluj_county AS (
  SELECT id FROM public.counties WHERE name = 'Cluj'
),
constanta_county AS (
  SELECT id FROM public.counties WHERE name = 'Constanța'
)
INSERT INTO public.initiatives (title, description, category, county_id, location, status, created_by, start_date, end_date)

-- Botoșani - 6 initiatives
SELECT 'Centru turism cultural', 'Muzeu și expoziții promovând cultura locală', 'cultura', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county
UNION ALL SELECT 'Program agricultură producție', 'Suport agricultori și producători din Botoșani', 'economie', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county
UNION ALL SELECT 'Parc zone verzi', 'Creere spații verzi și parc central', 'mediu', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county
UNION ALL SELECT 'Centru educație formare', 'Cursuri formare și programe educative', 'educatie', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county
UNION ALL SELECT 'Bibliotecă publică modernă', 'Bibliotecă cu facilități digitale și culturale', 'educatie', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', botosani_county.id, 'Botoșani', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, botosani_county

-- Brașov - 6 initiatives
UNION ALL SELECT 'Hub turism cultură', 'Centru turism dedicat promovării turismului și culturii', 'turism', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county
UNION ALL SELECT 'Transport public modern', 'Autobuze electrice și expansion rețea', 'transport', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county
UNION ALL SELECT 'Centru arte cultură', 'Teatru cinema și galerie artiști locali', 'cultura', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county
UNION ALL SELECT 'Parc zone verzi', 'Creere spații verzi și parc urban', 'mediu', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county
UNION ALL SELECT 'Program educație formare', 'Cursuri formare și programe educative', 'educatie', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', brasov_county.id, 'Brașov', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, brasov_county

-- Brăila - 6 initiatives
UNION ALL SELECT 'Centru turism Dunăre', 'Turism fluvial și promovare rute Dunăre', 'turism', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county
UNION ALL SELECT 'Muzeu istoria portului', 'Muzeu dedicat istoriei portului și comerțului', 'cultura', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county
UNION ALL SELECT 'Program protecție Dunăre', 'Inițiative protecție și curățare Dunării', 'mediu', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county
UNION ALL SELECT 'Centru pescuit tradițional', 'Ateliere și promovare meșeșuguri pescuitului', 'cultura', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county
UNION ALL SELECT 'Centru formare profesională', 'Cursuri formare în sectoare în creștere', 'educatie', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', braila_county.id, 'Brăila', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, braila_county

-- Buzău - 6 initiatives
UNION ALL SELECT 'Program agricultură producție', 'Suport agricultori și producători din Buzău', 'economie', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county
UNION ALL SELECT 'Parc zone verzi', 'Creere spații verzi și parc central', 'mediu', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county
UNION ALL SELECT 'Centru educație formare', 'Cursuri formare și programe educative', 'educatie', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county
UNION ALL SELECT 'Bibliotecă publică modernă', 'Bibliotecă cu facilități digitale și culturale', 'educatie', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county
UNION ALL SELECT 'Program turism agro-turism', 'Promovare turism agricol și rural în regiune', 'turism', buzau_county.id, 'Buzău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, buzau_county

-- Reșița - 6 initiatives
UNION ALL SELECT 'Centru turism cultura', 'Muzeu și galerii artiști locali și turism', 'cultura', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county
UNION ALL SELECT 'Program agricultură producție', 'Suport agricultori și producători din Caraș-Severin', 'economie', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county
UNION ALL SELECT 'Parc natural piste biciclete', 'Trasee biciclete și parc natural în regiune', 'turism', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county
UNION ALL SELECT 'Centru educație formare', 'Cursuri formare și programe educative', 'educatie', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county
UNION ALL SELECT 'Bibliotecă centru cultural', 'Bibliotecă cu facilități digitale și activități culturale', 'educatie', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', caras_county.id, 'Reșița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, caras_county

-- Cluj-Napoca - 6 initiatives
UNION ALL SELECT 'Hub inovație startup-uri', 'Incubator pentru startup-uri și companii tech', 'economie', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county
UNION ALL SELECT 'Centru arte cultură', 'Teatru cinema și galerie artiști locali', 'cultura', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county
UNION ALL SELECT 'Transport public modern', 'Autobuze electrice și expansion rețea', 'transport', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county
UNION ALL SELECT 'Parc zone verzi', 'Creere spații verzi și parc urban', 'mediu', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county
UNION ALL SELECT 'Program formare profesională', 'Cursuri formare în sectoare în creștere', 'educatie', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', cluj_county.id, 'Cluj-Napoca', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, cluj_county

-- Constanța - 6 initiatives
UNION ALL SELECT 'Centru turism plajă', 'Facilități și servicii pentru turiștii în stațiuni', 'turism', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county
UNION ALL SELECT 'Proteire mediu marin', 'Programe de protecție și conservare a mediului marin', 'mediu', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county
UNION ALL SELECT 'Centru cultură și artă', 'Muzeu și galerii dedicând culturei maritime', 'cultura', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county
UNION ALL SELECT 'Program educație și cultură', 'Programe educative și culturale pentru populație', 'educatie', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county
UNION ALL SELECT 'Centru sănătate wellness', 'Clinic și centre wellness pentru populație', 'sanatate', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county
UNION ALL SELECT 'Program socializare și agrement', 'Activități și programe de socializare comunitară', 'recreatie', constanta_county.id, 'Constanța', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, constanta_county;
