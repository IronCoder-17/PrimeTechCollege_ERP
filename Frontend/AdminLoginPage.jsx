// ============================================================
// AdminLoginPage.jsx
// Dedicated Admin sign-in — intentionally NOT linked from the
// public student/faculty login page or any public navigation.
// Rendered directly at /admin when no authenticated admin
// session exists (see App.jsx's AdminRoute). On success it
// simply stays on /admin, which then renders AdminDashboard.
// ============================================================

import { useState } from 'react';
import { Link } from 'react-router-dom';
import { Lock, Eye, EyeOff, ArrowRight, Shield, AlertCircle } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import styles from './PrimetechLogin.module.css';
import campusImg from '../assets/primetech-campus.png';
import logoImg from '../assets/primetech-logo.png';

export default function AdminLoginPage() {
  const { login } = useAuth();
  const [form,     setForm]     = useState({ email: '', password: '' });
  const [showPass, setShowPass] = useState(false);
  const [loading,  setLoading]  = useState(false);
  const [error,    setError]    = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      // Always authenticates against the real backend (password_hash
      // check + signed token) — see AuthContext.login()'s admin branch.
      await login(form.email, form.password, 'admin');
      // No navigate() needed: App.jsx's AdminRoute re-renders
      // AdminDashboard automatically once `user` is set.
    } catch (err) {
      setError(err.message || 'Invalid email or password.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className={styles.page}>
      <div className={styles.bg}>
        <img src={campusImg} alt="" />
        <div className={styles.bgOverlay} />
      </div>

      <nav className={styles.navbar}>
        <Link to="/" className={styles.navLogo}>
          <img src={logoImg} alt="PrimeTech College" className={styles.navLogoImg} />
        </Link>
        <div className={styles.navDivider}>ADMINISTRATION</div>
      </nav>

      <div className={styles.centerWrap}>
        <div className={styles.card}>
          <div className={styles.cardTopBar} />

          <div className={styles.logoWrap}>
            <img src={logoImg} alt="PrimeTech College" className={styles.logoImg} />
          </div>

          <p className={styles.cardTagline}>Restricted access — administrators only</p>
          <div className={styles.dividerLine} />

          <div className={styles.formRoleHeader}>
            <span className={styles.roleBadge}>
              <Shield size={11} /> ADMIN LOGIN
            </span>
          </div>

          {error && (
            <div className={styles.error}>
              <AlertCircle size={13} style={{ marginTop: 1, flexShrink: 0 }} />
              <span>{error}</span>
            </div>
          )}

          <form onSubmit={handleSubmit}>
            <div className={styles.field}>
              <div className={styles.inputWrap}>
                <Shield size={15} className={styles.inputIcon} />
                <input
                  type="email"
                  className={styles.input}
                  placeholder="admin@university.edu"
                  value={form.email}
                  onChange={e => setForm(f => ({ ...f, email: e.target.value }))}
                  required
                  autoFocus
                  autoComplete="username"
                />
              </div>
            </div>

            <div className={styles.field}>
              <div className={styles.inputWrap}>
                <Lock size={15} className={styles.inputIcon} />
                <input
                  type={showPass ? 'text' : 'password'}
                  className={styles.input}
                  placeholder="Password"
                  value={form.password}
                  onChange={e => setForm(f => ({ ...f, password: e.target.value }))}
                  required
                  autoComplete="current-password"
                />
                <button type="button" className={styles.eyeBtn} onClick={() => setShowPass(s => !s)}>
                  {showPass ? <EyeOff size={14} /> : <Eye size={14} />}
                </button>
              </div>
            </div>

            <button type="submit" className={styles.loginBtn} disabled={loading}>
              {loading ? <div className={styles.spinner} /> : <>LOGIN <ArrowRight size={16} /></>}
            </button>
          </form>

          <div className={styles.bottomOrnament}>
            <div className={styles.ornamentIcon}><Shield size={12} /></div>
          </div>
        </div>
      </div>
    </div>
  );
}
