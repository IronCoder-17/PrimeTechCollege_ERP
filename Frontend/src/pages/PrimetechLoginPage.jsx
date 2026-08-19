// ============================================================
// PrimetechLoginPage.jsx
// Dark gold luxury login — Rectangle card + real logo
// Three roles: Student, Faculty, Admin
// ============================================================

import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import {
  Lock, Eye, EyeOff, ArrowRight,
  User, Shield, BookOpen, BookMarked,
  Lightbulb, Trophy, Building2, AlertCircle, ChevronLeft
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import styles from './PrimetechLogin.module.css';
import campusImg from '../assets/primetech-campus.png';
import logoImg from '../assets/primetech-logo.png';

const ROLES = [
  {
    key: 'student',
    label: 'Student',
    icon: User,
    desc: 'Clubs, events & study groups',
    placeholder: 'student@university.edu',
    demo: { email: 'alex@university.edu', password: 'password123' },
    dashboardPath: '/feed',
  },
  {
    key: 'faculty',
    label: 'Faculty',
    icon: BookOpen,
    desc: 'Courses & announcements',
    placeholder: 'PTFAC20260001 or faculty email',
    demo: { email: 'faculty@university.edu', password: 'faculty123' },
    dashboardPath: '/faculty',
  },
  // NOTE: Admin is intentionally NOT listed here. The Admin Panel has its
  // own dedicated, unlisted login at /admin (see AdminLoginPage.jsx) and
  // is never advertised on this public-facing page.
];

const PILLARS = [
  { icon: BookMarked, label: 'LEARN',    sub: 'Expand Your Knowledge' },
  { icon: Lightbulb,  label: 'INNOVATE', sub: 'Shape The Future'      },
  { icon: Trophy,     label: 'EXCEL',    sub: 'Achieve Greatness'     },
  { icon: Building2,  label: 'BELONG',   sub: 'Be Part of Excellence' },
];

export default function PrimetechLoginPage() {
  const { login } = useAuth();
  const navigate   = useNavigate();

  const [step,         setStep]         = useState('role');
  const [selectedRole, setSelectedRole] = useState(null);
  const [form,         setForm]         = useState({ email: '', password: '' });
  const [showPass,     setShowPass]     = useState(false);
  const [rememberMe,   setRememberMe]   = useState(false);
  const [loading,      setLoading]      = useState(false);
  const [error,        setError]        = useState('');

  const role     = ROLES.find(r => r.key === selectedRole);
  const RoleIcon = role?.icon;

  const handleRoleSelect = (key) => {
    setSelectedRole(key);
    setError('');
    setForm({ email: '', password: '' });
    setStep('form');
  };

  const handleBack = () => {
    setStep('role');
    setSelectedRole(null);
    setError('');
  };

  const fillDemo = () => {
    if (role) setForm({ email: role.demo.email, password: role.demo.password });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    const lower = form.email.toLowerCase().trim();
    // Allow Employee ID login for faculty (format: PTFAC...)
    const isEmployeeId = /^ptfac\d+$/i.test(lower);
    if (!isEmployeeId && !lower.endsWith('.edu') && !lower.endsWith('.ac.in')) {
      setError('Use your institutional email (.edu / .ac.in) or Employee ID (e.g. PTFAC20260001) for faculty login.');
      return;
    }
    setLoading(true);
    try {
      await login(form.email, form.password, selectedRole);
      navigate(role.dashboardPath, { replace: true });
    } catch (err) {
      setError(err.message || 'Invalid email or password. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className={styles.page}>

      {/* ── Background campus image ── */}
      <div className={styles.bg}>
        <img src={campusImg} alt="" />
        <div className={styles.bgOverlay} />
      </div>

      {/* ── Navbar ── */}
      <nav className={styles.navbar}>
        <Link to="/" className={styles.navLogo}>
          <img src={logoImg} alt="PrimeTech College" className={styles.navLogoImg} />
        </Link>
        <div className={styles.navDivider}>LEARN &bull; INNOVATE &bull; EXCEL</div>
      </nav>

      {/* ── Rectangle Card ── */}
      <div className={styles.centerWrap}>
        <div className={styles.card}>

          {/* Top gold bar accent */}
          <div className={styles.cardTopBar} />

          {/* Logo */}
          <div className={styles.logoWrap}>
            <img src={logoImg} alt="PrimeTech College" className={styles.logoImg} />
          </div>

          <p className={styles.cardTagline}>Continue your journey of excellence</p>
          <div className={styles.dividerLine} />

          {/* ── STEP 1: Role Selection ── */}
          {step === 'role' && (
            <>
              <div className={styles.roleGrid}>
                {ROLES.map(({ key, label, icon: Icon, desc }) => (
                  <button key={key} className={styles.roleBtn} onClick={() => handleRoleSelect(key)}>
                    <div className={styles.roleBtnIcon}>
                      <Icon size={20} color="#c9a84c" />
                    </div>
                    <span className={styles.roleBtnLabel}>{label}</span>
                    <span className={styles.roleBtnDesc}>{desc}</span>
                  </button>
                ))}
              </div>

              <div className={styles.bottomOrnament}>
                <div className={styles.ornamentIcon}><Shield size={12} /></div>
              </div>

              <div className={styles.applyRow}>
                <p className={styles.applyText}>New to Primetech College? Use the Apply Now button on the home page.</p>
              </div>
            </>
          )}

          {/* ── STEP 2: Login Form ── */}
          {step === 'form' && role && (
            <>
              <div className={styles.formRoleHeader}>
                <button className={styles.backBtn} onClick={handleBack}>
                  <ChevronLeft size={13} style={{ display: 'inline', verticalAlign: 'middle' }} /> Back
                </button>
                <span className={styles.roleBadge}>
                  {RoleIcon && <RoleIcon size={11} />} {role.label.toUpperCase()} LOGIN
                </span>
              </div>

              <button type="button" className={styles.demoHint} onClick={fillDemo} title="Click to auto-fill">
                💡 <strong>{role.demo.email}</strong> / <strong>{role.demo.password}</strong>
                <span style={{ fontSize: 10, marginLeft: 6, opacity: 0.6 }}>(click to fill)</span>
              </button>

              {error && (
                <div className={styles.error}>
                  <AlertCircle size={13} style={{ marginTop: 1, flexShrink: 0 }} />
                  <span>{error}</span>
                </div>
              )}

              <form onSubmit={handleSubmit}>
                {/* Email / Employee ID
                    FIX: faculty login accepts Employee ID (PTFAC20260001) which
                    is not an email. Using type="text" for faculty avoids browser-
                    level HTML5 validation rejecting the non-email format. */}
                <div className={styles.field}>
                  <div className={styles.inputWrap}>
                    <User size={15} className={styles.inputIcon} />
                    <input
                      type={selectedRole === 'faculty' ? 'text' : 'email'}
                      className={styles.input}
                      placeholder={role.placeholder}
                      value={form.email}
                      onChange={e => setForm(f => ({ ...f, email: e.target.value }))}
                      required
                      autoFocus
                      autoComplete={selectedRole === 'faculty' ? 'username' : 'email'}
                    />
                  </div>
                </div>

                {/* Password */}
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
                    />
                    <button type="button" className={styles.eyeBtn} onClick={() => setShowPass(s => !s)}>
                      {showPass ? <EyeOff size={14} /> : <Eye size={14} />}
                    </button>
                  </div>
                </div>

                {/* Remember + Forgot */}
                <div className={styles.rememberRow}>
                  <label className={styles.rememberLabel}>
                    <input
                      type="checkbox"
                      checked={rememberMe}
                      onChange={e => setRememberMe(e.target.checked)}
                    />
                    <span className={styles.rememberText}>Remember me</span>
                  </label>
                  <a href="#" className={styles.forgotLink}>Forgot Password?</a>
                </div>

                {/* Submit */}
                <button type="submit" className={styles.loginBtn} disabled={loading}>
                  {loading
                    ? <div className={styles.spinner} />
                    : <>LOGIN <ArrowRight size={16} /></>
                  }
                </button>
              </form>

              <div className={styles.bottomOrnament}>
                <div className={styles.ornamentIcon}><Shield size={12} /></div>
              </div>

              <div className={styles.applyRow}>
                <p className={styles.applyText}>New to Primetech College? Use the Apply Now button on the home page.</p>
              </div>
            </>
          )}

          {/* Bottom gold bar accent */}
          <div className={styles.cardBottomBar} />
        </div>
      </div>

      {/* ── Footer Pillars ── */}
      <footer className={styles.footer}>
        <div className={styles.footerIcons}>
          {PILLARS.map(({ icon: Icon, label, sub }) => (
            <div key={label} className={styles.footerIcon}>
              <div className={styles.footerIconCircle}><Icon size={16} /></div>
              <span className={styles.footerIconLabel}>{label}</span>
              <span className={styles.footerIconSub}>{sub}</span>
            </div>
          ))}
        </div>
        <div className={styles.footerQuoteLine} />
        <p className={styles.footerQuote}>"Excellence is not an act, but a habit."</p>
        <div className={styles.footerQuoteLine} />
      </footer>

    </div>
  );
}
