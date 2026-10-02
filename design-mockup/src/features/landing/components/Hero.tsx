import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../../context/AuthContext';
import { useReveal } from './useReveal';

export default function Hero() {
  const { user } = useAuth();
  const text = useReveal();
  const visual = useReveal();

  return (
    <section className="landing-container">
      <div className="to-hero-split">

        {/* Left: text content */}
        <div ref={text.ref} className="to-hero-copy">

          <span className="to-badge" style={{ marginBottom: '24px' }}>
            <span className="to-badge-dot" />
            Smart Transport Operations Platform
          </span>

          <h1 className="to-hero-title to-hero-title-left">
            Run your entire fleet from one <span className="to-gradient-text">calm, clear place.</span>
          </h1>

          <p className="to-hero-sub to-hero-sub-left">
            TransitOps unifies vehicles, drivers, trips, maintenance, and expenses in one
            workspace — so your team dispatches faster, spends less, and stays ahead of every move.
          </p>

          <div className="to-hero-actions to-hero-actions-left">
            {user ? (
              <Link to="/dashboard" className="to-btn to-btn-primary to-btn-lg">
                Open Dashboard
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M5 12h14" />
                  <path d="m12 5 7 7-7 7" />
                </svg>
              </Link>
            ) : (
              <>
                <Link to="/register" className="to-btn to-btn-primary to-btn-lg">
                  Get Started Free
                  <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M5 12h14" />
                    <path d="m12 5 7 7-7 7" />
                  </svg>
                </Link>
                <Link to="/login" className="to-btn to-btn-light to-btn-lg">Sign In</Link>
              </>
            )}
          </div>

          <p className="to-hero-note to-hero-note-left">
            No credit card required · Set up in minutes
          </p>

        </div>

        {/* Right: video covers the whole container */}
        <div
          ref={visual.ref}
          className="to-hero-media"
          style={{
            opacity: visual.visible ? 1 : 0,
            transform: visual.visible ? 'none' : 'translateY(24px)',
            transition: 'opacity 0.8s cubic-bezier(0.16,1,0.3,1), transform 0.8s cubic-bezier(0.16,1,0.3,1)',
          }}
        >
          <div className="to-hero-media-box">
<div className="to-hero-video-wrap">
            <video
              className="to-hero-video"
              src="/hero_page.mp4"
              autoPlay
              muted
              loop
              playsInline
              preload="metadata"
            />
          </div>
          </div>
        </div>

      </div>
    </section>
  );
}