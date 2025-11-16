-- =====================================================
-- FIX EXISTING DATABASE - Run this if tables already exist
-- =====================================================

-- Drop existing tables if they have wrong schema
DROP TABLE IF EXISTS public.comments CASCADE;
DROP TABLE IF EXISTS public.votes CASCADE;
DROP TABLE IF EXISTS public.initiatives CASCADE;
DROP TABLE IF EXISTS public.counties CASCADE;
DROP TABLE IF EXISTS public.phone_verifications CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

-- Now run the full setup
-- =====================================================

-- 0. Create profiles table
CREATE TABLE public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  birth_date DATE NOT NULL,
  county TEXT NOT NULL,
  city TEXT NOT NULL,
  phone_number TEXT,
  cnp TEXT UNIQUE,
  avatar_url TEXT,
  phone_verified BOOLEAN NOT NULL DEFAULT false,
  twofa_sms_enabled BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Create policies for user access
CREATE POLICY "Users can view their own profile" 
ON public.profiles FOR SELECT 
USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile" 
ON public.profiles FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = user_id);

-- 1. Create counties table
CREATE TABLE public.counties (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  cnp_code TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable RLS on counties
ALTER TABLE public.counties ENABLE ROW LEVEL SECURITY;

-- Allow everyone to read counties (public data)
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
  ('Giurgiu', '52');

-- 2. Create initiatives table
CREATE TABLE public.initiatives (
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

-- 3. Create votes table
CREATE TABLE public.votes (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  initiative_id UUID NOT NULL REFERENCES public.initiatives(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  vote_type TEXT NOT NULL CHECK (vote_type IN ('for', 'against', 'abstain')),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(initiative_id, user_id)
);

-- 4. Create comments table
CREATE TABLE public.comments (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  initiative_id UUID NOT NULL REFERENCES public.initiatives(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  parent_comment_id UUID REFERENCES public.comments(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- 5. Create phone_verifications table
CREATE TABLE public.phone_verifications (
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
CREATE INDEX idx_votes_initiative ON public.votes(initiative_id);
CREATE INDEX idx_votes_user ON public.votes(user_id);
CREATE INDEX idx_comments_initiative ON public.comments(initiative_id);
CREATE INDEX idx_comments_user ON public.comments(user_id);
CREATE INDEX idx_initiatives_status ON public.initiatives(status);
CREATE INDEX idx_initiatives_county_id ON public.initiatives(county_id);
CREATE INDEX idx_phone_verifications_user_created ON public.phone_verifications(user_id, created_at);

-- 7. Enable Row Level Security
ALTER TABLE public.initiatives ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.phone_verifications ENABLE ROW LEVEL SECURITY;

-- 8. Create RLS Policies for initiatives
CREATE POLICY "Anyone can view active initiatives" 
ON public.initiatives FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can create initiatives" 
ON public.initiatives FOR INSERT 
WITH CHECK (auth.uid() = created_by);

-- 9. Create RLS Policies for votes
CREATE POLICY "Anyone can view votes" 
ON public.votes FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can vote" 
ON public.votes FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Authenticated users can update their votes" 
ON public.votes FOR UPDATE 
USING (auth.uid() = user_id);

-- 10. Create RLS Policies for comments
CREATE POLICY "Anyone can view comments" 
ON public.comments FOR SELECT 
USING (true);

CREATE POLICY "Authenticated users can create comments" 
ON public.comments FOR INSERT 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own comments" 
ON public.comments FOR DELETE 
USING (auth.uid() = user_id);

-- 11. Create RLS Policies for phone_verifications
CREATE POLICY "Users can insert their own phone verifications"
ON public.phone_verifications FOR INSERT
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view their own phone verifications"
ON public.phone_verifications FOR SELECT
USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own phone verifications"
ON public.phone_verifications FOR UPDATE
USING (auth.uid() = user_id);

-- 12. Create function to update timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 13. Create triggers for automatic timestamp updates
CREATE TRIGGER update_profiles_updated_at
BEFORE UPDATE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_initiatives_updated_at
BEFORE UPDATE ON public.initiatives
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_votes_updated_at
BEFORE UPDATE ON public.votes
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_comments_updated_at
BEFORE UPDATE ON public.comments
FOR EACH ROW
EXECUTE FUNCTION public.update_updated_at_column();

-- =====================================================
-- DATABASE FIX COMPLETE!
-- Note: profiles table is kept as-is from setup-database.sql
-- =====================================================
