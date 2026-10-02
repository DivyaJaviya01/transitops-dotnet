import { useState } from 'react';
import { FiUser, FiShield, FiBell, FiSave } from 'react-icons/fi';
import MainLayout from '../../components/layout/MainLayout';
import { useAuth } from '../../context/AuthContext';

const SettingsPage = () => {
  const { user } = useAuth();
  const [name, setName] = useState(user?.name || '');
  const [email, setEmail] = useState(user?.email || '');
  const [notifications, setNotifications] = useState(true);
  const [saved, setSaved] = useState(false);

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  const sections = [
    {
      title: 'Profile',
      icon: FiUser,
      content: (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          <div>
            <label className="settings-label">Full Name</label>
            <input className="settings-input" value={name} onChange={(e) => setName(e.target.value)} />
          </div>
          <div>
            <label className="settings-label">Email</label>
            <input className="settings-input" value={email} onChange={(e) => setEmail(e.target.value)} />
          </div>
        </div>
      ),
    },
    {
      title: 'Role & Permissions',
      icon: FiShield,
      content: (
        <div>
          <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem', margin: 0 }}>
            Current role: <strong style={{ color: 'var(--text-primary)' }}>{user?.role || 'N/A'}</strong>
          </p>
          <p style={{ color: 'var(--text-secondary)', fontSize: '0.85rem', marginTop: '0.5rem' }}>
            Role-based access is managed by your administrator. Contact your fleet manager to request role changes.
          </p>
        </div>
      ),
    },
    {
      title: 'Notifications',
      icon: FiBell,
      content: (
        <label style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', cursor: 'pointer', color: 'var(--text-primary)' }}>
          <input
            type="checkbox"
            checked={notifications}
            onChange={(e) => setNotifications(e.target.checked)}
            style={{ width: '18px', height: '18px', accentColor: '#1b4332' }}
          />
          Enable email notifications for trip updates, maintenance alerts, and system announcements
        </label>
      ),
    },
  ];

  return (
    <MainLayout>
      <div className="dashboard-page">
        <div className="dashboard-header">
          <div>
            <h1>Settings</h1>
            <p>Manage your account preferences and notifications.</p>
          </div>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem', maxWidth: '640px' }}>
          {sections.map((section) => {
            const Icon = section.icon;
            return (
              <div key={section.title} className="graph-card" style={{ marginBottom: 0 }}>
                <div className="graph-header" style={{ marginBottom: '1rem' }}>
                  <h3><Icon size={18} style={{ color: '#1b4332' }} /> {section.title}</h3>
                </div>
                {section.content}
              </div>
            );
          })}

          <button onClick={handleSave} className="btn-primary" style={{ width: 'fit-content' }}>
            <FiSave size={16} />
            {saved ? 'Saved!' : 'Save Preferences'}
          </button>
        </div>
      </div>
    </MainLayout>
  );
};

export default SettingsPage;
