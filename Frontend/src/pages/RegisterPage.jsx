// ============================================
// RegisterPage — Only .edu and .ac.in emails
// ============================================

import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { GraduationCap, Mail, Lock, User, BookOpen, ArrowRight, AlertCircle } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import styles from './AuthPage.module.css';

const YEARS = ['Freshman', 'Sophomore', 'Junior', 'Senior', 'Graduate'];

export default function RegisterPage() {
  const { register } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ name: '', email: '', password: '', major: '', year: 'Freshman' });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  // Live email domain hint
  const emailLower = form.email.toLowerCase().trim();
  const emailHasAt = emailLower.includes('@');
  const emailValid = emailLower.endsWith('.edu') || emailLower.endsWith('.ac.in');
  const showEmailWarning = emailHasAt && !emailValid;

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    if (!emailValid) {
      setError('Only .edu or .ac.in institutional email addresses are accepted.');
      return;
    }
    if (form.password.length < 8) {
      setError('Password must be at least 8 characters.');
      return;
    }
    setLoading(true);
    try {
      await register(form);
      navigate('/feed');
    } catch (err) {
      setError(err.message || 'Registration failed. Try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className={styles.page}>
      <div className={styles.bg}>
        <img src="https://images.unsplash.com/photo-1459767129954-1b1c1f9b9ace?w=1400&q=80&auto=format" alt="" />
        <div className={styles.bgOverlay} />
        <div className={styles.bgOrb1} />
        <div className={styles.bgOrb2} />
      </div>

      <div className={`${styles.card} animate-scale-in`}>
        <div className={styles.cardHeader}>
          <Link to="/" className={styles.logo}>
            <div className={styles.logoIcon}><GraduationCap size={20} color="white" /></div>
            <div>
              <span>Campus<strong>Connect</strong></span>
              <span className={styles.logoSub}>PrimeTech College</span>
            </div>
          </Link>
        </div>

        <h1 className={styles.title}>Join PrimeTech College</h1>
        <p className={styles.subtitle}>Free for all students with an institutional email</p>

        {/* Domain notice */}
        <div style={{
          padding: '8px 12px', borderRadius: 10, background: '#f0fdf4',
          border: '1px solid #bbf7d0', fontSize: 12, color: '#15803d',
          marginBottom: 16, textAlign: 'center',
        }}>
          🔒 Only <strong>.edu</strong> and <strong>.ac.in</strong> email addresses are accepted
        </div>

        {error && (
          <div className={styles.error} style={{ display: 'flex', alignItems: 'flex-start', gap: 8 }}>
            <AlertCircle size={15} style={{ marginTop: 1, flexShrink: 0 }} />
            <span>{error}</span>
          </div>
        )}

        <form className={styles.form} onSubmit={handleSubmit}>
          <div className={styles.fieldRow}>
            <div className={styles.field}>
              <label className={styles.label}>Full Name</label>
              <div className={styles.inputWrap}>
                <User size={16} className={styles.inputIcon} />
                <input type="text" className={`input ${styles.input}`} placeholder="Alex Johnson"
                  value={form.name} onChange={e => set('name', e.target.value)} required />
              </div>
            </div>
            <div className={styles.field}>
              <label className={styles.label}>Year</label>
              <select className={`input ${styles.input} ${styles.select}`} value={form.year} onChange={e => set('year', e.target.value)}>
                {YEARS.map(y => <option key={y}>{y}</option>)}
              </select>
            </div>
          </div>

          <div className={styles.field}>
            <label className={styles.label}>Institutional Email</label>
            <div className={styles.inputWrap}>
              <Mail size={16} className={styles.inputIcon} />
              <input
                type="email"
                className={`input ${styles.input}`}
                placeholder="you@university.edu or you@college.ac.in"
                value={form.email}
                onChange={e => set('email', e.target.value)}
                required
                style={showEmailWarning ? { borderColor: '#dc2626' } : {}}
              />
            </div>
            {showEmailWarning && (
              <div style={{ display: 'flex', alignItems: 'center', gap: 6, fontSize: 12, color: '#dc2626', marginTop: 4, padding: '4px 8px', background: '#fff1f2', borderRadius: 6, border: '1px solid #fecdd3' }}>
                <AlertCircle size={12} />
                Use a <strong>.edu</strong> or <strong>.ac.in</strong> address — Gmail and others are not accepted
              </div>
            )}
          </div>

          <div className={styles.field}>
            <label className={styles.label}>Major (optional)</label>
            <div className={styles.inputWrap}>
              <BookOpen size={16} className={styles.inputIcon} />
              <input type="text" className={`input ${styles.input}`} placeholder="Computer Science"
                value={form.major} onChange={e => set('major', e.target.value)} />
            </div>
          </div>

          <div className={styles.field}>
            <label className={styles.label}>Password</label>
            <div className={styles.inputWrap}>
              <Lock size={16} className={styles.inputIcon} />
              <input type="password" className={`input ${styles.input}`} placeholder="Min 8 characters"
                value={form.password} onChange={e => set('password', e.target.value)} required />
            </div>
          </div>

          <button
            type="submit"
            className="btn btn-primary"
            style={{ width: '100%', justifyContent: 'center' }}
            disabled={loading}
          >
            {loading
              ? <div className="spinner" style={{ width: 18, height: 18 }} />
              : <>Create Account <ArrowRight size={16} /></>
            }
          </button>
        </form>

        <p className={styles.switchText}>
          Already have an account? <Link to="/login">Sign in →</Link>
        </p>
      </div>
    </div>
  );
}
