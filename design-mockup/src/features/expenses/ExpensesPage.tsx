import React, { useState } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Toaster, toast } from 'sonner';
import { FiPlus, FiTrash2 } from 'react-icons/fi';
import api from '../../services/api';
import MainLayout from '../../components/layout/MainLayout';
import '../../components/page.css';

interface Vehicle { registrationNumber: string; name: string; }
interface Expense { id: string; amount: number; date: string; category: string; description?: string; vehicleId: string; vehicle: Vehicle; liters?: number; }
interface OperationalCost { vehicleId: string; fuelCost: number; expenseCost: number; totalOperationalCost: number; }

const ExpensesPage = () => {
  const queryClient = useQueryClient();
  const [showFuelModal, setShowFuelModal] = useState(false);
  const [showExpenseModal, setShowExpenseModal] = useState(false);
  const [selectedCostVehicle, setSelectedCostVehicle] = useState('');
  const [fuelForm, setFuelForm] = useState({ vehicleId: '', liters: '', cost: '', date: '' });
  const [expenseForm, setExpenseForm] = useState({ vehicleId: '', amount: '', category: 'Other', description: '', date: '' });

  const { data: vehicles } = useQuery<Vehicle[]>({ queryKey: ['vehicles-expense-options'], queryFn: async () => { const res = await api.get('/vehicles'); return res.data; } });
  const { data: expenses, isLoading } = useQuery<Expense[]>({ queryKey: ['expenses'], queryFn: async () => { const res = await api.get('/expenses'); return res.data; } });
  const { data: costData } = useQuery<OperationalCost>({ queryKey: ['operational-cost', selectedCostVehicle], queryFn: async () => { if (!selectedCostVehicle) return null; const res = await api.get(`/expenses/cost/${selectedCostVehicle}`); return res.data; }, enabled: !!selectedCostVehicle });

  const logFuelMutation = useMutation({
    mutationFn: async (payload: typeof fuelForm) => api.post('/expenses/fuel', payload),
    onSuccess: () => { ['expenses', 'operational-cost', 'kpis', 'vehicle-analytics'].forEach(k => queryClient.invalidateQueries({ queryKey: [k] })); toast.success('Fuel purchase log created successfully!'); setShowFuelModal(false); setFuelForm({ vehicleId: '', liters: '', cost: '', date: '' }); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Failed to log fuel'),
  });

  const logExpenseMutation = useMutation({
    mutationFn: async (payload: typeof expenseForm) => api.post('/expenses/other', payload),
    onSuccess: () => { ['expenses', 'operational-cost', 'kpis', 'vehicle-analytics'].forEach(k => queryClient.invalidateQueries({ queryKey: [k] })); toast.success('Expense logged successfully!'); setShowExpenseModal(false); setExpenseForm({ vehicleId: '', amount: '', category: 'Other', description: '', date: '' }); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Failed to log expense'),
  });

  const deleteExpenseMutation = useMutation({
    mutationFn: async (expense: any) => { if (expense.liters !== undefined) { await api.delete(`/expenses/fuel/${expense.id}`); } else { await api.delete(`/expenses/other/${expense.id}`); } },
    onSuccess: () => { ['expenses', 'operational-cost', 'kpis', 'vehicle-analytics'].forEach(k => queryClient.invalidateQueries({ queryKey: [k] })); toast.success('Entry deleted'); },
    onError: (err: any) => toast.error(err.response?.data?.error || 'Delete failed'),
  });

  return (
    <MainLayout>
      <Toaster position="top-right" richColors />
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Expenses</h1>
            <p>Log operational costs, fuel purchases, and compute vehicle total costs</p>
          </div>
          <div className="page-header-actions">
            <button onClick={() => setShowFuelModal(true)} className="btn-primary-sm">
              <FiPlus /> Log Fuel Purchase
            </button>
            <button onClick={() => setShowExpenseModal(true)} className="btn-primary-sm">
              <FiPlus /> Record Expense
            </button>
          </div>
        </div>

        {/* Cost Calculator */}
        <div className="table-card" style={{ padding: '1.25rem', marginBottom: '1.5rem' }}>
          <div className="form-field" style={{ marginBottom: 0 }}>
            <label className="form-label" style={{ marginBottom: '0.5rem' }}>Operational Cost Calculator</label>
            <select value={selectedCostVehicle} onChange={(e) => setSelectedCostVehicle(e.target.value)} className="form-select" style={{ maxWidth: '400px' }}>
              <option value="">-- Select Vehicle to Inspect --</option>
              {vehicles?.map((v) => (<option key={v.registrationNumber} value={v.registrationNumber}>{v.name} ({v.registrationNumber})</option>))}
            </select>
          </div>
          {costData && (
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: '1rem', marginTop: '1.25rem', borderTop: '1px solid var(--border-color)', paddingTop: '1.25rem' }}>
              <div>
                <div className="stat-card-label">Fuel Cost Sum</div>
                <div className="stat-card-value" style={{ fontSize: '1.25rem' }}>${costData.fuelCost.toLocaleString()}</div>
              </div>
              <div>
                <div className="stat-card-label">General Expenses</div>
                <div className="stat-card-value" style={{ fontSize: '1.25rem' }}>${costData.expenseCost.toLocaleString()}</div>
              </div>
              <div>
                <div className="stat-card-label">Total Cost</div>
                <div className="stat-card-value" style={{ fontSize: '1.25rem', color: 'var(--accent-brand)' }}>${costData.totalOperationalCost.toLocaleString()}</div>
              </div>
            </div>
          )}
        </div>

        {/* Fuel Modal */}
        {showFuelModal && (
          <div className="modal-overlay" onClick={() => setShowFuelModal(false)}>
            <div className="modal-card" style={{ maxWidth: '420px' }} onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Log Fuel Purchase</h3>
                <button onClick={() => setShowFuelModal(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <form onSubmit={(e) => { e.preventDefault(); if (!fuelForm.vehicleId || !fuelForm.liters || !fuelForm.cost) { toast.error('All fields are required'); return; } logFuelMutation.mutate(fuelForm); }}>
                <div className="form-field">
                  <label className="form-label">Vehicle</label>
                  <select value={fuelForm.vehicleId} onChange={(e) => setFuelForm({ ...fuelForm, vehicleId: e.target.value })} className="form-select">
                    <option value="">-- Choose Vehicle --</option>
                    {vehicles?.map((v) => (<option key={v.registrationNumber} value={v.registrationNumber}>{v.name} ({v.registrationNumber})</option>))}
                  </select>
                </div>
                <div className="form-row">
                  <div className="form-field">
                    <label className="form-label">Liters</label>
                    <input type="number" placeholder="e.g. 150" value={fuelForm.liters} onChange={(e) => setFuelForm({ ...fuelForm, liters: e.target.value })} className="form-input" required />
                  </div>
                  <div className="form-field">
                    <label className="form-label">Total Cost ($)</label>
                    <input type="number" placeholder="e.g. 450" value={fuelForm.cost} onChange={(e) => setFuelForm({ ...fuelForm, cost: e.target.value })} className="form-input" required />
                  </div>
                </div>
                <div className="form-actions">
                  <button type="button" onClick={() => setShowFuelModal(false)} className="btn-cancel">Cancel</button>
                  <button type="submit" className="btn-submit">Log Purchase</button>
                </div>
              </form>
            </div>
          </div>
        )}

        {/* Expense Modal */}
        {showExpenseModal && (
          <div className="modal-overlay" onClick={() => setShowExpenseModal(false)}>
            <div className="modal-card" style={{ maxWidth: '420px' }} onClick={(e) => e.stopPropagation()}>
              <div className="modal-header">
                <h3>Record Operational Expense</h3>
                <button onClick={() => setShowExpenseModal(false)} className="modal-close">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
                </button>
              </div>
              <form onSubmit={(e) => { e.preventDefault(); if (!expenseForm.vehicleId || !expenseForm.amount || !expenseForm.category) { toast.error('Required fields missing'); return; } logExpenseMutation.mutate(expenseForm); }}>
                <div className="form-field">
                  <label className="form-label">Vehicle</label>
                  <select value={expenseForm.vehicleId} onChange={(e) => setExpenseForm({ ...expenseForm, vehicleId: e.target.value })} className="form-select">
                    <option value="">-- Choose Vehicle --</option>
                    {vehicles?.map((v) => (<option key={v.registrationNumber} value={v.registrationNumber}>{v.name} ({v.registrationNumber})</option>))}
                  </select>
                </div>
                <div className="form-row">
                  <div className="form-field">
                    <label className="form-label">Amount ($)</label>
                    <input type="number" placeholder="e.g. 200" value={expenseForm.amount} onChange={(e) => setExpenseForm({ ...expenseForm, amount: e.target.value })} className="form-input" required />
                  </div>
                  <div className="form-field">
                    <label className="form-label">Category</label>
                    <select value={expenseForm.category} onChange={(e) => setExpenseForm({ ...expenseForm, category: e.target.value })} className="form-select">
                      <option value="Permit">Permit / Tolls</option>
                      <option value="Insurance">Insurance Renewal</option>
                      <option value="Other">Other Miscellaneous</option>
                    </select>
                  </div>
                </div>
                <div className="form-field">
                  <label className="form-label">Description</label>
                  <input type="text" placeholder="Reason / notes" value={expenseForm.description} onChange={(e) => setExpenseForm({ ...expenseForm, description: e.target.value })} className="form-input" />
                </div>
                <div className="form-actions">
                  <button type="button" onClick={() => setShowExpenseModal(false)} className="btn-cancel">Cancel</button>
                  <button type="submit" className="btn-submit">Record Expense</button>
                </div>
              </form>
            </div>
          </div>
        )}

        {/* Ledger */}
        <div style={{ marginTop: '1.5rem' }}>
          {isLoading ? (
            <p className="loading-state">Loading ledger...</p>
          ) : !expenses || expenses.length === 0 ? (
            <div className="table-card" style={{ padding: '2.5rem', textAlign: 'center' }}>
              <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--accent-brand)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginBottom: '1rem' }}><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
              <p className="empty-state">No operational expenses logged. Add logs using the buttons above.</p>
            </div>
          ) : (
            <div className="table-card">
              <div className="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>Vehicle</th>
                      <th>Expense Category</th>
                      <th>Description</th>
                      <th>Date</th>
                      <th>Cost Amount</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    {expenses.map((expense) => (
                      <tr key={expense.id}>
                        <td style={{ fontWeight: 700 }}>{expense.vehicle.name} ({expense.vehicleId})</td>
                        <td>{expense.category}</td>
                        <td>{expense.description || '—'}</td>
                        <td>{new Date(expense.date).toLocaleDateString()}</td>
                        <td style={{ fontWeight: 700, color: '#f87171' }}>-${expense.amount.toLocaleString()}</td>
                        <td>
                          <button onClick={() => { if (window.confirm('Delete this entry?')) deleteExpenseMutation.mutate(expense); }} className="btn-icon danger" title="Delete">
                            <FiTrash2 size={14} />
                          </button>
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

export default ExpensesPage;
