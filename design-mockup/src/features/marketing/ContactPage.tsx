import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import MarketingNavbar from './MarketingNavbar';
import Footer from '../landing/components/Footer';
import { useReveal } from '../landing/components/useReveal';
import { GradientText, RainbowHairline, ColorIconTile } from '../../components/decor/ColorBlobs';
import { PiEnvelopeSimple, PiPhone, PiMapPin, PiCheckCircle } from 'react-icons/pi';
import './marketing.css';

export default function ContactPage() {
  const formReveal = useReveal();
  const [submitted, setSubmitted] = useState(false);

  const onSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitted(true);
  };

  return (
    <div className="landing-body">
      <MarketingNavbar />
      <main>
        <section className="landing-container to-page-hero">
            <span className="to-eyebrow">Contact</span>
            <h1 className="to-page-title">Talk to the <GradientText>team behind TransitOps</GradientText></h1>
            <p className="to-page-sub">
              Questions about pricing, onboarding, or a custom setup? We usually reply within one
              business day.
            </p>
        </section>

        <section className="to-section hairline-t">
          <div className="landing-container">
            <div
              ref={formReveal.ref}
              className={`to-contact-grid ${formReveal.visible ? 'is-visible' : ''}`}
            >
              <div>
                {submitted ? (
                  <div className="to-card" style={{ textAlign: 'center', padding: '48px 32px' }}>
                    <span className="to-card-icon" style={{ margin: '0 auto 18px' }}>
                      <PiCheckCircle size={22} />
                    </span>
                    <h3 className="to-card-title" style={{ fontSize: 20 }}>Message sent</h3>
                    <p className="to-card-desc" style={{ maxWidth: 320, margin: '0 auto' }}>
                      Thanks for reaching out. Our team will get back to you within one business day.
                    </p>
                  </div>
                ) : (
                  <form className="to-form" onSubmit={onSubmit}>
                    <div className="to-field">
                      <label htmlFor="name">Full name</label>
                      <input id="name" className="to-input" type="text" placeholder="Jane Cooper" required />
                    </div>
                    <div className="to-field">
                      <label htmlFor="email">Work email</label>
                      <input id="email" className="to-input" type="email" placeholder="jane@company.com" required />
                    </div>
                    <div className="to-field">
                      <label htmlFor="company">Company</label>
                      <input id="company" className="to-input" type="text" placeholder="Acme Logistics" />
                    </div>
                    <div className="to-field">
                      <label htmlFor="subject">What can we help with?</label>
                      <select id="subject" className="to-select" defaultValue="General question">
                        <option>General question</option>
                        <option>Sales & pricing</option>
                        <option>Onboarding & training</option>
                        <option>Partnership</option>
                        <option>Something else</option>
                      </select>
                    </div>
                    <div className="to-field">
                      <label htmlFor="message">Message</label>
                      <textarea id="message" className="to-textarea" placeholder="Tell us about your fleet..." required />
                    </div>
                    <button type="submit" className="to-btn to-btn-primary to-btn-lg">
                      Send Message
                    </button>
                    <p className="to-form-note">
                      By submitting, you agree to our Privacy Policy. We never share your data.
                    </p>
                  </form>
                )}
              </div>

              <div className="to-contact-info">
                <div className="to-contact-item">
                  <span className="to-contact-icon"><PiEnvelopeSimple size={18} /></span>
                  <div>
                    <h4>Email</h4>
                    <p>hello@transitops.dev</p>
                  </div>
                </div>
                <div className="to-contact-item">
                  <span className="to-contact-icon"><PiPhone size={18} /></span>
                  <div>
                    <h4>Phone</h4>
                    <p>+1 (555) 010-2030</p>
                  </div>
                </div>
                <div className="to-contact-item">
                  <span className="to-contact-icon"><PiMapPin size={18} /></span>
                  <div>
                    <h4>Office</h4>
                    <p>Operations Hub, Fleet District, Bengaluru, India</p>
                  </div>
                </div>
                <div className="to-card" style={{ marginTop: 6 }}>
                  <h3 className="to-card-title">Prefer to start right away?</h3>
                  <p className="to-card-desc" style={{ marginBottom: 20 }}>
                    Set up a workspace in minutes — no credit card required. No sales call needed to see the product.
                  </p>
                  <Link to="/register" className="to-btn to-btn-primary to-btn-lg">Get Started Free</Link>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}