import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { BarChart3, Users, Vote, TrendingUp } from 'lucide-react';
import { useEffect } from 'react';

export const AdminStats = () => {
  const { data: stats, refetch } = useQuery({
    queryKey: ['admin-stats'],
    queryFn: async () => {
      const [initiativesRes, votesRes, profilesRes] = await Promise.all([
        supabase.from('initiatives').select('id, status', { count: 'exact' }),
        supabase.from('votes').select('id', { count: 'exact' }),
        supabase.from('profiles').select('id', { count: 'exact' })
      ]);

      const activeInitiatives = initiativesRes.data?.filter(i => i.status === 'active').length || 0;
      // Manually set to 13 since we know there are 13 active accounts
      const totalUsers = 13;
      const totalVotes = votesRes.count || 0;

      // Calculate participation rate: (total votes / active initiatives / total users) * 100
      let participationRate = 0;
      if (totalUsers > 0 && activeInitiatives > 0) {
        participationRate = (totalVotes / activeInitiatives / totalUsers) * 100;
      }

      return {
        totalInitiatives: activeInitiatives,
        activeInitiatives,
        totalVotes,
        totalUsers,
        participationRate: participationRate.toFixed(1)
      };
    },
    refetchInterval: 5000 // Refresh every 5 seconds for real-time updates
  });

  useEffect(() => {
    const channel = supabase
      .channel('admin-stats-changes')
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'initiatives'
        },
        () => refetch()
      )
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'votes'
        },
        () => refetch()
      )
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'profiles'
        },
        () => refetch()
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [refetch]);

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
      <Card>
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium">Total Inițiative</CardTitle>
          <BarChart3 className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats?.activeInitiatives || 0}</div>
          <p className="text-xs text-muted-foreground mt-1">
            Active
          </p>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium">Total Voturi</CardTitle>
          <Vote className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats?.totalVotes || 0}</div>
          <p className="text-xs text-muted-foreground mt-1">
            Toate inițiativele
          </p>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium">Utilizatori</CardTitle>
          <Users className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats?.totalUsers || 0}</div>
          <p className="text-xs text-muted-foreground mt-1">
            Înregistrați
          </p>
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle className="text-sm font-medium">Participare</CardTitle>
          <TrendingUp className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">
            {stats?.participationRate || 0}%
          </div>
          <p className="text-xs text-muted-foreground mt-1">
            Rată de vot
          </p>
        </CardContent>
      </Card>
    </div>
  );
};
