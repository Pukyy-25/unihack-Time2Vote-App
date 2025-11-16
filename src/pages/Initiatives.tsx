import { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card } from "@/components/ui/card";
import { MapPin, Clock, Users, Building2, LogOut, Settings } from "lucide-react";
import { useTown } from "@/contexts/TownContext";
import { useTheme } from "@/contexts/ThemeContext";
import { toast } from "sonner";
import { supabase } from "@/integrations/supabase/client";
import { useUserRole } from "@/hooks/useUserRole";
import { AdminStats } from "@/components/AdminStats";
import { AdminCreateInitiative } from "@/components/AdminCreateInitiative";
import { useQuery } from "@tanstack/react-query";

const categories = ["All", "infrastructură", "mediu", "educație", "sănătate", "sport", "cultură", "social", "altele"];

const Initiatives = () => {
  const [selectedCategory, setSelectedCategory] = useState("All");
  const { selectedTown, setSelectedTown } = useTown();
  const { theme } = useTheme();
  const navigate = useNavigate();
  const { isAdmin, loading: roleLoading } = useUserRole();

  useEffect(() => {
    if (!selectedTown) {
      toast.error("Please select a town first");
      navigate("/");
    }
  }, [selectedTown, navigate]);

  const { data: initiatives = [], refetch } = useQuery({
    queryKey: ['initiatives', selectedTown?.county],
    queryFn: async () => {
      if (!selectedTown) return [];
      
      const { data, error } = await supabase
        .from('initiatives')
        .select(`
          *,
          counties!inner (
            name,
            cnp_code
          )
        `)
        .eq('status', 'active')
        .eq('counties.name', selectedTown.county)
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data || [];
    },
    enabled: !!selectedTown
  });

  // Realtime subscription for new initiatives
  useEffect(() => {
    const channel = supabase
      .channel('initiatives-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'initiatives'
        },
        () => refetch()
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [refetch]);

  const filteredInitiatives = selectedCategory === "All" 
    ? initiatives 
    : initiatives.filter(i => i.category === selectedCategory);

  const getDaysLeft = (endDate: string) => {
    const end = new Date(endDate);
    const now = new Date();
    const diffTime = end.getTime() - now.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays > 0 ? diffDays : 0;
  };

  const handleSignOut = async () => {
    await supabase.auth.signOut();
    toast.success("Deconectat cu succes");
    navigate("/auth");
  };

  if (!selectedTown) {
    return null;
  }

  return (
<<<<<<< Updated upstream
    <div className={`min-h-screen w-screen overflow-x-hidden ${
      theme === "light" ? "bg-gray-100" : "bg-gray-900"
    }`}>
=======
    <div className="min-h-screen w-screen overflow-x-hidden" style={{
      background: "#7a2d2d",
      backgroundImage: "linear-gradient(90deg, rgba(122, 45, 45, 1) 0%, rgba(65, 30, 100, 1) 35%, rgba(9, 9, 121, 1) 50%, rgba(0, 100, 200, 1) 75%, rgba(0, 212, 255, 1) 100%)"
    }}>
>>>>>>> Stashed changes
      {/* Header */}
      <header className={`border-b ${
        theme === "light"
          ? "bg-white border-gray-200"
          : "bg-slate-900/80 border-slate-700"
      }`}>
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between flex-wrap gap-4">
            <div className="flex items-center gap-3">
              <Building2 className="h-5 w-5" style={{ color: "#FFAE00" }} />
              <div>
                <h1 className={`text-lg md:text-xl font-bold ${theme === "light" ? "text-gray-900" : "text-white"}`}>{selectedTown.name}</h1>
                <p className={`text-xs ${theme === "light" ? "text-gray-600" : "text-slate-400"}`}>{selectedTown.county}</p>
              </div>
            </div>

            <div className="flex gap-2">
              <Button 
                size="sm"
                onClick={() => navigate("/settings")}
                className="text-gray-900"
                style={{ backgroundColor: "#FFAE00" }}
              >
                <Settings className="h-4 w-4 mr-2" />
                Settings
              </Button>
              <Button 
                variant="outline" 
                size="sm"
                onClick={handleSignOut}
                className={theme === "light"
                  ? "text-gray-900 border-gray-300 hover:bg-gray-100 hover:text-yellow-600"
                  : "text-white border-slate-500 bg-slate-700 hover:bg-slate-600 hover:text-yellow-400"
                }
              >
                <LogOut className="h-4 w-4 mr-2" />
                Logout
              </Button>
            </div>
          </div>
        </div>
      </header>

      {/* Admin Stats - shown only for admins */}
      {isAdmin && (
        <div className="container mx-auto px-4 py-6">
          <AdminStats />
        </div>
      )}

      {/* Category Filter */}
      <div className={`border-b ${
        theme === "light"
          ? "bg-gray-50 border-gray-200"
          : "bg-slate-800/50 border-slate-700"
      }`}>
        <div className="container mx-auto px-4 py-4">
          <div className="flex gap-2 overflow-x-auto">
            {categories.map((category) => (
              <button
                key={category}
                onClick={() => setSelectedCategory(category)}
                className={`px-3 py-2 text-sm font-medium rounded-md whitespace-nowrap transition-all ${
                  selectedCategory === category
                    ? theme === "light"
                      ? "text-black"
                      : "text-black"
                    : theme === "light"
                    ? "border border-gray-300 text-gray-900 hover:text-yellow-600"
                    : "border border-slate-600 text-white hover:text-yellow-400"
                }`}
                style={selectedCategory === category ? { backgroundColor: '#FFAE00' } : {}}
              >
                {category}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Initiatives Grid */}
      <main className={`container mx-auto px-4 py-8 ${
        theme === "light" ? "bg-gray-100" : ""
      }`}>
        <div className="mb-6">
<<<<<<< Updated upstream
          <h2 className={`text-2xl font-bold mb-2 ${theme === "light" ? "text-gray-900" : "text-white"}`}>Active Initiatives</h2>
          <p className={theme === "light" ? "text-gray-600" : "text-slate-300"}>
=======
          <h2 className="text-2xl font-bold text-white mb-2">Active Initiatives</h2>
          <p className="text-slate-300">
>>>>>>> Stashed changes
            {filteredInitiatives.length} initiatives available for voting
          </p>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {filteredInitiatives.map((initiative) => {
            const daysLeft = getDaysLeft(initiative.end_date);

            return (
              <Link key={initiative.id} to={`/initiative/${initiative.id}`}>
<<<<<<< Updated upstream
                <Card className={`h-full p-6 hover:shadow-lg transition-shadow cursor-pointer flex flex-col ${
                  theme === "light"
                    ? "bg-white border-gray-200"
                    : "border-slate-700"
                }`} style={theme === "dark" ? { backgroundColor: "#D3D5ED" } : undefined}>
=======
                <Card className="h-full p-6 hover:shadow-lg transition-shadow cursor-pointer bg-gradient-to-b from-slate-800 to-slate-800/70 flex flex-col">
>>>>>>> Stashed changes
                  <div className="flex flex-col flex-1 space-y-4">
                    {/* Header */}
                    <div className="space-y-2">
                      <div className="flex items-start justify-between gap-2">
                        <Badge variant="secondary" className="text-xs capitalize">
                          {initiative.category}
                        </Badge>
                        <div className={`flex items-center gap-1 text-xs ${
                          theme === "light" ? "text-gray-500" : "text-gray-600"
                        }`}>
                          <Clock className="h-3 w-3" />
                          {daysLeft}d rămase
                        </div>
                      </div>
<<<<<<< Updated upstream
                      <h3 className={`font-bold text-lg leading-tight line-clamp-2 min-h-[3.5rem] ${
                        theme === "light" ? "text-gray-900" : "text-gray-900"
                      }`}>
=======
                      <h3 className="font-bold text-lg text-white leading-tight line-clamp-2 min-h-[3.5rem]">
>>>>>>> Stashed changes
                        {initiative.title}
                      </h3>
                    </div>

                    {/* Description */}
<<<<<<< Updated upstream
                    <p className={`text-sm line-clamp-3 min-h-[4.5rem] ${
                      theme === "light" ? "text-gray-600" : "text-gray-700"
                    }`}>
=======
                    <p className="text-sm text-slate-300 line-clamp-3 min-h-[4.5rem]">
>>>>>>> Stashed changes
                      {initiative.description}
                    </p>

                    {/* Location */}
<<<<<<< Updated upstream
                    <div className={`flex items-center gap-2 text-sm ${
                      theme === "light" ? "text-gray-600" : "text-gray-700"
                    }`}>
=======
                    <div className="flex items-center gap-2 text-sm text-slate-300">
>>>>>>> Stashed changes
                      <MapPin className="h-4 w-4" />
                      {initiative.location}, {initiative.counties?.name}
                    </div>

                    {/* CTA */}
<<<<<<< Updated upstream
                    <Button className="w-full mt-auto text-white" variant="default" style={{ backgroundColor: "#5150A6" }}>
=======
                    <Button className="w-full mt-auto bg-pink-500 hover:bg-pink-600 text-white" variant="default">
>>>>>>> Stashed changes
                      View & Vote
                    </Button>
                  </div>
                </Card>
              </Link>
            );
          })}
        </div>
      </main>

      {/* Admin Create Initiative Button - shown only for admins */}
      {isAdmin && <AdminCreateInitiative />}
    </div>
  );
};

export default Initiatives;
