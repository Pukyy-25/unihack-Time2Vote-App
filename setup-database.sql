-- =====================================================
-- POCKET DEMOCRACY - DATABASE SETUP SCRIPT
-- Run this in Supabase SQL Editor to set up your database
-- =====================================================

-- 1. Create profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  birth_date DATE NOT NULL,
  county TEXT NOT NULL,
  city TEXT NOT NULL,
  phone_number TEXT,
  cnp TEXT UNIQUE,
  id_document_url TEXT,
  id_verified BOOLEAN DEFAULT false,
  id_verification_data JSONB,
  phone_verified BOOLEAN NOT NULL DEFAULT false,
  twofa_sms_enabled BOOLEAN NOT NULL DEFAULT false,
  avatar_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- 2. Create counties table
CREATE TABLE IF NOT EXISTS public.counties (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  cnp_code TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS on counties
ALTER TABLE public.counties ENABLE ROW LEVEL SECURITY;

-- Allow everyone to read counties (public data)
DROP POLICY IF EXISTS "Counties are viewable by everyone" ON public.counties;
CREATE POLICY "Counties are viewable by everyone"
ON public.counties FOR SELECT
USING (true);

-- Insert all Romanian counties with their CNP codes
INSERT INTO public.counties (name, cnp_code) VALUES
  ('Alba', '01'),
  ('Arad', '02'),
  ('Argeș', '03'),
  ('Bacău', '04'),
  ('Bihor', '05'),
  ('Bistrița-Năsăud', '06'),
  ('Botoșani', '07'),
  ('Brașov', '08'),
  ('Brăila', '09'),
  ('Buzău', '10'),
  ('Caraș-Severin', '11'),
  ('Cluj', '12'),
  ('Constanța', '13'),
  ('Covasna', '14'),
  ('Dâmbovița', '15'),
  ('Dolj', '16'),
  ('Galați', '17'),
  ('Gorj', '18'),
  ('Harghita', '19'),
  ('Hunedoara', '20'),
  ('Ialomița', '21'),
  ('Iași', '22'),
  ('Ilfov', '23'),
  ('Maramureș', '24'),
  ('Mehedinți', '25'),
  ('Mureș', '26'),
  ('Neamț', '27'),
  ('Olt', '28'),
  ('Prahova', '29'),
  ('Satu-Mare', '30'),
  ('Sălaj', '31'),
  ('Sibiu', '32'),
  ('Suceava', '33'),
  ('Teleorman', '34'),
  ('Timiș', '35'),
  ('Tulcea', '36'),
  ('Vaslui', '37'),
  ('Vâlcea', '38'),
  ('Vrancea', '39'),
  ('București', '40'),
  ('București - Sector 1', '41'),
  ('București - Sector 2', '42'),
  ('București - Sector 3', '43'),
  ('București - Sector 4', '44'),
  ('București - Sector 5', '45'),
  ('București - Sector 6', '46'),
  ('Călărași', '51'),
  ('Giurgiu', '52')
ON CONFLICT (name) DO NOTHING;

-- 3. Create initiatives table
CREATE TABLE IF NOT EXISTS public.initiatives (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  county_id UUID NOT NULL REFERENCES public.counties(id) ON DELETE CASCADE,
  location TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'closed', 'approved', 'rejected')),
  start_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  end_date TIMESTAMP WITH TIME ZONE NOT NULL,
  created_by UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- 4. Create votes table
CREATE TABLE IF NOT EXISTS public.votes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  initiative_id UUID NOT NULL REFERENCES public.initiatives(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  vote_type TEXT NOT NULL CHECK (vote_type IN ('for', 'against', 'abstain')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(initiative_id, user_id)
);

-- 4. Create comments table
CREATE TABLE IF NOT EXISTS public.comments (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  initiative_id UUID NOT NULL REFERENCES public.initiatives(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_comment_id UUID REFERENCES public.comments(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- 5. Create phone_verifications table
CREATE TABLE IF NOT EXISTS public.phone_verifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  phone_number TEXT NOT NULL,
  code_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL,
  attempts INT NOT NULL DEFAULT 0,
  verified BOOLEAN NOT NULL DEFAULT false
);

-- 6. Create indexes
CREATE INDEX IF NOT EXISTS idx_votes_initiative ON public.votes(initiative_id);
CREATE INDEX IF NOT EXISTS idx_votes_user ON public.votes(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_initiative ON public.comments(initiative_id);
CREATE INDEX IF NOT EXISTS idx_comments_user ON public.comments(user_id);
CREATE INDEX IF NOT EXISTS idx_initiatives_status ON public.initiatives(status);
CREATE INDEX IF NOT EXISTS idx_initiatives_county_id ON public.initiatives(county_id);
CREATE INDEX IF NOT EXISTS idx_phone_verifications_user_created ON public.phone_verifications(user_id, created_at);

-- 7. Enable Row Level Security
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.initiatives ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.phone_verifications ENABLE ROW LEVEL SECURITY;

-- 8. Drop existing policies if any
DROP POLICY IF EXISTS "Users can view their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can insert their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
DROP POLICY IF EXISTS "Anyone can view active initiatives" ON public.initiatives;
DROP POLICY IF EXISTS "Authenticated users can create initiatives" ON public.initiatives;
DROP POLICY IF EXISTS "Anyone can view votes" ON public.votes;
DROP POLICY IF EXISTS "Authenticated users can vote" ON public.votes;
DROP POLICY IF EXISTS "Authenticated users can update their votes" ON public.votes;
DROP POLICY IF EXISTS "Anyone can view comments" ON public.comments;
DROP POLICY IF EXISTS "Authenticated users can create comments" ON public.comments;
DROP POLICY IF EXISTS "Users can delete their own comments" ON public.comments;
DROP POLICY IF EXISTS "Users can insert their own phone verifications" ON public.phone_verifications;
DROP POLICY IF EXISTS "Users can view their own phone verifications" ON public.phone_verifications;
DROP POLICY IF EXISTS "Users can update their own phone verifications" ON public.phone_verifications;

-- 9. Create RLS Policies for profiles
CREATE POLICY "Users can view their own profile" 
ON public.profiles FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = user_id);

-- 10. Create RLS Policies for initiatives
CREATE POLICY "Anyone can view active initiatives" 
ON public.initiatives FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can create initiatives" 
ON public.initiatives FOR INSERT 
WITH CHECK (auth.uid() = created_by);

-- 11. Create RLS Policies for votes
CREATE POLICY "Anyone can view votes" 
ON public.votes FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can vote" 
ON public.votes FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Authenticated users can update their votes" 
ON public.votes FOR UPDATE 
USING (auth.uid() = user_id);

-- 12. Create RLS Policies for comments
CREATE POLICY "Anyone can view comments" 
ON public.comments FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can create comments" 
ON public.comments FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own comments" 
ON public.comments FOR DELETE 
USING (auth.uid() = user_id);

-- 13. Create RLS Policies for phone_verifications
CREATE POLICY "Users can insert their own phone verifications"
ON public.phone_verifications FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own phone verifications"
ON public.phone_verifications FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own phone verifications"
ON public.phone_verifications FOR UPDATE
USING (auth.uid() = user_id);

-- 14. Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 15. Create triggers for automatic timestamp updates
DROP TRIGGER IF EXISTS update_profiles_updated_at ON public.profiles;
CREATE TRIGGER update_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS update_initiatives_updated_at ON public.initiatives;
CREATE TRIGGER update_initiatives_updated_at
BEFORE UPDATE ON public.initiatives
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS update_votes_updated_at ON public.votes;
CREATE TRIGGER update_votes_updated_at
BEFORE UPDATE ON public.votes
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS update_comments_updated_at ON public.comments;
CREATE TRIGGER update_comments_updated_at
BEFORE UPDATE ON public.comments
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- 16. Create storage bucket for avatars
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'avatars',
  'avatars',
  true,
  2097152, -- 2MB limit
  ARRAY['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/gif']
)
ON CONFLICT (id) DO NOTHING;

-- 17. Create storage bucket for ID documents
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'id-documents',
  'id-documents',
  false,
  5242880, -- 5MB limit
  ARRAY['image/jpeg', 'image/jpg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO NOTHING;

-- 18. Create RLS policies for avatars bucket
DROP POLICY IF EXISTS "Anyone can view avatars" ON storage.objects;
DROP POLICY IF EXISTS "Users can upload their own avatar" ON storage.objects;
DROP POLICY IF EXISTS "Users can update their own avatar" ON storage.objects;
DROP POLICY IF EXISTS "Users can delete their own avatar" ON storage.objects;

CREATE POLICY "Anyone can view avatars"
ON storage.objects FOR SELECT
USING (bucket_id = 'avatars');

CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'avatars' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can update their own avatar"
ON storage.objects FOR UPDATE
USING (
  bucket_id = 'avatars' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can delete their own avatar"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'avatars' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

-- 19. Create RLS policies for id-documents bucket
DROP POLICY IF EXISTS "Users can upload their own ID documents" ON storage.objects;
DROP POLICY IF EXISTS "Users can view their own ID documents" ON storage.objects;

CREATE POLICY "Users can upload their own ID documents"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'id-documents' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Users can view their own ID documents"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'id-documents' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

-- =====================================================
-- DATABASE SETUP COMPLETE!
-- =====================================================
