// ============================================================
// FeeStructurePage — "Fee Structure" destination
// • Accessible at /fee-structure publicly (no login needed)
// • Also nested inside AppLayout for logged-in students
// • Fetches live data from the centralized fee DB on mount
// • Falls back to the same demo data shown on the landing page
//   if the backend is unavailable, so the page is never blank
// • PDF download happens only when the user clicks the
//   "Download Fee Structure PDF" button (no auto-download)
// ============================================================

import { useEffect, useState, useCallback } from 'react';
import { Link } from 'react-router-dom';
import {
  Download, FileText, RefreshCw, AlertTriangle,
  CheckCircle2, GraduationCap, Home, Bus, IndianRupee,
  BookMarked, ArrowLeft
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import { admissionApi, feesApi, transportationApi } from '../utils/api';
import { generateFeeStructurePdf } from '../utils/Feestructurepdf';
import styles from './FeeStructurePage.module.css';

// ── Demo / fallback data (same as landing page) ─────────────
const DEMO_COURSES = [
  { course_id:1, course_name:'B.Tech Computer Engineering', course_code:'BTCE', department:'Engineering', total_semesters:8,
    fees: Array.from({length:8},(_,i)=>({ semester:i+1, tuition_fee:75000, exam_fee:3000, total_fee:78000 })) },
  { course_id:2, course_name:'B.Tech Information Technology', course_code:'BTIT', department:'Engineering', total_semesters:8,
    fees: Array.from({length:8},(_,i)=>({ semester:i+1, tuition_fee:72000, exam_fee:3000, total_fee:75000 })) },
  { course_id:3, course_name:'B.Tech Mechanical Engineering', course_code:'BTME', department:'Engineering', total_semesters:8,
    fees: Array.from({length:8},(_,i)=>({ semester:i+1, tuition_fee:68000, exam_fee:3000, total_fee:71000 })) },
  { course_id:4, course_name:'BCA', course_code:'BCA', department:'Computer Applications', total_semesters:6,
    fees: Array.from({length:6},(_,i)=>({ semester:i+1, tuition_fee:40000, exam_fee:2500, total_fee:42500 })) },
  { course_id:5, course_name:'MBA', course_code:'MBA', department:'Management', total_semesters:4,
    fees: Array.from({length:4},(_,i)=>({ semester:i+1, tuition_fee:65000, exam_fee:3000, total_fee:68000 })) },
  { course_id:6, course_name:'B.Com', course_code:'BCOM', department:'Commerce', total_semesters:6,
    fees: Array.from({length:6},(_,i)=>({ semester:i+1, tuition_fee:28000, exam_fee:2000, total_fee:30000 })) },
];
const DEMO_SETTINGS = [
  { fee_key:'admission_fee',  label:'Admission Fee',      amount:5000,  description:'One-time, non-refundable' },
  { fee_key:'registration',   label:'Registration Fee',   amount:2000,  description:'Per semester' },
  { fee_key:'exam_fee',       label:'Examination Fee',    amount:3000,  description:'Per semester' },
  { fee_key:'library_fee',    label:'Library Fee',        amount:1500,  description:'Per year' },
  { fee_key:'lab_fee',        label:'Laboratory Fee',     amount:3500,  description:'Per semester (technical courses)' },
  { fee_key:'id_card',        label:'Identity Card Fee',  amount:500,   description:'One-time' },
  { fee_key:'activity_fee',   label:'Activity / Sports',  amount:1500,  description:'Per year' },
];
const DEMO_HOSTEL = [
  { id:1, hostel_type:'Boys Hostel',  room_type:'Non-AC (3 Sharing)', hostel_admission_fee:5000, security_deposit:10000, hostel_fee:35000, mess_fee:25000, maintenance_fee:3000, total_fee:78000 },
  { id:2, hostel_type:'Boys Hostel',  room_type:'Non-AC (2 Sharing)', hostel_admission_fee:5000, security_deposit:10000, hostel_fee:45000, mess_fee:25000, maintenance_fee:3000, total_fee:88000 },
  { id:3, hostel_type:'Boys Hostel',  room_type:'AC (2 Sharing)',     hostel_admission_fee:5000, security_deposit:10000, hostel_fee:60000, mess_fee:25000, maintenance_fee:5000, total_fee:105000 },
  { id:4, hostel_type:'Girls Hostel', room_type:'Non-AC (3 Sharing)', hostel_admission_fee:5000, security_deposit:10000, hostel_fee:38000, mess_fee:25000, maintenance_fee:3000, total_fee:81000 },
  { id:5, hostel_type:'Girls Hostel', room_type:'Non-AC (2 Sharing)', hostel_admission_fee:5000, security_deposit:10000, hostel_fee:48000, mess_fee:25000, maintenance_fee:3000, total_fee:91000 },
  { id:6, hostel_type:'Girls Hostel', room_type:'AC (2 Sharing)',     hostel_admission_fee:5000, security_deposit:10000, hostel_fee:65000, mess_fee:25000, maintenance_fee:5000, total_fee:108000 },
];
const DEMO_ROUTES = [
  { id:1, location:'Rajkot',        bus_number:'PT-01', transport_fee:18000, status:'active' },
  { id:2, location:'Gondal',        bus_number:'PT-02', transport_fee:14000, status:'active' },
  { id:3, location:'Wankaner',      bus_number:'PT-03', transport_fee:16000, status:'active' },
  { id:4, location:'Morbi',         bus_number:'PT-04', transport_fee:20000, status:'active' },
  { id:5, location:'Jamnagar',      bus_number:'PT-05', transport_fee:22000, status:'active' },
  { id:6, location:'Surendranagar', bus_number:'PT-06', transport_fee:24000, status:'active' },
];

const TABS = [
  { key:'academic',  label:'Academic Fees',   Icon: BookMarked },
  { key:'hostel',    label:'Hostel Fees',     Icon: Home },
  { key:'transport', label:'Transportation',  Icon: Bus },
  { key:'other',     label:'Other Charges',   Icon: IndianRupee },
];

function fmt(n) { return `₹${Number(n||0).toLocaleString('en-IN')}`; }

// ── Group a course's semester-wise fee rows into academic years ──
// Year 1 = Sem 1+2, Year 2 = Sem 3+4, Year 3 = Sem 5+6, Year 4 = Sem 7+8
// This keeps the DB schema semester-wise (unchanged) while the UI
// always presents Year-wise totals, computed live from whatever
// semester rows currently exist for the course.
function groupFeesByYear(fees = []) {
  const years = {};
  fees.forEach(f => {
    const year = Math.ceil(Number(f.semester) / 2);
    if (!years[year]) years[year] = { year, tuition_fee: 0, exam_fee: 0, total_fee: 0 };
    years[year].tuition_fee += Number(f.tuition_fee || 0);
    years[year].exam_fee    += Number(f.exam_fee || 0);
    years[year].total_fee   += Number(f.total_fee || 0);
  });
  return Object.values(years).sort((a, b) => a.year - b.year);
}

const YEAR_LABELS = { 1: 'Year 1', 2: 'Year 2', 3: 'Year 3', 4: 'Year 4' };
const MAX_YEARS = 4; // covers all courses (longest is 4-year UG programs)

export default function FeeStructurePage() {
  const auth = useAuth?.();
  const isLoggedIn = !!auth?.user;

  const [loading,     setLoading]     = useState(true);
  const [usingDemo,   setUsingDemo]   = useState(false);
  const [data,        setData]        = useState(null);
  const [activeTab,   setActiveTab]   = useState('academic');
  const [downloaded,  setDownloaded]  = useState(false);
  const [downloading, setDownloading] = useState(false);
  const [dlError,     setDlError]     = useState(null);

  const load = useCallback(async () => {
    setLoading(true);
    setUsingDemo(false);
    let payload = null;

    try {
      const cacheBust = { _t: Date.now() };
      const [feeRes, settingsRes, hostelRes, routesRes] = await Promise.all([
        admissionApi.getFeeStructure(cacheBust),
        feesApi.getSettings(cacheBust),
        feesApi.getHostelPlans(cacheBust),
        transportationApi.getRoutes(cacheBust),
      ]);
      const courses     = feeRes?.data?.courses     || [];
      const settings    = settingsRes?.data?.settings || [];
      const hostelPlans = hostelRes?.data?.plans     || [];
      const routes      = routesRes?.data?.routes    || [];

      // If backend returns empty arrays (fresh DB), fall back to demo
      if (!courses.length && !settings.length) {
        payload = { courses: DEMO_COURSES, settings: DEMO_SETTINGS, hostelPlans: DEMO_HOSTEL, routes: DEMO_ROUTES };
        setUsingDemo(true);
      } else {
        payload = { courses, settings, hostelPlans, routes };
      }
    } catch {
      // Backend unavailable — show demo data so page is never blank
      payload = { courses: DEMO_COURSES, settings: DEMO_SETTINGS, hostelPlans: DEMO_HOSTEL, routes: DEMO_ROUTES };
      setUsingDemo(true);
    }

    setData(payload);
    setLoading(false);
  }, []);

  useEffect(() => { load(); }, [load]);

  // ── Keep fee data in sync with the Admin panel automatically ──
  // 1) Poll every 30s while the page is open, so an in-progress visit
  //    picks up Admin edits without the student doing anything.
  // 2) Also refetch immediately whenever the tab/window regains focus
  //    or becomes visible again (e.g. student alt-tabs back after the
  //    Admin just updated a fee) — feels instant instead of waiting
  //    for the next poll tick.
  useEffect(() => {
    const POLL_MS = 30000;
    const interval = setInterval(() => { load(); }, POLL_MS);

    const onFocusOrVisible = () => {
      if (document.visibilityState === 'visible') load();
    };
    window.addEventListener('focus', onFocusOrVisible);
    document.addEventListener('visibilitychange', onFocusOrVisible);

    return () => {
      clearInterval(interval);
      window.removeEventListener('focus', onFocusOrVisible);
      document.removeEventListener('visibilitychange', onFocusOrVisible);
    };
  }, [load]);

  const redownload = async () => {
    if (!data) return;
    setDownloading(true);
    setDlError(null);
    try {
      await generateFeeStructurePdf(data, true);
      setDownloaded(true);
    } catch {
      setDlError('Could not generate PDF. Please try again.');
    }
    setDownloading(false);
  };

  // ── Inner page content (used whether inside AppLayout or standalone) ──
  const pageContent = (
    <div className={styles.page}>
      {/* Header */}
      <div className={styles.pageHeader}>
        <div className={styles.pageIconWrap}><FileText size={20} /></div>
        <div>
          <h1 className={styles.pageTitle}>Fee Structure 2025–26</h1>
          <p className={styles.pageSub}>
            {usingDemo
              ? 'Showing indicative fees for reference. Connect to the backend for live Admin-configured amounts.'
              : 'Live data — reflects the latest amounts set by the Admissions Office.'}
          </p>
        </div>
      </div>

      {/* Status banner */}
      <div className={styles.banner}>
        {loading ? (
          <><RefreshCw size={15} className={styles.spin} /> Loading fee structure…</>
        ) : downloading ? (
          <><RefreshCw size={15} className={styles.spin} /> Generating PDF…</>
        ) : dlError ? (
          <><AlertTriangle size={15} color="#B3261E" /> {dlError}</>
        ) : downloaded ? (
          <><CheckCircle2 size={15} color="#16a34a" /> PDF downloaded successfully!</>
        ) : usingDemo ? (
          <><AlertTriangle size={14} color="#c2410c" /> Showing demo data (backend not connected)</>
        ) : (
          <><CheckCircle2 size={15} color="#16a34a" /> Live fee data loaded from Admin database</>
        )}
      </div>

      {/* Action buttons */}
      <div className={styles.actions}>
        <button className={styles.downloadBtn} disabled={!data || downloading} onClick={redownload}>
          <Download size={15} />
          {downloading ? 'Preparing PDF…' : 'Download Fee Structure PDF'}
        </button>
        <button className={styles.refreshBtn} disabled={loading} onClick={() => load()}>
          <RefreshCw size={14} /> Refresh
        </button>
      </div>

      {/* Tab switcher */}
      {data && (
        <>
          <div className={styles.tabBar}>
            {TABS.map(({ key, label, Icon }) => (
              <button
                key={key}
                className={`${styles.tab} ${activeTab === key ? styles.tabActive : ''}`}
                onClick={() => setActiveTab(key)}
              >
                <Icon size={14} /> {label}
              </button>
            ))}
          </div>

          {/* ── Academic Fees ── */}
          {activeTab === 'academic' && (() => {
            // All courses currently in the database — no hardcoded list,
            // no cap on count. Any course added by the Admin (via
            // /api/admission/courses + fee_structure rows) appears here
            // automatically on the next load/refresh.
            const courses = data.courses || [];

            // How many academic-year columns are actually needed, based
            // on the longest course currently in the DB (max 4).
            const yearsNeeded = Math.min(
              MAX_YEARS,
              Math.max(1, ...courses.map(c => Math.ceil((c.total_semesters || 0) / 2)))
            );
            const yearCols = Array.from({ length: yearsNeeded }, (_, i) => i + 1);

            // Representative (starting) values for fees that are not
            // course-specific in the schema — sourced live from the same
            // Admin-managed tables shown in the Hostel / Other tabs.
            const hostelStart = data.hostelPlans?.length
              ? Math.min(...data.hostelPlans.map(p => Number(p.total_fee || 0)))
              : null;
            const transportStart = data.routes?.filter(r => r.status === 'active')?.length
              ? Math.min(...data.routes.filter(r => r.status === 'active').map(r => Number(r.transport_fee || 0)))
              : null;
            const otherFeesTotal = (data.settings || []).reduce((sum, s) => sum + Number(s.amount || 0), 0);

            return (
              <section className={styles.section}>
                <h2 className={styles.sectionTitle}>
                  Academic Fees — Course-wise &amp; Year-wise ({courses.length} course{courses.length === 1 ? '' : 's'})
                </h2>
                <div className={styles.tableWrap}>
                  <table className={styles.table}>
                    <thead>
                      <tr>
                        <th>Course</th>
                        <th>Code</th>
                        {yearCols.map(y => <th key={y}>{YEAR_LABELS[y]} Fees</th>)}
                        <th>Total Tuition</th>
                        <th>Hostel Fee</th>
                        <th>Transportation</th>
                        <th>Other Fees</th>
                      </tr>
                    </thead>
                    <tbody>
                      {courses.map(c => {
                        const byYear = groupFeesByYear(c.fees || []);
                        const yearMap = Object.fromEntries(byYear.map(y => [y.year, y]));
                        const totalTuition = byYear.reduce((s, y) => s + y.tuition_fee, 0);
                        return (
                          <tr key={c.course_id}>
                            <td className={styles.bold}>{c.course_name}</td>
                            <td><span className={styles.chip}>{c.course_code}</span></td>
                            {yearCols.map(y => (
                              <td key={y} className={styles.amt}>
                                {yearMap[y] ? fmt(yearMap[y].total_fee) : <span className={styles.muted}>—</span>}
                              </td>
                            ))}
                            <td className={styles.total}>{fmt(totalTuition)}</td>
                            <td className={styles.muted}>{hostelStart != null ? `From ${fmt(hostelStart)}` : '—'}</td>
                            <td className={styles.muted}>{transportStart != null ? `From ${fmt(transportStart)}` : '—'}</td>
                            <td className={styles.muted}>{otherFeesTotal ? fmt(otherFeesTotal) : '—'}</td>
                          </tr>
                        );
                      })}
                      {!courses.length && (
                        <tr><td colSpan={yearCols.length + 6} className={styles.empty}>No course fee data configured.</td></tr>
                      )}
                    </tbody>
                  </table>
                </div>
                <p className={styles.footnote} style={{marginTop:10}}>
                  * Fees shown Year-wise (First Year = Sem 1+2, Second Year = Sem 3+4, Third Year = Sem 5+6, Fourth Year = Sem 7+8).
                  Hostel, Transportation and Other Fees are Admin-managed campus-wide charges — see their respective tabs for full breakdowns.
                </p>
              </section>
            );
          })()}

          {/* ── Hostel Fees ── */}
          {activeTab === 'hostel' && (
            <section className={styles.section}>
              <h2 className={styles.sectionTitle}>Hostel Fees</h2>
              <div className={styles.tableWrap}>
                <table className={styles.table}>
                  <thead>
                    <tr>
                      <th>Hostel</th><th>Room Type</th><th>Admission</th>
                      <th>Deposit</th><th>Hostel / Year</th><th>Mess / Year</th>
                      <th>Maintenance</th><th>Total / Year</th>
                    </tr>
                  </thead>
                  <tbody>
                    {data.hostelPlans.map(p => (
                      <tr key={p.id}>
                        <td className={styles.bold}>{p.hostel_type}</td>
                        <td>{p.room_type}</td>
                        <td>{fmt(p.hostel_admission_fee)}</td>
                        <td>{fmt(p.security_deposit)}</td>
                        <td className={styles.amt}>{fmt(p.hostel_fee)}</td>
                        <td>{fmt(p.mess_fee)}</td>
                        <td>{fmt(p.maintenance_fee)}</td>
                        <td className={styles.total}><b>{fmt(p.total_fee)}</b></td>
                      </tr>
                    ))}
                    {!data.hostelPlans.length && (
                      <tr><td colSpan={8} className={styles.empty}>No hostel fee plans configured.</td></tr>
                    )}
                  </tbody>
                </table>
              </div>
            </section>
          )}

          {/* ── Transportation ── */}
          {activeTab === 'transport' && (
            <section className={styles.section}>
              <h2 className={styles.sectionTitle}>Transportation Fees</h2>
              <div className={styles.transportGrid}>
                {data.routes.filter(r => r.status === 'active').map(r => (
                  <div key={r.id} className={styles.transportCard}>
                    <div className={styles.transportIcon}><Bus size={20} /></div>
                    <div>
                      <div className={styles.bold}>{r.location}</div>
                      <div className={styles.muted} style={{fontSize:12}}>Bus: {r.bus_number}</div>
                      <div className={styles.total} style={{marginTop:4}}>{fmt(r.transport_fee)} / year</div>
                    </div>
                  </div>
                ))}
                {!data.routes.filter(r=>r.status==='active').length && (
                  <p className={styles.empty}>No active transportation routes.</p>
                )}
              </div>
            </section>
          )}

          {/* ── Other Charges ── */}
          {activeTab === 'other' && (
            <section className={styles.section}>
              <h2 className={styles.sectionTitle}>Registration &amp; Other Charges</h2>
              <div className={styles.tableWrap}>
                <table className={styles.table}>
                  <thead><tr><th>Fee</th><th>Amount</th><th>Notes</th></tr></thead>
                  <tbody>
                    {data.settings.map(s => (
                      <tr key={s.fee_key}>
                        <td className={styles.bold}>{s.label}</td>
                        <td className={styles.amt}>{fmt(s.amount)}</td>
                        <td className={styles.notes}>{s.description}</td>
                      </tr>
                    ))}
                    {!data.settings.length && (
                      <tr><td colSpan={3} className={styles.empty}>No charges configured.</td></tr>
                    )}
                  </tbody>
                </table>
              </div>
            </section>
          )}

          <p className={styles.footnote}>
            {usingDemo
              ? '* Demo amounts shown for reference only. Admin can update live values via Fee Structure Management.'
              : '* Live data — sourced from Admin\'s Fee Structure Management. Download the PDF for a printable copy.'}
          </p>
        </>
      )}
    </div>
  );

  // ── If logged in, just render page content (AppLayout handles shell) ──
  if (isLoggedIn) return pageContent;

  // ── Public standalone: render with its own mini navbar ──
  return (
    <div className={styles.publicWrapper}>
      <nav className={styles.publicNav}>
        <Link to="/" className={styles.publicNavBrand}>
          <div className={styles.publicNavBrandIcon}>
            <GraduationCap size={18} color="#fff" />
          </div>
          PrimeTech<strong style={{color:'#C9963C', marginLeft:2}}>College</strong>
        </Link>
        <div className={styles.publicNavActions}>
          <Link to="/" className={styles.publicNavBack}>
            <ArrowLeft size={14} /> Back to Home
          </Link>
          <Link to="/login" className={styles.publicNavBack} style={{background:'#C9963C', borderColor:'#C9963C', color:'#fff'}}>
            Sign In
          </Link>
        </div>
      </nav>
      <div className={styles.publicContent}>
        {pageContent}
      </div>
    </div>
  );
}