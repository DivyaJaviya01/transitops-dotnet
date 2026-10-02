import React from 'react';
import { PiTruck, PiUserCircle, PiNavigationArrow, PiWrench, PiWallet, PiChartLineUp, PiBellRinging, PiGauge, PiShieldCheck, PiClipboardText } from 'react-icons/pi';
import { useReveal } from './useReveal';

const features = [
  {
    icon: <PiTruck size={20} />,
    title: 'Fleet Management',
    desc: 'Track every vehicle — type, load capacity, odometer, and status — from acquisition to retirement.',
  },
  {
    icon: <PiUserCircle size={20} />,
    title: 'Driver Management',
    desc: 'Licenses, safety scores, and availability in one place. Expiry warnings before they become problems.',
  },
  {
    icon: <PiNavigationArrow size={20} />,
    title: 'Dispatch & Trips',
    desc: 'Plan, dispatch, and complete trips with built-in capacity and license validation at every step.',
  },
  {
    icon: <PiWrench size={20} />,
    title: 'Maintenance Scheduling',
    desc: 'Open and close work orders, track repair costs, and keep vehicles out of the shop only when they must be.',
  },
  {
    icon: <PiWallet size={20} />,
    title: 'Expense Tracking',
    desc: 'Fuel logs, tolls, parking, and permits. Every dollar accounted for against the vehicle that spent it.',
  },
  {
    icon: <PiChartLineUp size={20} />,
    title: 'Reports & Analytics',
    desc: 'KPI dashboards, vehicle ROI, and one-click CSV export for the decisions that move the fleet.',
  },
];

const productPoints = [
  { icon: <PiBellRinging size={18} />, text: 'Role-aware alerts for the events that matter' },
  { icon: <PiGauge size={18} />, text: 'Real-time utilization and efficiency insights' },
  { icon: <PiShieldCheck size={18} />, text: 'Role-based access for every seat in ops' },
  { icon: <PiClipboardText size={18} />, text: 'Active & closed maintenance with cost history' },
];

export default function Features() {
  const reveal = useReveal();
  const productReveal = useReveal();

  return (
    <>
      <section className="to-section hairline-t" id="features">
        <div className="landing-container">
          <div className="to-section-head">
            <span className="to-eyebrow">Everything Included</span>
            <h2 className="to-h2">One platform for the entire fleet lifecycle</h2>
            <p className="to-lead">
              Seven modules that talk to each other — so nothing gets lost between a fuel log and a work order.
            </p>
          </div>

          <div
            ref={reveal.ref}
            className={`to-grid to-grid-3 ${reveal.visible ? 'is-visible' : ''}`}
          >
            {features.map((f) => (
              <div key={f.title} className="to-card">
                <span className="to-card-icon">{f.icon}</span>
                <h3 className="to-card-title">{f.title}</h3>
                <p className="to-card-desc">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="to-section hairline-t" id="product">
        <div className="landing-container">
          <div className="to-section-head">
            <span className="to-eyebrow">Powered by Business Rules</span>
            <h2 className="to-h2">Software that guards the details your team forgets</h2>
            <p className="to-lead">
              Eleven built-in rules keep your operations honest — from capacity checks to licence expiry validation.
            </p>
          </div>

          <div
            ref={productReveal.ref}
            className={`to-grid to-grid-2 ${productReveal.visible ? 'is-visible' : ''}`}
          >
            <div className="to-card">
              <h3 className="to-card-title">Dispatch, without the paper trail</h3>
              <p className="to-card-desc">
                Every trip moves through a clear pipeline — Draft, Dispatched, Completed. The system refuses an
                over-capacity vehicle or an expired licence before it ever leaves the yard.
              </p>
            </div>
            <div className="to-card">
              <h3 className="to-card-title">Costs that close the loop</h3>
              <p className="to-card-desc">
                Close a maintenance order and the expense posts itself. Finish a trip and the fuel log is
                recorded. No double entry, no missing receipts.
              </p>
            </div>
          </div>

          <div className="to-grid to-grid-2" style={{ marginTop: '18px' }}>
            <div className="to-card">
              <ul className="to-footer-list" style={{ gap: '16px' }}>
                {productPoints.map((p) => (
                  <li key={p.text} style={{ display: 'flex', alignItems: 'center', gap: '12px', fontSize: '14.5px', color: 'var(--to-ink-soft)' }}>
                    <span className="to-card-icon" style={{ width: 32, height: 32, margin: 0, borderRadius: 8 }}>
                      {p.icon}
                    </span>
                    {p.text}
                  </li>
                ))}
              </ul>
            </div>
            <div className="to-card" style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', gap: '6px' }}>
              <p className="to-card-desc" style={{ marginBottom: '8px' }}>
                The dashboard answers the three questions every manager asks:
              </p>
              <p className="to-card-desc" style={{ fontWeight: 650, color: 'var(--to-ink)' }}>How much of the fleet is earning right now?</p>
              <p className="to-card-desc" style={{ fontWeight: 650, color: 'var(--to-ink)' }}>Which trip is at risk of going sideways?</p>
              <p className="to-card-desc" style={{ fontWeight: 650, color: 'var(--to-ink)' }}>Where did the money go this month?</p>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}