import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api, { exportDriversCsv } from '../../services/api';
import MainLayout from "../../components/layout/MainLayout.tsx";
import '../../components/page.css';

const statusBadgeCls: Record<string, string> = {
  'On Trip': 'badge badge-info',
  'Available': 'badge badge-success',
  'Off Duty': 'badge badge-default',
  'Suspended': 'badge badge-danger',
};

const DriverForm = ({ onSubmit, onCancel, loading }: { onSubmit: (data: any) => void; onCancel: () => void; loading: boolean }) => {
  const [form, setForm] = useState({ name: '', licenseNumber: '', licenseCategory: 'Class A', licenseExpiryDate: '', contactNumber: '', status: 'Available', safetyScore: 85 });
  return (
    <form onSubmit={(e) => { e.preventDefault(); onSubmit({ ...form, licenseExpiryDate: new Date(form.licenseExpiryDate) }); }}>
      <div className="form-field">
        <label className="form-label">Full Name</label>
        <input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} className="form-input" required />
      </div>
      <div className="form-row">
        <div className="form-field">
          <label className="form-label">License Number</label>
          <input value={form.licenseNumber} onChange={(e) => setForm({ ...form, licenseNumber: e.target.value })} className="form-input" required />
        </div>
        <div className="form-field">
          <label className="form-label">License Category</label>
          <select value={form.licenseCategory} onChange={(e) => setForm({ ...form, licenseCategory: e.target.value })} className="form-select">
            <option value="Class A">Class A</option>
            <option value="Class B">Class B</option>
            <option value="Class C">Class C</option>
          </select>
        </div>
      </div>
      <div className="form-field">
        <label className="form-label">Contact Number</label>
        <input value={form.contactNumber} onChange={(e) => setForm({ ...form, contactNumber: e.target.value })} className="form-input" placeholder="e.g. +1-555-1234" required />
      </div>
      <div className="form-row">
        <div className="form-field">
          <label className="form-label">License Expiry</label>
          <input type="date" value={form.licenseExpiryDate} onChange={(e) => setForm({ ...form, licenseExpiryDate: e.target.value })} className="form-input" required />
        </div>
        <div className="form-field">
          <label className="form-label">Status</label>
          <select value={form.status} onChange={(e) => setForm({ ...form, status: e.target.value })} className="form-select">
            <option value="Available">Available</option>
            <option value="On Trip">On Trip</option>
            <option value="Off Duty">Off Duty</option>
          </select>
        </div>
      </div>
      <div className="form-field">
        <label className="form-label">Safety Score (0-100)</label>
        <input type="number" value={form.safetyScore} onChange={(e) => setForm({ ...form, safetyScore: Number(e.target.value) })} className="form-input" min="0" max="100" />
      </div>
      <div className="form-actions">
        <button type="button" onClick={onCancel} className="btn-cancel">Cancel</button>
        <button type="submit" disabled={loading} className="btn-submit">{loading ? 'Saving...' : 'Save Driver'}</button>
      </div>
    </form>
  );
};

const DriversPage = () => {
  const [statusFilter, setStatusFilter] = useState('');
  const [viewMode, setViewMode] = useState<'list' | 'grid'>('list');
  const [showAddDriver, setShowAddDriver] = useState(false);
  const [selectedDriver, setSelectedDriver] = useState<any>(null);
  const queryClient = useQueryClient();

  const handleExportCSV = () => {
    exportDriversCsv();
  };

  const addDriverMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await api.post('/drivers', data);
      return res.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['drivers'] });
      queryClient.invalidateQueries({ queryKey: ['kpis'] });
      queryClient.invalidateQueries({ queryKey: ['available-drivers'] });
      setShowAddDriver(false);
    },
  });

  const deleteDriverMutation = useMutation({
    mutationFn: async (id: string) => {
      await api.delete(`/drivers/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['drivers'] });
      queryClient.invalidateQueries({ queryKey: ['kpis'] });
      queryClient.invalidateQueries({ queryKey: ['available-drivers'] });
    },
  });

  const { data: allDrivers, isLoading } = useQuery({
    queryKey: ['drivers', statusFilter],
    queryFn: async () => {
      const params = new URLSearchParams();
      if (statusFilter) params.set('status', statusFilter);
      const res = await api.get(`/drivers?${params.toString()}`);
      return res.data;
    },
  });

  const drivers = allDrivers || [];
  const totalPersonnel = drivers.length;
  const onTrip = drivers.filter((d: any) => d.status === 'On Trip').length;
  const available = drivers.filter((d: any) => d.status === 'Available').length;
  const avgSafety = drivers.length > 0
    ? (drivers.reduce((s: number, d: any) => s + (d.safetyScore || 0), 0) / drivers.length).toFixed(1)
    : '0';

  return (
    <MainLayout>
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Drivers</h1>
            <p>Personnel directory, safety scores, and availability</p>
          </div>
          <div className="page-header-actions">
            <button onClick={handleExportCSV} className="btn-ghost">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
              Export CSV
            </button>
            <button onClick={() => setShowAddDriver(true)} className="btn-primary-sm">
              <span>+</span> ADD DRIVER
            </button>
          </div>
        </div>

        <div className="stats-grid">
          <div className="stat-card">
            <div style={{ background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)' }} className="stat-card-icon">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </div>
            <div className="stat-card-label">Total Personnel</div>
            <div className="stat-card-value">{totalPersonnel}</div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(45,106,79,0.12)', color: '#2d6a4f' }} className="stat-card-icon">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
            </div>
            <div className="stat-card-label">On Trip</div>
            <div className="stat-card-value">{onTrip} <span className="stat-card-sub">{totalPersonnel > 0 ? Math.round((onTrip / totalPersonnel) * 100) : 0}%</span></div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)' }} className="stat-card-icon">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
            </div>
            <div className="stat-card-label">Available</div>
            <div className="stat-card-value">{available} <span className="stat-card-sub">Ready</span></div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(184,134,11,0.15)', color: '#fbbf24' }} className="stat-card-icon">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
            </div>
            <div className="stat-card-label">Avg Safety Score</div>
            <div className="stat-card-value">{avgSafety} <span className="stat-card-sub">/ 100</span></div>
          </div>
        </div>

        <div className="filter-bar">
          <div className="filter-bar-left">
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', background: 'var(--card-bg)', borderRadius: '8px', padding: '0.2rem', border: '1px solid var(--border-color)' }}>
              <button onClick={() => setViewMode('list')} className="btn-icon" style={{ background: viewMode === 'list' ? 'var(--table-row-hover)' : 'transparent' }}>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="8" y1="6" x2="21" y2="6"/><line x1="8" y1="12" x2="21" y2="12"/><line x1="8" y1="18" x2="21" y2="18"/><line x1="3" y1="6" x2="3.01" y2="6"/><line x1="3" y1="12" x2="3.01" y2="12"/><line x1="3" y1="18" x2="3.01" y2="18"/></svg>
              </button>
              <button onClick={() => setViewMode('grid')} className="btn-icon" style={{ background: viewMode === 'grid' ? 'var(--table-row-hover)' : 'transparent' }}>
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
              </button>
            </div>
            <span className="filter-label">Status:</span>
            <select className="filter-select" value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)}>
              <option value="">All Statuses</option>
              <option value="On Trip">On Trip</option>
              <option value="Available">Available</option>
              <option value="Off Duty">Off Duty</option>
              <option value="Suspended">Suspended</option>
            </select>
          </div>
          <span className="filter-count">Showing {drivers.length} drivers</span>
        </div>

        {viewMode === 'list' ? (
          <div className="table-card">
            <div className="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Personnel Name</th>
                    <th>ID / License</th>
                    <th>Status</th>
                    <th style={{ textAlign: 'center' }}>Safety Score</th>
                    <th>License Expiry</th>
                    <th style={{ textAlign: 'right' }}>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {isLoading && (
                    <tr><td colSpan={6} className="loading-state">Loading drivers...</td></tr>
                  )}
                  {!isLoading && drivers.length === 0 && (
                    <tr><td colSpan={6} className="empty-state">No drivers found</td></tr>
                  )}
                  {drivers.map((d: any) => {
                    const daysLeft = Math.ceil((new Date(d.licenseExpiryDate).getTime() - Date.now()) / (1000 * 60 * 60 * 24));
                    return (
                      <tr key={d.id}>
                        <td>
                          <div style={{ display: 'flex', alignItems: 'center', gap: '0.65rem' }}>
                            <div style={{ width: '36px', height: '36px', borderRadius: '50%', background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 600, fontSize: '0.75rem', flexShrink: 0 }}>
                              {d.name.split(' ').map((n: string) => n[0]).join('').slice(0, 2).toUpperCase()}
                            </div>
                            <div>
                              <div style={{ fontWeight: 600 }}>{d.name}</div>
                              <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>{d.licenseCategory}</div>
                            </div>
                          </div>
                        </td>
                        <td>#{d.licenseNumber}</td>
                        <td>
                          <span className={statusBadgeCls[d.status] || statusBadgeCls['Available']}>
                            <span className="badge-dot"></span> {d.status}
                          </span>
                        </td>
                        <td style={{ textAlign: 'center' }}>
                          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '0.2rem' }}>
                            <span style={{ fontWeight: 700, color: d.safetyScore >= 90 ? 'var(--accent-brand)' : d.safetyScore >= 80 ? '#92400e' : '#b91c1c' }}>{d.safetyScore}</span>
                            <div style={{ width: '64px', height: '4px', background: 'var(--surface-muted)', borderRadius: '2px', overflow: 'hidden' }}>
                              <div style={{ height: '100%', borderRadius: '2px', width: `${d.safetyScore}%`, background: d.safetyScore >= 90 ? 'var(--accent-brand)' : d.safetyScore >= 80 ? '#92400e' : '#b91c1c' }}></div>
                            </div>
                          </div>
                        </td>
                        <td>
                          <div style={{ fontSize: '0.82rem' }}>{new Date(d.licenseExpiryDate).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}</div>
                          <div style={{ fontSize: '0.68rem', fontWeight: 700, color: daysLeft <= 0 ? '#b91c1c' : daysLeft <= 30 ? '#92400e' : 'var(--accent-brand)' }}>
                            {daysLeft <= 0 ? 'EXPIRED' : `${daysLeft} days left`}
                          </div>
                        </td>
                        <td style={{ textAlign: 'right' }}>
                          <button onClick={() => setSelectedDriver(d)} className="btn-icon" title="View Details">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                          </button>
                          <button onClick={() => { if (window.confirm('Delete this driver?')) deleteDriverMutation.mutate(d.id); }} className="btn-icon danger" title="Delete">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                          </button>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>
        ) : (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(280px, 1fr))', gap: '1rem' }}>
            {isLoading && <p className="loading-state" style={{ gridColumn: '1 / -1' }}>Loading drivers...</p>}
            {!isLoading && drivers.length === 0 && <p className="empty-state" style={{ gridColumn: '1 / -1' }}>No drivers found</p>}
            {drivers.map((d: any) => {
              const daysLeft = Math.ceil((new Date(d.licenseExpiryDate).getTime() - Date.now()) / (1000 * 60 * 60 * 24));
              return (
                <div key={d.id} className="stat-card" style={{ cursor: 'pointer' }} onClick={() => setSelectedDriver(d)}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1rem' }}>
                    <div style={{ width: '44px', height: '44px', borderRadius: '50%', background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 600, fontSize: '0.9rem', flexShrink: 0 }}>
                      {d.name.split(' ').map((n: string) => n[0]).join('').slice(0, 2).toUpperCase()}
                    </div>
                    <div>
                      <div style={{ fontWeight: 600, fontSize: '0.95rem' }}>{d.name}</div>
                      <div style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>{d.licenseCategory}</div>
                    </div>
                  </div>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', fontSize: '0.82rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                      <span style={{ color: 'var(--text-secondary)' }}>License</span>
                      <span style={{ fontWeight: 600 }}>#{d.licenseNumber}</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                      <span style={{ color: 'var(--text-secondary)' }}>Status</span>
                      <span className={statusBadgeCls[d.status] || statusBadgeCls['Available']}>
                        <span className="badge-dot"></span> {d.status}
                      </span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                      <span style={{ color: 'var(--text-secondary)' }}>Safety Score</span>
                      <span style={{ fontWeight: 700, color: d.safetyScore >= 90 ? 'var(--accent-brand)' : d.safetyScore >= 80 ? '#92400e' : '#b91c1c' }}>{d.safetyScore}/100</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                      <span style={{ color: 'var(--text-secondary)' }}>Expiry</span>
                      <span style={{ fontWeight: 700, color: daysLeft <= 0 ? '#b91c1c' : daysLeft <= 30 ? '#92400e' : 'var(--accent-brand)' }}>
                        {new Date(d.licenseExpiryDate).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                      </span>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {selectedDriver && (
          <div className="modal-overlay" onClick={() => setSelectedDriver(null)}>
            <div className="modal-card" style={{ maxWidth: '420px' }} onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <div style={{ display: 'flex', gap: '0.75rem', alignItems: 'center' }}>
                  <div style={{ width: '44px', height: '44px', borderRadius: '50%', background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 600, fontSize: '0.9rem', flexShrink: 0 }}>
                    {selectedDriver.name.split(' ').map((n: string) => n[0]).join('').slice(0, 2).toUpperCase()}
                  </div>
                  <div>
                    <h3 style={{ margin: 0 }}>{selectedDriver.name}</h3>
                    <p style={{ margin: '0.1rem 0 0', fontSize: '0.82rem', color: 'var(--text-secondary)' }}>{selectedDriver.licenseCategory}</p>
                  </div>
                </div>
                <button onClick={() => setSelectedDriver(null)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>License Number</span>
                  <span style={{ fontWeight: 600 }}>#{selectedDriver.licenseNumber}</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Status</span>
                  <span className={statusBadgeCls[selectedDriver.status] || statusBadgeCls['Available']}>
                    <span className="badge-dot"></span> {selectedDriver.status}
                  </span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Safety Score</span>
                  <span style={{ fontWeight: 700, color: selectedDriver.safetyScore >= 90 ? 'var(--accent-brand)' : selectedDriver.safetyScore >= 80 ? '#92400e' : '#b91c1c' }}>{selectedDriver.safetyScore}/100</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>License Expiry</span>
                  <span style={{ fontWeight: 600 }}>{new Date(selectedDriver.licenseExpiryDate).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}</span>
                </div>
              </div>
            </div>
          </div>
        )}

        {showAddDriver && (
          <div className="modal-overlay" onClick={() => setShowAddDriver(false)}>
            <div className="modal-card" onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Add New Driver</h3>
                <button onClick={() => setShowAddDriver(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <DriverForm onSubmit={(data) => addDriverMutation.mutate(data)} onCancel={() => setShowAddDriver(false)} loading={addDriverMutation.isPending} />
            </div>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default DriversPage;
