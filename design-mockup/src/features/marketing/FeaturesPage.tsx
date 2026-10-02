import React from 'react';
import { Link } from 'react-router-dom';
import MarketingNavbar from './MarketingNavbar';
import Footer from '../landing/components/Footer';
import { useReveal } from '../landing/components/useReveal';
import { ColorIconTile, GradientText, RainbowHairline } from '../../components/decor/ColorBlobs';
import {
  PiUserSwitch, PiTruck, PiUserCircle, PiNavigationArrow, PiWrench,
  PiWallet, PiChartLineUp, PiCheckCircle,
} from 'react-icons/pi';
import './marketing.css';

const modules = [
  {
    icon: <PiUserSwitch size={20} />,
    color: 'is-blue' as const,
    title: 'Authentication & Role-Based Access',
    desc: 'Secure login with ASP.NET Core Identity and five distinct roles — Admin, Fleet Manager, Dispatcher, Safety Officer, Financial Analyst. Role-based authorization policies guard every seat in ops.',
  },
  {
    icon: <PiTruck size={20} />,
    color: 'is-green' as const,
    title: 'Vehicle Master Registry',
    desc: 'Full lifecycle tracking — registration plate, model, type, payload capacity, odometer, and acquisition cost. Live status states and a document vault for insurance, fitness certificates, and RC.',
  },
  {
    icon: <PiUserCircle size={20} />,
    color: 'is-orange' as const,
    title: 'Driver Compliance',
    desc: 'License verification, safety scorecards, and expiry alerts 30 days ahead. Expired licenses trigger red indicators and hard dispatch locks before a driver ever leaves the yard.',
  },
  {
    icon: <PiNavigationArrow size={20} />,
    color: 'is-pink' as const,
    title: 'Smart Dispatch & Trip Engine',
    desc: 'Plan, dispatch, and complete trips with automated payload, availability, and license validation at every step. Dual-entity status transitions are transactional — no partial state corruption.',
  },
  {
    icon: <PiWrench size={20} />,
    color: 'is-blue' as const,
    title: 'Maintenance Hub',
    desc: 'Work orders for oil changes, brake inspections, engine overhauls, and more. Active maintenance locks a vehicle InShop and hides it from dispatch; completion restores it automatically.',
  },
  {
    icon: <PiWallet size={20} />,
    color: 'is-green' as const,
    title: 'Cost & Expense Ledger',
    desc: 'Fuel logs, tolls, permits, parking, insurance, and routine repairs. Every expense posts against the vehicle that spent it, with automated per-vehicle operating cost calculation.',
  },
  {
    icon: <PiChartLineUp size={20} />,
    color: 'is-orange' as const,
    title: 'Executive Analytics & Reporting',
    desc: 'Live KPI cards, fleet health donuts, safety-score distributions, and per-vehicle ROI. One-click CSV export and formatted executive PDF reports for the decisions that move the fleet.',
  },
];

const rules = [
  { id: '1', name: 'Unique Vehicle Registration', desc: 'Every registration plate must be strictly unique across the platform.' },
  { id: '2', name: 'Dispatch Vehicle Pool', desc: 'Retired or InShop vehicles never appear in trip assignment dropdowns.' },
  { id: '3', name: 'Driver Compliance', desc: 'Drivers with expired licenses or Suspended/OffDuty status cannot be assigned.' },
  { id: '4', name: 'No Double Booking', desc: 'A vehicle or driver currently OnTrip cannot be assigned to another trip.' },
  { id: '5', name: 'Payload Limit Validation', desc: 'Cargo weight is always validated against maximum load capacity.' },
  { id: '6', name: 'Automatic Dispatch Transition', desc: 'Dispatching switches vehicle and driver to OnTrip and locks the start odometer.' },
  { id: '7', name: 'Automatic Completion Transition', desc: 'Completing restores availability, updates the odometer, and creates a fuel log.' },
  { id: '8', name: 'Automatic Cancellation Reversal', desc: 'Cancelling a dispatched trip instantly restores vehicle and driver availability.' },
  { id: '9', name: 'Maintenance Status Lock', desc: 'An active maintenance log switches the vehicle to InShop and removes it from dispatch.' },
  { id: '10', name: 'Maintenance Resolution', desc: 'Completing maintenance restores the vehicle to Available unless it is Retired.' },
];

export default function FeaturesPage() {
  const gridReveal = useReveal();
  const rulesReveal = useReveal();

  return (
    <div className="landing-body">
      <MarketingNavbar />
      <main>
        <section className="landing-container to-page-hero">
            <span className="to-eyebrow">Everything Included</span>
            <h1 className="to-page-title">One platform for the <GradientText>entire fleet lifecycle</GradientText></h1>
            <p className="to-page-sub">
              Seven modules that talk to each other — from acquisition and driver compliance to dispatch,
              maintenance, and cost analytics. Nothing gets lost between a fuel log and a work order.
            </p>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div className="to-section-head">
              <h2 className="to-h2">The seven modules</h2>
              <p className="to-lead">Every module enforces the business rules that keep your operations honest.</p>
            </div>
            <div
              ref={gridReveal.ref}
              className={`to-grid to-grid-3 ${gridReveal.visible ? 'is-visible' : ''}`}
            >
              {modules.map((m) => (
                <div key={m.title} className="to-card">
                  <ColorIconTile color={m.color}>{m.icon}</ColorIconTile>
                  <h3 className="to-card-title">{m.title}</h3>
                  <p className="to-card-desc">{m.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t" id="business-rules">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">Powered by Business Rules</span>
              <h2 className="to-h2">Software that guards the details your team forgets</h2>
              <p className="to-lead">
                Ten mandatory business rules keep the fleet safe — from capacity checks to license expiry validation.
              </p>
            </div>
            <div
              ref={rulesReveal.ref}
              className={`to-table-wrap ${rulesReveal.visible ? 'is-visible' : ''}`}
            >
              <table className="to-table">
                <thead>
                  <tr>
                    <th style={{ width: '80px' }}>Rule</th>
                    <th style={{ width: '300px' }}>Name</th>
                    <th>What it enforces</th>
                  </tr>
                </thead>
                <tbody>
                  {rules.map((r) => (
                    <tr key={r.id}>
                      <td>BR-{r.id}</td>
                      <td>{r.name}</td>
                      <td>{r.desc}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <section className="to-section hairline-t to-cta">
          <RainbowHairline />
          <div className="landing-container">
            <h2 className="to-cta-title">Ready to take your fleet operations seriously?</h2>
            <p className="to-cta-sub">
              Set up a workspace in minutes and get your fleet, drivers, and trips on one calm, clear platform today.
            </p>
            <div className="to-hero-actions">
              <Link to="/register" className="to-btn to-gradient-cta to-btn-lg">
                Get Started Free
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M5 12h14" />
                  <path d="m12 5 7 7-7 7" />
                </svg>
              </Link>
              <Link to="/contact" className="to-btn to-btn-light to-btn-lg">Talk to Sales</Link>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}