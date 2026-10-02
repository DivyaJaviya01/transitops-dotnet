import React from 'react';
import { Link } from 'react-router-dom';
import MarketingNavbar from './MarketingNavbar';
import Footer from '../landing/components/Footer';
import { useReveal } from '../landing/components/useReveal';
import { GradientText, RainbowHairline } from '../../components/decor/ColorBlobs';
import { PiCheck, PiMinus } from 'react-icons/pi';
import './marketing.css';

const plans = [
  {
    name: 'Starter',
    desc: 'For small fleets getting off the spreadsheet.',
    price: '$49',
    period: 'per month',
    cta: 'Start Free Trial',
    to: '/register',
    featured: false,
    features: [
      'Up to 10 vehicles',
      'Vehicle registry & odometer tracking',
      'Driver profiles & license expiry alerts',
      'Up to 50 trips per month',
      'Basic maintenance work orders',
      'Email support',
    ],
  },
  {
    name: 'Growth',
    desc: 'For operations teams running the daily grind.',
    price: '$129',
    period: 'per month',
    cta: 'Start Free Trial',
    to: '/register',
    featured: true,
    features: [
      'Up to 50 vehicles',
      'Everything in Starter',
      'Unlimited trips with smart dispatch',
      'Fuel logging & expense ledger',
      'Executive dashboard & KPI cards',
      'Per-vehicle ROI analytics',
      'CSV & PDF report export',
      'Priority support',
    ],
  },
  {
    name: 'Enterprise',
    desc: 'For multi-hub fleets with custom needs.',
    price: 'Custom',
    period: 'talk to sales',
    cta: 'Talk to Sales',
    to: '/contact',
    featured: false,
    features: [
      'Unlimited vehicles & users',
      'Everything in Growth',
      'Role-based access control',
      'Custom business rules',
      'Onboarding & training',
      'Dedicated support manager',
    ],
  },
];

const comparison = [
  { feature: 'Vehicles', starter: '10', growth: '50', enterprise: 'Unlimited' },
  { feature: 'Smart dispatch engine', starter: false, growth: true, enterprise: true },
  { feature: 'Maintenance work orders', starter: true, growth: true, enterprise: true },
  { feature: 'Fuel & expense ledger', starter: false, growth: true, enterprise: true },
  { feature: 'Executive dashboard & KPIs', starter: false, growth: true, enterprise: true },
  { feature: 'Per-vehicle ROI analytics', starter: false, growth: true, enterprise: true },
  { feature: 'CSV & PDF export', starter: false, growth: true, enterprise: true },
  { feature: 'Role-based access (5 roles)', starter: false, growth: true, enterprise: true },
  { feature: 'Custom business rules', starter: false, growth: false, enterprise: true },
];

const faqs = [
  {
    q: 'Do I need a credit card to start?',
    a: 'No. Every plan starts with a free 14-day trial. No credit card required and no obligation — set up a workspace in minutes.',
  },
  {
    q: 'Can I change plans later?',
    a: 'Yes. You can upgrade or downgrade at any time. Changes take effect on your next billing cycle and we never prorate retroactively.',
  },
  {
    q: 'What happens when I hit my plan limits?',
    a: 'We never cut you off mid-operation. You will see a friendly upgrade prompt in the app; your data stays safe and exportable at any time.',
  },
  {
    q: 'Is my fleet data exportable?',
    a: 'Always. One-click CSV export for every ledger, plus a formatted executive PDF report. Your data belongs to you.',
  },
];

function Cell({ value }: { value: boolean | string }) {
  if (typeof value === 'boolean') {
    return value ? (
      <span style={{ color: 'var(--to-accent)', display: 'inline-flex' }}><PiCheck size={18} /></span>
    ) : (
      <span style={{ color: 'var(--to-ink-muted)', display: 'inline-flex' }}><PiMinus size={18} /></span>
    );
  }
  return <span>{value}</span>;
}

export default function PricingPage() {
  const pricingReveal = useReveal();
  const compareReveal = useReveal();
  const faqReveal = useReveal();

  return (
    <div className="landing-body">
      <MarketingNavbar />
      <main>
        <section className="landing-container to-page-hero">
            <span className="to-eyebrow">Pricing</span>
            <h1 className="to-page-title">Simple pricing that <GradientText>scales with your fleet</GradientText></h1>
            <p className="to-page-sub">
              Start free, upgrade when you grow. Every plan includes the full fleet lifecycle —
              vehicles, drivers, trips, maintenance, and expenses.
            </p>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div
              ref={pricingReveal.ref}
              className={`to-pricing-grid ${pricingReveal.visible ? 'is-visible' : ''}`}
            >
              {plans.map((p) => (
                <div key={p.name} className={`to-price-card ${p.featured ? 'is-featured' : ''}`}>
                  {p.featured && <span className="to-price-tag">Most Popular</span>}
                  <h3 className="to-price-name">{p.name}</h3>
                  <p className="to-price-desc">{p.desc}</p>
                  <div className="to-price-amount">
                    <span className="amount">{p.price}</span>
                    <span className="period">{p.period}</span>
                  </div>
                  <ul className="to-price-list">
                    {p.features.map((f) => (
                      <li key={f}>
                        <span style={{ color: 'var(--to-accent)', display: 'inline-flex', marginTop: 2 }}><PiCheck size={16} /></span>
                        {f}
                      </li>
                    ))}
                  </ul>
                  <Link
                    to={p.to}
                    className={p.featured ? 'to-btn to-btn-primary to-btn-lg' : 'to-btn to-btn-light to-btn-lg'}
                    style={{ width: '100%' }}
                  >
                    {p.cta}
                  </Link>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t" id="comparison">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">Compare</span>
              <h2 className="to-h2">What's in each plan</h2>
            </div>
            <div
              ref={compareReveal.ref}
              className={`to-table-wrap ${compareReveal.visible ? 'is-visible' : ''}`}
            >
              <table className="to-table">
                <thead>
                  <tr>
                    <th>Feature</th>
                    <th style={{ textAlign: 'center' }}>Starter</th>
                    <th style={{ textAlign: 'center' }}>Growth</th>
                    <th style={{ textAlign: 'center' }}>Enterprise</th>
                  </tr>
                </thead>
                <tbody>
                  {comparison.map((row) => (
                    <tr key={row.feature}>
                      <td style={{ fontWeight: 600, color: 'var(--to-ink)' }}>{row.feature}</td>
                      <td style={{ textAlign: 'center' }}><Cell value={row.starter} /></td>
                      <td style={{ textAlign: 'center' }}><Cell value={row.growth} /></td>
                      <td style={{ textAlign: 'center' }}><Cell value={row.enterprise} /></td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <section className="to-section hairline-t" id="faq">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">FAQ</span>
              <h2 className="to-h2">Frequently asked questions</h2>
            </div>
            <div
              ref={faqReveal.ref}
              className={`to-faq-list ${faqReveal.visible ? 'is-visible' : ''}`}
            >
              {faqs.map((f) => (
                <div key={f.q} className="to-faq-item">
                  <h3 className="to-faq-q">{f.q}</h3>
                  <p className="to-faq-a">{f.a}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t to-cta">
          <RainbowHairline />
          <div className="landing-container">
            <h2 className="to-cta-title">Start your <GradientText>free trial</GradientText> today</h2>
            <p className="to-cta-sub">
              No credit card required. Set up a workspace and put your fleet, drivers, and trips
              on one calm, clear platform in minutes.
            </p>
            <div className="to-hero-actions">
              <Link to="/register" className="to-btn to-gradient-cta to-btn-lg">Get Started Free</Link>
              <Link to="/contact" className="to-btn to-btn-light to-btn-lg">Talk to Sales</Link>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}