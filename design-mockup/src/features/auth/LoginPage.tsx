import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import './Login.css';

const roles = ['Fleet Manager', 'Dispatcher', 'Safety Officer', 'Financial Analyst'];

const LoginPage = () => {
  const [email, setEmail] = useState('manager@transitops.com');
  const [password, setPassword] = useState('divya123');
  const [role, setRole] = useState('Fleet Manager');
  const [remember, setRemember] = useState(true);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const { user, login } = useAuth();
  const navigate = useNavigate();

  React.useEffect(() => {
    if (user) {
      navigate('/dashboard', { replace: true });
    }
  }, [user, navigate]);

  const handleRoleChange = (selectedRole: string) => {
    setRole(selectedRole);
    if (selectedRole === 'Fleet Manager') setEmail('manager@transitops.com');
    else if (selectedRole === 'Safety Officer') setEmail('safety@transitops.com');
    else if (selectedRole === 'Financial Analyst') setEmail('finance@transitops.com');
    else if (selectedRole === 'Driver' || selectedRole === 'Dispatcher') setEmail('driver@transitops.com');
  };

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await login(email, password);
      navigate('/dashboard');
    } catch (err: any) {
      setError(err.response?.data?.error || 'Invalid credentials. Account locked after 5 failed attempts.');
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
            <p>Smart Transport Operations Platform</p>
          </div>
          <div className="auth-brand-decoration" />
          <p style={{ fontSize: '0.78rem', color: '#9ca3af', lineHeight: 1.5, margin: 0 }}>
            Orchestrate your shipping dispatches, automate preventive care, track asset locations, and audit operations in an editorial workspace designed for modern fleets.
          </p>
        </div>
        <div className="auth-brand-footer">TRANSITOPS &copy; 2026</div>
      </div>

      <div className="auth-form-side">
        <div className="auth-form-container">
          <h2>Sign in to your account</h2>
          <p className="form-subtitle">Enter your credentials to continue</p>

          {error && (
            <div className="error-callout">
              <span className="error-label">Error</span>
              <span className="error-msg">{error}</span>
            </div>
          )}

          <form onSubmit={handleLogin}>
            <div className="form-group">
              <label>Email</label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </div>

            <div className="form-group">
              <label>Password</label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>

            <div className="form-group">
              <label>Role (RBAC)</label>
              <select value={role} onChange={(e) => handleRoleChange(e.target.value)}>
                {roles.map((r) => (
                  <option key={r} value={r}>{r}</option>
                ))}
              </select>
            </div>

            <div className="form-row">
              <label className="checkbox-group">
                <input
                  type="checkbox"
                  checked={remember}
                  onChange={(e) => setRemember(e.target.checked)}
                />
                Remember me
              </label>
              <a href="#" className="forgot-link" onClick={(e) => e.preventDefault()}>
                Forgot password?
              </a>
            </div>

            <button type="submit" className="signin-btn" disabled={loading}>
              {loading ? 'Signing In...' : 'Sign In'}
            </button>
          </form>

          <Link to="/register" className="register-btn">
            Create Account
          </Link>

          <div className="scope-notes">
            <strong>Access is scoped by role after login</strong><br />
            Fleet Manager &rarr; Fleet, Maintenance<br />
            Dispatcher &rarr; Dashboard, Trips<br />
            Safety Officer &rarr; Drivers, Compliance<br />
            Financial Analyst &rarr; Fuel &amp; Expenses, Analytics
          </div>
        </div>

        <div className="auth-watermark">TransitOps</div>
      </div>
    </div>
  );
};

export default LoginPage;
