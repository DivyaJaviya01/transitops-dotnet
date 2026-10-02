import React from 'react';
import { useAuth } from '../../context/AuthContext';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import TrustedBy from './components/TrustedBy';
import Features from './components/Features';
import StackedStory from './components/StackedStory';
import Stats from './components/Stats';
import CTA from './components/CTA';
import Footer from './components/Footer';
import './landing.css';

export default function LandingPage() {
  const { loading } = useAuth();

  if (loading) {
    return (
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: '100vh',
        backgroundColor: '#ffffff',
        color: '#111827',
        fontFamily: 'system-ui, sans-serif'
      }}>
        Loading...
      </div>
    );
  }

  return (
    <div className="landing-body">
      <Navbar />
      <main>
        <Hero />
        <TrustedBy />
        <Features />
        <StackedStory />
        <Stats />
        <CTA />
      </main>
      <Footer />
    </div>
  );
}