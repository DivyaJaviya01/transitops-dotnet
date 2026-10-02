import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Toaster, toast } from 'sonner';
import { FiPlus, FiCheck, FiTrash2 } from 'react-icons/fi';
import api from '../../services/api';
import MainLayout from '../../components/layout/MainLayout';
import '../../components/page.css';

interface Vehicle { registrationNumber: string; name: string; status: string; }
interface MaintenanceLog { id: string; type: string; cost: number; startDate: string; estimatedCompletionDate: string; actualCompletionDate?: string; status: string; vehicleId: string; vehicle: Vehicle; }

const MaintenancePage = () => {
  const queryClient = useQueryClient();
  const [showModal, setShowModal] = useState(false);
  const [form, setForm] = useState({ vehicleId: '', type: 'Routine Oil Change', cost: '', startDate: '', estimatedCompletionDate: '' });

  const { data: logs, isLoading } = useQuery<MaintenanceLog[]>({ queryKey: ['maintenance-logs'], queryFn: async () => { const res = await api.get('/maintenance'); return res.data; } });
  const { data: vehicles } = useQuery<Vehicle[]>({ queryKey: ['vehicles-maintenance-options'], queryFn: async () => { const res = await api.get('/vehicles'); return res.data.filter((v: Vehicle) => v.status !== 'Retired'); } });

  const invalidateAll = () => { ['maintenance-logs', 'vehicles', 'kpis', 'available-vehicles', 'vehicles-expense-options', 'vehicles-report'].forEach(k => queryClient.invalidateQueries({ queryKey: [k] })); };

  const createMutation = useMutation({
    mutationFn: async (newLog: typeof form) => api.post('/maintenance', newLog),
    onSuccess: () => { invalidateAll(); toast.success('Vehicle placed in shop for maintenance successfully!'); setShowModal(false); setForm({ vehicleId: '', type: 'Routine Oil Change', cost: '', startDate: '', estimatedCompletionDate: '' }); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Scheduling failed'),
  });

  const closeMutation = useMutation({
    mutationFn: async (id: string) => api.patch(`/maintenance/${id}/close`, { actualCompletionDate: new Date().toISOString() }),
    onSuccess: () => { invalidateAll(); toast.success('Maintenance completed. Vehicle returned to Available status.'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Failed to close log'),
  });

  const deleteMaintenanceMutation = useMutation({
    mutationFn: async (id: string) => api.delete(`/maintenance/${id}`),
    onSuccess: () => { invalidateAll(); toast.success('Maintenance entry deleted'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Delete failed'),
  });

  return (
    <MainLayout>
      <Toaster position="top-right" richColors />
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Maintenance</h1>
            <p>Schedule services and track active repair logs</p>
          </div>
          <div className="page-header-actions">
            <button onClick={() => setShowModal(true)} className="btn-primary-sm">
              <FiPlus /> Schedule Service
            </button>
          </div>
        </div>

        {showModal && (
          <div className="modal-overlay" onClick={() => setShowModal(false)}>
            <div className="modal-card" onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Schedule Vehicle Maintenance</h3>
                <button onClick={() => setShowModal(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <form onSubmit={(e) => { e.preventDefault(); if (!form.vehicleId || !form.type || !form.cost || !form.startDate || !form.estimatedCompletionDate) { toast.error('Please fill in all fields'); return; } createMutation.mutate(form); }}>
                <div className="form-field">
                  <label className="form-label">Vehicle</label>
                  <select value={form.vehicleId} onChange={(e) => setForm({ ...form, vehicleId: e.target.value })} className="form-select">
                    <option value="">-- Select Vehicle --</option>
                    {vehicles?.map((v) => (<option key={v.registrationNumber} value={v.registrationNumber}>{v.name} ({v.registrationNumber}) — {v.status}</option>))}
                  </select>
                </div>
                <div className="form-field">
                  <label className="form-label">Service Type</label>
                  <select value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} className="form-select">
                    <option value="Routine Oil Change">Routine Oil Change</option>
                    <option value="Tire Rotation/Replacement">Tire Rotation/Replacement</option>
                    <option value="Brake Pad Service">Brake Pad Service</option>
                    <option value="Engine Repair">Engine Repair</option>
                    <option value="Body work">Body work</option>
                  </select>
                </div>
                <div className="form-field">
                  <label className="form-label">Estimated Cost ($)</label>
                  <input type="number" placeholder="e.g. 450" value={form.cost} onChange={(e) => setForm({ ...form, cost: e.target.value })} className="form-input" required />
                </div>
                <div className="form-row">
                  <div className="form-field">
                    <label className="form-label">Start Date</label>
                    <input type="date" value={form.startDate} onChange={(e) => setForm({ ...form, startDate: e.target.value })} className="form-input" required />
                  </div>
                  <div className="form-field">
                    <label className="form-label">Est. Completion</label>
                    <input type="date" value={form.estimatedCompletionDate} onChange={(e) => setForm({ ...form, estimatedCompletionDate: e.target.value })} className="form-input" required />
                  </div>
                </div>
                <div className="form-actions">
                  <button type="button" onClick={() => setShowModal(false)} className="btn-cancel">Cancel</button>
                  <button type="submit" className="btn-submit">Schedule</button>
                </div>
              </form>
            </div>
          </div>
        )}

        <div style={{ marginTop: '1.5rem' }}>
          {isLoading ? (
            <p className="loading-state">Loading logs...</p>
          ) : !logs || logs.length === 0 ? (
            <div className="table-card" style={{ padding: '2.5rem', textAlign: 'center' }}>
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--accent-brand)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginBottom: '1rem' }}><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>
              <p className="empty-state">No maintenance logs. Click the button to schedule service.</p>
            </div>
          ) : (
            <div className="table-card">
              <div className="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>Vehicle</th>
                      <th>Service Type</th>
                      <th>Cost</th>
                      <th>Start Date</th>
                      <th>Estimated End</th>
                      <th>Status</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {logs.map((log) => (
                      <tr key={log.id}>
                        <td style={{ fontWeight: 700 }}>{log.vehicle.name} ({log.vehicleId})</td>
                        <td>{log.type}</td>
                        <td>${log.cost.toLocaleString()}</td>
                        <td>{new Date(log.startDate).toLocaleDateString()}</td>
                        <td>{new Date(log.estimatedCompletionDate).toLocaleDateString()}</td>
                        <td>
                          {log.status === 'Closed' ? (
                            <span className="badge badge-success"><span className="badge-dot"></span> Closed</span>
                          ) : (
                            <span className="badge badge-warning"><span className="badge-dot"></span> Active</span>
                          )}
                        </td>
                        <td>
                          <div style={{ display: 'flex', gap: '0.4rem', alignItems: 'center' }}>
                            {log.status === 'Active' && (
                              <>
                                <button onClick={() => closeMutation.mutate(log.id)} className="btn-ghost" style={{ fontSize: '0.72rem', padding: '0.2rem 0.6rem', gap: '0.2rem' }}>
                                  <FiCheck size={12} /> Close
                                </button>
                                <button onClick={() => { if (window.confirm('Delete this maintenance entry?')) deleteMaintenanceMutation.mutate(log.id); }} className="btn-icon danger" title="Delete">
                                  <FiTrash2 size={14} />
                                </button>
                              </>
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

export default MaintenancePage;
