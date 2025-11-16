-- Batch 1 initiatives - With random deadlines (30-180 days)

WITH admin_user AS (
  SELECT id FROM auth.users WHERE email = 'matei.petrescu.2008@gmail.com'
),
bucuresti_county AS (
  SELECT id FROM public.counties WHERE name = 'București'
),
alba_county AS (
  SELECT id FROM public.counties WHERE name = 'Alba'
),
arad_county AS (
  SELECT id FROM public.counties WHERE name = 'Arad'
),
arges_county AS (
  SELECT id FROM public.counties WHERE name = 'Argeș'
),
bacau_county AS (
  SELECT id FROM public.counties WHERE name = 'Bacău'
),
bihor_county AS (
  SELECT id FROM public.counties WHERE name = 'Bihor'
),
bistrita_county AS (
  SELECT id FROM public.counties WHERE name = 'Bistrița-Năsăud'
)
INSERT INTO public.initiatives (title, description, category, county_id, location, status, created_by, start_date, end_date)

-- București - 6 initiatives
SELECT 'Transport public modernizat', 'Extinderea rețelei de metrou și autobuze electrice în întreaga ciutat', 'transport', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county
UNION ALL SELECT 'Parc central cu lac artificial', 'Construire de parc cu facilități sportive și de agrement', 'mediu', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county
UNION ALL SELECT 'Educație digitală pentru toți', 'Programe gratuite de IT și programare în biblioteci', 'educatie', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county
UNION ALL SELECT 'Restaurare clădiri istorice', 'Conservarea patrimoniului arhitectural din centrul istoric', 'cultura', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county
UNION ALL SELECT 'Rețea de piste de biciclete', 'Construire de piste sigure și interconectate pe întreg oraș', 'mobilitate', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county
UNION ALL SELECT 'Sistem de reciclare modern', 'Implementare de colectare separată de deșeuri în toate cartierele', 'mediu', bucuresti_county.id, 'București', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bucuresti_county

-- Alba Iulia - 6 initiatives
UNION ALL SELECT 'Fort medieval restaurat', 'Restaurare și deschidere pentru turism a fortificațiilor istorice', 'cultura', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county
UNION ALL SELECT 'Rute turistice noi', 'Creare de trasee și promovare a atracțiilor locale', 'turism', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county
UNION ALL SELECT 'LED iluminat public', 'Înlocuire sistem de iluminat cu versiune eco-eficientă', 'infrastructura', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county
UNION ALL SELECT 'Cursuri meșteșuguri tradiționale', 'Transmitere de cunoștințe și ateliere de meșteșuguri locale', 'educatie', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county
UNION ALL SELECT 'Parc comunitar nou', 'Amenajare parc pentru activități comunitare și recreație', 'mediu', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county
UNION ALL SELECT 'Program antreprenori', 'Suport și microfinanțare pentru tineri antreprenori', 'economie', alba_county.id, 'Alba Iulia', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, alba_county

-- Arad - 6 initiatives
UNION ALL SELECT 'Centru sportiv modern', 'Construire de centru cu bazin, sală de fitness și arenă', 'sport', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county
UNION ALL SELECT 'Bibliotecă digitală', 'Colecție online de cărți și resurse educaționale gratuite', 'educatie', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county
UNION ALL SELECT 'Păduri urbane', 'Plantare de copaci și creere de zone verzi în city', 'mediu', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county
UNION ALL SELECT 'Restaurare clădiri istorice', 'Conservare și restabilire a clădirilor cu importanță istorică', 'cultura', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county
UNION ALL SELECT 'Centru de sănătate comunitar', 'Clinică multifuncțională pentru servicii medicale preventive', 'sanatate', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county
UNION ALL SELECT 'Program socializare seniori', 'Activități și programe dedicate pentru persoane vârstnice', 'socializare', arad_county.id, 'Arad', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arad_county

-- Pitești - 6 initiatives
UNION ALL SELECT 'Centru cultural și artă', 'Spațiu dedicat exponatelor și evenimentelor culturale locale', 'cultura', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county
UNION ALL SELECT 'Programe educație în scoli', 'Inițiative pentru îmbunătățirea calității educației în orașe', 'educatie', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county
UNION ALL SELECT 'Parc de recreație pentru copii', 'Spații sigure și amenajări pentru jocul copiilor', 'recreatie', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county
UNION ALL SELECT 'Centru cultural și ateliere', 'Spații pentru arte și meșteșuguri tradiționale', 'cultura', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county
UNION ALL SELECT 'Rețea transport local modern', 'Autobuze noi și sisteme de transport inteligente', 'mobilitate', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county
UNION ALL SELECT 'Grădini comunitare ecologice', 'Spații pentru cultivation de plante și legume organic', 'mediu', arges_county.id, 'Pitești', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, arges_county

-- Bacău - 6 initiatives
UNION ALL SELECT 'Program de dezvoltare economie locală', 'Suport pentru afaceri locale și atragere de investitori', 'economie', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county
UNION ALL SELECT 'Parc regional de conservare naturii', 'Protejare a zonelor cu valoare ecologică și biodiversitate', 'mediu', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county
UNION ALL SELECT 'Centru de sănătate și wellness', 'Facilități medicale și programe de wellness pentru populație', 'sanatate', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county
UNION ALL SELECT 'Infrastructură rutieră modernă', 'Îmbunătățire și reparații ale drumurilor principale', 'infrastructura', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county
UNION ALL SELECT 'Program cultural și tradițional', 'Promovare a artelor și tradițiilor culturale locale', 'cultura', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county
UNION ALL SELECT 'Rețea biblioteci cu resurse digitale', 'Extindere și modernizare a serviciilor bibliotecilor publice', 'educatie', bacau_county.id, 'Bacău', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bacau_county

-- Oradea - 6 initiatives
UNION ALL SELECT 'Program turism și culturi', 'Promovare și atragere de turiști din diverse culturi', 'turism', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county
UNION ALL SELECT 'Centru sportiv și recreație', 'Facilități pentru sport și activități de agrement', 'sport', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county
UNION ALL SELECT 'Parc ecologic și pădure urbană', 'Creere de spații verzi și protejare a biodiversității', 'mediu', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county
UNION ALL SELECT 'Centru cultural și ateliere de artă', 'Spații dedicate artei și meșteșugurilor tradiționale', 'cultura', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county
UNION ALL SELECT 'Program socializare comunitar', 'Inițiative pentru conectarea și sprijinul comunității', 'social', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county
UNION ALL SELECT 'Infrastructură transport și mobilitate', 'Modernizare piste biciclete și căi de acces public', 'infrastructura', bihor_county.id, 'Oradea', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bihor_county

-- Bistrița - 6 initiatives
UNION ALL SELECT 'Program educație și formare profesională', 'Cursuri și programe de reconverzie profesională', 'educatie', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county
UNION ALL SELECT 'Centru cultural și muzeu local', 'Spații pentru exponatele și promovarea culturii locale', 'cultura', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county
UNION ALL SELECT 'Program turism și rute de drumeții', 'Promovare a atracțiilor naturale și trasee de drumeții', 'turism', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county
UNION ALL SELECT 'Centru de sănătate și medical', 'Clinică cu servicii medicale și preventive', 'sanatate', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county
UNION ALL SELECT 'Program turism și agro-turism', 'Promovare a turismului rural și agro-turismului local', 'turism', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county
UNION ALL SELECT 'Parc comunitar și zone verzi', 'Amenajare de spații verzi și parc pentru comunitate', 'mediu', bistrita_county.id, 'Bistrița', 'active', admin_user.id, NOW(), NOW() + INTERVAL '1 day' * (30 + (RANDOM() * 150)::INT) FROM admin_user, bistrita_county;
