import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Toaster, toast } from 'sonner';
import { FiPlus, FiSend, FiCheck, FiX, FiTrash2 } from 'react-icons/fi';
import api from '../../services/api';
import MainLayout from '../../components/layout/MainLayout';
import '../../components/page.css';

interface Vehicle { registrationNumber: string; name: string; status: string; }
interface Driver { id: string; name: string; status: string; }
interface Trip { id: string; source: string; destination: string; cargoWeight: number; plannedDistance: number; actualDistance?: number; fuelConsumed?: number; status: string; vehicleId: string; driverId: string; vehicle: Vehicle; driver: Driver; }

const TripsPage = () => {
  const queryClient = useQueryClient();
  const [showModal, setShowModal] = useState(false);
  const [showCompleteModal, setShowCompleteModal] = useState(false);
  const [selectedTripId, setSelectedTripId] = useState<string | null>(null);
  const [completeForm, setCompleteForm] = useState({ actualDistance: '', fuelConsumed: '' });
  const [form, setForm] = useState({ source: '', destination: '', cargoWeight: '', plannedDistance: '', vehicleId: '', driverId: '' });

  const { data: trips, isLoading } = useQuery<Trip[]>({ queryKey: ['trips'], queryFn: async () => { const res = await api.get('/trips'); return res.data; } });
  const { data: vehicles } = useQuery<Vehicle[]>({ queryKey: ['available-vehicles'], queryFn: async () => { const res = await api.get('/vehicles'); return res.data.filter((v: Vehicle) => v.status === 'Available'); } });
  const { data: drivers } = useQuery<Driver[]>({ queryKey: ['available-drivers'], queryFn: async () => { const res = await api.get('/drivers'); return res.data.filter((d: Driver) => d.status === 'Available'); } });

  const invalidateAll = () => {
    ['trips', 'kpis', 'available-vehicles', 'available-drivers', 'vehicles', 'drivers', 'recent-trips'].forEach(k => queryClient.invalidateQueries({ queryKey: [k] }));
  };

  const createMutation = useMutation({
    mutationFn: async (newTrip: typeof form) => api.post('/trips', newTrip),
    onSuccess: () => { invalidateAll(); toast.success('Trip created successfully in Draft!'); setShowModal(false); setForm({ source: '', destination: '', cargoWeight: '', plannedDistance: '', vehicleId: '', driverId: '' }); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Failed to create trip'),
  });

  const dispatchMutation = useMutation({
    mutationFn: async (id: string) => api.patch(`/trips/${id}/dispatch`),
    onSuccess: () => { invalidateAll(); toast.success('Trip successfully dispatched!'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Dispatch failed'),
  });

  const completeMutation = useMutation({
    mutationFn: async ({ id, payload }: { id: string; payload: typeof completeForm }) => api.patch(`/trips/${id}/complete`, payload),
    onSuccess: () => { invalidateAll(); toast.success('Trip marked as completed!'); setShowCompleteModal(false); setSelectedTripId(null); setCompleteForm({ actualDistance: '', fuelConsumed: '' }); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Completion failed'),
  });

  const cancelMutation = useMutation({
    mutationFn: async (id: string) => api.patch(`/trips/${id}/cancel`),
    onSuccess: () => { invalidateAll(); toast.success('Trip has been cancelled.'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Cancellation failed'),
  });

  const deleteTripMutation = useMutation({
    mutationFn: async (id: string) => api.delete(`/trips/${id}`),
    onSuccess: () => { queryClient.invalidateQueries({ queryKey: ['trips'] }); queryClient.invalidateQueries({ queryKey: ['kpis'] }); toast.success('Trip deleted'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Delete failed'),
  });

  const getStatusBadge = (status: string) => {
    switch (status.toLowerCase()) {
      case 'completed': return <span className="badge badge-success"><span className="badge-dot"></span> Completed</span>;
      case 'dispatched': return <span className="badge badge-info"><span className="badge-dot"></span> Dispatched</span>;
      case 'cancelled': return <span className="badge badge-danger"><span className="badge-dot"></span> Cancelled</span>;
      default: return <span className="badge badge-default"><span className="badge-dot"></span> Draft</span>;
    }
  };

  return (
    <MainLayout>
      <Toaster position="top-right" richColors />
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Trips</h1>
            <p>Plan, dispatch, and track active deliveries</p>
          </div>
          <div className="page-header-actions">
            <button onClick={() => setShowModal(true)} className="btn-primary-sm">
              <FiPlus /> New Trip
            </button>
          </div>
        </div>

        {showModal && (
          <div className="modal-overlay" onClick={() => setShowModal(false)}>
            <div className="modal-card" onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Create New Trip</h3>
                <button onClick={() => setShowModal(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <form onSubmit={(e) => { e.preventDefault(); if (!form.source || !form.destination || !form.cargoWeight || !form.plannedDistance || !form.vehicleId || !form.driverId) { toast.error('Please fill in all fields'); return; } createMutation.mutate(form); }}>
                <div className="form-field">
                  <label className="form-label">Source Location</label>
                  <input type="text" placeholder="e.g. New York, NY" value={form.source} onChange={(e) => setForm({ ...form, source: e.target.value })} className="form-input" required />
                </div>
                <div className="form-field">
                  <label className="form-label">Destination Location</label>
                  <input type="text" placeholder="e.g. Boston, MA" value={form.destination} onChange={(e) => setForm({ ...form, destination: e.target.value })} className="form-input" required />
                </div>
                <div className="form-row">
                  <div className="form-field">
                    <label className="form-label">Cargo Weight (kg)</label>
                    <input type="number" placeholder="e.g. 5000" value={form.cargoWeight} onChange={(e) => setForm({ ...form, cargoWeight: e.target.value })} className="form-input" required />
                  </div>
                  <div className="form-field">
                    <label className="form-label">Planned Distance (km)</label>
                    <input type="number" placeholder="e.g. 350" value={form.plannedDistance} onChange={(e) => setForm({ ...form, plannedDistance: e.target.value })} className="form-input" required />
                  </div>
                </div>
                <div className="form-field">
                  <label className="form-label">Select Vehicle</label>
                  <select value={form.vehicleId} onChange={(e) => setForm({ ...form, vehicleId: e.target.value })} className="form-select">
                    <option value="">-- Choose Vehicle --</option>
                    {vehicles?.map((v) => (<option key={v.registrationNumber} value={v.registrationNumber}>{v.name} ({v.registrationNumber})</option>))}
                  </select>
                </div>
                <div className="form-field">
                  <label className="form-label">Select Driver</label>
                  <select value={form.driverId} onChange={(e) => setForm({ ...form, driverId: e.target.value })} className="form-select">
                    <option value="">-- Choose Driver --</option>
                    {drivers?.map((d) => (<option key={d.id} value={d.id}>{d.name}</option>))}
                  </select>
                </div>
                <div className="form-actions">
                  <button type="button" onClick={() => setShowModal(false)} className="btn-cancel">Cancel</button>
                  <button type="submit" className="btn-submit">Create</button>
                </div>
              </form>
            </div>
          </div>
        )}

        {showCompleteModal && (
          <div className="modal-overlay" onClick={() => { setShowCompleteModal(false); setSelectedTripId(null); }}>
            <div className="modal-card" style={{ maxWidth: '400px' }} onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Complete Delivery</h3>
                <button onClick={() => { setShowCompleteModal(false); setSelectedTripId(null); }} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <form onSubmit={(e) => { e.preventDefault(); if (!completeForm.actualDistance || !completeForm.fuelConsumed) { toast.error('All fields required'); return; } if (selectedTripId) completeMutation.mutate({ id: selectedTripId, payload: completeForm }); }}>
                <div className="form-field">
                  <label className="form-label">Actual Distance (km)</label>
                  <input type="number" placeholder="e.g. 340" value={completeForm.actualDistance} onChange={(e) => setCompleteForm({ ...completeForm, actualDistance: e.target.value })} className="form-input" required />
                </div>
                <div className="form-field">
                  <label className="form-label">Fuel Consumed (liters)</label>
                  <input type="number" placeholder="e.g. 120" value={completeForm.fuelConsumed} onChange={(e) => setCompleteForm({ ...completeForm, fuelConsumed: e.target.value })} className="form-input" required />
                </div>
                <div className="form-actions">
                  <button type="button" onClick={() => { setShowCompleteModal(false); setSelectedTripId(null); }} className="btn-cancel">Cancel</button>
                  <button type="submit" className="btn-submit">Save & Complete</button>
                </div>
              </form>
            </div>
          </div>
        )}

        <div style={{ marginTop: '1.5rem' }}>
          {isLoading ? (
            <p className="loading-state">Loading dispatcher logs...</p>
          ) : !trips || trips.length === 0 ? (
            <div className="table-card" style={{ padding: '2.5rem', textAlign: 'center' }}>
              <FiSend size={40} style={{ color: 'var(--accent-brand)', marginBottom: '1rem' }} />
              <p className="empty-state">No trip delivery logs. Plan a new trip route above.</p>
            </div>
          ) : (
            <div className="table-card">
              <div className="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>Route</th>
                      <th>Cargo Load</th>
                      <th>Distance</th>
                      <th>Vehicle ID</th>
                      <th>Driver Name</th>
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {trips.map((t) => (
                      <tr key={t.id}>
                        <td style={{ fontWeight: 700 }}>{t.source} &rarr; {t.destination}</td>
                        <td>{t.cargoWeight} kg</td>
                        <td>{t.status === 'Completed' ? `${t.actualDistance} km (actual)` : `${t.plannedDistance} km (planned)`}</td>
                        <td>{t.vehicle.name} ({t.vehicleId})</td>
                        <td>{t.driver.name}</td>
                        <td>{getStatusBadge(t.status)}</td>
                        <td>
                          <div style={{ display: 'flex', gap: '0.4rem', alignItems: 'center' }}>
                            {t.status === 'Draft' && (
                              <button onClick={() => dispatchMutation.mutate(t.id)} className="btn-ghost" style={{ fontSize: '0.72rem', padding: '0.2rem 0.6rem', gap: '0.2rem' }}>
                                <FiSend size={12} /> Dispatch
                              </button>
                            )}
                            {t.status === 'Dispatched' && (
                              <button onClick={() => { setSelectedTripId(t.id); setShowCompleteModal(true); }} className="btn-ghost" style={{ fontSize: '0.72rem', padding: '0.2rem 0.6rem', gap: '0.2rem' }}>
                                <FiCheck size={12} /> Complete
                              </button>
                            )}
                            {t.status !== 'Completed' && t.status !== 'Cancelled' && (
                              <button onClick={() => cancelMutation.mutate(t.id)} className="btn-icon danger" title="Cancel Trip">
                                <FiX size={14} />
                              </button>
                            )}
                            {t.status === 'Draft' && (
                              <button onClick={() => { if (window.confirm('Delete this trip?')) deleteTripMutation.mutate(t.id); }} className="btn-icon danger" title="Delete">
                                <FiTrash2 size={14} />
                              </button>
                            )}
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>
      </div>
    </MainLayout>
  );
};

export default TripsPage;
