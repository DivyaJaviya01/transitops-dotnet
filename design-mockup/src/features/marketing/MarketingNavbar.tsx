import React, { useEffect, useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';

const links = [
  { to: '/features', label: 'Features' },
  { to: '/pricing', label: 'Pricing' },
  { to: '/about', label: 'About' },
  { to: '/contact', label: 'Contact' },
];

export default function MarketingNavbar() {
  const { user } = useAuth();
  const { pathname } = useLocation();
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 12);
    onScroll();
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);

  return (
    <header className={`to-nav ${scrolled ? 'is-scrolled' : ''}`}>
      <div className="landing-container to-nav-inner">
        <Link to="/" className="to-brand">
          <span className="to-brand-mark">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4" strokeLinecap="round" strokeLinejoin="round">
              <path d="M1 3h15v13H1z" />
              <path d="M16 8h4l3 3v5h-7V8z" />
              <circle cx="5.5" cy="18.5" r="2.5" />
              <circle cx="18.5" cy="18.5" r="2.5" />
            </svg>
          </span>
          TransitOps
        </Link>

        <nav className="to-nav-links">
          {links.map((l) => (
            <Link key={l.to} to={l.to} className={`to-nav-link ${pathname === l.to ? 'is-active' : ''}`}>
              {l.label}
            </Link>
          ))}
        </nav>

        <div className="to-nav-right">
          {user ? (
            <Link to="/dashboard" className="to-btn to-btn-primary">Open Dashboard</Link>
          ) : (
            <>
              <Link to="/login" className="to-btn to-btn-light">Sign In</Link>
              <Link to="/register" className="to-btn to-btn-primary">Get Started</Link>
            </>
          )}
        </div>
      </div>
    </header>
  );
}