-- Enable RLS on tables
ALTER TABLE public.initiatives ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Allow public read access to all initiatives
CREATE POLICY initiatives_public_read ON public.initiatives
  FOR SELECT
  USING (true);

-- Allow users to see all votes
CREATE POLICY votes_public_read ON public.votes
  FOR SELECT
  USING (true);

-- Allow users to see all profiles
CREATE POLICY profiles_public_read ON public.profiles
  FOR SELECT
  USING (true);
