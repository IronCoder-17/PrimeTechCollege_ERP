// ============================================
// StudentDashboard — Full Academic Dashboard
// PrimeTech College Campus Connect
// ============================================

import { useState, useEffect } from 'react';
import { NavLink } from 'react-router-dom';
import {
  TrendingUp, BookOpen, Clock, Award, AlertCircle,
  CheckCircle, ChevronRight, Calendar, Bell, Users,
  Briefcase, FileText, BarChart2, Target, Star,
  ArrowUpRight, Zap, Activity, UserCircle, Layers, XCircle
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import { resultsApi, timetableApi } from '../utils/api';
import styles from './StudentDashboard.module.css';



const courses = [
  { code: 'CS501', name: 'Data Structures & Algorithms', faculty: 'Dr. Priya Shah',    credits: 4, attendance: 90, status: 'active' },
  { code: 'CS502', name: 'Database Management Systems',  faculty: 'Prof. Amit Patel',  credits: 3, attendance: 82, status: 'active' },
  { code: 'CS503', name: 'Computer Networks',            faculty: 'Dr. Ravi Kumar',    credits: 3, attendance: 78, status: 'active' },
  { code: 'CS504', name: 'Operating Systems',            faculty: 'Prof. Meera Joshi', credits: 4, attendance: 92, status: 'active' },
  { code: 'CS505', name: 'Software Engineering',         faculty: 'Dr. Suresh Nair',   credits: 3, attendance: 88, status: 'active' },
];

const assignments = [
  { subject: 'DSA',  title: 'Implement AVL Tree',       due: 'Jun 10, 2026', status: 'pending',   marks: null },
  { subject: 'DBMS', title: 'ER Diagram Project',       due: 'Jun 12, 2026', status: 'pending',   marks: null },
  { subject: 'CN',   title: 'TCP/IP Analysis Report',   due: 'Jun 08, 2026', status: 'overdue',   marks: null },
  { subject: 'OS',   title: 'Process Scheduling Sim',   due: 'Jun 05, 2026', status: 'submitted', marks: 18 },
  { subject: 'SE',   title: 'UML Diagrams',             due: 'Jun 01, 2026', status: 'submitted', marks: 22 },
];

const todaySchedule = [
  { time: '09:00',  end: '10:00', subject: 'Data Structures', room: 'LH-201', type: 'lecture', faculty: 'Dr. Priya Shah' },
  { time: '10:15',  end: '11:15', subject: 'DBMS',            room: 'LH-104', type: 'lecture', faculty: 'Prof. Amit Patel' },
  { time: '11:30',  end: '13:30', subject: 'CN Lab',          room: 'Lab-3',  type: 'lab',     faculty: 'Dr. Ravi Kumar' },
  { time: '14:00',  end: '15:00', subject: 'OS',              room: 'LH-202', type: 'lecture', faculty: 'Prof. Meera Joshi' },
];

const examSchedule = [
  { subject: 'Data Structures',         date: 'Jun 18, 2026', time: '10:00 AM', hall: 'Exam Hall A' },
  { subject: 'Database Management',     date: 'Jun 20, 2026', time: '10:00 AM', hall: 'Exam Hall B' },
  { subject: 'Computer Networks',       date: 'Jun 22, 2026', time: '02:00 PM', hall: 'Exam Hall A' },
  { subject: 'Operating Systems',       date: 'Jun 24, 2026', time: '10:00 AM', hall: 'Exam Hall C' },
];

const marks = [
  { subject: 'DSA',  internal: 38, quiz: 18, total: 56, max: 70, grade: 'A' },
  { subject: 'DBMS', internal: 42, quiz: 20, total: 62, max: 70, grade: 'A+' },
  { subject: 'CN',   internal: 31, quiz: 14, total: 45, max: 70, grade: 'B+' },
  { subject: 'OS',   internal: 44, quiz: 19, total: 63, max: 70, grade: 'A+' },
  { subject: 'SE',   internal: 36, quiz: 17, total: 53, max: 70, grade: 'A' },
];

const notifications = [
  { type: 'college', title: 'Annual Sports Day registration open', time: '2h ago',   read: false },
  { type: 'faculty',  title: 'DBMS assignment deadline extended to Jun 14', time: '5h ago',   read: false },
  { type: 'event',    title: 'TechFest 2026 — Team registration closes today', time: '1d ago',  read: true },
  { type: 'club',     title: 'Coding Club: Hackathon this weekend',  time: '2d ago',  read: true },
];

const placements = [
  { company: 'Google',        role: 'SDE Intern',           ctc: '80k/mo', deadline: 'Jun 15', tags: ['FAANG', 'Remote'] },
  { company: 'Infosys',       role: 'Systems Engineer',     ctc: '4.5 LPA', deadline: 'Jun 20', tags: ['On-campus'] },
  { company: 'Razorpay',      role: 'Backend Engineer',     ctc: '18 LPA', deadline: 'Jun 18', tags: ['Fintech', 'Fast-growing'] },
  { company: 'Adobe',         role: 'Product Intern',       ctc: '60k/mo', deadline: 'Jun 25', tags: ['Design', 'Tech'] },
];

const resources = [
  { title: 'DSA Complete Notes',        type: 'PDF',  subject: 'DSA',   size: '4.2 MB', icon: '📄' },
  { title: 'DBMS PYQ 2024',            type: 'PDF',  subject: 'DBMS',  size: '2.1 MB', icon: '📝' },
  { title: 'OS Lecture Recordings',    type: 'Video',subject: 'OS',    size: '1.8 GB', icon: '🎬' },
  { title: 'CN Textbook (Forouzan)',   type: 'eBook',subject: 'CN',    size: '22 MB',  icon: '📚' },
  { title: 'SE Reference Notes',       type: 'PDF',  subject: 'SE',    size: '3.5 MB', icon: '📄' },
];

const campusActivity = [
  { club: 'Coding Club',   role: 'Member',    events: 12, next: 'Hackathon — Jun 14' },
  { club: 'Robotics Club', role: 'Co-Lead',   events: 8,  next: 'Workshop — Jun 16' },
];

const studyGroups = [
  { name: 'DSA Crunch',   members: 8,  topic: 'Trees & Graphs',     next: 'Today 6 PM' },
  { name: 'DBMS Masters', members: 5,  topic: 'Normalization',       next: 'Jun 9 4 PM' },
];

// ── Helpers ───────────────────────────────────────────────────────────────────
function ProgressBar({ value, max = 100, color = 'var(--dark-beige)' }) {
  const pct = Math.min((value / max) * 100, 100);
  return (
    <div className={styles.progressTrack}>
      <div className={styles.progressFill} style={{ width: `${pct}%`, background: color }} />
    </div>
  );
}

function StatusBadge({ status }) {
  const map = {
    pending:   { label: 'Pending',   cls: styles.badgePending },
    submitted: { label: 'Submitted', cls: styles.badgeSubmitted },
    overdue:   { label: 'Overdue',   cls: styles.badgeOverdue },
  };
  const m = map[status] || {};
  return <span className={`${styles.statusBadge} ${m.cls}`}>{m.label}</span>;
}

// ── SECTIONS ──────────────────────────────────────────────────────────────────
function QuickStats({ student }) {
  const stats = [
    { label: 'Attendance',          value: `${student.attendance}%`, icon: Activity,    color: '#10b981', bg: '#ecfdf5' },
    { label: 'CGPA',                value: student.cgpa,              icon: Star,        color: '#C9963C', bg: '#FDF4E3' },
    { label: 'Pending Assignments', value: '4',                       icon: AlertCircle, color: '#e05a5a', bg: '#fff1f2' },
    { label: 'Upcoming Events',     value: '3',                       icon: Calendar,    color: '#8B7355', bg: '#F5EFE6' },
  ];
  return (
    <div className={styles.statsGrid}>
      {stats.map(({ label, value, icon: Icon, color, bg }) => (
        <div key={label} className={`${styles.statCard} card`}>
          <div className={styles.statIconWrap} style={{ background: bg }}>
            <Icon size={20} color={color} />
          </div>
          <div className={styles.statValue}>{value}</div>
          <div className={styles.statLabel}>{label}</div>
        </div>
      ))}
    </div>
  );
}

function AcademicOverview({ student }) {
  const creditPct = (student.creditsCompleted / student.totalCredits) * 100;
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <TrendingUp size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Academic Overview</h2>
        <span className={styles.semTag}>{student.semester}</span>
      </div>
      <div className={styles.overviewGrid}>
        <div className={styles.overviewItem}>
          <span className={styles.overviewLabel}>CGPA</span>
          <span className={styles.overviewValue} style={{ color: 'var(--soft-gold)' }}>{student.cgpa}</span>
        </div>
        <div className={styles.overviewItem}>
          <span className={styles.overviewLabel}>SGPA</span>
          <span className={styles.overviewValue} style={{ color: '#10b981' }}>{student.sgpa}</span>
        </div>
        <div className={styles.overviewItem}>
          <span className={styles.overviewLabel}>Attendance</span>
          <span className={styles.overviewValue} style={{ color: student.attendance >= 85 ? '#10b981' : '#e05a5a' }}>{student.attendance}%</span>
        </div>
        <div className={styles.overviewItem}>
          <span className={styles.overviewLabel}>Branch</span>
          <span className={styles.overviewValue} style={{ fontSize: 13, color: 'var(--charcoal-500)' }}>{student.branch}</span>
        </div>
      </div>
      <div className={styles.creditSection}>
        <div className={styles.creditHeader}>
          <span className={styles.overviewLabel}>Credit Progress</span>
          <span className={styles.creditCount}>{student.creditsCompleted} / {student.totalCredits} credits</span>
        </div>
        <ProgressBar value={student.creditsCompleted} max={student.totalCredits} color="var(--soft-gold)" />
        <span className={styles.creditPct}>{creditPct.toFixed(0)}% completed</span>
      </div>
    </div>
  );
}

function CoursesSection() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <BookOpen size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Enrolled Courses</h2>
        <span className={styles.semTag}>{courses.length} subjects</span>
      </div>
      <div className={styles.courseList}>
        {courses.map(c => (
          <div key={c.code} className={styles.courseRow}>
            <div className={styles.courseCode}>{c.code}</div>
            <div className={styles.courseInfo}>
              <span className={styles.courseName}>{c.name}</span>
              <span className={styles.courseFaculty}>{c.faculty} · {c.credits} credits</span>
            </div>
            <div className={styles.courseAttend}>
              <span className={styles.attendPct} style={{ color: c.attendance >= 85 ? '#10b981' : '#e05a5a' }}>{c.attendance}%</span>
              <ProgressBar value={c.attendance} max={100} color={c.attendance >= 85 ? '#10b981' : '#e05a5a'} />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function AssignmentsSection() {
  const [tab, setTab] = useState('pending');
  const filtered = assignments.filter(a =>
    tab === 'pending' ? ['pending','overdue'].includes(a.status) : a.status === 'submitted'
  );
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <FileText size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Assignments</h2>
        <div className={styles.tabGroup}>
          <button className={`${styles.tabBtn} ${tab === 'pending' ? styles.tabActive : ''}`} onClick={() => setTab('pending')}>Pending</button>
          <button className={`${styles.tabBtn} ${tab === 'submitted' ? styles.tabActive : ''}`} onClick={() => setTab('submitted')}>Submitted</button>
        </div>
      </div>
      <div className={styles.assignList}>
        {filtered.map((a, i) => (
          <div key={i} className={styles.assignRow}>
            <div className={styles.assignSubjectTag}>{a.subject}</div>
            <div className={styles.assignInfo}>
              <span className={styles.assignTitle}>{a.title}</span>
              <span className={styles.assignDue}>Due: {a.due}</span>
            </div>
            <div className={styles.assignRight}>
              <StatusBadge status={a.status} />
              {a.marks !== null && <span className={styles.assignMarks}>{a.marks} marks</span>}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function TodaySchedule() {
  const typeColor = { lecture: '#8B7355', lab: '#10b981' };
  const [rows, setRows] = useState(null);
  const [error, setError] = useState(false);

  useEffect(() => {
    let cancelled = false;
    timetableApi.getMy()
      .then(res => {
        if (cancelled) return;
        const dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        const today = dayNames[new Date().getDay()];
        const todayRow = (res.data.grid || []).find(r => r.day === today);
        const periods = (todayRow?.periods || []).filter(p => !p.is_break && p.subject_name);
        setRows(periods.map(p => ({
          time: String(p.start_time).slice(0, 5),
          end: String(p.end_time).slice(0, 5),
          subject: p.subject_name,
          room: p.room_code || '-',
          faculty: p.faculty_name || '-',
          type: 'lecture',
        })));
      })
      .catch(() => { if (!cancelled) setError(true); });
    return () => { cancelled = true; };
  }, []);

  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Clock size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Today's Schedule</h2>
        <NavLink to="/timetable" className={styles.viewAllBtn}>Full Timetable <ChevronRight size={13} /></NavLink>
      </div>
      <div className={styles.scheduleList}>
        {rows === null && !error && <div style={{ fontSize: 13, color: 'var(--charcoal-400)', padding: '8px 0' }}>Loading today's schedule…</div>}
        {error && <div style={{ fontSize: 13, color: 'var(--charcoal-400)', padding: '8px 0' }}>Timetable not available yet.</div>}
        {rows && rows.length === 0 && <div style={{ fontSize: 13, color: 'var(--charcoal-400)', padding: '8px 0' }}>No lectures scheduled today.</div>}
        {rows && rows.map((s, i) => (
          <div key={i} className={styles.scheduleRow}>
            <div className={styles.scheduleTime}>
              <span className={styles.timeStart}>{s.time}</span>
              <span className={styles.timeEnd}>{s.end}</span>
            </div>
            <div className={styles.scheduleBar} style={{ background: typeColor[s.type] || 'var(--dark-beige)' }} />
            <div className={styles.scheduleInfo}>
              <span className={styles.schedSubject}>{s.subject}</span>
              <span className={styles.schedMeta}>{s.room} · {s.faculty}</span>
            </div>
            <span className={styles.schedType} style={{ color: typeColor[s.type] }}>{s.type}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function ExamSchedule() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Award size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Exam Schedule</h2>
      </div>
      <div className={styles.examList}>
        {examSchedule.map((e, i) => (
          <div key={i} className={styles.examRow}>
            <div className={styles.examDate}>
              <span className={styles.examDay}>{e.date.split(',')[0].split(' ')[1]}</span>
              <span className={styles.examMon}>{e.date.split(' ')[0]}</span>
            </div>
            <div className={styles.examInfo}>
              <span className={styles.examSubject}>{e.subject}</span>
              <span className={styles.examMeta}>{e.time} · {e.hall}</span>
            </div>
            <ChevronRight size={16} color="var(--charcoal-300)" />
          </div>
        ))}
      </div>
    </div>
  );
}

// Previous Semester Results — live from /results.php/my-results.
// Shows a card per completed semester with SGPA + Pass/Fail, and the
// overall CGPA derived across all of them. Links to the full Results
// page for subject-wise marks and the academic progress graph.
function PreviousResultsSection({ resultsData, loading, error }) {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Layers size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Previous Semester Results</h2>
        <NavLink to="/results" className={styles.viewAllBtn}>Full Results <ChevronRight size={13} /></NavLink>
      </div>

      {loading ? (
        <div style={{ padding: '20px 4px', color: 'var(--charcoal-400)', fontSize: 13 }}>Loading Results…</div>
      ) : error ? (
        <div style={{ padding: '20px 4px', color: '#e05a5a', fontSize: 13 }}>{error}</div>
      ) : !resultsData || resultsData.semesters.length === 0 ? (
        <div style={{ padding: '20px 4px', color: 'var(--charcoal-400)', fontSize: 13 }}>
          <strong style={{ color: 'var(--charcoal)' }}>No Results Available</strong>
          <div style={{ marginTop: 4 }}>Once your results are added by the administration, they'll appear here automatically.</div>
        </div>
      ) : (
        <>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(140px,1fr))', gap: 10, marginBottom: 14 }}>
            {resultsData.semesters.map(sem => (
              <div key={sem.id} style={{
                border: '1px solid var(--border-soft, #eee5d8)', borderRadius: 12, padding: '12px 14px',
                background: sem.result_status === 'Fail' ? '#fff1f2' : sem.result_status === 'ATKT' ? '#fff7ed' : 'var(--cream, #faf6ef)',
              }}>
                <div style={{ fontSize: 11, color: 'var(--charcoal-400)', textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 4 }}>
                  Semester {sem.semester}{sem.academic_year ? ` · ${sem.academic_year}` : ''}
                </div>
                <div style={{ fontSize: 22, fontWeight: 800, color: 'var(--soft-gold)' }}>{sem.sgpa}</div>
                <div style={{ fontSize: 11, color: 'var(--charcoal-400)', marginBottom: 6 }}>SGPA</div>
                <div style={{
                  display: 'inline-flex', alignItems: 'center', gap: 4, fontSize: 11, fontWeight: 700, padding: '2px 8px', borderRadius: 20,
                  color: sem.result_status === 'Pass' ? '#10b981' : sem.result_status === 'ATKT' ? '#e08a3c' : '#e05a5a',
                  background: sem.result_status === 'Pass' ? '#ecfdf5' : sem.result_status === 'ATKT' ? '#fff7ed' : '#fff1f2',
                }}>
                  {sem.result_status === 'Pass' ? <CheckCircle size={11} /> : <XCircle size={11} />} {sem.result_status === 'ATKT' ? 'ATKT' : sem.result_status}
                </div>
              </div>
            ))}
          </div>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px solid var(--border-soft, #eee5d8)', paddingTop: 12 }}>
            <span style={{ fontSize: 12, color: 'var(--charcoal-400)' }}>Cumulative Grade Point Average</span>
            <span style={{ fontSize: 20, fontWeight: 800, color: 'var(--soft-gold)' }}>CGPA {resultsData.cgpa}</span>
          </div>
        </>
      )}
    </div>
  );
}

function PerformanceSection() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <BarChart2 size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Internal Marks</h2>
        <NavLink to="/results" className={styles.viewAllBtn}>Full Results <ChevronRight size={13} /></NavLink>
      </div>
      <div className={styles.marksTable}>
        <div className={styles.marksHeader}>
          <span>Subject</span><span>Internal</span><span>Quiz</span><span>Total</span><span>Grade</span>
        </div>
        {marks.map(m => (
          <div key={m.subject} className={styles.marksRow}>
            <span className={styles.marksSubj}>{m.subject}</span>
            <span>{m.internal}/50</span>
            <span>{m.quiz}/20</span>
            <div className={styles.marksTotal}>
              <ProgressBar value={m.total} max={m.max} color="var(--soft-gold)" />
              <span>{m.total}/{m.max}</span>
            </div>
            <span className={`${styles.gradeTag} ${m.grade === 'A+' ? styles.gradePlus : ''}`}>{m.grade}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function NotificationsSection() {
  const typeIcon = { college: '🏫', faculty: '👨‍🏫', event: '🎉', club: '🎯' };
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Bell size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Notifications</h2>
        <NavLink to="/notifications" className={styles.viewAllBtn}>View All <ChevronRight size={13} /></NavLink>
      </div>
      <div className={styles.notifList}>
        {notifications.map((n, i) => (
          <div key={i} className={`${styles.notifRow} ${!n.read ? styles.notifUnread : ''}`}>
            <span className={styles.notifEmoji}>{typeIcon[n.type]}</span>
            <div className={styles.notifInfo}>
              <span className={styles.notifTitle}>{n.title}</span>
              <span className={styles.notifTime}>{n.time}</span>
            </div>
            {!n.read && <div className={styles.notifDot} />}
          </div>
        ))}
      </div>
    </div>
  );
}

function CampusActivitySection() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Users size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Campus Activity</h2>
      </div>
      <h3 className={styles.subHeading}>My Clubs</h3>
      <div className={styles.clubList}>
        {campusActivity.map((c, i) => (
          <div key={i} className={styles.clubRow}>
            <div className={styles.clubAvatar}>{c.club[0]}</div>
            <div className={styles.clubInfo}>
              <span className={styles.clubName}>{c.club}</span>
              <span className={styles.clubRole}>{c.role} · {c.events} events attended</span>
              <span className={styles.clubNext}>Next: {c.next}</span>
            </div>
          </div>
        ))}
      </div>
      <h3 className={styles.subHeading} style={{ marginTop: 16 }}>Study Groups</h3>
      <div className={styles.clubList}>
        {studyGroups.map((g, i) => (
          <div key={i} className={styles.clubRow}>
            <div className={styles.clubAvatar} style={{ background: 'var(--gold-50)', color: 'var(--soft-gold)' }}>{g.name[0]}</div>
            <div className={styles.clubInfo}>
              <span className={styles.clubName}>{g.name}</span>
              <span className={styles.clubRole}>{g.members} members · Topic: {g.topic}</span>
              <span className={styles.clubNext}>Next session: {g.next}</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function PlacementsSection() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <Briefcase size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Placement Opportunities</h2>
        <NavLink to="/placements" className={styles.viewAllBtn}>View All <ChevronRight size={13} /></NavLink>
      </div>
      <div className={styles.placementList}>
        {placements.map((p, i) => (
          <div key={i} className={styles.placementRow}>
            <div className={styles.companyAvatar}>{p.company[0]}</div>
            <div className={styles.placementInfo}>
              <span className={styles.companyName}>{p.company}</span>
              <span className={styles.placementRole}>{p.role} · {p.ctc}</span>
              <div className={styles.tagGroup}>
                {p.tags.map(t => <span key={t} className={styles.tag}>{t}</span>)}
              </div>
            </div>
            <div className={styles.placementRight}>
              <span className={styles.placementDeadline}>Deadline: {p.deadline}</span>
              <button className={styles.applyBtn}><ArrowUpRight size={14} /> Apply</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function ResourcesSection() {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <BookOpen size={18} className={styles.sectionIcon} />
        <h2 className={styles.sectionTitle}>Resources</h2>
        <NavLink to="/resources" className={styles.viewAllBtn}>View All <ChevronRight size={13} /></NavLink>
      </div>
      <div className={styles.resourceList}>
        {resources.map((r, i) => (
          <div key={i} className={styles.resourceRow}>
            <span className={styles.resourceEmoji}>{r.icon}</span>
            <div className={styles.resourceInfo}>
              <span className={styles.resourceTitle}>{r.title}</span>
              <span className={styles.resourceMeta}>{r.type} · {r.subject} · {r.size}</span>
            </div>
            <button className={styles.downloadBtn}>Download</button>
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Main Dashboard ─────────────────────────────────────────────────────────────
export default function StudentDashboard() {
  const { user } = useAuth();

  // ── Live academic results (current semester, SGPA/CGPA, previous semesters) ──
  const [resultsData, setResultsData] = useState(null);
  const [resultsLoading, setResultsLoading] = useState(true);
  const [resultsError, setResultsError] = useState('');

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const res = await resultsApi.getMyResults();
        if (active) setResultsData(res.data);
      } catch (e) {
        if (active) setResultsError('Could not load your academic results.');
      } finally {
        if (active) setResultsLoading(false);
      }
    })();
    return () => { active = false; };
  }, []);

  // Build a student display object from the authenticated user,
  // with sensible fallbacks so the UI never shows undefined/null.
  const firstName = user?.firstName || user?.name?.split(' ')[0] || 'Student';
  const currentSemester = resultsData?.student?.current_semester ?? user?.semester;
  const student = {
    name:             user?.name            || 'Student',
    branch:           user?.major           || user?.course         || 'Computer Science',
    year:             user?.year            || '—',
    semester:         currentSemester
                        ? `Sem ${currentSemester}`
                        : (user?.year || 'Semester —'),
    // CGPA is derived live from published semester results (credit-weighted
    // average of SGPAs) — falls back to the profile value while loading.
    cgpa:             resultsData?.cgpa      ?? (user?.cgpa ?? 0),
    sgpa:             resultsData?.semesters?.length
                        ? resultsData.semesters[resultsData.semesters.length - 1].sgpa
                        : (user?.sgpa ?? 0),
    attendance:       user?.attendance      ?? 0,
    creditsCompleted: user?.creditsCompleted ?? 0,
    totalCredits:     user?.totalCredits     ?? 160,
  };

  const hasHostel = user?.hostelRequired === true;

  if (!user) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 80 }}>
        <div className="spinner" style={{ width: 36, height: 36 }} />
      </div>
    );
  }

  return (
    <div className={styles.dashboard}>
      {/* Welcome Banner */}
      <div className={styles.welcomeBanner}>
        <div className={styles.welcomeLeft}>
          <div className={styles.welcomeTag}><Zap size={12} /> {student.semester}</div>
          <h1 className={styles.welcomeTitle}>Good morning, {firstName}! 👋</h1>
          <p className={styles.welcomeSub}>{student.branch} · {student.year} · CGPA {student.cgpa}</p>
          <NavLink to="/profile" className={styles.viewProfileBtn}><UserCircle size={14} /> View Profile</NavLink>
          <NavLink to="/edit-profile" className={styles.viewProfileBtn} style={{ marginLeft: 8 }}><UserCircle size={14} /> Edit Profile</NavLink>
        </div>
        <div className={styles.welcomeRight}>
          <div className={styles.welcomeStat}>
            <Target size={28} color="var(--soft-gold)" />
            <div>
              <span className={styles.welcomeStatVal}>{student.attendance}%</span>
              <span className={styles.welcomeStatLabel}>Attendance</span>
            </div>
          </div>
        </div>
      </div>

      {/* Hostel Card — only for hostel students */}
      {hasHostel && (
        <div className={`${styles.sectionCard} card`} style={{ marginBottom: 20, border: '1px solid #bfdbfe', background: 'linear-gradient(135deg,#eff6ff,#f0f9ff)' }}>
          <div className={styles.sectionHeader}>
            <span style={{ fontSize: 20 }}>🏠</span>
            <h2 className={styles.sectionTitle} style={{ color: '#1e40af' }}>Hostel</h2>
            <span className={styles.semTag} style={{ background: '#dbeafe', color: '#1d4ed8' }}>Active</span>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(150px,1fr))', gap: 12, marginTop: 4 }}>
            {[
              { label: 'Hostel Type', value: user?.hostelType || '—' },
              { label: 'Room Type',   value: user?.roomType   || '—' },
              { label: 'Room Number', value: user?.hostelRoomNumber || 'Pending Allocation' },
              { label: 'Fee Status',  value: user?.hostelPaymentStatus || 'Paid' },
            ].map(({ label, value }) => (
              <div key={label} style={{ background: 'white', borderRadius: 10, padding: '10px 14px', border: '1px solid #dbeafe' }}>
                <div style={{ fontSize: 11, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 4 }}>{label}</div>
                <div style={{ fontSize: 14, fontWeight: 700, color: '#1e40af' }}>{value}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Quick Stats */}
      <QuickStats student={student} />

      {/* Main Grid */}
      <div className={styles.mainGrid}>
        {/* Left Column */}
        <div className={styles.leftCol}>
          <AcademicOverview student={student} />
          <PreviousResultsSection resultsData={resultsData} loading={resultsLoading} error={resultsError} />
          <TodaySchedule />
          <CoursesSection />
          <PerformanceSection />
          <PlacementsSection />
          <ResourcesSection />
        </div>

        {/* Right Column */}
        <div className={styles.rightCol}>
          <AssignmentsSection />
          <NotificationsSection />
          <ExamSchedule />
          <CampusActivitySection />
        </div>
      </div>
    </div>
  );
}