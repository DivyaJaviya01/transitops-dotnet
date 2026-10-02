import React from 'react';
import { useReveal } from './useReveal';

const stats = [
  { value: '94%', label: 'Average fleet utilization across managed vehicles' },
  { value: '3.2k+', label: 'Trips dispatched and tracked end-to-end' },
  { value: '99.9%', label: 'Operational uptime for your control plane' },
  { value: '11', label: 'Business rules enforced without human follow-up' },
];

export default function Stats() {
  const { ref, visible } = useReveal();

  return (
    <section className="to-section hairline-t" id="stats" style={{ padding: '72px 0' }}>
      <div className="landing-container">
        <div ref={ref} className={`to-stats ${visible ? 'is-visible' : ''}`}>
          {stats.map((s) => (
            <div key={s.label} className="to-stat">
              <div className="to-stat-value">{s.value}</div>
              <div className="to-stat-label">{s.label}</div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}