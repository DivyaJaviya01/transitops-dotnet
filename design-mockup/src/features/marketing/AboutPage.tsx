import React from 'react';
import { Link } from 'react-router-dom';
import MarketingNavbar from './MarketingNavbar';
import Footer from '../landing/components/Footer';
import { useReveal } from '../landing/components/useReveal';
import { GradientText, RainbowHairline, ColorIconTile } from '../../components/decor/ColorBlobs';
import { PiTarget, PiShieldCheck, PiLightning, PiUsersThree } from 'react-icons/pi';
import './marketing.css';

const values = [
  {
    icon: <PiTarget size={20} />,
    color: 'is-blue' as const,
    title: 'Operational clarity',
    desc: 'Every vehicle, driver, and expense should answer a question instantly — not live in a spreadsheet someone else owns.',
  },
  {
    icon: <PiShieldCheck size={20} />,
    color: 'is-green' as const,
    title: 'Rules over memory',
    desc: 'The platform enforces the ten business rules your team should never have to remember by hand.',
  },
  {
    icon: <PiLightning size={20} />,
    color: 'is-orange' as const,
    title: 'Calm by design',
    desc: 'A minimal, Stripe-inspired interface that stays out of the way so your team can dispatch faster and spend less.',
  },
  {
    icon: <PiUsersThree size={20} />,
    color: 'is-pink' as const,
    title: 'Built for every seat',
    desc: 'Five roles, one workspace. Dispatchers, safety officers, analysts, and managers all see what they need.',
  },
];

const team = [
  { initials: 'DJ', name: 'Divya Javiya', role: 'Product & Engineering', color: 'is-blue' as const },
  { initials: 'RT', name: 'Runtime Terrors', role: 'Design & Experience', color: 'is-pink' as const },
  { initials: 'TO', name: 'TransitOps Crew', role: 'Operations & Testing', color: 'is-green' as const },
  { initials: 'TS', name: 'Transit Solutions', role: 'Research & Data', color: 'is-orange' as const },
];

const stats = [
  { value: '94%', label: 'Average fleet utilization across managed vehicles' },
  { value: '3.2k+', label: 'Trips dispatched and tracked end-to-end' },
  { value: '99.9%', label: 'Operational uptime for your control plane' },
  { value: '10', label: 'Business rules enforced without human follow-up' },
];

export default function AboutPage() {
  const valuesReveal = useReveal();
  const teamReveal = useReveal();

  return (
    <div className="landing-body">
      <MarketingNavbar />
      <main>
        <section className="landing-container to-page-hero">
            <span className="to-eyebrow">About TransitOps</span>
            <h1 className="to-page-title">A <GradientText>calmer, clearer</GradientText> way to run a fleet</h1>
            <p className="to-page-sub">
              TransitOps is an all-in-one transport operations platform that automates the busywork of
              dispatch, maintenance, and cost tracking — so operations teams spend their energy on the
              road, not the paperwork.
            </p>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">Our Story</span>
              <h2 className="to-h2">Built for the teams that keep the world moving</h2>
              <p className="to-lead">
                We watched operations teams juggle disconnected logbooks, printed license checklists,
                and fuel receipts stuffed in gloveboxes. TransitOps replaces all of it with one
                platform — where a completed trip creates its own fuel log, and a maintenance order
                posts its own expense. No double entry, no missing receipts.
              </p>
            </div>
          </div>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">What We Believe</span>
              <h2 className="to-h2">Four values, one platform</h2>
            </div>
            <div
              ref={valuesReveal.ref}
              className={`to-values-grid ${valuesReveal.visible ? 'is-visible' : ''}`}
            >
              {values.map((v) => (
                <div key={v.title} className="to-card">
                  <ColorIconTile color={v.color}>{v.icon}</ColorIconTile>
                  <h3 className="to-card-title">{v.title}</h3>
                  <p className="to-card-desc">{v.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div className="to-stats" style={{ border: '1px solid var(--to-line)', borderRadius: 16 }}>
              {stats.map((s) => (
                <div key={s.value} className="to-stat">
                  <div className="to-stat-value">{s.value}</div>
                  <div className="to-stat-label">{s.label}</div>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div className="to-section-head">
              <span className="to-eyebrow">The Team</span>
              <h2 className="to-h2">People who sweat the details</h2>
            </div>
            <div
              ref={teamReveal.ref}
              className={`to-team-grid ${teamReveal.visible ? 'is-visible' : ''}`}
            >
              {team.map((t) => (
                <div key={t.name} className="to-team-card">
                  <div className="to-team-avatar" style={{ background: 'none', fontSize: 0 }}>
                    <ColorIconTile color={t.color} style={{ width: 56, height: 56, borderRadius: '50%', fontSize: 15 }}>
                      <span style={{ fontWeight: 700 }}>{t.initials}</span>
                    </ColorIconTile>
                  </div>
                  <h3 className="to-team-name">{t.name}</h3>
                  <p className="to-team-role">{t.role}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="to-section hairline-t to-cta">
          <RainbowHairline />
          <div className="landing-container">
            <h2 className="to-cta-title">Come <GradientText>run your fleet</GradientText> with us</h2>
            <p className="to-cta-sub">
              Set up a workspace in minutes and see what calm, clear operations feel like.
            </p>
            <div className="to-hero-actions">
              <Link to="/register" className="to-btn to-gradient-cta to-btn-lg">Get Started Free</Link>
              <Link to="/contact" className="to-btn to-btn-light to-btn-lg">Contact Us</Link>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}