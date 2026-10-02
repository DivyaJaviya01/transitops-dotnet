import React from 'react';
import { Link } from 'react-router-dom';

export default function Footer() {
  return (
    <footer className="to-footer hairline-t">
      <div className="landing-container">

        <div className="to-footer-grid">

          <div className="to-footer-brand">
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
            <p>
              The operations platform for modern transportation, shipping, and distribution fleets.
              Built to maximize dispatch reliability and minimize operating costs.
            </p>
          </div>

          <div className="to-footer-col">
            <h4 className="to-footer-col-title">Product</h4>
            <ul className="to-footer-list">
              <li><Link to="/dashboard">Operations Deck</Link></li>
              <li><Link to="/vehicles">Fleet Hub</Link></li>
              <li><Link to="/maintenance">Maintenance</Link></li>
              <li><Link to="/expenses">Expense Center</Link></li>
            </ul>
          </div>

          <div className="to-footer-col">
            <h4 className="to-footer-col-title">Resources</h4>
            <ul className="to-footer-list">
              <li><a href="#">Documentation</a></li>
              <li><a href="#">API Reference</a></li>
              <li><a href="#">System Status</a></li>
              <li><a href="#">Changelog</a></li>
            </ul>
          </div>

          <div className="to-footer-col">
            <h4 className="to-footer-col-title">Company</h4>
            <ul className="to-footer-list">
              <li><Link to="/about">About</Link></li>
              <li><Link to="/contact">Contact</Link></li>
              <li><a href="#">Security</a></li>
              <li><a href="#">Privacy</a></li>
              <li><a href="#">Terms</a></li>
            </ul>
          </div>

        </div>

        <div className="to-footer-bottom">
          <p>&copy; {new Date().getFullYear()} TransitOps · Team Runtime Terrors</p>
          <p>Built for the Odoo Hackathon 2026</p>
        </div>

      </div>
    </footer>
  );
}