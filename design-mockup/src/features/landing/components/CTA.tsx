import React from 'react';
import { Link } from 'react-router-dom';
import { useReveal } from './useReveal';

export default function CTA() {
  const { ref, visible } = useReveal();

  return (
    <section className="to-section hairline-t to-cta">
      <div className="landing-container">
        <div ref={ref} className={visible ? 'is-visible' : ''}>
          <h2 className="to-cta-title">Ready to take your fleet operations seriously?</h2>
          <p className="to-cta-sub">
            Set up a workspace in minutes and get your fleet, drivers, and trips on one calm,
            clear platform today.
          </p>
          <div className="to-hero-actions">
            <Link to="/register" className="to-btn to-btn-primary to-btn-lg">
              Get Started Free
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M5 12h14" />
                <path d="m12 5 7 7-7 7" />
              </svg>
            </Link>
            <Link to="/login" className="to-btn to-btn-light to-btn-lg">Sign In</Link>
          </div>
        </div>
      </div>
    </section>
  );
}