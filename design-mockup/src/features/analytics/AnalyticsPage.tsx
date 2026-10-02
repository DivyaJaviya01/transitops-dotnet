import { useQuery } from '@tanstack/react-query';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, Area, AreaChart } from 'recharts';
import { FiBarChart2, FiTrendingUp, FiPieChart } from 'react-icons/fi';
import MainLayout from '../../components/layout/MainLayout';
import api from '../../services/api';

const COLORS = ['#1b4332', '#2d6a4f', '#40916c', '#52b788', '#95d5b2'];
const STATUS_COLORS = ['#2d6a4f', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6'];

const AnalyticsPage = () => {
  const { data: kpiData } = useQuery({
    queryKey: ['kpis'],
    queryFn: async () => { const res = await api.get('/reports/kpis'); return res.data; },
    refetchInterval: 30000,
  });

  const { data: vehicles } = useQuery({
    queryKey: ['vehicles'],
    queryFn: async () => { const res = await api.get('/vehicles'); return res.data; },
  });

  const { data: trips } = useQuery({
    queryKey: ['trips'],
    queryFn: async () => { const res = await api.get('/trips'); return res.data; },
  });

  const fleetByType = (vehicles || []).reduce((acc: Record<string, number>, v: any) => {
    acc[v.type] = (acc[v.type] || 0) + 1;
    return acc;
  }, {});

  const pieData = Object.entries(fleetByType).map(([name, value]) => ({ name, value }));

  const statusCounts = (vehicles || []).reduce((acc: Record<string, number>, v: any) => {
    acc[v.status] = (acc[v.status] || 0) + 1;
    return acc;
  }, {});

  const statusData = Object.entries(statusCounts).map(([name, value]) => ({ name, value }));

  const tripsByDayData = (() => {
    const days: string[] = [];
    for (let i = 13; i >= 0; i--) {
      const d = new Date();
      d.setDate(d.getDate() - i);
      days.push(d.toISOString().slice(0, 10));
    }
    const counts: Record<string, number> = {};
    (trips || []).forEach((t: any) => {
      const day = new Date(t.createdAt).toISOString().slice(0, 10);
      if (days.includes(day)) counts[day] = (counts[day] || 0) + 1;
    });
    return days.map(d => ({
      day: new Date(d).toLocaleDateString('en', { month: 'short', day: 'numeric' }),
      trips: counts[d] || 0,
    }));
  })();

  const metrics = [
    { label: 'Total Fleet', value: vehicles?.length ?? '...', color: '#2d6a4f' },
    { label: 'Active Trips', value: kpiData?.activeTrips ?? '...', color: '#10b981' },
    { label: 'Fleet Utilization', value: kpiData ? `${kpiData.fleetUtilizationPercentage}%` : '...', color: '#f59e0b' },
    { label: 'Drivers On Duty', value: kpiData?.driversOnDuty ?? '...', color: '#8b5cf6' },
  ];

  return (
    <MainLayout>
      <div className="dashboard-page">
        <div className="dashboard-header">
          <div>
            <h1>Fleet Analytics</h1>
            <p>Deep dive into fleet performance and distribution metrics.</p>
          </div>
        </div>

        <div className="dashboard-grid" style={{ gridTemplateColumns: 'repeat(4, 1fr)' }}>
          {metrics.map((m) => (
            <div key={m.label} className="kpi-card" style={{ borderLeftColor: m.color }}>
              <h3>{m.label}</h3>
              <p className="kpi-value" style={{ color: m.color }}>{m.value}</p>
            </div>
          ))}
        </div>

        <div className="bottom-grid" style={{ gridTemplateColumns: '1fr 1fr', marginBottom: '1.5rem' }}>
          <div className="graph-card" style={{ marginBottom: 0 }}>
            <div className="graph-header">
              <h3><FiTrendingUp size={18} style={{ color: '#1b4332' }} /> 14-Day Trip Trend</h3>
            </div>
            <ResponsiveContainer width="100%" height={260}>
              <AreaChart data={tripsByDayData}>
                <defs>
                  <linearGradient id="analyticsGradient" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="0%" stopColor="#1b4332" stopOpacity={0.3} />
                    <stop offset="100%" stopColor="#1b4332" stopOpacity={0.02} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="var(--card-border)" vertical={false} />
                <XAxis dataKey="day" tick={{ fontSize: 11, fill: 'var(--text-secondary)' }} axisLine={false} tickLine={false} />
                <YAxis tick={{ fontSize: 11, fill: 'var(--text-secondary)' }} axisLine={false} tickLine={false} allowDecimals={false} />
                <Tooltip />
                <Area type="monotone" dataKey="trips" stroke="#1b4332" strokeWidth={2.5} fill="url(#analyticsGradient)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>

          <div className="graph-card" style={{ marginBottom: 0 }}>
            <div className="graph-header">
              <h3><FiBarChart2 size={18} style={{ color: '#1b4332' }} /> Fleet by Type</h3>
            </div>
            <ResponsiveContainer width="100%" height={260}>
              <BarChart data={pieData}>
                <CartesianGrid strokeDasharray="3 3" stroke="var(--card-border)" vertical={false} />
                <XAxis dataKey="name" tick={{ fontSize: 11, fill: 'var(--text-secondary)' }} axisLine={false} tickLine={false} />
                <YAxis tick={{ fontSize: 11, fill: 'var(--text-secondary)' }} axisLine={false} tickLine={false} allowDecimals={false} />
                <Tooltip />
                <Bar dataKey="value" radius={[6, 6, 0, 0]}>
                  {pieData.map((_: any, i: number) => (
                    <Cell key={i} fill={COLORS[i % COLORS.length]} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        <div className="graph-card">
          <div className="graph-header">
            <h3><FiPieChart size={18} style={{ color: '#1b4332' }} /> Vehicle Status Distribution</h3>
          </div>
          <div style={{ display: 'flex', justifyContent: 'center' }}>
            <ResponsiveContainer width="100%" height={280}>
              <PieChart>
                <Pie data={statusData} cx="50%" cy="50%" innerRadius={60} outerRadius={100} paddingAngle={3} dataKey="value" label={(entry: any) => `${entry.name} ${((entry.percent ?? 0) * 100).toFixed(0)}%`}>
                  {statusData.map((_: any, i: number) => (
                    <Cell key={i} fill={STATUS_COLORS[i % STATUS_COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
    </MainLayout>
  );
};

export default AnalyticsPage;
