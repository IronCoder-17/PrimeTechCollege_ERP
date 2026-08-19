import React, { useEffect, useMemo, useState } from 'react';
import { NavLink } from 'react-router-dom';
import styles from './TimetablePage.module.css';
import { Clock, Download, Printer, CalendarClock } from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import { timetableApi } from '../utils/api';

const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

const subjectPalette = [
  '#C9963C', '#10b981', '#8B7355', '#7c3aed', '#e05a5a', '#0891b2',
  '#d97706', '#059669', '#4f46e5', '#db2777',
];

function colorForSubject(name) {
  if (!name) return 'transparent';
  let hash = 0;
  for (let i = 0; i < name.length; i++) hash = name.charCodeAt(i) + ((hash << 5) - hash);
  return subjectPalette[Math.abs(hash) % subjectPalette.length];
}

// ── Admin gets a friendly redirect card instead of the raw API error ──
function AdminNotice() {
  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <Clock size={22} color="var(--dark-beige)" />
        <h1 className={styles.pageTitle}>Weekly Timetable</h1>
      </div>
      <div className="card" style={{ padding: 32, textAlign: 'center' }}>
        <CalendarClock size={36} color="var(--dark-beige)" style={{ marginBottom: 12 }} />
        <p style={{ fontSize: 15, color: 'var(--charcoal-400)', marginBottom: 18 }}>
          As an Admin, view and manage every course's timetable — including editing lectures,
          replacing whole schedules, and exporting — from the Admin Dashboard.
        </p>
        <NavLink
          to="/admin?tab=timetable"
          className="btn-ghost"
          style={{ display: 'inline-flex', alignItems: 'center', gap: 8, padding: '10px 18px' }}
        >
          Go to Timetable Management
        </NavLink>
      </div>
    </div>
  );
}

export default function TimetablePage() {
  const { user } = useAuth();
  const [grid, setGrid] = useState(null);
  const [courseLabel, setCourseLabel] = useState('');
  const [semesterLabel, setSemesterLabel] = useState(null);
  const [courseId, setCourseId] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const today = days[new Date().getDay() - 1] || 'Monday';

  useEffect(() => {
    let cancelled = false;
    async function load() {
      if (user?.role === 'admin') { setLoading(false); return; }
      setLoading(true);
      setError('');
      try {
        if (user?.role === 'faculty') {
          const res = await timetableApi.getMy();
          if (cancelled) return;
          const periodsRes = await timetableApi.getPeriods();
          const allPeriods = periodsRes.data.periods;
          const byDay = res.data.weekly_schedule;
          const g = days.map(day => ({
            day,
            periods: allPeriods.map(p => {
              if (p.is_break) return { period_no: p.period_no, label: p.label, start_time: p.start_time, end_time: p.end_time, is_break: true };
              const match = (byDay[day] || []).find(s => s.period_no === p.period_no || String(s.start_time).slice(0,5) === String(p.start_time).slice(0,5));
              return {
                period_no: p.period_no, label: p.label,
                start_time: p.start_time, end_time: p.end_time, is_break: false,
                subject_name: match?.subject_name || null,
                faculty_name: null,
                room_code: match?.room_code || null,
              };
            }),
          }));
          setGrid(g);
          setCourseLabel(`${res.data.faculty_name} — Weekly Lecture Schedule`);
          setSemesterLabel(null);
        } else {
          const res = await timetableApi.getMy();
          if (cancelled) return;
          setGrid(res.data.grid);
          setCourseId(res.data.course?.id ?? null);
          setCourseLabel(res.data.course?.course_name || '');
          setSemesterLabel(res.data.semester);
        }
      } catch (err) {
        if (!cancelled) {
          setError(err.response?.data?.error || 'Could not load your timetable yet.');
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    }
    if (user) load();
    return () => { cancelled = true; };
  }, [user]);

  const periodCols = useMemo(() => (grid && grid[0] ? grid[0].periods : []), [grid]);

  if (user?.role === 'admin') return <AdminNotice />;

  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <Clock size={22} color="var(--dark-beige)" />
        <h1 className={styles.pageTitle}>
          {courseLabel ? courseLabel : 'Weekly Timetable'}
        </h1>
        {courseId && semesterLabel && (
          <div style={{ marginLeft: 'auto', display: 'flex', gap: 8 }}>
            <button className="btn-ghost" onClick={() => timetableApi.exportCSV(courseId, semesterLabel)} title="Export Excel/CSV">
              <Download size={14} /> Export
            </button>
            <button className="btn-ghost" onClick={() => timetableApi.exportPDF(courseId, semesterLabel)} title="Print / PDF">
              <Printer size={14} /> Print
            </button>
          </div>
        )}
      </div>

      {loading && <div className="card" style={{ padding: 24 }}>Loading your timetable…</div>}

      {!loading && error && (
        <div className="card" style={{ padding: 24, color: 'var(--charcoal-400)' }}>{error}</div>
      )}

      {!loading && !error && grid && (
        <div className={`${styles.tableWrap} card`}>
          <div className={styles.grid} style={{ gridTemplateColumns: `90px repeat(${days.length}, 1fr)` }}>
            <div className={styles.corner} />
            {days.map(d => (
              <div key={d} className={`${styles.dayHead} ${d === today ? styles.today : ''}`}>{d.slice(0, 3)}</div>
            ))}
            {periodCols.map((p, pi) => (
              <React.Fragment key={p.period_no + '-' + pi}>
                <div className={styles.periodLabel}>{p.is_break ? p.label : String(p.start_time).slice(0,5)}</div>
                {days.map(d => {
                  const cell = grid.find(row => row.day === d)?.periods[pi];
                  const isBreak = cell?.is_break;
                  const subj = cell?.subject_name;
                  const color = colorForSubject(subj);
                  const isBlank = !subj && !isBreak;
                  return (
                    <div key={d + p.period_no}
                      className={`${styles.cell} ${isBreak || isBlank ? styles.blankCell : styles.subjCell}`}
                      style={!isBreak && !isBlank ? { borderLeft: `3px solid ${color}`, background: color + '18', flexDirection: 'column' } : {}}
                      title={subj ? `${subj}${cell.faculty_name ? ' · ' + cell.faculty_name : ''}${cell.room_code ? ' · ' + cell.room_code : ''}` : ''}
                    >
                      {isBreak && <span className={styles.subjLabel} style={{ color: 'var(--charcoal-300)' }}>{p.label}</span>}
                      {!isBreak && subj && (
                        <>
                          <span className={styles.subjLabel} style={{ color }}>{subj}</span>
                          {cell.room_code && <span style={{ fontSize: 9, color: 'var(--charcoal-300)' }}>{cell.room_code}</span>}
                        </>
                      )}
                    </div>
                  );
                })}
              </React.Fragment>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}