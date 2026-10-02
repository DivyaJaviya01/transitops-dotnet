import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import api from '../../services/api';
import './Login.css';

const ROLES = ['Fleet Manager', 'Driver', 'Safety Officer', 'Financial Analyst'];

const RegisterPage = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [role, setRole] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleRegister = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setSuccess('');
    setLoading(true);
    try {
      await api.post('/auth/register', { name, email, password, role });
      setSuccess('Account created successfully! Redirecting to login...');
      setTimeout(() => navigate('/login'), 1500);
    } catch (err: any) {
      setError(err.response?.data?.error || 'Registration failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-brand-side">
        <div className="auth-brand-content">
          <div className="auth-brand-logo">
            <img src="/image.png" alt="TransitOps" />
          </div>
          <div className="auth-brand-text">
            <h1>TransitOps</h1>
            <p>Join the fleet management platform</p>
          </div>
          <div className="auth-brand-decoration" />
          <p style={{ fontSize: '0.85rem', color: '#9ca3af', lineHeight: 1.7, margin: 0 }}>
            Create your account and start orchestrating your shipping dispatches, tracking assets, and managing your fleet in one place.
          </p>
        </div>
        <div className="auth-brand-footer">TRANSITOPS &copy; 2026</div>
      </div>

      <div className="auth-form-side">
        <div className="auth-form-container">
          <h2>Create your account</h2>
          <p className="form-subtitle">Fill in the details below to get started</p>

          {error && (
            <div className="error-callout">
              <span className="error-label">Error</span>
              <span className="error-msg">{error}</span>
            </div>
          )}

          {success && (
            <div style={{
              border: '1px solid #16a34a',
              borderRadius: '12px',
              padding: '0.85rem 1rem',
              marginBottom: '1.5rem',
              backgroundColor: '#f0fdf4',
              color: '#166534',
              fontSize: '0.9rem'
            }}>
              {success}
            </div>
          )}

          <form onSubmit={handleRegister}>
            <div className="form-group">
              <label>Full Name</label>
              <input
                type="text"
                value={name}
                onChange={(e) => setName(e.target.value)}
                placeholder="e.g. Jane Smith"
                required
              />
            </div>

            <div className="form-group">
              <label>Email</label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="you@company.com"
                required
              />
            </div>

            <div className="form-group">
              <label>Password</label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Minimum 6 characters"
                required
                minLength={6}
              />
            </div>

            <div className="form-group">
              <label>Role</label>
              <select
                value={role}
                onChange={(e) => setRole(e.target.value)}
                required
              >
                <option value="" disabled>Select your role</option>
                {ROLES.map((r) => (
                  <option key={r} value={r}>{r}</option>
                ))}
              </select>
            </div>

            <button type="submit" className="signin-btn" disabled={loading}>
              {loading ? 'Creating Account...' : 'Sign Up'}
            </button>
          </form>

          <Link to="/login" className="register-btn">
            Already have an account? Sign In
          </Link>
        </div>

        <div className="auth-watermark">TransitOps</div>
      </div>
    </div>
  );
};

export default RegisterPage;
