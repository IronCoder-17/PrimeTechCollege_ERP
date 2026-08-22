// ============================================
// LandingPage — Cinematic Hero + Features
// ============================================

import { useState } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import {
  GraduationCap, ArrowRight, Users, CalendarDays, BookOpen,
  MessageCircle, Star, ChevronDown, Briefcase,
  Mail, Lock, Eye, EyeOff, User, Shield, X, PlayCircle,
  MapPin, Phone, FlaskConical, Building2, Home, Network, Award,
  IndianRupee, Utensils
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import styles from './LandingPage.module.css';
import campusImg from '../assets/primetech-campus.png';
// Campus Tour video modal
import CampusTourModal from '../components/CampusTourModal';
// Apply Now — public inquiry-only modal (not a registration)
import ApplyNowModal from '../components/ApplyNowModal';

const FEATURES = [
  { icon: Users, color: '#2563eb', bg: '#eff6ff', title: 'Clubs & Orgs', desc: 'Discover and join 100+ campus clubs, from tech societies to arts collectives.' },
  { icon: CalendarDays, color: '#7c3aed', bg: '#f5f3ff', title: 'Events', desc: 'Never miss a hackathon, concert, or career fair again. RSVP in one tap.' },
  { icon: BookOpen, color: '#059669', bg: '#ecfdf5', title: 'Study Groups', desc: 'Find peers studying the same courses and ace your exams together.' },
  { icon: MessageCircle, color: '#d97706', bg: '#fffbeb', title: 'Campus Chat', desc: 'Real-time messaging with classmates. No phone number needed.' },
];

const STATS = [
  { value: '12K+', label: 'Students' },
  { value: '200+', label: 'Clubs' },
  { value: '50+', label: 'Events/Month' },
  { value: '98%', label: 'Satisfaction' },
];

const TESTIMONIALS = [
  { name: 'Alex Johnson', major: 'Computer Science · Junior', text: 'PrimeTech College helped me find my internship through a club networking event. Absolute game changer.', avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=60&h=60&fit=crop&crop=face', stars: 5 },
  { name: 'Maya Patel', major: 'Biology · Sophomore', text: 'I went from knowing nobody to having a study group and friend group within my first week.', avatar: 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=60&h=60&fit=crop&crop=face', stars: 5 },
  { name: 'Jordan Lee', major: 'Business · Senior', text: 'The events calendar alone is worth it. I\'ve been to 30+ events this semester because of it.', avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=60&h=60&fit=crop&crop=face', stars: 5 },
];

const COMPANIES = [
  { name: 'Google', color: '#4285F4', icon: 'google' }, { name: 'Microsoft', color: '#00A4EF', icon: 'microsoft' },
  { name: 'Amazon', color: '#FF9900', icon: 'amazon' }, { name: 'Meta', color: '#0866FF', icon: 'meta' },
  { name: 'Netflix', color: '#E50914', icon: 'netflix' }, { name: 'Adobe', color: '#FF0000', icon: 'adobe' },
  { name: 'IBM', color: '#1F70C1', icon: 'ibm' }, { name: 'Salesforce', color: '#00A1E0', icon: 'salesforce' },
  { name: 'Intel', color: '#0071C5', icon: 'intel' }, { name: 'Oracle', color: '#F80000', icon: 'oracle' },
  { name: 'Infosys', color: '#007CC3', icon: 'infosys' }, { name: 'Wipro', color: '#341C5C', icon: 'wipro' },
  { name: 'TCS', color: '#E2261B', icon: 'tata' }, { name: 'Accenture', color: '#A100FF', icon: 'accenture' },
  { name: 'Deloitte', color: '#86BC25', icon: 'deloitte' }, { name: 'Apple', color: '#555555', icon: 'apple' },
];

const ALUMNI = [
  { name: 'Priya Sharma', role: 'Software Engineer @ Google', batch: 'B.Tech CSE, 2021', img: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&h=300&fit=crop&crop=face' },
  { name: 'Rahul Mehta', role: 'Product Manager @ Microsoft', batch: 'MBA, 2020', img: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=300&h=300&fit=crop&crop=face' },
  { name: 'Ananya Iyer', role: 'Data Scientist @ Amazon', batch: 'M.Sc Data Science, 2022', img: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=300&h=300&fit=crop&crop=face' },
  { name: 'Arjun Nair', role: 'ML Engineer @ Meta', batch: 'B.Tech AI, 2023', img: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&h=300&fit=crop&crop=face' },
  { name: 'Sneha Kapoor', role: 'UX Designer @ Adobe', batch: 'B.Des, 2021', img: 'https://images.unsplash.com/photo-1598550874175-4d0ef436c909?w=300&h=300&fit=crop&crop=face' },
];

const FEST_IMAGES = [
  { src: 'https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?w=600&h=400&fit=crop', alt: 'Music Concert' },
  { src: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&h=400&fit=crop', alt: 'Tech Fest' },
  { src: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600&h=400&fit=crop', alt: 'Cultural Night' },
  { src: 'https://images.unsplash.com/photo-1506157786151-b8491531f063?w=600&h=400&fit=crop', alt: 'Stage Performance' },
  { src: 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=600&h=400&fit=crop', alt: 'Hackathon' },
  { src: 'https://images.unsplash.com/photo-1511578314322-379afb476865?w=600&h=400&fit=crop', alt: 'College Event' },
];

const PLACED_STUDENTS = [
  {
    name: 'Riya Desai',
    branch: 'B.Tech Computer Science, 2024',
    company: 'Google',
    companyIcon: 'google',
    companyColor: '#4285F4',
    package: '₹32 LPA',
    img: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&h=400&fit=crop&crop=face',
  },
  {
    name: 'Karan Shah',
    branch: 'B.Tech Information Technology, 2024',
    company: 'Microsoft',
    companyIcon: 'microsoft',
    companyColor: '#00A4EF',
    package: '₹28 LPA',
    img: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&h=400&fit=crop&crop=face',
  },
  {
    name: 'Ananya Verma',
    branch: 'M.Tech Data Science, 2024',
    company: 'Amazon',
    companyIcon: 'amazon',
    companyColor: '#FF9900',
    package: '₹25 LPA',
    img: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400&h=400&fit=crop&crop=face',
  },
];

const WHY_CHOOSE = [
  {
    icon: GraduationCap,
    color: '#2563eb',
    bg: '#eff6ff',
    title: 'Experienced Faculty',
    desc: 'Highly qualified professors with decades of industry and academic experience guiding every step.',
  },
  {
    icon: FlaskConical,
    color: '#059669',
    bg: '#ecfdf5',
    title: 'Modern Laboratories',
    desc: 'State-of-the-art labs equipped with the latest technology for hands-on practical learning.',
  },
  {
    icon: Award,
    color: '#c9963c',
    bg: '#fdf4e3',
    title: 'Placement Support',
    desc: 'Dedicated training and placement cell with 95%+ placement record year after year.',
  },
  {
    icon: Home,
    color: '#7c3aed',
    bg: '#f5f3ff',
    title: 'Hostel Facilities',
    desc: 'Safe, comfortable, and well-maintained accommodation with 24/7 security and amenities.',
  },
  {
    icon: Network,
    color: '#dc2626',
    bg: '#fff1f2',
    title: 'Industry Partnerships',
    desc: 'Strong collaborations with 200+ leading companies for internships, projects, and live exposure.',
  },
  {
    icon: Building2,
    color: '#0891b2',
    bg: '#ecfeff',
    title: 'Modern Infrastructure',
    desc: 'Sprawling campus with smart classrooms, sports facilities, and world-class amenities.',
  },
];

const CONTACT_INFO = [
  {
    icon: MapPin,
    color: '#2563eb',
    bg: '#eff6ff',
    title: 'Our Address',
    lines: ['PrimeTech College of Engineering', 'Morbi Highway Road', 'Rajkot, Gujarat – 380015'],
  },
  {
    icon: Phone,
    color: '#059669',
    bg: '#ecfdf5',
    title: 'Call Us',
    lines: ['+91 9601817086', '+91 8200821696', 'Mon – Sat, 9:00 AM – 6:00 PM'],
  },
  {
    icon: Mail,
    color: '#c9963c',
    bg: '#fdf4e3',
    title: 'Email Us',
    lines: ['admissions@primetech.edu.in', 'info@primetech.edu.in', 'placements@primetech.edu.in'],
  },
];


const ROLES = [
  {
    key: 'student',
    label: 'Student',
    icon: User,
    color: '#2563eb',
    bg: '#eff6ff',
    border: '#bfdbfe',
    desc: 'Access clubs, events & study groups',
    placeholder: 'student@university.edu',
    demo: { email: 'alex@university.edu', password: 'password123' },
  },
  {
    key: 'admin',
    label: 'Admin',
    icon: Shield,
    color: '#dc2626',
    bg: '#fff1f2',
    border: '#fecdd3',
    desc: 'Manage campus platform & users',
    placeholder: 'admin@university.edu',
    demo: { email: 'admin@university.edu', password: 'admin123' },
  },
  {
    key: 'faculty',
    label: 'Faculty',
    icon: Briefcase,
    color: '#7c3aed',
    bg: '#f5f3ff',
    border: '#ddd6fe',
    desc: 'Course management & announcements',
    placeholder: 'faculty@university.edu',
    demo: { email: 'faculty@university.edu', password: 'faculty123' },
  },
];

// ── Login Modal ──────────────────────────────────────────────────────────────
function LoginModal({ onClose }) {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [step, setStep] = useState('role'); // 'role' | 'form'
  const [selectedRole, setSelectedRole] = useState(null);
  const [form, setForm] = useState({ email: '', password: '' });
  const [showPass, setShowPass] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const role = ROLES.find(r => r.key === selectedRole);

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

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);
    try {
      await login(form.email, form.password, selectedRole);
      navigate('/feed');
    } catch (err) {
      setError(err.response?.data?.error || 'Invalid email or password. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const RoleIcon = role?.icon;

  return (
    <div className={styles.modalOverlay} onClick={(e) => e.target === e.currentTarget && onClose()}>
      <div className={styles.modalCard}>
        {/* Close */}
        <button className={styles.modalClose} onClick={onClose} aria-label="Close">
          <X size={18} />
        </button>

        {/* Header */}
        <div className={styles.modalHeader}>
          <div className={styles.modalLogoIcon}><GraduationCap size={18} color="white" /></div>
          <p className={styles.modalLogoSub}>PrimeTech College</p>
        </div>

        {step === 'role' ? (
          <>
            <h2 className={styles.modalTitle}>Welcome back!</h2>
            <p className={styles.modalSubtitle}>Select your role to continue</p>

            <div className={styles.roleGrid}>
              {ROLES.map(({ key, label, icon: Icon, color, bg, border, desc }) => (
                <button
                  key={key}
                  className={styles.roleBtn}
                  style={{ '--role-color': color, '--role-bg': bg, '--role-border': border }}
                  onClick={() => handleRoleSelect(key)}
                >
                  <div className={styles.roleBtnIcon} style={{ background: bg, border: `1.5px solid ${border}` }}>
                    <Icon size={22} color={color} />
                  </div>
                  <span className={styles.roleBtnLabel}>{label}</span>
                  <span className={styles.roleBtnDesc}>{desc}</span>
                </button>
              ))}
            </div>

          </>
        ) : (
          <>
            {/* Back + role badge */}
            <div className={styles.formRoleHeader}>
              <button className={styles.backBtn} onClick={handleBack}>
                ← Back
              </button>
              <span className={styles.formRoleBadge} style={{ background: role.bg, color: role.color, border: `1px solid ${role.border}` }}>
                {RoleIcon && <RoleIcon size={13} />} {role.label} Login
              </span>
            </div>

            <h2 className={styles.modalTitle}>Sign in as {role.label}</h2>
            <p className={styles.modalSubtitle}>{role.desc}</p>

            {/* Demo hint */}
            <div className={styles.demoHint} style={{ borderColor: role.border, color: role.color, background: role.bg }}>
              💡 Demo: <strong>{role.demo.email}</strong> / <strong>{role.demo.password}</strong>
            </div>

            {error && <div className={styles.formError}>{error}</div>}

            <form className={styles.loginForm} onSubmit={handleSubmit}>
              <div className={styles.formField}>
                <label className={styles.formLabel}>Email</label>
                <div className={styles.inputWrap}>
                  <Mail size={15} className={styles.inputIcon} />
                  <input
                    type="email"
                    className={`input ${styles.formInput}`}
                    placeholder={role.placeholder}
                    value={form.email}
                    onChange={e => setForm(f => ({ ...f, email: e.target.value }))}
                    required
                    autoFocus
                  />
                </div>
              </div>

              <div className={styles.formField}>
                <label className={styles.formLabel}>Password</label>
                <div className={styles.inputWrap}>
                  <Lock size={15} className={styles.inputIcon} />
                  <input
                    type={showPass ? 'text' : 'password'}
                    className={`input ${styles.formInput}`}
                    placeholder="Enter your password"
                    value={form.password}
                    onChange={e => setForm(f => ({ ...f, password: e.target.value }))}
                    required
                  />
                  <button type="button" className={styles.eyeBtn} onClick={() => setShowPass(s => !s)}>
                    {showPass ? <EyeOff size={14} /> : <Eye size={14} />}
                  </button>
                </div>
              </div>

              <button
                type="submit"
                className="btn btn-primary"
                style={{ width: '100%', justifyContent: 'center', background: `linear-gradient(135deg, ${role.color}, ${role.color}cc)` }}
                disabled={loading}
              >
                {loading
                  ? <div className="spinner" style={{ width: 18, height: 18 }} />
                  : <>{role.label} Sign In <ArrowRight size={16} /></>
                }
              </button>
            </form>

            <p className={styles.modalSwitch}>
              Don't have an account? Contact the Admin Office — accounts are issued during admission.
            </p>
          </>
        )}
      </div>
    </div>
  );
}

// ── Main Page ────────────────────────────────────────────────────────────────

export default function LandingPage() {
  const navigate = useNavigate();
  const location = useLocation();
  const [showModal, setShowModal] = useState(false);
  // Controls the full-screen Campus Tour video modal
  const [showTour, setShowTour] = useState(false);
  // Controls the public Apply Now inquiry modal (not a registration)
  const [showApply, setShowApply] = useState(false);

  const goToLogin = () => navigate('/login');

  return (
    <div className={styles.page}>
      {showModal && <LoginModal onClose={() => setShowModal(false)} />}

      {/* Campus Tour full-screen video modal */}
      {showTour && <CampusTourModal onClose={() => setShowTour(false)} />}

      {/* Apply Now — basic inquiry only, no registration */}
      {showApply && <ApplyNowModal onClose={() => setShowApply(false)} />}

      {/* ── Navbar ── */}
      <nav className={styles.nav}>
        <div className={styles.navLogo}>
          <div className={styles.navLogoIcon}><GraduationCap size={20} color="white" /></div>
          <div>
            <span>PrimeTech<strong>College</strong></span>
            <span className={styles.navLogoSubtitle}></span>
          </div>
        </div>
        <div className={styles.navLinks}>
          <a href="#features">Features</a>
          <a href="#testimonials">Reviews</a>
          <Link
            to="/rules-regulations"
            className={location.pathname === '/rules-regulations' ? styles.navLinkActive : ''}
          >
            R &amp; R
          </Link>
          {/* Campus Tour button — opens full-screen video modal */}
          <button
            className={`btn btn-secondary btn-sm ${styles.campusTourBtn}`}
            onClick={() => setShowTour(true)}
          >
            <PlayCircle size={15} />
            Campus Tour
          </button>
          <button className="btn btn-secondary btn-sm" onClick={goToLogin}>Sign In</button>
        </div>
        {/* Fee Structure button lives OUTSIDE navLinks so responsive
            CSS that hides navLinks anchors never affects it */}
        <Link to="/fee-structure" className={styles.feeNavBtn}>
          <IndianRupee size={14} />
          <span>Fee Structure</span>
        </Link>
      </nav>

      {/* ── Hero ── */}
      <section
        className={styles.hero}
        style={{
          backgroundImage: `url(${campusImg})`,
          backgroundSize: 'cover',
          backgroundPosition: 'center center',
          backgroundRepeat: 'no-repeat',
        }}
      >
        <div className={styles.heroImageOverlay} />

        <div className={styles.heroContent}>
          <div className={`badge badge-blue ${styles.heroBadge} animate-fade-in`}>
            ✨ Now live at 50+ campuses
          </div>

          <h1 className={`${styles.heroTitle} animate-fade-in-up delay-1`}>
            PrimeTech Campus.<br />
            <span className="gradient-text">Innovation Excellence</span>
          </h1>

          <p className={`${styles.heroSubtitle} animate-fade-in-up delay-2`}>
            The all-in-one platform where students discover clubs, join study groups,
            RSVP to events, and build real friendships — all on one beautiful campus.
          </p>

          <div className={`${styles.heroCTA} animate-fade-in-up delay-3`}>
            <button className="btn btn-primary btn-lg" onClick={() => setShowApply(true)}>
              Apply Now <ArrowRight size={18} />
            </button>
            <button className="btn btn-secondary btn-lg" onClick={goToLogin}>
              Sign In
            </button>
          </div>

          <div className={`${styles.heroStats} animate-fade-in-up delay-4`}>
            {STATS.map(s => (
              <div key={s.label} className={styles.heroStat}>
                <span className={styles.heroStatValue}>{s.value}</span>
                <span className={styles.heroStatLabel}>{s.label}</span>
              </div>
            ))}
          </div>
        </div>

        <a href="#features" className={styles.scrollDown}><ChevronDown size={20} /></a>
      </section>

      {/* ── Features ── */}
      <section className={styles.features} id="features">
        <div className={styles.sectionHeader}>
          <span className="badge badge-blue">Everything You Need</span>
          <h2 className={styles.sectionTitle}>One platform.<br />All of campus life.</h2>
          <p className={styles.sectionDesc}>Built by students, for students — to make every semester unforgettable.</p>
        </div>
        <div className={styles.featuresGrid}>
          {FEATURES.map(({ icon: Icon, color, bg, title, desc }, i) => (
            <div key={title} className={`${styles.featureCard} card float-card animate-fade-in-up delay-${i+1}`}>
              <div className={styles.featureIcon} style={{ background: bg }}>
                <Icon size={24} color={color} />
              </div>
              <h3 className={styles.featureTitle}>{title}</h3>
              <p className={styles.featureDesc}>{desc}</p>
            </div>
          ))}
        </div>
      </section>

      {/* ── Campus Life Photos ── */}
      <section className={styles.campusLifeSection}>
        <div className={styles.sectionHeader}>
          <span className="badge badge-blue">Campus Life</span>
          <h2 className={styles.sectionTitle}>Life on Campus</h2>
          <p className={styles.sectionDesc}>Experience the vibrant campus culture that makes every day memorable.</p>
        </div>
        <div className={styles.photoGrid}>
          <img src="https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?w=600&h=400&fit=crop" alt="Campus life" loading="lazy" />
          <img src="https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=600&h=400&fit=crop" alt="Students studying" loading="lazy" />
          <img src="https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?w=600&h=400&fit=crop" alt="College event" loading="lazy" />
          <img src="https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=400&fit=crop" alt="Student club" loading="lazy" />
        </div>
      </section>

      {/* ── College Fest ── */}
      <section className={styles.festSection}>
        <div className={styles.sectionHeader}>
          <h2 className={styles.sectionTitle}>College Fest</h2>
          <p className={styles.sectionDesc}>Relive the energy — music, culture, tech, and unforgettable moments.</p>
        </div>
        <div className={styles.festGrid}>
          {FEST_IMAGES.map((img, i) => (
            <div key={i} className={styles.festItem}>
              <img src={img.src} alt={img.alt} loading="lazy" />
              <div className={styles.festOverlay}><span>{img.alt}</span></div>
            </div>
          ))}
        </div>
      </section>

      {/* ── Placement Companies Marquee ── */}
      <section className={styles.placementSection}>
        <div className={styles.sectionHeader}>
          <span className="badge badge-green">Career Opportunities</span>
          <h2 className={styles.sectionTitle}>Our Students Work At</h2>
          <p className={styles.sectionDesc}>Top global companies recruit directly from our campus every year.</p>
        </div>
        <div className={styles.marqueeWrapper}>
          <div className={styles.marqueeTrack}>
            {[...COMPANIES, ...COMPANIES].map((company, i) => (
              <div key={i} className={styles.companyLogo} title={company.name}>
                <img
                  src={`https://cdn.simpleicons.org/${company.icon}/${company.color.replace('#','')}`}
                  alt={company.name} width="28" height="28" style={{ flexShrink: 0 }}
                  onError={(e) => { e.currentTarget.style.display = 'none'; }}
                />
                <span className={styles.companyName} style={{ color: company.color }}>{company.name}</span>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* ── Alumni ── */}
      <section className={styles.alumniSection}>
        <div className={styles.sectionHeader}>
          <span className="badge badge-blue">Success Stories</span>
          <h2 className={styles.sectionTitle}>Our Alumni</h2>
          <p className={styles.sectionDesc}>Graduates who are shaping the future at the world's leading companies.</p>
        </div>
        <div className={styles.alumniGrid}>
          {ALUMNI.map((alum, i) => (
            <div key={i} className={`${styles.alumniCard} card`}>
              <div className={styles.alumniImgWrap}><img src={alum.img} alt={alum.name} loading="lazy" /></div>
              <div className={styles.alumniInfo}>
                <h4 className={styles.alumniName}>{alum.name}</h4>
                <p className={styles.alumniRole}>{alum.role}</p>
                <span className={styles.alumniBatch}>{alum.batch}</span>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* ── Testimonials ── */}
      <section className={styles.testimonials} id="testimonials">
        <div className={styles.sectionHeader}>
          <span className="badge badge-green">Student Stories</span>
          <h2 className={styles.sectionTitle}>Loved by students<br />everywhere.</h2>
        </div>
        <div className={styles.testimonialsGrid}>
          {TESTIMONIALS.map((t, i) => (
            <div key={t.name} className={`${styles.testimonialCard} card animate-fade-in-up delay-${i+1}`}>
              <div className={styles.testimonialStars}>
                {Array.from({ length: t.stars }).map((_, j) => (
                  <Star key={j} size={14} fill="#f59e0b" color="#f59e0b" />
                ))}
              </div>
              <p className={styles.testimonialText}>"{t.text}"</p>
              <div className={styles.testimonialAuthor}>
                <img src={t.avatar} alt={t.name} className="avatar avatar-sm" />
                <div>
                  <span className={styles.testimonialName}>{t.name}</span>
                  <span className={styles.testimonialMeta}>{t.major}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* ── Placement Highlights ── */}
      <section className={styles.placementHighlights} id="placements">
        <div className={styles.sectionHeader}>
          <span className="badge badge-green">Placements & Career Success</span>
          <h2 className={styles.sectionTitle}>Our Students, Our Pride</h2>
          <p className={styles.sectionDesc}>Outstanding placement records that speak for themselves — careers launched at the world's most sought-after companies.</p>
        </div>
        <div className={styles.placedGrid}>
          {PLACED_STUDENTS.map((s, i) => (
            <div key={i} className={styles.placedCard}>
              <div className={styles.placedImgWrap}>
                <img src={s.img} alt={s.name} loading="lazy" />
                <div className={styles.placedPackageBadge}>{s.package}</div>
              </div>
              <div className={styles.placedInfo}>
                <h4 className={styles.placedName}>{s.name}</h4>
                <p className={styles.placedBranch}>{s.branch}</p>
                <div className={styles.placedCompanyRow}>
                  <img
                    src={`https://cdn.simpleicons.org/${s.companyIcon}/${s.companyColor.replace('#','')}`}
                    alt={s.company}
                    width="20" height="20"
                    onError={(e) => { e.currentTarget.style.display='none'; }}
                  />
                  <span className={styles.placedCompanyName} style={{ color: s.companyColor }}>{s.company}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* ── Why Choose Us ── */}
      <section className={styles.whyChooseSection} id="why-us">
        <div className={styles.sectionHeader}>
          <span className="badge badge-blue">Why Choose Us</span>
          <h2 className={styles.sectionTitle}>Built for Excellence</h2>
          <p className={styles.sectionDesc}>Discover what makes PrimeTech the first choice for thousands of students and families every year.</p>
        </div>
        <div className={styles.whyGrid}>
          {WHY_CHOOSE.map(({ icon: Icon, color, bg, title, desc }, i) => (
            <div key={title} className={`${styles.whyCard} animate-fade-in-up delay-${(i % 4) + 1}`}>
              <div className={styles.whyIcon} style={{ background: bg }}>
                <Icon size={26} color={color} />
              </div>
              <div className={styles.whyText}>
                <h3 className={styles.whyTitle}>{title}</h3>
                <p className={styles.whyDesc}>{desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* ── Contact Information ── */}
      <section className={styles.contactSection} id="contact">
        <div className={styles.sectionHeader}>
          <span className="badge badge-blue">Get In Touch</span>
          <h2 className={styles.sectionTitle}>Contact Us</h2>
          <p className={styles.sectionDesc}>We'd love to hear from you. Reach out for admissions, queries, or campus visits.</p>
        </div>
        <div className={styles.contactGrid}>
          {CONTACT_INFO.map(({ icon: Icon, color, bg, title, lines }, i) => (
            <div key={i} className={styles.contactCard}>
              <div className={styles.contactIconWrap} style={{ background: bg }}>
                <Icon size={28} color={color} />
              </div>
              <h4 className={styles.contactTitle}>{title}</h4>
              <div className={styles.contactLines}>
                {lines.map((line, j) => (
                  <p key={j} className={j === 0 ? styles.contactLinePrimary : styles.contactLineSecondary}>{line}</p>
                ))}
              </div>
            </div>
          ))}
        </div>
      </section>

      

      {/* ── Footer ── */}
      <footer className={styles.footer}>
        <div className={styles.footerLogo}>
          <div className={styles.navLogoIcon}><GraduationCap size={16} color="white" /></div>
          <span>PrimeTech<strong>College</strong></span>
        </div>
        <p>© 2025 PrimeTech College. Built with ❤️ for students.</p>
        <div className={styles.footerLinks}>
          <a href="#">Privacy</a>
          <a href="#">Terms</a>
          <a href="#">Support</a>
        </div>
        <a
          href="http://t.me/Primetechcollege_bot"
          target="_blank"
          rel="noopener noreferrer"
          className={styles.telegramBtn}
          aria-label="Chat with us on Telegram"
        >
          <svg viewBox="0 0 240 240" width="20" height="20" aria-hidden="true" focusable="false">
            <circle cx="120" cy="120" r="120" fill="#229ED9" />
            <path
              fill="#fff"
              d="M170.6 72.6 149 178.1c-1.6 7.2-5.9 9-11.9 5.6l-33-24.3-15.9 15.3c-1.8 1.8-3.3 3.3-6.7 3.3l2.4-33.9 61.7-55.8c2.7-2.4-.6-3.7-4.2-1.3l-76.3 48-32.8-10.3c-7.1-2.2-7.3-7.1 1.5-10.6l128.2-49.4c6-2.2 11.2 1.4 9.3 10z"
            />
          </svg>
          <span>Chat with us on Telegram</span>
        </a>
      </footer>
    </div>
  );
}
