import { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '../../services/api';
import MainLayout from "../../components/layout/MainLayout.tsx";
import '../../components/page.css';

const statusBadgeCls: Record<string, string> = {
  'Available': 'badge badge-success',
  'On Trip': 'badge badge-info',
  'In Shop': 'badge badge-warning',
  'Retired': 'badge badge-default',
};

const VehicleForm = ({ onSubmit, onCancel, loading }: { onSubmit: (data: any) => void; onCancel: () => void; loading: boolean }) => {
  const [form, setForm] = useState({ registrationNumber: '', name: '', type: 'Truck', maxLoadCapacity: 0, odometer: 0, acquisitionCost: 0, status: 'Available' });
  return (
    <form onSubmit={(e) => { e.preventDefault(); onSubmit(form); }}>
      <div className="form-field">
        <label className="form-label">Registration Number</label>
        <input value={form.registrationNumber} onChange={(e) => setForm({ ...form, registrationNumber: e.target.value })} className="form-input" placeholder="e.g. VT-1234-X" required />
      </div>
      <div className="form-field">
        <label className="form-label">Vehicle Name</label>
        <input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} className="form-input" placeholder="e.g. Volvo FH16" required />
      </div>
      <div className="form-row">
        <div className="form-field">
          <label className="form-label">Type</label>
          <select value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} className="form-select">
            <option value="Truck">Truck</option>
            <option value="Van">Van</option>
            <option value="Sedan">Sedan</option>
          </select>
        </div>
        <div className="form-field">
          <label className="form-label">Status</label>
          <select value={form.status} onChange={(e) => setForm({ ...form, status: e.target.value })} className="form-select">
            <option value="Available">Available</option>
            <option value="On Trip">On Trip</option>
            <option value="In Shop">In Shop</option>
            <option value="Retired">Retired</option>
          </select>
        </div>
      </div>
      <div className="form-row">
        <div className="form-field">
          <label className="form-label">Max Load (kg)</label>
          <input type="number" value={form.maxLoadCapacity} onChange={(e) => setForm({ ...form, maxLoadCapacity: Number(e.target.value) })} className="form-input" min="0" required />
        </div>
        <div className="form-field">
          <label className="form-label">Odometer (km)</label>
          <input type="number" value={form.odometer} onChange={(e) => setForm({ ...form, odometer: Number(e.target.value) })} className="form-input" min="0" />
        </div>
      </div>
      <div className="form-field">
        <label className="form-label">Cost ($)</label>
        <input type="number" value={form.acquisitionCost} onChange={(e) => setForm({ ...form, acquisitionCost: Number(e.target.value) })} className="form-input" min="0" required />
      </div>
      <div className="form-actions">
        <button type="button" onClick={onCancel} className="btn-cancel">Cancel</button>
        <button type="submit" disabled={loading} className="btn-submit">{loading ? 'Saving...' : 'Save Vehicle'}</button>
      </div>
    </form>
  );
};

const VehicleRegistry: React.FC = () => {
  const [statusFilter, setStatusFilter] = useState('');
  const [typeFilter, setTypeFilter] = useState('');
  const [showAddVehicle, setShowAddVehicle] = useState(false);
  const [selectedVehicle, setSelectedVehicle] = useState<any>(null);
  const queryClient = useQueryClient();

  const addVehicleMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await api.post('/vehicles', data);
      return res.data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vehicles'] });
      queryClient.invalidateQueries({ queryKey: ['kpis'] });
      queryClient.invalidateQueries({ queryKey: ['available-vehicles'] });
      queryClient.invalidateQueries({ queryKey: ['vehicles-expense-options'] });
      queryClient.invalidateQueries({ queryKey: ['vehicles-maintenance-options'] });
      queryClient.invalidateQueries({ queryKey: ['vehicles-report'] });
      setShowAddVehicle(false);
    },
  });

  const deleteVehicleMutation = useMutation({
    mutationFn: async (regNo: string) => {
      await api.delete(`/vehicles/${regNo}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vehicles'] });
      queryClient.invalidateQueries({ queryKey: ['kpis'] });
    },
  });

  const { data: vehicles, isLoading } = useQuery({
    queryKey: ['vehicles', statusFilter, typeFilter],
    queryFn: async () => {
      const params = new URLSearchParams();
      if (statusFilter) params.set('status', statusFilter);
      if (typeFilter) params.set('type', typeFilter);
      const res = await api.get(`/vehicles?${params.toString()}`);
      return res.data;
    },
  });

  return (
    <MainLayout>
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Vehicle Registry</h1>
            <p>Fleet — All Assets</p>
          </div>
          <div className="page-header-actions">
            <button onClick={() => setShowAddVehicle(true)} className="btn-primary-sm">
              <span>+</span> ADD VEHICLE
            </button>
          </div>
        </div>

        <div className="stats-grid">
          <div className="stat-card">
            <div style={{ background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)' }} className="stat-card-icon">
              <span style={{ fontSize: '1.1rem' }}>🚛</span>
            </div>
            <div className="stat-card-label">Total Fleet</div>
            <div className="stat-card-value">{vehicles?.length ?? '...'} <span className="stat-card-sub">Assets</span></div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(45,106,79,0.12)', color: '#2d6a4f' }} className="stat-card-icon">
              <span style={{ fontSize: '1.1rem' }}>✓</span>
            </div>
            <div className="stat-card-label">Active (On Trip)</div>
            <div className="stat-card-value">{vehicles?.filter((v: any) => v.status === 'On Trip').length ?? '...'} <span className="stat-card-sub">Operational</span></div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(184,134,11,0.15)', color: '#fbbf24' }} className="stat-card-icon">
              <span style={{ fontSize: '1.1rem' }}>⚡</span>
            </div>
            <div className="stat-card-label">Maintenance</div>
            <div className="stat-card-value">{vehicles?.filter((v: any) => v.status === 'In Shop').length ?? '...'} <span className="stat-card-sub">In Shop</span></div>
          </div>
          <div className="stat-card">
            <div style={{ background: 'rgba(27,67,50,0.06)', color: 'var(--accent-brand)' }} className="stat-card-icon">
              <span style={{ fontSize: '1.1rem' }}>○</span>
            </div>
            <div className="stat-card-label">Available</div>
            <div className="stat-card-value">{vehicles?.filter((v: any) => v.status === 'Available').length ?? '...'} <span className="stat-card-sub">Ready</span></div>
          </div>
        </div>

        <div className="filter-bar">
          <div className="filter-bar-left">
            <span className="filter-label">Filters:</span>
            <select className="filter-select" value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)}>
              <option value="">All Statuses</option>
              <option value="Available">Available</option>
              <option value="On Trip">On Trip</option>
              <option value="In Shop">In Shop</option>
              <option value="Retired">Retired</option>
            </select>
            <select className="filter-select" value={typeFilter} onChange={(e) => setTypeFilter(e.target.value)}>
              <option value="">All Vehicle Types</option>
              <option value="Truck">Truck</option>
              <option value="Van">Van</option>
              <option value="Sedan">Sedan</option>
            </select>
            <button className="filter-clear" onClick={() => { setStatusFilter(''); setTypeFilter(''); }}>Clear All</button>
          </div>
          <span className="filter-count">Showing {vehicles?.length ?? 0} vehicles</span>
        </div>

        <div className="table-card">
          <div className="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>Vehicle ID</th>
                  <th>Name / Type</th>
                  <th>Status</th>
                  <th>Odometer</th>
                  <th>Capacity</th>
                  <th style={{ textAlign: 'right' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {isLoading && (
                  <tr><td colSpan={6} className="loading-state">Loading vehicles...</td></tr>
                )}
                {!isLoading && vehicles?.length === 0 && (
                  <tr><td colSpan={6} className="empty-state">No vehicles found</td></tr>
                )}
                {(vehicles || []).map((v: any) => (
                  <tr key={v.registrationNumber} onClick={() => setSelectedVehicle(v)} style={{ cursor: 'pointer' }}>
                    <td>
                      <div style={{ display: 'flex', flexDirection: 'column' }}>
                        <span style={{ fontWeight: 600 }}>{v.registrationNumber}</span>
                        <span style={{ fontSize: '0.75rem', color: 'var(--text-secondary)' }}>{v.name}</span>
                      </div>
                    </td>
                    <td>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        <span>{v.type === 'Truck' ? '🚛' : v.type === 'Van' ? '🚐' : '🚗'}</span>
                        <span>{v.type}</span>
                      </div>
                    </td>
                    <td>
                      <span className={statusBadgeCls[v.status] || statusBadgeCls['Available']}>
                        <span className="badge-dot"></span> {v.status.toUpperCase()}
                      </span>
                    </td>
                    <td>{v.odometer?.toLocaleString()} km</td>
                    <td>{v.maxLoadCapacity?.toLocaleString()} kg</td>
                    <td style={{ textAlign: 'right' }}>
                      <button onClick={(e) => { e.stopPropagation(); setSelectedVehicle(v); }} className="btn-icon" title="View Details">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                      </button>
                      <button onClick={(e) => { e.stopPropagation(); if (window.confirm('Delete this vehicle?')) deleteVehicleMutation.mutate(v.registrationNumber); }} className="btn-icon danger" title="Delete">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {selectedVehicle && (
          <div className="modal-overlay" onClick={() => setSelectedVehicle(null)}>
            <div className="modal-card" style={{ maxWidth: '420px' }} onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <div>
                  <h3>{selectedVehicle.registrationNumber}</h3>
                  <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)', margin: '0.1rem 0 0' }}>{selectedVehicle.name}</p>
                </div>
                <button onClick={() => setSelectedVehicle(null)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Type</span>
                  <span style={{ fontWeight: 600 }}>{selectedVehicle.type}</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Status</span>
                  <span className={statusBadgeCls[selectedVehicle.status] || statusBadgeCls['Available']}>
                    <span className="badge-dot"></span> {selectedVehicle.status.toUpperCase()}
                  </span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Odometer</span>
                  <span style={{ fontWeight: 600 }}>{selectedVehicle.odometer?.toLocaleString()} km</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', borderBottom: '1px solid var(--border-color)', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Max Load</span>
                  <span style={{ fontWeight: 600 }}>{selectedVehicle.maxLoadCapacity?.toLocaleString()} kg</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.5rem 0', fontSize: '0.85rem' }}>
                  <span style={{ color: 'var(--text-secondary)' }}>Acquisition Cost</span>
                  <span style={{ fontWeight: 600 }}>${selectedVehicle.acquisitionCost?.toLocaleString() || 'N/A'}</span>
                </div>
              </div>
            </div>
          </div>
        )}

        {showAddVehicle && (
          <div className="modal-overlay" onClick={() => setShowAddVehicle(false)}>
            <div className="modal-card" onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Add New Vehicle</h3>
                <button onClick={() => setShowAddVehicle(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <VehicleForm onSubmit={(data) => addVehicleMutation.mutate(data)} onCancel={() => setShowAddVehicle(false)} loading={addVehicleMutation.isPending} />
            </div>
          </div>
        )}
      </div>
    </MainLayout>
  );
};

export default VehicleRegistry;
