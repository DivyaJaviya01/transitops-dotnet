import React, { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { FiDownload } from 'react-icons/fi';
import api, { exportFleetCsv } from '../../services/api';
import MainLayout from '../../components/layout/MainLayout';
import '../../components/page.css';

interface Vehicle { registrationNumber: string; name: string; type: string; odometer: number; }
interface Analytics { registrationNumber: string; fuelEfficiencyKmPerLiter: number; totalDistanceTraveledKm: number; totalOperationalCost: number; estimatedRevenue: number; roiPercentage: number; }

const ReportsPage = () => {
  const [selectedVehicle, setSelectedVehicle] = useState<string | null>(null);
  const { data: vehicles, isLoading } = useQuery<Vehicle[]>({ queryKey: ['vehicles-report'], queryFn: async () => { const res = await api.get('/vehicles'); return res.data; } });
  const { data: analytics, isLoading: isAnalyticsLoading } = useQuery<Analytics>({ queryKey: ['vehicle-analytics', selectedVehicle], queryFn: async () => { if (!selectedVehicle) return null; const res = await api.get(`/reports/analytics/${selectedVehicle}`); return res.data; }, enabled: !!selectedVehicle });

  const handleExportCSV = () => exportFleetCsv();

  return (
    <MainLayout>
      <div className="content-wrapper">
        <div className="page-header">
          <div>
            <h1>Reports & Analytics</h1>
            <p>Analyze vehicle efficiency, ROI metrics, and export reports</p>
          </div>
          <div className="page-header-actions">
            <button onClick={handleExportCSV} className="btn-ghost">
              <FiDownload /> Export Fleet CSV
            </button>
          </div>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1.5rem', marginTop: '1rem' }}>
          {/* Fleet Assets */}
          <div>
            <h3 style={{ fontFamily: "'Geist', sans-serif", fontWeight: 700, letterSpacing: '-0.01em', marginBottom: '0.75rem', fontSize: '1rem', color: 'var(--text-primary)' }}>Fleet Assets</h3>
            {isLoading ? (
              <p className="loading-state">Loading fleet list...</p>
            ) : !vehicles || vehicles.length === 0 ? (
              <p className="empty-state">No vehicles registered yet.</p>
            ) : (
              <div className="table-card">
                <div className="table-wrap">
                  <table>
                    <thead>
                      <tr>
                        <th>Vehicle</th>
                        <th>Type</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      {vehicles.map((v) => (
                        <tr key={v.registrationNumber} onClick={() => setSelectedVehicle(v.registrationNumber)}
                          style={{ cursor: 'pointer', background: selectedVehicle === v.registrationNumber ? 'rgba(27,67,50,0.04)' : undefined }}>
                          <td style={{ fontWeight: 700 }}>{v.name} ({v.registrationNumber})</td>
                          <td>{v.type}</td>
                          <td>
                            <button onClick={() => setSelectedVehicle(v.registrationNumber)} className="btn-ghost" style={{ fontSize: '0.72rem', padding: '0.2rem 0.6rem' }}>
                              Analyze
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

          {/* Analysis View */}
          <div>
            <h3 style={{ fontFamily: "'Geist', sans-serif", fontWeight: 700, letterSpacing: '-0.01em', marginBottom: '0.75rem', fontSize: '1rem', color: 'var(--text-primary)' }}>Vehicle Telemetry & ROI</h3>
            {!selectedVehicle ? (
              <div className="table-card" style={{ padding: '2.5rem', textAlign: 'center' }}>
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--accent-brand)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginBottom: '1rem' }}><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                <p className="empty-state">Select an asset from the left table to load financial and efficiency analytics.</p>
              </div>
            ) : isAnalyticsLoading ? (
              <p className="loading-state">Computing operational telemetry...</p>
            ) : analytics ? (
              <div className="table-card" style={{ padding: '1.5rem' }}>
                <h3 style={{ fontFamily: "'Geist', sans-serif", fontWeight: 700, letterSpacing: '-0.01em', marginBottom: '1rem', fontSize: '1.1rem', color: 'var(--text-primary)' }}>{selectedVehicle} Analytics</h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                  <div style={{ borderBottom: '1px solid var(--border-color)', paddingBottom: '0.75rem' }}>
                    <div className="stat-card-label">Fuel Efficiency</div>
                    <div style={{ fontWeight: 700, fontSize: '1.1rem' }}>{analytics.fuelEfficiencyKmPerLiter} km / Liter</div>
                  </div>
                  <div style={{ borderBottom: '1px solid var(--border-color)', paddingBottom: '0.75rem' }}>
                    <div className="stat-card-label">Total Distance Traveled</div>
                    <div style={{ fontWeight: 700, fontSize: '1.1rem' }}>{analytics.totalDistanceTraveledKm} km</div>
                  </div>
                  <div style={{ borderBottom: '1px solid var(--border-color)', paddingBottom: '0.75rem' }}>
                    <div className="stat-card-label">Operational Costs</div>
                    <div style={{ fontWeight: 700, fontSize: '1.1rem', color: '#f87171' }}>-${analytics.totalOperationalCost.toLocaleString()}</div>
                  </div>
                  <div style={{ borderBottom: '1px solid var(--border-color)', paddingBottom: '0.75rem' }}>
                    <div className="stat-card-label">Estimated Revenue</div>
                    <div style={{ fontWeight: 700, fontSize: '1.1rem', color: 'var(--accent-brand)' }}>+${analytics.estimatedRevenue.toLocaleString()}</div>
                  </div>
                  <div>
                    <div className="stat-card-label">Asset ROI</div>
                    <div style={{ fontWeight: 800, fontSize: '1.5rem', color: analytics.roiPercentage >= 0 ? 'var(--accent-brand)' : '#b91c1c' }}>
                      {analytics.roiPercentage}%
                    </div>
                  </div>
                </div>
              </div>
            ) : null}
          </div>
        </div>
      </div>
    </MainLayout>
  );
};

export default ReportsPage;
