// ============================================================
// RulesRegulationsPage — "R & R" destination
// • Accessible at /rules-regulations publicly (no login needed)
// • Also nested inside AppLayout for logged-in students
// • Mirrors the exact shell pattern used by FeeStructurePage so
//   the Header/Footer/design stay perfectly consistent
// ============================================================

import { Link } from 'react-router-dom';
import {
  ShieldCheck, GraduationCap, ArrowLeft, CreditCard, Ban, Users,
  Smartphone, ClipboardCheck, FileWarning, Cigarette, Shirt,
  Wrench, Trash2, DoorClosed, MessageSquareWarning, Gavel,
  Clock, UserCheck2, Bus as BusIcon,
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import feeStyles from './FeeStructurePage.module.css';
import styles from './RulesRegulationsPage.module.css';

const GENERAL_RULES = [
  { Icon: CreditCard, text: 'Every student must carry a valid College Identity Card while inside the campus.' },
  { Icon: Ban, text: 'Ragging in any form is strictly prohibited. Any student found involved will face immediate disciplinary action according to government regulations.' },
  { Icon: Users, text: 'Students must maintain respectful behavior toward faculty members, staff, visitors, and fellow students at all times.' },
  { Icon: Smartphone, text: 'Mobile phones must remain on silent mode during lectures, practical sessions, seminars, workshops, and examinations.' },
  { Icon: ClipboardCheck, text: 'Students must maintain the minimum attendance percentage prescribed by the college to remain eligible for examinations.' },
  { Icon: FileWarning, text: 'Cheating, plagiarism, impersonation, or any unfair means during examinations, assignments, or projects is strictly prohibited.' },
  { Icon: Cigarette, text: 'Smoking, tobacco, alcohol, vaping, drugs, or any prohibited substances are not permitted anywhere on the college campus.' },
  { Icon: Shirt, text: 'Students must wear the prescribed uniform or follow the official dress code wherever applicable.' },
  { Icon: Wrench, text: 'Damaging college property, laboratory equipment, library resources, furniture, classrooms, or campus infrastructure will result in disciplinary action and financial compensation.' },
  { Icon: Trash2, text: 'Students must help maintain cleanliness by using dustbins and keeping classrooms and campus surroundings clean.' },
  { Icon: DoorClosed, text: 'Unauthorized entry into laboratories, staff rooms, administrative offices, or restricted areas is strictly prohibited.' },
  { Icon: MessageSquareWarning, text: 'Cyberbullying, harassment, discrimination, abusive language, or misuse of college digital platforms is strictly prohibited.' },
  { Icon: Gavel, text: 'The college administration reserves the right to take disciplinary action against any student violating institutional rules.' },
];

const HOSTEL_RULES = [
  { Icon: Clock, text: 'Hostel students must strictly follow the hostel entry and exit timings established by the hostel administration.' },
  { Icon: UserCheck2, text: 'Visitors are permitted only during approved visiting hours with prior permission from the hostel authorities.' },
  { Icon: Ban, text: 'Possession or consumption of alcohol, tobacco, drugs, smoking materials, or any prohibited items inside the hostel is strictly forbidden and may result in hostel expulsion.' },
];

const TRANSPORT_RULES = [
  { Icon: CreditCard, text: 'Students using college transport must carry a valid transport pass or college ID while boarding the bus.' },
  { Icon: Clock, text: 'Students should arrive at their designated pickup point at least five minutes before the scheduled bus arrival time.' },
  { Icon: BusIcon, text: 'Students must not distract the driver, damage bus property, stand near the door while the bus is moving, or create disturbances inside the bus. Violations may lead to suspension of transport privileges.' },
];

function RuleList({ rules, startIndex }) {
  return (
    <ol className={styles.ruleList} start={startIndex}>
      {rules.map((rule, i) => (
        <li key={i} className={styles.ruleItem}>
          <span className={styles.ruleIcon}><rule.Icon size={16} /></span>
          <span className={styles.ruleText}>{rule.text}</span>
        </li>
      ))}
    </ol>
  );
}

export default function RulesRegulationsPage() {
  const auth = useAuth?.();
  const isLoggedIn = !!auth?.user;

  // ── Inner page content (used whether inside AppLayout or standalone) ──
  const pageContent = (
    <div className={feeStyles.page}>
      {/* Header */}
      <div className={feeStyles.pageHeader}>
        <div className={feeStyles.pageIconWrap}><ShieldCheck size={20} /></div>
        <div>
          <h1 className={feeStyles.pageTitle}>Rules &amp; Regulations</h1>
          <p className={feeStyles.pageSub}>
            All students are expected to maintain discipline, integrity, responsibility, and respect
            while on campus. Every student must comply with the following rules and regulations.
          </p>
        </div>
      </div>

      <section className={feeStyles.section}>
        <h2 className={feeStyles.sectionTitle}>General Rules</h2>
        <RuleList rules={GENERAL_RULES} startIndex={1} />
      </section>

      <section className={feeStyles.section}>
        <h2 className={feeStyles.sectionTitle}>Hostel Rules</h2>
        <RuleList rules={HOSTEL_RULES} startIndex={GENERAL_RULES.length + 1} />
      </section>

      <section className={feeStyles.section}>
        <h2 className={feeStyles.sectionTitle}>Transportation Rules</h2>
        <RuleList rules={TRANSPORT_RULES} startIndex={GENERAL_RULES.length + HOSTEL_RULES.length + 1} />
      </section>
    </div>
  );

  // ── If logged in, just render page content (AppLayout handles shell) ──
  if (isLoggedIn) return pageContent;

  // ── Public standalone: render with its own mini navbar ──
  return (
    <div className={feeStyles.publicWrapper}>
      <nav className={feeStyles.publicNav}>
        <Link to="/" className={feeStyles.publicNavBrand}>
          <div className={feeStyles.publicNavBrandIcon}>
            <GraduationCap size={18} color="#fff" />
          </div>
          PrimeTech<strong style={{ color: '#C9963C', marginLeft: 2 }}>College</strong>
        </Link>
        <div className={feeStyles.publicNavActions}>
          <Link to="/" className={feeStyles.publicNavBack}>
            <ArrowLeft size={14} /> Back to Home
          </Link>
          <Link to="/login" className={feeStyles.publicNavBack} style={{ background: '#C9963C', borderColor: '#C9963C', color: '#fff' }}>
            Sign In
          </Link>
        </div>
      </nav>
      <div className={feeStyles.publicContent}>
        {pageContent}
      </div>
    </div>
  );
}