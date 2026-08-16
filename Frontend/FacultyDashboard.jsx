// ============================================
// FacultyDashboard — Full Featured (Modules 10-14 included)
// PrimeTech College Campus Connect
// ============================================

import { useState, useEffect } from 'react';
import { useAuth } from '../contexts/AuthContext';
import {
  Briefcase, BookOpen, CalendarDays, Bell, LogOut,
  GraduationCap, Users, FileText, PlusCircle,
  CheckCircle, Clock, MessageCircle, TrendingUp,
  Edit2, Trash2, UserSearch, ClipboardList, Timer,
  BarChart2, BookMarked, ChevronDown, ChevronUp,
  AlertCircle, PlayCircle, StopCircle, Activity,
  Hash, Percent, Star, Target, MapPin, Cpu,
  Filter, ChevronLeft, ChevronRight, Download, CalendarCheck
} from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import {
  getStudentsForFaculty, queryStudents,
  saveAttendanceBatch, getAttendanceForDate, getAttendanceHistory,
  getStudentAttendanceSummary, getMonthlyAttendanceReport,
} from '../utils/studentMapping';
import { facultyApi } from '../utils/api';

// ── Static Data ─────────────────────────────────────────────

const COURSES = [
  { id: 1, code: 'CS401', name: 'Advanced Algorithms', students: 64, schedule: 'Mon/Wed 10:00 AM', room: 'Block A - 204', progress: 68 },
  { id: 2, code: 'CS302', name: 'Database Systems', students: 52, schedule: 'Tue/Thu 2:00 PM', room: 'Block B - 101', progress: 45 },
  { id: 3, code: 'CS501', name: 'Machine Learning', students: 38, schedule: 'Fri 9:00 AM', room: 'Lab 3', progress: 30 },
];

const INIT_ANNOUNCEMENTS = [
  { id: 1, course: 'CS401', title: 'Assignment 3 Deadline Extended', body: 'Due to the tech fest, deadline moved to next Monday.', time: '2h ago', pinned: true },
  { id: 2, course: 'CS302', title: 'Mid-term Exam Schedule', body: 'Mid-term will be held on June 20 in Block B Hall.', time: '1 day ago', pinned: false },
  { id: 3, course: 'CS501', title: 'Guest Lecture This Friday', body: 'Dr. Ananya Krishnan from Google Research will speak on LLMs.', time: '2 days ago', pinned: false },
];

const UPCOMING = [
  { label: 'CS401 Lecture', time: 'Today, 10:00 AM', room: 'Block A - 204', type: 'lecture' },
  { label: 'CS302 Lab Session', time: 'Today, 2:00 PM', room: 'Lab 2', type: 'lab' },
  { label: 'CS401 Assignment 3 Due', time: 'Tomorrow', room: '', type: 'deadline' },
  { label: 'Faculty Meeting', time: 'Thu, 11:00 AM', room: 'Conference Room', type: 'meeting' },
  { label: 'CS501 Guest Lecture', time: 'Fri, 9:00 AM', room: 'Auditorium', type: 'special' },
];

const INIT_QUERIES = [
  { id: 1, student: 'Alex Johnson', course: 'CS401', msg: 'Sir, can you share resources for dynamic programming?', time: '30 min ago', answered: false },
  { id: 2, student: 'Maya Patel', course: 'CS302', msg: 'When will the Assignment 2 grades be posted?', time: '2h ago', answered: false },
  { id: 3, student: 'Ravi Kumar', course: 'CS501', msg: 'Thank you for the ML session, really helpful!', time: '5h ago', answered: true },
];

const INIT_SYLLABUS = [
  {
    subject_id: 1, subject: 'Advanced Algorithms', code: 'CS401',
    units: [
      { unit_no: 1, topic_name: 'Algorithm Analysis & Complexity', total: 8, completed: 8 },
      { unit_no: 2, topic_name: 'Divide & Conquer', total: 6, completed: 5 },
      { unit_no: 3, topic_name: 'Dynamic Programming', total: 8, completed: 4 },
      { unit_no: 4, topic_name: 'Graph Algorithms', total: 10, completed: 2 },
    ],
  },
  {
    subject_id: 2, subject: 'Database Systems', code: 'CS302',
    units: [
      { unit_no: 1, topic_name: 'Introduction to DBMS', total: 6, completed: 6 },
      { unit_no: 2, topic_name: 'ER Model & Relational Model', total: 8, completed: 6 },
      { unit_no: 3, topic_name: 'SQL Queries', total: 10, completed: 5 },
      { unit_no: 4, topic_name: 'Normalization', total: 8, completed: 0 },
    ],
  },
  {
    subject_id: 3, subject: 'Machine Learning', code: 'CS501',
    units: [
      { unit_no: 1, topic_name: 'Introduction & Math Foundations', total: 6, completed: 4 },
      { unit_no: 2, topic_name: 'Supervised Learning', total: 8, completed: 2 },
      { unit_no: 3, topic_name: 'Unsupervised Learning', total: 8, completed: 0 },
      { unit_no: 4, topic_name: 'Neural Networks & Deep Learning', total: 10, completed: 0 },
    ],
  },
];

const INIT_NOTIFICATIONS = [
  { id: 1, title: 'Upcoming Class Reminder', message: 'CS401 lecture at 10:00 AM today in Block A-204.', type: 'class', is_read: false, created_at: '10 min ago' },
  { id: 2, title: 'Pending Attendance', message: 'You have not submitted attendance for CS302 on Jun 7.', type: 'attendance', is_read: false, created_at: '2h ago' },
  { id: 3, title: 'Syllabus Update Pending', message: 'Unit 3 of CS501 has no lectures recorded yet.', type: 'syllabus', is_read: false, created_at: '1 day ago' },
  { id: 4, title: 'TechFest 2026 Event', message: 'Annual TechFest begins on June 15. Register your students.', type: 'event', is_read: true, created_at: '2 days ago' },
  { id: 5, title: 'Faculty Senate Meeting', message: 'Monthly meeting scheduled for Thursday, 11:00 AM.', type: 'meeting', is_read: true, created_at: '3 days ago' },
];

// ── Helpers ──────────────────────────────────────────────────

const typeColor = (t) => ({
  lecture: '#2563eb', lab: '#16a34a', deadline: '#dc2626',
  meeting: '#7c3aed', special: '#d97706',
}[t] || '#6b7280');

const notifColor = (t) => ({
  class: '#2563eb', attendance: '#dc2626', syllabus: '#d97706',
  event: '#16a34a', meeting: '#7c3aed',
}[t] || '#6b7280');

const notifIcon = (t) => ({
  class: '🏫', attendance: '📋', syllabus: '📚', event: '🎉', meeting: '📅',
}[t] || '🔔');

const statusColor = (s) => ({
  Present: { bg: '#f0fdf4', color: '#16a34a' },
  Absent: { bg: '#fff1f2', color: '#dc2626' },
  Leave: { bg: '#fff7ed', color: '#d97706' },
}[s] || { bg: '#f3f4f6', color: '#6b7280' });

const pct = (c, t) => t === 0 ? 0 : Math.round((c / t) * 100);

// Format a TIME ("09:05:00") or DATETIME ("2026-06-14 09:05:00") string
// from the backend into a friendly 12-hour time, e.g. "9:05 AM".
const formatTimeStr = (t) => {
  if (!t) return '-';
  const timePart = t.includes(' ') ? t.split(' ')[1] : t;
  const [hStr, mStr] = timePart.split(':');
  const hour = parseInt(hStr, 10);
  const ampm = hour >= 12 ? 'PM' : 'AM';
  const hour12 = hour % 12 === 0 ? 12 : hour % 12;
  return `${hour12}:${mStr} ${ampm}`;
};

// Format decimal hours (8.5) into "8h 30m"
const formatHours = (hrs) => {
  if (hrs === null || hrs === undefined || hrs === '') return '-';
  const h = Math.floor(hrs);
  const m = Math.round((hrs - h) * 60);
  return `${h}h ${m}m`;
};

// ── Styles ──────────────────────────────────────────────────

const card = {
  background: 'white', borderRadius: 16, padding: 20,
  border: '1px solid #e5e7eb', boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
};

const btn = (primary = true) => ({
  display: 'inline-flex', alignItems: 'center', gap: 6,
  padding: '8px 16px', borderRadius: 9, border: 'none', cursor: 'pointer',
  fontSize: 13, fontWeight: 600,
  background: primary ? '#7c3aed' : '#f3f4f6',
  color: primary ? 'white' : '#374151',
});

// ── Sub-components ───────────────────────────────────────────

function StatCard({ label, value, icon: Icon, color, bg, sub }) {
  return (
    <div style={{ ...card }}>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 10 }}>
        <span style={{ fontSize: 12, color: '#6b7280', fontWeight: 500 }}>{label}</span>
        <div style={{ width: 34, height: 34, background: bg, borderRadius: 9, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
          <Icon size={17} color={color} />
        </div>
      </div>
      <div style={{ fontSize: 26, fontWeight: 800, color: '#111827' }}>{value}</div>
      {sub && <div style={{ fontSize: 11, color: '#9ca3af', marginTop: 2 }}>{sub}</div>}
    </div>
  );
}

function ProgressBar({ value, color = '#7c3aed', height = 8 }) {
  return (
    <div style={{ height, background: '#f3f4f6', borderRadius: 4, overflow: 'hidden' }}>
      <div style={{ height: '100%', width: `${value}%`, background: color, borderRadius: 4, transition: 'width 0.4s' }} />
    </div>
  );
}

// ── Main Component ───────────────────────────────────────────

export default function FacultyDashboard() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const TABS = [
    { key: 'overview',      label: 'Overview',           icon: TrendingUp },
    { key: 'courses',       label: 'My Courses',          icon: BookOpen },
    { key: 'students',      label: 'Student Management',  icon: Users },
    { key: 'attendance',    label: 'Student Attendance',  icon: ClipboardList },
    { key: 'my_attendance', label: 'My Attendance',       icon: Activity },
    { key: 'punch',         label: 'Punch In/Out',        icon: Timer },
    { key: 'syllabus',      label: 'Syllabus Mapping',    icon: BookMarked },
    { key: 'announcements', label: 'Announcements',       icon: Bell },
    { key: 'queries',       label: 'Student Queries',     icon: MessageCircle },
    { key: 'schedule',      label: 'Schedule',            icon: CalendarDays },
    { key: 'notifications', label: 'Notifications',       icon: Bell },
    { key: 'my_profile',    label: 'My Profile',          icon: GraduationCap },
    { key: 'edit_profile',  label: 'Edit Profile',        icon: Edit2 },
  ];

  const [activeTab, setActiveTab] = useState('overview');
  const [announcements, setAnnouncements] = useState(INIT_ANNOUNCEMENTS);
  const [queries, setQueries] = useState(INIT_QUERIES);
  const [newAnn, setNewAnn] = useState({ course: 'CS401', title: '', body: '' });
  const [showAnnForm, setShowAnnForm] = useState(false);
  const [notifications, setNotifications] = useState(INIT_NOTIFICATIONS);

  // ── Real Student Directory (filtered by faculty department/specialization) ──
  const myStudents = getStudentsForFaculty(user);

  // Student Management tab state
  const [stuSearch, setStuSearch] = useState('');
  const [stuCourseFilter, setStuCourseFilter] = useState('');
  const [stuSemFilter, setStuSemFilter] = useState('');
  const [stuSort, setStuSort] = useState('name');
  const [stuSortDir, setStuSortDir] = useState('asc');
  const [stuPage, setStuPage] = useState(1);

  // Student Attendance state (now backed by real student directory + localStorage)
  const todayStr = new Date().toISOString().slice(0, 10);
  const [attCourse, setAttCourse] = useState('CS401');
  const [attSemester, setAttSemester] = useState('');
  const [attDivision, setAttDivision] = useState('A');
  const [attDate, setAttDate] = useState(todayStr);
  const [attData, setAttData] = useState({});
  const [attSaved, setAttSaved] = useState(false);
  const [attTab, setAttTab] = useState('mark'); // 'mark' | 'history' | 'analytics'
  const [searchEnroll, setSearchEnroll] = useState('');
  const [searchResult, setSearchResult] = useState(null);

  // Students relevant to currently-selected subject (semester filter optional)
  const attendanceStudents = myStudents.filter(s =>
    !attSemester || String(s.semester) === String(attSemester)
  );

  // Load existing attendance for the selected subject+date whenever they change
  useEffect(() => {
    const existing = getAttendanceForDate(attCourse, attDate);
    const initial = {};
    attendanceStudents.forEach(s => {
      initial[s.id] = existing[s.id] || 'Present';
    });
    setAttData(initial);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [attCourse, attDate, myStudents.length]);

  // ── Live Faculty Attendance / Punch In-Out state (real DB via API) ──
  const [todayPunch, setTodayPunch] = useState(null);          // { punch_in_time, punch_out_time, total_working_hours }
  const [myAttendanceRecords, setMyAttendanceRecords] = useState([]);
  const [myAttendanceSummary, setMyAttendanceSummary] = useState({ total: 0, present: 0, absent: 0, leave: 0, pct: 0 });
  const [punchLogs, setPunchLogs] = useState([]);
  const [attendanceLoading, setAttendanceLoading] = useState(true);
  const [attendanceError, setAttendanceError] = useState('');
  const [punchActionLoading, setPunchActionLoading] = useState(false);
  const [punchActionError, setPunchActionError] = useState('');

  const loadAttendanceData = async () => {
    setAttendanceLoading(true);
    setAttendanceError('');
    try {
      const [summaryRes, attRes, logsRes] = await Promise.all([
        facultyApi.getDashboardSummary(),
        facultyApi.getMyAttendance(),
        facultyApi.getPunchLogs(30),
      ]);
      setTodayPunch(summaryRes.data?.today_punch || null);
      setMyAttendanceRecords(attRes.data?.records || []);
      setMyAttendanceSummary(attRes.data?.summary || { total: 0, present: 0, absent: 0, leave: 0, pct: 0 });
      setPunchLogs(logsRes.data?.logs || []);
    } catch (e) {
      setAttendanceError('Could not load attendance data from the server.');
    } finally {
      setAttendanceLoading(false);
    }
  };

  useEffect(() => {
    loadAttendanceData();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handlePunchIn = async () => {
    setPunchActionLoading(true);
    setPunchActionError('');
    try {
      await facultyApi.punchIn({});
      await loadAttendanceData();
    } catch (e) {
      setPunchActionError(e?.response?.data?.message || 'Could not punch in. Please try again.');
    } finally {
      setPunchActionLoading(false);
    }
  };

  const handlePunchOut = async () => {
    setPunchActionLoading(true);
    setPunchActionError('');
    try {
      await facultyApi.punchOut();
      await loadAttendanceData();
    } catch (e) {
      setPunchActionError(e?.response?.data?.message || 'Could not punch out. Please try again.');
    } finally {
      setPunchActionLoading(false);
    }
  };

  const punchedIn   = !!todayPunch?.punch_in_time;
  const punchedOut  = !!todayPunch?.punch_out_time;
  const workingHoursToday = punchedOut ? formatHours(todayPunch?.total_working_hours) : null;

  // Syllabus state
  const [syllabus, setSyllabus] = useState(INIT_SYLLABUS);
  const [syllabusSubject, setSyllabusSubject] = useState(0);
  const [editingUnit, setEditingUnit] = useState(null);
  const [editCompleted, setEditCompleted] = useState('');

  const handleLogout = () => { logout(); navigate('/'); };

  const deleteAnn = (id) => setAnnouncements(prev => prev.filter(a => a.id !== id));
  const markAnswered = (id) => setQueries(prev => prev.map(q => q.id === id ? { ...q, answered: true } : q));
  const postAnnouncement = () => {
    if (!newAnn.title.trim() || !newAnn.body.trim()) return;
    setAnnouncements(prev => [{ id: Date.now(), ...newAnn, time: 'Just now', pinned: false }, ...prev]);
    setNewAnn({ course: 'CS401', title: '', body: '' });
    setShowAnnForm(false);
  };

  const handleSearch = () => {
    const q = searchEnroll.toLowerCase().trim();
    const found = myStudents.find(s =>
      s.enrollmentNumber?.toLowerCase() === q || s.grNumber?.toLowerCase() === q
    );
    setSearchResult(found || 'notfound');
  };

  const setAllAttendance = (status) => {
    setAttData(prev => {
      const updated = { ...prev };
      attendanceStudents.forEach(s => { updated[s.id] = status; });
      return updated;
    });
  };

  const saveAttendance = () => {
    const subj = COURSES.find(c => c.code === attCourse);
    const records = attendanceStudents.map(s => ({
      studentId: s.id,
      studentName: s.name,
      status: attData[s.id] || 'Present',
    }));
    saveAttendanceBatch({
      subjectCode: attCourse,
      subjectName: subj?.name || attCourse,
      date: attDate,
      facultyId: user?.id,
      facultyName: user?.name,
      records,
    });
    setAttSaved(true);
    setTimeout(() => setAttSaved(false), 2000);
  };

  const markAllRead = () => setNotifications(prev => prev.map(n => ({ ...n, is_read: true })));

  // ── Profile Edit State ─────────────────────────────────────
  const [profileEdit, setProfileEdit] = useState({
    phone: user?.phone || '',
    address: user?.address || '',
  });
  const [profilePhotoPreview, setProfilePhotoPreview] = useState(user?.photoDataUrl || user?.avatar || null);
  const [profileSaved, setProfileSaved] = useState(false);
  const [pwForm, setPwForm] = useState({ current: '', newPw: '', confirm: '' });
  const [pwMsg, setPwMsg] = useState('');
  const [showPw, setShowPw] = useState(false);

  const handleProfileSave = () => {
    // Update in localStorage
    try {
      const apps = JSON.parse(localStorage.getItem('pt_faculty_applications') || '[]');
      const updated = apps.map(a =>
        a.employeeId === user?.employeeId
          ? { ...a, phone: profileEdit.phone, address: profileEdit.address,
              ...(profilePhotoPreview && profilePhotoPreview !== user?.avatar ? { photoDataUrl: profilePhotoPreview } : {}) }
          : a
      );
      localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
      setProfileSaved(true);
      setTimeout(() => setProfileSaved(false), 2500);
    } catch (e) { console.error(e); }
  };

  const handlePwChange = () => {
    if (!pwForm.current) { setPwMsg('Enter your current password.'); return; }
    if (pwForm.newPw.length < 6) { setPwMsg('New password must be at least 6 characters.'); return; }
    if (pwForm.newPw !== pwForm.confirm) { setPwMsg('Passwords do not match.'); return; }
    // Verify current password
    try {
      const apps = JSON.parse(localStorage.getItem('pt_faculty_applications') || '[]');
      const myApp = apps.find(a => a.employeeId === user?.employeeId);
      if (myApp && myApp.password !== pwForm.current) { setPwMsg('Current password is incorrect.'); return; }
      const updated = apps.map(a =>
        a.employeeId === user?.employeeId ? { ...a, password: pwForm.newPw } : a
      );
      localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
      setPwMsg('✓ Password changed successfully! Please login again.');
      setPwForm({ current: '', newPw: '', confirm: '' });
    } catch (e) { setPwMsg('Failed to update password.'); }
  };

  const handlePhotoUpload = (file) => {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (e) => setProfilePhotoPreview(e.target.result);
    reader.readAsDataURL(file);
  };

  const updateSyllabusUnit = (subIdx, unitIdx) => {
    const val = parseInt(editCompleted);
    if (isNaN(val)) return;
    setSyllabus(prev => {
      const updated = prev.map((sub, si) => {
        if (si !== subIdx) return sub;
        return {
          ...sub,
          units: sub.units.map((u, ui) => ui === unitIdx ? { ...u, completed: Math.min(val, u.total) } : u),
        };
      });
      return updated;
    });
    setEditingUnit(null);
    setEditCompleted('');
  };

  const currentSub = syllabus[syllabusSubject];
  const subTotalLectures = currentSub.units.reduce((a, u) => a + u.total, 0);
  const subCompletedLectures = currentSub.units.reduce((a, u) => a + u.completed, 0);
  const subPct = pct(subCompletedLectures, subTotalLectures);

  const myAttTotal   = myAttendanceSummary.total   || 0;
  const myAttPresent = myAttendanceSummary.present || 0;
  const myAttAbsent  = myAttendanceSummary.absent  || 0;
  const myAttLeave   = myAttendanceSummary.leave   || 0;
  const myAttPct     = myAttendanceSummary.pct     || 0;

  const unreadNotifs = notifications.filter(n => !n.is_read).length;

  // ── Student Management: queried/filtered/paginated list ──
  const studentQuery = queryStudents(myStudents, {
    search: stuSearch,
    course: stuCourseFilter,
    semester: stuSemFilter,
    sortBy: stuSort,
    sortDir: stuSortDir,
    page: stuPage,
    pageSize: 8,
  });

  // Distinct course codes among "my students" for the filter dropdown
  const myCourseCodes = [...new Set(myStudents.map(s => s.courseCode).filter(Boolean))];
  const mySemesters = [...new Set(myStudents.map(s => s.semester).filter(Boolean))].sort();

  // ── Overview: dashboard summary stats ──
  const todaysClasses = UPCOMING.filter(u => u.time.startsWith('Today')).length;
  const attendanceMarkedToday = COURSES.filter(c => {
    const hist = getAttendanceForDate(c.code, todayStr);
    return Object.keys(hist).length > 0;
  }).length;
  const pendingAttendance = COURSES.length - attendanceMarkedToday;
  const overallAttCompletionPct = COURSES.length > 0
    ? Math.round((attendanceMarkedToday / COURSES.length) * 100)
    : 0;

  return (
    <div style={{ minHeight: '100vh', background: '#f8fafc', fontFamily: 'Inter, sans-serif' }}>
      {/* ── Top Bar ── */}
      <header style={{
        background: 'white', borderBottom: '1px solid #e5e7eb',
        padding: '0 24px', height: 64, display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', position: 'sticky', top: 0, zIndex: 100,
        boxShadow: '0 1px 4px rgba(0,0,0,0.06)',
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <div style={{ width: 36, height: 36, background: 'linear-gradient(135deg,#7c3aed,#6d28d9)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <GraduationCap size={20} color="white" />
          </div>
          <div>
            <div style={{ fontWeight: 700, fontSize: 16, color: '#111827' }}>PrimeTech College</div>
            <div style={{ fontSize: 11, color: '#6b7280' }}>Faculty Dashboard</div>
          </div>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '6px 12px', background: '#f5f3ff', borderRadius: 20, border: '1px solid #ddd6fe' }}>
            <Briefcase size={13} color="#7c3aed" />
            <span style={{ fontSize: 12, fontWeight: 600, color: '#7c3aed' }}>Faculty</span>
          </div>
          {unreadNotifs > 0 && (
            <div style={{ position: 'relative', cursor: 'pointer' }} onClick={() => setActiveTab('notifications')}>
              <Bell size={20} color="#6b7280" />
              <span style={{ position: 'absolute', top: -6, right: -6, background: '#dc2626', color: 'white', borderRadius: '50%', width: 16, height: 16, fontSize: 10, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700 }}>{unreadNotifs}</span>
            </div>
          )}
          <img
            src={user?.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name || 'faculty'}`}
            alt={user?.name}
            style={{ width: 34, height: 34, borderRadius: '50%', objectFit: 'cover', border: '2px solid #ddd6fe' }}
          />
          <span style={{ fontSize: 14, fontWeight: 500, color: '#374151' }}>{user?.name || 'Dr. Priya Shah'}</span>
          <button onClick={handleLogout} style={{ ...btn(false), gap: 6 }}>
            <LogOut size={13} /> Sign Out
          </button>
        </div>
      </header>

      <div style={{ display: 'flex', maxWidth: 1400, margin: '0 auto', padding: '20px 20px 40px' }}>
        {/* ── Sidebar ── */}
        <aside style={{ width: 210, flexShrink: 0, marginRight: 20 }}>
          <div style={{ position: 'sticky', top: 80 }}>
            {TABS.map(({ key, label, icon: Icon }) => (
              <button key={key} onClick={() => setActiveTab(key)} style={{
                width: '100%', display: 'flex', alignItems: 'center', gap: 9,
                padding: '9px 13px', borderRadius: 10, border: 'none', cursor: 'pointer',
                background: activeTab === key ? '#f5f3ff' : 'transparent',
                color: activeTab === key ? '#7c3aed' : '#6b7280',
                fontWeight: activeTab === key ? 600 : 400, fontSize: 13, marginBottom: 2,
                transition: 'all 0.15s', textAlign: 'left',
              }}>
                <Icon size={15} /> {label}
                {key === 'notifications' && unreadNotifs > 0 && (
                  <span style={{ marginLeft: 'auto', background: '#dc2626', color: 'white', borderRadius: 20, padding: '1px 7px', fontSize: 10, fontWeight: 700 }}>{unreadNotifs}</span>
                )}
              </button>
            ))}
          </div>
        </aside>

        {/* ── Main ── */}
        <main style={{ flex: 1, minWidth: 0 }}>
          <div style={{ marginBottom: 20 }}>
            <h1 style={{ fontSize: 20, fontWeight: 700, color: '#111827', margin: 0 }}>
              {TABS.find(t => t.key === activeTab)?.label}
            </h1>
            <p style={{ color: '#6b7280', fontSize: 13, margin: '3px 0 0' }}>
              {user?.major || 'Computer Science'} · PrimeTech College
            </p>
          </div>

          {/* ══════════════════ OVERVIEW ══════════════════ */}
          {activeTab === 'overview' && (
            <>
              {/* Stat Cards Row 1 */}
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5,1fr)', gap: 14, marginBottom: 16 }}>
                <StatCard label="Total Students Assigned" value={myStudents.length} icon={Users} color="#2563eb" bg="#eff6ff" sub={user?.department || 'Your Department'} />
                <StatCard label="Subjects Assigned" value={COURSES.length} icon={BookOpen} color="#d97706" bg="#fff7ed" />
                <StatCard label="Today's Classes" value={todaysClasses} icon={Clock} color="#dc2626" bg="#fff1f2" />
                <StatCard label="Pending Attendance" value={pendingAttendance} icon={AlertCircle} color="#dc2626" bg="#fff1f2" sub={`${attendanceMarkedToday}/${COURSES.length} marked today`} />
                <StatCard label="Attendance Completion" value={`${overallAttCompletionPct}%`} icon={CalendarCheck} color="#16a34a" bg="#f0fdf4" />
              </div>
              {/* Stat Cards Row 2 */}
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5,1fr)', gap: 14, marginBottom: 20 }}>
                <StatCard label="Syllabus Completion" value={`${subPct}%`} icon={Target} color="#7c3aed" bg="#f5f3ff" sub={currentSub.subject} />
                <StatCard label="My Attendance" value={`${myAttPct}%`} icon={Activity} color="#16a34a" bg="#f0fdf4" sub={`${myAttPresent}/${myAttTotal} days`} />
                <StatCard label="Today Status" value={punchedIn ? 'Present' : 'Not Marked'} icon={CheckCircle} color={punchedIn ? '#16a34a' : '#9ca3af'} bg={punchedIn ? '#f0fdf4' : '#f3f4f6'} />
                <StatCard label="Punch In" value={punchedIn ? formatTimeStr(todayPunch.punch_in_time) : 'Not yet'} icon={PlayCircle} color="#2563eb" bg="#eff6ff" />
                <StatCard label="Working Hours" value={workingHoursToday || (punchedIn ? 'Active' : '-')} icon={Timer} color="#d97706" bg="#fff7ed" />
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 18 }}>
                {/* Today's Schedule */}
                <div style={{ ...card }}>
                  <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 12 }}>Today's Schedule</h2>
                  {UPCOMING.slice(0, 3).map((item, i) => (
                    <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 10, padding: '9px 0', borderBottom: i < 2 ? '1px solid #f3f4f6' : 'none' }}>
                      <div style={{ width: 9, height: 9, borderRadius: '50%', background: typeColor(item.type), flexShrink: 0 }} />
                      <div style={{ flex: 1 }}>
                        <div style={{ fontSize: 13, fontWeight: 600, color: '#111827' }}>{item.label}</div>
                        <div style={{ fontSize: 12, color: '#9ca3af' }}>{item.time}{item.room ? ` · ${item.room}` : ''}</div>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Punch Card */}
                <div style={{ ...card }}>
                  <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 12 }}>Today's Attendance</h2>
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                    {[
                      { label: 'Punch In', val: punchedIn ? formatTimeStr(todayPunch.punch_in_time) : 'Not yet', color: '#16a34a' },
                      { label: 'Punch Out', val: punchedOut ? formatTimeStr(todayPunch.punch_out_time) : 'Not yet', color: punchedOut ? '#dc2626' : '#9ca3af' },
                      { label: 'Working Hours', val: workingHoursToday || (punchedIn ? 'Running...' : '-'), color: '#2563eb' },
                      { label: 'Status', val: punchedIn ? 'Present' : 'Not Marked', color: punchedIn ? '#16a34a' : '#9ca3af' },
                    ].map(({ label, val, color }) => (
                      <div key={label} style={{ background: '#f8fafc', borderRadius: 10, padding: '10px 12px' }}>
                        <div style={{ fontSize: 11, color: '#9ca3af', marginBottom: 3 }}>{label}</div>
                        <div style={{ fontSize: 14, fontWeight: 700, color }}>{val}</div>
                      </div>
                    ))}
                  </div>
                  {!punchedIn && (
                    <button onClick={handlePunchIn} disabled={punchActionLoading} style={{ ...btn(true), marginTop: 12, width: '100%', justifyContent: 'center', opacity: punchActionLoading ? 0.6 : 1 }}>
                      <PlayCircle size={14} /> {punchActionLoading ? 'Punching In…' : 'Punch In Now'}
                    </button>
                  )}
                  {punchedIn && !punchedOut && (
                    <button onClick={handlePunchOut} disabled={punchActionLoading} style={{ ...btn(false), marginTop: 12, background: '#fff1f2', color: '#dc2626', border: '1px solid #fecaca', width: '100%', justifyContent: 'center', opacity: punchActionLoading ? 0.6 : 1 }}>
                      <StopCircle size={14} /> {punchActionLoading ? 'Punching Out…' : 'Punch Out Now'}
                    </button>
                  )}
                  {punchActionError && (
                    <div style={{ marginTop: 10, fontSize: 12, color: '#dc2626', fontWeight: 600 }}>{punchActionError}</div>
                  )}
                </div>

                {/* Syllabus Overview */}
                <div style={{ ...card }}>
                  <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 12 }}>Syllabus Progress</h2>
                  {syllabus.map(sub => {
                    const total = sub.units.reduce((a, u) => a + u.total, 0);
                    const done = sub.units.reduce((a, u) => a + u.completed, 0);
                    const p = pct(done, total);
                    return (
                      <div key={sub.subject_id} style={{ marginBottom: 12 }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 4 }}>
                          <span style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>{sub.code} – {sub.subject}</span>
                          <span style={{ fontSize: 12, color: '#7c3aed', fontWeight: 700 }}>{p}%</span>
                        </div>
                        <ProgressBar value={p} />
                      </div>
                    );
                  })}
                </div>

                {/* Notifications Preview */}
                <div style={{ ...card }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
                    <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', margin: 0 }}>Notifications</h2>
                    <button onClick={() => setActiveTab('notifications')} style={{ fontSize: 12, color: '#7c3aed', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600 }}>View All</button>
                  </div>
                  {notifications.slice(0, 4).map(n => (
                    <div key={n.id} style={{ display: 'flex', gap: 10, padding: '7px 0', borderBottom: '1px solid #f3f4f6', opacity: n.is_read ? 0.6 : 1 }}>
                      <span style={{ fontSize: 16 }}>{notifIcon(n.type)}</span>
                      <div>
                        <div style={{ fontSize: 12, fontWeight: 600, color: '#111827' }}>{n.title}</div>
                        <div style={{ fontSize: 11, color: '#9ca3af' }}>{n.created_at}</div>
                      </div>
                      {!n.is_read && <div style={{ width: 7, height: 7, borderRadius: '50%', background: '#7c3aed', marginLeft: 'auto', marginTop: 4, flexShrink: 0 }} />}
                    </div>
                  ))}
                </div>
              </div>
            </>
          )}

          {/* ══════════════════ COURSES ══════════════════ */}
          {activeTab === 'courses' && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
              {COURSES.map(course => (
                <div key={course.id} style={{ ...card }}>
                  <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 14 }}>
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 4 }}>
                        <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: '#f5f3ff', color: '#7c3aed', fontWeight: 700 }}>{course.code}</span>
                        <h3 style={{ margin: 0, fontSize: 16, fontWeight: 700, color: '#111827' }}>{course.name}</h3>
                      </div>
                      <div style={{ fontSize: 13, color: '#6b7280', display: 'flex', gap: 14 }}>
                        <span><Users size={11} style={{ display: 'inline', marginRight: 3 }} />{course.students} students</span>
                        <span><Clock size={11} style={{ display: 'inline', marginRight: 3 }} />{course.schedule}</span>
                        <span><MapPin size={11} style={{ display: 'inline', marginRight: 3 }} />{course.room}</span>
                      </div>
                    </div>
                    <div style={{ display: 'flex', gap: 8 }}>
                      <button style={{ ...btn(false) }}><FileText size={12} /> Materials</button>
                      <button style={{ ...btn(true) }}><Bell size={12} /> Announce</button>
                    </div>
                  </div>
                  <div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 5 }}>
                      <span style={{ fontSize: 12, color: '#6b7280' }}>Syllabus Progress</span>
                      <span style={{ fontSize: 12, fontWeight: 600, color: '#7c3aed' }}>{course.progress}%</span>
                    </div>
                    <ProgressBar value={course.progress} />
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* ══════════════════ STUDENT MANAGEMENT ══════════════════ */}
          {activeTab === 'students' && (
            <>
              {/* Filters */}
              <div style={{ ...card, marginBottom: 16 }}>
                <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', alignItems: 'flex-end' }}>
                  <div style={{ flex: '1 1 220px' }}>
                    <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Search</label>
                    <input
                      placeholder="Search by name, email, enrollment or GR number..."
                      value={stuSearch}
                      onChange={e => { setStuSearch(e.target.value); setStuPage(1); }}
                      style={{ width: '100%', padding: '9px 13px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', outline: 'none', boxSizing: 'border-box' }}
                    />
                  </div>
                  <div>
                    <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Course</label>
                    <select value={stuCourseFilter} onChange={e => { setStuCourseFilter(e.target.value); setStuPage(1); }}
                      style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                      <option value="">All Courses</option>
                      {myCourseCodes.map(c => <option key={c} value={c}>{c}</option>)}
                    </select>
                  </div>
                  <div>
                    <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Semester</label>
                    <select value={stuSemFilter} onChange={e => { setStuSemFilter(e.target.value); setStuPage(1); }}
                      style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                      <option value="">All Semesters</option>
                      {mySemesters.map(s => <option key={s} value={s}>Sem {s}</option>)}
                    </select>
                  </div>
                  <div>
                    <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Sort By</label>
                    <select value={stuSort} onChange={e => setStuSort(e.target.value)}
                      style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                      <option value="name">Name</option>
                      <option value="enrollmentNumber">Enrollment No.</option>
                      <option value="semester">Semester</option>
                      <option value="courseCode">Course</option>
                    </select>
                  </div>
                  <button onClick={() => setStuSortDir(d => d === 'asc' ? 'desc' : 'asc')} style={{ ...btn(false) }}>
                    {stuSortDir === 'asc' ? <ChevronUp size={14} /> : <ChevronDown size={14} />} {stuSortDir === 'asc' ? 'Asc' : 'Desc'}
                  </button>
                </div>
              </div>

              {/* Results / Empty state */}
              {myStudents.length === 0 ? (
                <div style={{ ...card, textAlign: 'center', padding: 48 }}>
                  <Users size={36} color="#d1d5db" style={{ marginBottom: 12 }} />
                  <h3 style={{ margin: '0 0 6px', fontSize: 15, fontWeight: 700, color: '#374151' }}>No Students Found</h3>
                  <p style={{ margin: 0, fontSize: 13, color: '#9ca3af' }}>
                    No students matching your department ({user?.department || '—'}) have been admitted yet.
                  </p>
                </div>
              ) : studentQuery.items.length === 0 ? (
                <div style={{ ...card, textAlign: 'center', padding: 48 }}>
                  <Filter size={36} color="#d1d5db" style={{ marginBottom: 12 }} />
                  <h3 style={{ margin: '0 0 6px', fontSize: 15, fontWeight: 700, color: '#374151' }}>No Matches</h3>
                  <p style={{ margin: 0, fontSize: 13, color: '#9ca3af' }}>Try adjusting your search or filters.</p>
                </div>
              ) : (
                <div style={{ background: 'white', borderRadius: 14, border: '1px solid #e5e7eb', overflow: 'hidden' }}>
                  <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 2fr 1fr 1fr 1fr 1fr', background: '#f8fafc', padding: '10px 16px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                    <span>Enrollment No.</span><span>Name / Email</span><span>Course</span><span>Semester</span><span>Attendance %</span><span>Status</span>
                  </div>
                  {studentQuery.items.map((s, i) => {
                    const summary = getStudentAttendanceSummary(s.id);
                    return (
                      <div key={s.id} style={{ display: 'grid', gridTemplateColumns: '1.5fr 2fr 1fr 1fr 1fr 1fr', padding: '12px 16px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                        <span style={{ fontSize: 12, color: '#7c3aed', fontWeight: 700, fontFamily: 'monospace' }}>{s.enrollmentNumber || s.grNumber || '—'}</span>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                          {s.photoDataUrl
                            ? <img src={s.photoDataUrl} alt={s.name} style={{ width: 30, height: 30, borderRadius: '50%', objectFit: 'cover' }} />
                            : <div style={{ width: 30, height: 30, borderRadius: '50%', background: '#ede9fe', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, color: '#7c3aed', fontSize: 13, flexShrink: 0 }}>{(s.name || '?')[0]}</div>
                          }
                          <div>
                            <div style={{ fontSize: 13, fontWeight: 600, color: '#111827' }}>{s.name}</div>
                            <div style={{ fontSize: 11, color: '#9ca3af' }}>{s.email}</div>
                          </div>
                        </div>
                        <span style={{ fontSize: 12, color: '#6b7280' }}>{s.courseCode || s.course || '—'}</span>
                        <span style={{ fontSize: 12, color: '#6b7280' }}>{s.semester ? `Sem ${s.semester}` : '—'}</span>
                        <span style={{ fontSize: 13, fontWeight: 700, color: summary.pct >= 75 ? '#16a34a' : summary.pct > 0 ? '#d97706' : '#9ca3af' }}>
                          {summary.total > 0 ? `${summary.pct}%` : '—'}
                        </span>
                        <span style={{
                          fontSize: 11, padding: '3px 9px', borderRadius: 20, fontWeight: 700, width: 'fit-content',
                          background: s.accountStatus === 'Active' ? '#f0fdf4' : '#fff1f2',
                          color: s.accountStatus === 'Active' ? '#16a34a' : '#dc2626',
                        }}>
                          {s.accountStatus}
                        </span>
                      </div>
                    );
                  })}

                  {/* Pagination */}
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px 16px', borderTop: '1px solid #f3f4f6' }}>
                    <span style={{ fontSize: 12, color: '#9ca3af' }}>
                      Showing {(studentQuery.page - 1) * studentQuery.pageSize + 1}–{Math.min(studentQuery.page * studentQuery.pageSize, studentQuery.total)} of {studentQuery.total} students
                    </span>
                    <div style={{ display: 'flex', gap: 6 }}>
                      <button onClick={() => setStuPage(p => Math.max(1, p - 1))} disabled={studentQuery.page === 1}
                        style={{ ...btn(false), padding: '6px 10px', opacity: studentQuery.page === 1 ? 0.4 : 1 }}>
                        <ChevronLeft size={14} />
                      </button>
                      <span style={{ fontSize: 12, color: '#374151', fontWeight: 600, padding: '6px 10px' }}>
                        Page {studentQuery.page} of {studentQuery.totalPages}
                      </span>
                      <button onClick={() => setStuPage(p => Math.min(studentQuery.totalPages, p + 1))} disabled={studentQuery.page === studentQuery.totalPages}
                        style={{ ...btn(false), padding: '6px 10px', opacity: studentQuery.page === studentQuery.totalPages ? 0.4 : 1 }}>
                        <ChevronRight size={14} />
                      </button>
                    </div>
                  </div>
                </div>
              )}
            </>
          )}

          {/* ══════════════════ STUDENT ATTENDANCE ══════════════════ */}
          {activeTab === 'attendance' && (
            <>
              {/* Search by Enrollment / GR Number */}
              <div style={{ ...card, marginBottom: 16 }}>
                <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 12, display: 'flex', alignItems: 'center', gap: 8 }}>
                  <UserSearch size={16} color="#7c3aed" /> Search Student by Enrollment / GR Number
                </h2>
                <div style={{ display: 'flex', gap: 10 }}>
                  <input
                    placeholder="Enter Enrollment or GR Number (e.g. PT2026BTCE0001)"
                    value={searchEnroll}
                    onChange={e => { setSearchEnroll(e.target.value); setSearchResult(null); }}
                    style={{ flex: 1, padding: '9px 13px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', outline: 'none' }}
                  />
                  <button onClick={handleSearch} style={{ ...btn(true) }}><UserSearch size={14} /> Search</button>
                </div>
                {searchResult === 'notfound' && (
                  <div style={{ marginTop: 12, padding: '10px 14px', background: '#fff1f2', borderRadius: 9, color: '#dc2626', fontSize: 13 }}>
                    No student found with enrollment/GR number "{searchEnroll}" in your department.
                  </div>
                )}
                {searchResult && searchResult !== 'notfound' && (() => {
                  const summary = getStudentAttendanceSummary(searchResult.id);
                  return (
                    <div style={{ marginTop: 12, padding: '14px 16px', background: '#f5f3ff', borderRadius: 10, border: '1px solid #ddd6fe' }}>
                      <div style={{ display: 'flex', gap: 20, flexWrap: 'wrap' }}>
                        {[['Name', searchResult.name], ['Enrollment', searchResult.enrollmentNumber || searchResult.grNumber], ['Course', searchResult.courseCode], ['Semester', searchResult.semester], ['Attendance', summary.total > 0 ? `${summary.pct}%` : 'No records']].map(([k, v]) => (
                          <div key={k}>
                            <div style={{ fontSize: 10, color: '#9ca3af', textTransform: 'uppercase', letterSpacing: 0.5 }}>{k}</div>
                            <div style={{ fontSize: 14, fontWeight: 700, color: '#111827' }}>{v}</div>
                          </div>
                        ))}
                      </div>
                    </div>
                  );
                })()}
              </div>

              {/* Sub-tabs: Mark / History / Analytics */}
              <div style={{ display: 'flex', gap: 8, marginBottom: 14 }}>
                {[
                  { key: 'mark', label: 'Mark Attendance', icon: ClipboardList },
                  { key: 'history', label: 'Attendance History', icon: Clock },
                  { key: 'analytics', label: 'Analytics & Reports', icon: BarChart2 },
                ].map(({ key, label, icon: Icon }) => (
                  <button key={key} onClick={() => setAttTab(key)} style={{ ...btn(attTab === key), borderRadius: 9 }}>
                    <Icon size={13} /> {label}
                  </button>
                ))}
              </div>

              {/* ── Mark Attendance ── */}
              {attTab === 'mark' && (
                <div style={{ ...card }}>
                  <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 14, display: 'flex', alignItems: 'center', gap: 8 }}>
                    <ClipboardList size={16} color="#7c3aed" /> Mark Attendance
                  </h2>
                  <div style={{ display: 'flex', gap: 12, marginBottom: 16, flexWrap: 'wrap' }}>
                    <div>
                      <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Subject</label>
                      <select value={attCourse} onChange={e => setAttCourse(e.target.value)}
                        style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                        {COURSES.map(c => <option key={c.id} value={c.code}>{c.code} – {c.name}</option>)}
                      </select>
                    </div>
                    <div>
                      <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Semester</label>
                      <select value={attSemester} onChange={e => setAttSemester(e.target.value)}
                        style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                        <option value="">All Semesters</option>
                        {mySemesters.map(s => <option key={s} value={s}>Sem {s}</option>)}
                      </select>
                    </div>
                    <div>
                      <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Division</label>
                      <select value={attDivision} onChange={e => setAttDivision(e.target.value)}
                        style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                        {['A', 'B', 'C'].map(d => <option key={d} value={d}>Division {d}</option>)}
                      </select>
                    </div>
                    <div>
                      <label style={{ fontSize: 11, color: '#6b7280', display: 'block', marginBottom: 4 }}>Date</label>
                      <input type="date" value={attDate} onChange={e => setAttDate(e.target.value)}
                        style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151' }} />
                    </div>
                  </div>

                  {/* Bulk actions */}
                  {attendanceStudents.length > 0 && (
                    <div style={{ display: 'flex', gap: 8, marginBottom: 12 }}>
                      <span style={{ fontSize: 12, color: '#9ca3af', alignSelf: 'center', marginRight: 4 }}>Mark all as:</span>
                      {['Present', 'Absent', 'Leave'].map(st => (
                        <button key={st} onClick={() => setAllAttendance(st)}
                          style={{ padding: '5px 12px', borderRadius: 8, cursor: 'pointer', fontSize: 12, fontWeight: 600, background: statusColor(st).bg, color: statusColor(st).color, border: `1px solid ${statusColor(st).color}30` }}>
                          {st}
                        </button>
                      ))}
                    </div>
                  )}

                  {attendanceStudents.length === 0 ? (
                    <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 13 }}>
                      <Users size={32} color="#d1d5db" style={{ marginBottom: 10 }} />
                      <div>No students found for this subject/semester.</div>
                    </div>
                  ) : (
                    <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                      <div style={{ display: 'grid', gridTemplateColumns: '1fr 2fr 1fr 1fr', background: '#f8fafc', padding: '9px 14px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                        <span>Enrollment</span><span>Name</span><span>Course</span><span>Status</span>
                      </div>
                      {attendanceStudents.map((s, i) => (
                        <div key={s.id} style={{ display: 'grid', gridTemplateColumns: '1fr 2fr 1fr 1fr', padding: '10px 14px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                          <span style={{ fontSize: 12, color: '#7c3aed', fontWeight: 600, fontFamily: 'monospace' }}>{s.enrollmentNumber || s.grNumber || '—'}</span>
                          <span style={{ fontSize: 13, fontWeight: 600, color: '#111827' }}>{s.name}</span>
                          <span style={{ fontSize: 12, color: '#6b7280' }}>{s.courseCode || '—'}</span>
                          <div style={{ display: 'flex', gap: 6 }}>
                            {['Present', 'Absent', 'Leave'].map(st => (
                              <button key={st} onClick={() => setAttData(prev => ({ ...prev, [s.id]: st }))}
                                style={{
                                  padding: '4px 10px', borderRadius: 6, cursor: 'pointer', fontSize: 11, fontWeight: 600,
                                  background: attData[s.id] === st ? statusColor(st).bg : '#f3f4f6',
                                  color: attData[s.id] === st ? statusColor(st).color : '#9ca3af',
                                  border: attData[s.id] === st ? `1px solid ${statusColor(st).color}30` : '1px solid transparent',
                                }}>
                                {st}
                              </button>
                            ))}
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                  <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginTop: 14 }}>
                    <button onClick={saveAttendance} disabled={attendanceStudents.length === 0} style={{ ...btn(true), opacity: attendanceStudents.length === 0 ? 0.5 : 1 }}>
                      <CheckCircle size={14} /> Save Attendance
                    </button>
                    {attSaved && <span style={{ fontSize: 13, color: '#16a34a', fontWeight: 600, display: 'flex', alignItems: 'center', gap: 5 }}><CheckCircle size={14} /> Saved successfully!</span>}
                  </div>
                </div>
              )}

              {/* ── Attendance History ── */}
              {attTab === 'history' && (() => {
                const history = getAttendanceHistory(attCourse);
                // Group by date
                const byDate = {};
                history.forEach(rec => {
                  if (!byDate[rec.date]) byDate[rec.date] = [];
                  byDate[rec.date].push(rec);
                });
                const dates = Object.keys(byDate).sort((a, b) => b.localeCompare(a));

                return (
                  <div style={{ ...card }}>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
                      <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', margin: 0, display: 'flex', alignItems: 'center', gap: 8 }}>
                        <Clock size={16} color="#7c3aed" /> Attendance History — {attCourse}
                      </h2>
                      <select value={attCourse} onChange={e => setAttCourse(e.target.value)}
                        style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', background: 'white' }}>
                        {COURSES.map(c => <option key={c.id} value={c.code}>{c.code} – {c.name}</option>)}
                      </select>
                    </div>

                    {dates.length === 0 ? (
                      <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 13 }}>
                        <Clock size={32} color="#d1d5db" style={{ marginBottom: 10 }} />
                        <div>No attendance has been recorded for {attCourse} yet.</div>
                      </div>
                    ) : (
                      dates.map(date => {
                        const recs = byDate[date];
                        const present = recs.filter(r => r.status === 'Present').length;
                        const absent = recs.filter(r => r.status === 'Absent').length;
                        const leave = recs.filter(r => r.status === 'Leave').length;
                        return (
                          <div key={date} style={{ marginBottom: 14, border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: '#f8fafc', padding: '9px 14px' }}>
                              <span style={{ fontSize: 13, fontWeight: 700, color: '#374151' }}>{date}</span>
                              <div style={{ display: 'flex', gap: 10, fontSize: 11, fontWeight: 700 }}>
                                <span style={{ color: '#16a34a' }}>{present} Present</span>
                                <span style={{ color: '#dc2626' }}>{absent} Absent</span>
                                <span style={{ color: '#d97706' }}>{leave} Leave</span>
                              </div>
                            </div>
                            {recs.map(rec => {
                              const sc = statusColor(rec.status);
                              return (
                                <div key={rec.studentId} style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', padding: '8px 14px', alignItems: 'center', borderTop: '1px solid #f3f4f6' }}>
                                  <span style={{ fontSize: 13, color: '#111827', fontWeight: 500 }}>{rec.studentName}</span>
                                  <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: sc.bg, color: sc.color, fontWeight: 700, width: 'fit-content' }}>{rec.status}</span>
                                </div>
                              );
                            })}
                          </div>
                        );
                      })
                    )}
                  </div>
                );
              })()}

              {/* ── Analytics & Reports ── */}
              {attTab === 'analytics' && (() => {
                const monthStr = attDate.slice(0, 7);
                const report = getMonthlyAttendanceReport(attCourse, monthStr);
                const reportDates = Object.keys(report).sort();
                const totals = reportDates.reduce((acc, d) => {
                  acc.Present += report[d].Present || 0;
                  acc.Absent += report[d].Absent || 0;
                  acc.Leave += report[d].Leave || 0;
                  return acc;
                }, { Present: 0, Absent: 0, Leave: 0 });
                const grandTotal = totals.Present + totals.Absent + totals.Leave;
                const overallPct = grandTotal > 0 ? Math.round((totals.Present / grandTotal) * 100) : 0;

                return (
                  <>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 14, marginBottom: 16 }}>
                      <StatCard label="Present Marks" value={totals.Present} icon={CheckCircle} color="#16a34a" bg="#f0fdf4" />
                      <StatCard label="Absent Marks" value={totals.Absent} icon={AlertCircle} color="#dc2626" bg="#fff1f2" />
                      <StatCard label="Leave Marks" value={totals.Leave} icon={Clock} color="#d97706" bg="#fff7ed" />
                      <StatCard label="Overall Attendance %" value={`${overallPct}%`} icon={Percent} color="#7c3aed" bg="#f5f3ff" sub={attCourse} />
                    </div>

                    <div style={{ ...card, marginBottom: 16 }}>
                      <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 14, display: 'flex', alignItems: 'center', gap: 8 }}>
                        <BarChart2 size={16} color="#7c3aed" /> Monthly Attendance Report — {monthStr} ({attCourse})
                      </h2>
                      {reportDates.length === 0 ? (
                        <div style={{ textAlign: 'center', padding: 30, color: '#9ca3af', fontSize: 13 }}>No attendance data for this month yet.</div>
                      ) : (
                        <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                          <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1fr', background: '#f8fafc', padding: '9px 14px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                            <span>Date</span><span>Present</span><span>Absent</span><span>Leave</span><span>Daily %</span>
                          </div>
                          {reportDates.map((d, i) => {
                            const day = report[d];
                            const dayTotal = (day.Present || 0) + (day.Absent || 0) + (day.Leave || 0);
                            const dayPct = dayTotal > 0 ? Math.round(((day.Present || 0) / dayTotal) * 100) : 0;
                            return (
                              <div key={d} style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1fr', padding: '9px 14px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                                <span style={{ fontSize: 13, color: '#374151', fontWeight: 500 }}>{d}</span>
                                <span style={{ fontSize: 13, color: '#16a34a', fontWeight: 600 }}>{day.Present || 0}</span>
                                <span style={{ fontSize: 13, color: '#dc2626', fontWeight: 600 }}>{day.Absent || 0}</span>
                                <span style={{ fontSize: 13, color: '#d97706', fontWeight: 600 }}>{day.Leave || 0}</span>
                                <span style={{ fontSize: 13, color: '#7c3aed', fontWeight: 700 }}>{dayPct}%</span>
                              </div>
                            );
                          })}
                        </div>
                      )}
                    </div>

                    {/* Per-student attendance breakdown */}
                    <div style={{ ...card }}>
                      <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 14 }}>Per-Student Attendance — {attCourse}</h2>
                      <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                        <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr', background: '#f8fafc', padding: '9px 14px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                          <span>Name</span><span>Present</span><span>Absent</span><span>Leave</span><span>%</span>
                        </div>
                        {myStudents.map((s, i) => {
                          const summary = getStudentAttendanceSummary(s.id, attCourse);
                          if (summary.total === 0) return null;
                          return (
                            <div key={s.id} style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr', padding: '9px 14px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                              <span style={{ fontSize: 13, color: '#111827', fontWeight: 500 }}>{s.name}</span>
                              <span style={{ fontSize: 13, color: '#16a34a', fontWeight: 600 }}>{summary.present}</span>
                              <span style={{ fontSize: 13, color: '#dc2626', fontWeight: 600 }}>{summary.absent}</span>
                              <span style={{ fontSize: 13, color: '#d97706', fontWeight: 600 }}>{summary.leave}</span>
                              <span style={{ fontSize: 13, fontWeight: 700, color: summary.pct >= 75 ? '#16a34a' : '#dc2626' }}>{summary.pct}%</span>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  </>
                );
              })()}
            </>
          )}

          {/* ══════════════════ MY ATTENDANCE ══════════════════ */}
          {activeTab === 'my_attendance' && (
            <>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5,1fr)', gap: 14, marginBottom: 20 }}>
                <StatCard label="Total Working Days" value={myAttTotal} icon={CalendarDays} color="#7c3aed" bg="#f5f3ff" />
                <StatCard label="Present Days" value={myAttPresent} icon={CheckCircle} color="#16a34a" bg="#f0fdf4" />
                <StatCard label="Absent Days" value={myAttAbsent} icon={AlertCircle} color="#dc2626" bg="#fff1f2" />
                <StatCard label="Leave Days" value={myAttLeave} icon={Clock} color="#d97706" bg="#fff7ed" />
                <StatCard label="Attendance %" value={`${myAttPct}%`} icon={Percent} color="#2563eb" bg="#eff6ff" />
              </div>

              <div style={{ ...card, marginBottom: 16 }}>
                <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 6 }}>Monthly Progress</h2>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 5 }}>
                  <span style={{ fontSize: 12, color: '#6b7280' }}>{new Date().toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}</span>
                  <span style={{ fontSize: 12, fontWeight: 700, color: '#16a34a' }}>{myAttPct}%</span>
                </div>
                <ProgressBar value={myAttPct} color="#16a34a" height={12} />
              </div>

              <div style={{ ...card }}>
                <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 14 }}>Attendance Records</h2>
                {attendanceLoading ? (
                  <div style={{ padding: 24, textAlign: 'center', color: '#9ca3af', fontSize: 13 }}>Loading attendance…</div>
                ) : attendanceError ? (
                  <div style={{ padding: 24, textAlign: 'center', color: '#dc2626', fontSize: 13 }}>{attendanceError}</div>
                ) : myAttendanceRecords.length === 0 ? (
                  <div style={{ padding: 24, textAlign: 'center', color: '#9ca3af', fontSize: 13 }}>No attendance records for this month yet. Punch in to get started.</div>
                ) : (
                  <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1fr', background: '#f8fafc', padding: '9px 14px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                      <span>Date</span><span>Status</span><span>Punch In</span><span>Punch Out</span><span>Working Hours</span>
                    </div>
                    {myAttendanceRecords.map((r, i) => {
                      const sc = statusColor(r.status);
                      return (
                        <div key={r.id ?? r.date} style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr 1fr 1fr 1fr', padding: '10px 14px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                          <span style={{ fontSize: 13, color: '#374151', fontWeight: 500 }}>{r.date}</span>
                          <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: sc.bg, color: sc.color, fontWeight: 700, width: 'fit-content' }}>{r.status}</span>
                          <span style={{ fontSize: 13, color: '#374151' }}>{formatTimeStr(r.punch_in_time)}</span>
                          <span style={{ fontSize: 13, color: '#374151' }}>{r.punch_out_time ? formatTimeStr(r.punch_out_time) : (r.status === 'Present' ? 'Active' : '-')}</span>
                          <span style={{ fontSize: 13, color: '#374151', fontWeight: r.working_hours != null ? 600 : 400 }}>{formatHours(r.working_hours)}</span>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            </>
          )}

          {/* ══════════════════ PUNCH IN/OUT ══════════════════ */}
          {activeTab === 'punch' && (
            <>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 18, marginBottom: 20 }}>
                {/* Main Punch Card */}
                <div style={{ ...card, textAlign: 'center', padding: 36 }}>
                  <div style={{ width: 72, height: 72, borderRadius: '50%', background: punchedIn && !punchedOut ? 'linear-gradient(135deg,#16a34a,#15803d)' : '#f3f4f6', display: 'flex', alignItems: 'center', justifyContent: 'center', margin: '0 auto 16px' }}>
                    {punchedIn && !punchedOut
                      ? <Activity size={32} color="white" />
                      : <Timer size={32} color="#9ca3af" />}
                  </div>
                  <div style={{ fontSize: 16, fontWeight: 700, color: '#111827', marginBottom: 4 }}>
                    {!punchedIn ? 'Not Punched In' : punchedOut ? 'Shift Complete' : 'Currently Active'}
                  </div>
                  <div style={{ fontSize: 13, color: '#9ca3af', marginBottom: 24 }}>
                    {new Date().toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}
                  </div>

                  {!punchedIn && (
                    <button onClick={handlePunchIn} disabled={punchActionLoading} style={{ ...btn(true), padding: '12px 32px', fontSize: 15, borderRadius: 12, opacity: punchActionLoading ? 0.6 : 1 }}>
                      <PlayCircle size={18} /> {punchActionLoading ? 'Punching In…' : 'Punch In'}
                    </button>
                  )}
                  {punchedIn && !punchedOut && (
                    <button onClick={handlePunchOut} disabled={punchActionLoading} style={{ ...btn(false), padding: '12px 32px', fontSize: 15, borderRadius: 12, background: '#fff1f2', color: '#dc2626', border: '1px solid #fecaca', opacity: punchActionLoading ? 0.6 : 1 }}>
                      <StopCircle size={18} /> {punchActionLoading ? 'Punching Out…' : 'Punch Out'}
                    </button>
                  )}
                  {punchedOut && (
                    <div style={{ padding: '10px 20px', background: '#f0fdf4', borderRadius: 10, color: '#16a34a', fontWeight: 600, fontSize: 14 }}>
                      ✅ Shift Ended · Great work today!
                    </div>
                  )}
                  {punchActionError && (
                    <div style={{ marginTop: 12, fontSize: 12, color: '#dc2626', fontWeight: 600 }}>{punchActionError}</div>
                  )}
                </div>

                {/* Today's Summary */}
                <div style={{ ...card }}>
                  <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 16 }}>Today's Summary</h2>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                    {[
                      { label: 'Punch In Time', value: punchedIn ? formatTimeStr(todayPunch.punch_in_time) : 'Not yet', color: '#16a34a', icon: PlayCircle },
                      { label: 'Punch Out Time', value: punchedOut ? formatTimeStr(todayPunch.punch_out_time) : (punchedIn ? 'Still active' : '-'), color: punchedOut ? '#dc2626' : '#9ca3af', icon: StopCircle },
                      { label: 'Working Hours', value: workingHoursToday || (punchedIn ? 'Counting...' : '-'), color: '#2563eb', icon: Timer },
                      { label: 'Status', value: punchedIn ? 'Present' : 'Not Marked', color: punchedIn ? '#16a34a' : '#9ca3af', icon: CheckCircle },
                    ].map(({ label, value, color, icon: Icon }) => (
                      <div key={label} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '10px 14px', background: '#f8fafc', borderRadius: 10 }}>
                        <div style={{ width: 34, height: 34, borderRadius: 9, background: `${color}15`, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                          <Icon size={16} color={color} />
                        </div>
                        <div>
                          <div style={{ fontSize: 11, color: '#9ca3af' }}>{label}</div>
                          <div style={{ fontSize: 14, fontWeight: 700, color }}>{value}</div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Recent Punch Logs */}
              <div style={{ ...card }}>
                <h2 style={{ fontSize: 14, fontWeight: 600, color: '#111827', marginBottom: 14 }}>Recent Punch Logs</h2>
                {attendanceLoading ? (
                  <div style={{ padding: 24, textAlign: 'center', color: '#9ca3af', fontSize: 13 }}>Loading punch logs…</div>
                ) : punchLogs.length === 0 ? (
                  <div style={{ padding: 24, textAlign: 'center', color: '#9ca3af', fontSize: 13 }}>No punch logs yet. Punch in to start recording attendance.</div>
                ) : (
                  <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflow: 'hidden' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr', background: '#f8fafc', padding: '9px 14px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.5 }}>
                      <span>Date</span><span>Status</span><span>Punch In</span><span>Punch Out</span><span>Total Hours</span>
                    </div>
                    {punchLogs.map((r, i) => (
                      <div key={r.id ?? r.date} style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr', padding: '10px 14px', alignItems: 'center', background: i % 2 === 0 ? 'white' : '#fafafa', borderTop: '1px solid #f3f4f6' }}>
                        <span style={{ fontSize: 13, color: '#374151', fontWeight: 500 }}>{r.date}</span>
                        <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: r.punch_in_time ? '#f0fdf4' : '#f3f4f6', color: r.punch_in_time ? '#16a34a' : '#6b7280', fontWeight: 700, width: 'fit-content' }}>{r.punch_in_time ? 'Present' : '-'}</span>
                        <span style={{ fontSize: 13, color: '#374151' }}>{formatTimeStr(r.punch_in_time)}</span>
                        <span style={{ fontSize: 13, color: '#374151' }}>{r.punch_out_time ? formatTimeStr(r.punch_out_time) : '-'}</span>
                        <span style={{ fontSize: 13, fontWeight: 600, color: '#7c3aed' }}>{formatHours(r.total_working_hours)}</span>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            </>
          )}

          {/* ══════════════════ SYLLABUS MAPPING ══════════════════ */}
          {activeTab === 'syllabus' && (
            <>
              <div style={{ display: 'flex', gap: 10, marginBottom: 18 }}>
                {syllabus.map((sub, i) => (
                  <button key={sub.subject_id} onClick={() => setSyllabusSubject(i)}
                    style={{ ...btn(syllabusSubject === i), borderRadius: 9 }}>
                    {sub.code}
                  </button>
                ))}
              </div>

              <div style={{ ...card, marginBottom: 16 }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
                  <div>
                    <h2 style={{ fontSize: 16, fontWeight: 700, color: '#111827', margin: 0 }}>{currentSub.subject}</h2>
                    <p style={{ fontSize: 12, color: '#9ca3af', margin: '3px 0 0' }}>
                      {subCompletedLectures} of {subTotalLectures} lectures completed
                    </p>
                  </div>
                  <div style={{ textAlign: 'right' }}>
                    <div style={{ fontSize: 28, fontWeight: 800, color: '#7c3aed' }}>{subPct}%</div>
                    <div style={{ fontSize: 11, color: '#9ca3af' }}>Overall Completion</div>
                  </div>
                </div>
                <ProgressBar value={subPct} height={12} />
              </div>

              <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                {currentSub.units.map((unit, ui) => {
                  const unitPct = pct(unit.completed, unit.total);
                  const isEditing = editingUnit?.subIdx === syllabusSubject && editingUnit?.unitIdx === ui;
                  return (
                    <div key={unit.unit_no} style={{ ...card }}>
                      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 10 }}>
                        <div style={{ flex: 1 }}>
                          <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 4 }}>
                            <span style={{ fontSize: 11, padding: '2px 8px', borderRadius: 20, background: '#f5f3ff', color: '#7c3aed', fontWeight: 700 }}>Unit {unit.unit_no}</span>
                            <span style={{ fontSize: 14, fontWeight: 600, color: '#111827' }}>{unit.topic_name}</span>
                            {unitPct === 100 && <span style={{ fontSize: 11, color: '#16a34a', fontWeight: 700 }}>✅ Complete</span>}
                          </div>
                          <div style={{ fontSize: 12, color: '#9ca3af' }}>
                            {unit.completed} / {unit.total} lectures completed
                          </div>
                        </div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                          <span style={{ fontSize: 22, fontWeight: 800, color: unitPct === 100 ? '#16a34a' : '#7c3aed' }}>{unitPct}%</span>
                          {!isEditing
                            ? <button onClick={() => { setEditingUnit({ subIdx: syllabusSubject, unitIdx: ui }); setEditCompleted(unit.completed.toString()); }} style={{ ...btn(false), padding: '6px 12px' }}><Edit2 size={12} /> Update</button>
                            : (
                              <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                                <input type="number" min={0} max={unit.total} value={editCompleted} onChange={e => setEditCompleted(e.target.value)}
                                  style={{ width: 56, padding: '6px 9px', borderRadius: 7, border: '1px solid #7c3aed', fontSize: 13, color: '#374151', outline: 'none' }} />
                                <button onClick={() => updateSyllabusUnit(syllabusSubject, ui)} style={{ ...btn(true), padding: '6px 12px' }}><CheckCircle size={12} /> Save</button>
                                <button onClick={() => setEditingUnit(null)} style={{ ...btn(false), padding: '6px 10px' }}>✕</button>
                              </div>
                            )}
                        </div>
                      </div>
                      <ProgressBar value={unitPct} color={unitPct === 100 ? '#16a34a' : '#7c3aed'} />
                    </div>
                  );
                })}
              </div>
            </>
          )}

          {/* ══════════════════ ANNOUNCEMENTS ══════════════════ */}
          {activeTab === 'announcements' && (
            <>
              <div style={{ marginBottom: 14, display: 'flex', justifyContent: 'flex-end' }}>
                <button onClick={() => setShowAnnForm(f => !f)} style={{ ...btn(true) }}>
                  <PlusCircle size={14} /> New Announcement
                </button>
              </div>
              {showAnnForm && (
                <div style={{ ...card, marginBottom: 14, border: '1px solid #ddd6fe' }}>
                  <h3 style={{ margin: '0 0 12px', fontSize: 14, fontWeight: 600, color: '#111827' }}>Post Announcement</h3>
                  <select value={newAnn.course} onChange={e => setNewAnn(a => ({ ...a, course: e.target.value }))}
                    style={{ width: '100%', padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', marginBottom: 9, fontSize: 13, color: '#374151', background: 'white' }}>
                    {COURSES.map(c => <option key={c.id} value={c.code}>{c.code} – {c.name}</option>)}
                  </select>
                  <input placeholder="Announcement title" value={newAnn.title} onChange={e => setNewAnn(a => ({ ...a, title: e.target.value }))}
                    style={{ width: '100%', padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', marginBottom: 9, fontSize: 13, color: '#374151', boxSizing: 'border-box' }} />
                  <textarea placeholder="Write your announcement..." value={newAnn.body} onChange={e => setNewAnn(a => ({ ...a, body: e.target.value }))}
                    rows={3} style={{ width: '100%', padding: '8px 12px', borderRadius: 8, border: '1px solid #e5e7eb', marginBottom: 10, fontSize: 13, color: '#374151', resize: 'vertical', boxSizing: 'border-box' }} />
                  <div style={{ display: 'flex', gap: 9 }}>
                    <button onClick={postAnnouncement} style={{ ...btn(true) }}>Post</button>
                    <button onClick={() => setShowAnnForm(false)} style={{ ...btn(false) }}>Cancel</button>
                  </div>
                </div>
              )}
              <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
                {announcements.map(a => (
                  <div key={a.id} style={{ ...card, border: `1px solid ${a.pinned ? '#ddd6fe' : '#e5e7eb'}`, borderLeft: `4px solid ${a.pinned ? '#7c3aed' : '#e5e7eb'}` }}>
                    <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between' }}>
                      <div style={{ flex: 1 }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 5 }}>
                          <span style={{ fontSize: 11, padding: '2px 7px', background: '#f5f3ff', color: '#7c3aed', borderRadius: 20, fontWeight: 700 }}>{a.course}</span>
                          {a.pinned && <span style={{ fontSize: 11, color: '#d97706' }}>📌 Pinned</span>}
                          <span style={{ fontSize: 12, color: '#9ca3af', marginLeft: 'auto' }}>{a.time}</span>
                        </div>
                        <h3 style={{ margin: '0 0 3px', fontSize: 14, fontWeight: 600, color: '#111827' }}>{a.title}</h3>
                        <p style={{ margin: 0, fontSize: 13, color: '#6b7280' }}>{a.body}</p>
                      </div>
                      <div style={{ display: 'flex', gap: 6, marginLeft: 10 }}>
                        <button style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 7, cursor: 'pointer' }}><Edit2 size={12} color="#6b7280" /></button>
                        <button onClick={() => deleteAnn(a.id)} style={{ padding: 6, background: '#fff1f2', border: 'none', borderRadius: 7, cursor: 'pointer' }}><Trash2 size={12} color="#dc2626" /></button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </>
          )}

          {/* ══════════════════ STUDENT QUERIES ══════════════════ */}
          {activeTab === 'queries' && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
              {queries.map(q => (
                <div key={q.id} style={{ ...card, border: `1px solid ${q.answered ? '#e5e7eb' : '#ddd6fe'}`, opacity: q.answered ? 0.75 : 1 }}>
                  <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between' }}>
                    <div style={{ flex: 1 }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 5 }}>
                        <img src={`https://api.dicebear.com/7.x/avataaars/svg?seed=${q.student}`} alt={q.student}
                          style={{ width: 26, height: 26, borderRadius: '50%' }} />
                        <span style={{ fontSize: 14, fontWeight: 600, color: '#111827' }}>{q.student}</span>
                        <span style={{ fontSize: 11, padding: '2px 7px', background: '#f5f3ff', color: '#7c3aed', borderRadius: 20, fontWeight: 700 }}>{q.course}</span>
                        <span style={{ fontSize: 12, color: '#9ca3af', marginLeft: 'auto' }}>{q.time}</span>
                      </div>
                      <p style={{ margin: 0, fontSize: 13, color: '#374151', paddingLeft: 34 }}>{q.msg}</p>
                    </div>
                    {!q.answered
                      ? <button onClick={() => markAnswered(q.id)} style={{ marginLeft: 14, ...btn(false), background: '#f0fdf4', color: '#16a34a', border: '1px solid #bbf7d0', flexShrink: 0 }}>
                          <CheckCircle size={12} /> Reply
                        </button>
                      : <span style={{ marginLeft: 14, fontSize: 12, color: '#16a34a', fontWeight: 600, display: 'flex', alignItems: 'center', gap: 4, flexShrink: 0 }}>
                          <CheckCircle size={12} /> Answered
                        </span>}
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* ══════════════════ SCHEDULE ══════════════════ */}
          {activeTab === 'schedule' && (
            <div style={{ ...card }}>
              <h2 style={{ fontSize: 15, fontWeight: 600, color: '#111827', marginBottom: 18 }}>Upcoming Schedule</h2>
              {UPCOMING.map((item, i) => (
                <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 14, padding: '13px 0', borderBottom: i < UPCOMING.length - 1 ? '1px solid #f3f4f6' : 'none' }}>
                  <div style={{ width: 42, height: 42, borderRadius: 11, background: `${typeColor(item.type)}18`, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                    <CalendarDays size={19} color={typeColor(item.type)} />
                  </div>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: 14, fontWeight: 600, color: '#111827' }}>{item.label}</div>
                    <div style={{ fontSize: 12, color: '#9ca3af' }}>{item.time}{item.room ? ` · ${item.room}` : ''}</div>
                  </div>
                  <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: `${typeColor(item.type)}15`, color: typeColor(item.type), fontWeight: 700, textTransform: 'capitalize' }}>
                    {item.type}
                  </span>
                </div>
              ))}
            </div>
          )}

          {/* ══════════════════ NOTIFICATIONS ══════════════════ */}
          {activeTab === 'notifications' && (
            <>
              <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: 14 }}>
                <button onClick={markAllRead} style={{ ...btn(false) }}>
                  <CheckCircle size={13} /> Mark All Read
                </button>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
                {notifications.map(n => (
                  <div key={n.id} onClick={() => setNotifications(prev => prev.map(x => x.id === n.id ? { ...x, is_read: true } : x))}
                    style={{ ...card, cursor: 'pointer', border: `1px solid ${n.is_read ? '#e5e7eb' : '#ddd6fe'}`, borderLeft: `4px solid ${n.is_read ? '#e5e7eb' : notifColor(n.type)}`, opacity: n.is_read ? 0.7 : 1 }}>
                    <div style={{ display: 'flex', alignItems: 'flex-start', gap: 12 }}>
                      <div style={{ width: 38, height: 38, borderRadius: 10, background: `${notifColor(n.type)}15`, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18, flexShrink: 0 }}>
                        {notifIcon(n.type)}
                      </div>
                      <div style={{ flex: 1 }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 3 }}>
                          <h3 style={{ margin: 0, fontSize: 14, fontWeight: 600, color: '#111827' }}>{n.title}</h3>
                          {!n.is_read && <div style={{ width: 7, height: 7, borderRadius: '50%', background: '#7c3aed', flexShrink: 0 }} />}
                        </div>
                        <p style={{ margin: 0, fontSize: 13, color: '#6b7280' }}>{n.message}</p>
                        <span style={{ fontSize: 11, color: '#9ca3af', marginTop: 4, display: 'block' }}>{n.created_at}</span>
                      </div>
                      <span style={{ fontSize: 10, padding: '3px 8px', borderRadius: 20, background: `${notifColor(n.type)}15`, color: notifColor(n.type), fontWeight: 700, textTransform: 'capitalize', flexShrink: 0 }}>
                        {n.type}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            </>
          )}
          {/* ══════════════════ MY PROFILE ══════════════════ */}
          {activeTab === 'my_profile' && (
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 18 }}>
              {/* Profile Card */}
              <div style={{ ...card, gridColumn: '1 / -1', display: 'flex', alignItems: 'center', gap: 20, background: 'linear-gradient(135deg,#f5f3ff,#eff6ff)' }}>
                <div style={{ position: 'relative' }}>
                  {profilePhotoPreview
                    ? <img src={profilePhotoPreview} alt={user?.name} style={{ width: 80, height: 80, borderRadius: '50%', objectFit: 'cover', border: '3px solid #ddd6fe' }} />
                    : <div style={{ width: 80, height: 80, borderRadius: '50%', background: '#7c3aed', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 32, fontWeight: 700, color: 'white', border: '3px solid #ddd6fe' }}>
                        {(user?.firstName || user?.name || 'F')[0]}
                      </div>
                  }
                  <div style={{ position: 'absolute', bottom: 0, right: 0, width: 22, height: 22, background: '#16a34a', borderRadius: '50%', border: '2px solid white', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: 12 }}>✓</span>
                  </div>
                </div>
                <div>
                  <div style={{ fontSize: 22, fontWeight: 800, color: '#111827' }}>{user?.name || 'Faculty Member'}</div>
                  <div style={{ fontSize: 14, color: '#6b7280', marginTop: 4 }}>{user?.designation || 'Faculty'} · {user?.department || 'Department'}</div>
                  <div style={{ display: 'flex', gap: 8, marginTop: 10 }}>
                    <span style={{ fontSize: 11, padding: '3px 10px', background: '#f5f3ff', color: '#7c3aed', borderRadius: 20, fontWeight: 700, border: '1px solid #ddd6fe' }}>
                      {user?.employeeId || 'PTFAC—'}
                    </span>
                    <span style={{ fontSize: 11, padding: '3px 10px', background: '#f0fdf4', color: '#16a34a', borderRadius: 20, fontWeight: 700, border: '1px solid #bbf7d0' }}>
                      {user?.accountStatus || 'Active'}
                    </span>
                  </div>
                </div>
              </div>

              {/* Personal Information */}
              <div style={{ ...card }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', paddingBottom: 10, borderBottom: '1px solid #f3f4f6', display: 'flex', alignItems: 'center', gap: 6 }}>
                  👤 Personal Information
                </h3>
                {[
                  ['Full Name', [user?.firstName, user?.middleName, user?.lastName].filter(Boolean).join(' ') || user?.name],
                  ['Date of Birth', user?.dob ? new Date(user.dob).toLocaleDateString('en-IN') : '—'],
                  ['Gender', user?.gender || '—'],
                  ['Phone Number', user?.phone || '—'],
                  ['Address', user?.address || '—'],
                ].map(([label, value]) => (
                  <div key={label} style={{ display: 'flex', justifyContent: 'space-between', padding: '8px 0', borderBottom: '1px solid #f9fafb', fontSize: 13 }}>
                    <span style={{ color: '#9ca3af', fontWeight: 500 }}>{label}</span>
                    <span style={{ color: '#111827', fontWeight: 600, textAlign: 'right', maxWidth: '60%' }}>{value || '—'}</span>
                  </div>
                ))}
              </div>

              {/* Professional Information */}
              <div style={{ ...card }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', paddingBottom: 10, borderBottom: '1px solid #f3f4f6', display: 'flex', alignItems: 'center', gap: 6 }}>
                  💼 Professional Information
                </h3>
                {[
                  ['Employee ID', user?.employeeId || '—'],
                  ['Designation', user?.designation || '—'],
                  ['Department', user?.department || '—'],
                  ['Qualification', user?.qualification || '—'],
                  ['Specialization', user?.specialization || '—'],
                  ['Experience', user?.experience ? `${user.experience} years` : '—'],
                ].map(([label, value]) => (
                  <div key={label} style={{ display: 'flex', justifyContent: 'space-between', padding: '8px 0', borderBottom: '1px solid #f9fafb', fontSize: 13 }}>
                    <span style={{ color: '#9ca3af', fontWeight: 500 }}>{label}</span>
                    <span style={{ color: '#111827', fontWeight: 600, textAlign: 'right', maxWidth: '60%' }}>{value}</span>
                  </div>
                ))}
              </div>

              {/* Account Information */}
              <div style={{ ...card }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', paddingBottom: 10, borderBottom: '1px solid #f3f4f6', display: 'flex', alignItems: 'center', gap: 6 }}>
                  🔐 Account Information
                </h3>
                {[
                  ['Faculty Email', user?.facultyEmail || user?.email || '—'],
                  ['Joining Date', user?.joiningDate ? new Date(user.joiningDate).toLocaleDateString('en-IN') : '—'],
                  ['Account Status', user?.accountStatus || 'Active'],
                ].map(([label, value]) => (
                  <div key={label} style={{ display: 'flex', justifyContent: 'space-between', padding: '8px 0', borderBottom: '1px solid #f9fafb', fontSize: 13 }}>
                    <span style={{ color: '#9ca3af', fontWeight: 500 }}>{label}</span>
                    <span style={{ color: label === 'Account Status' ? '#16a34a' : '#111827', fontWeight: 600 }}>{value}</span>
                  </div>
                ))}
              </div>

              {/* Quick Actions */}
              <div style={{ ...card }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', paddingBottom: 10, borderBottom: '1px solid #f3f4f6' }}>
                  ⚡ Quick Actions
                </h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
                  <button onClick={() => setActiveTab('edit_profile')} style={{ ...btn(true), width: '100%', justifyContent: 'center' }}>
                    <Edit2 size={13} /> Edit Profile
                  </button>
                  <button onClick={handleLogout} style={{ ...btn(false), width: '100%', justifyContent: 'center' }}>
                    <LogOut size={13} /> Sign Out
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* ══════════════════ EDIT PROFILE ══════════════════ */}
          {activeTab === 'edit_profile' && (
            <div style={{ maxWidth: 700 }}>
              {/* Read-only fields card */}
              <div style={{ ...card, marginBottom: 16, background: '#f9fafb' }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 14px', display: 'flex', alignItems: 'center', gap: 6 }}>
                  🔒 Read-Only Fields (Admin Only)
                </h3>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
                  {[
                    ['Employee ID', user?.employeeId],
                    ['Faculty Email', user?.facultyEmail || user?.email],
                    ['Department', user?.department],
                    ['Joining Date', user?.joiningDate ? new Date(user.joiningDate).toLocaleDateString('en-IN') : '—'],
                  ].map(([label, value]) => (
                    <div key={label} style={{ background: 'white', borderRadius: 9, padding: '10px 14px', border: '1px solid #e5e7eb' }}>
                      <div style={{ fontSize: 11, color: '#9ca3af', textTransform: 'uppercase', letterSpacing: '0.04em', marginBottom: 4 }}>{label}</div>
                      <div style={{ fontSize: 13, fontWeight: 700, color: '#374151', fontFamily: label === 'Employee ID' || label === 'Faculty Email' ? 'monospace' : 'inherit' }}>{value || '—'}</div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Editable fields */}
              <div style={{ ...card, marginBottom: 16 }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', display: 'flex', alignItems: 'center', gap: 6 }}>
                  ✏️ Editable Information
                </h3>

                {/* Profile Photo */}
                <div style={{ marginBottom: 18 }}>
                  <div style={{ fontSize: 12, fontWeight: 600, color: '#374151', marginBottom: 8 }}>Profile Photo</div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
                    {profilePhotoPreview
                      ? <img src={profilePhotoPreview} alt="preview" style={{ width: 56, height: 56, borderRadius: '50%', objectFit: 'cover', border: '2px solid #ddd6fe' }} />
                      : <div style={{ width: 56, height: 56, borderRadius: '50%', background: '#ede9fe', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 22, fontWeight: 700, color: '#7c3aed', border: '2px solid #ddd6fe' }}>
                          {(user?.firstName || 'F')[0]}
                        </div>
                    }
                    <label style={{ display: 'inline-flex', alignItems: 'center', gap: 7, padding: '8px 14px', border: '1.5px dashed #d1d5db', borderRadius: 9, cursor: 'pointer', fontSize: 13, color: '#6b7280', background: '#f9fafb' }}>
                      <input type="file" accept=".jpg,.jpeg,.png" style={{ display: 'none' }}
                        onChange={e => handlePhotoUpload(e.target.files[0])} />
                      📷 Change Photo
                    </label>
                  </div>
                </div>

                {/* Phone */}
                <div style={{ marginBottom: 14 }}>
                  <label style={{ fontSize: 12, fontWeight: 600, color: '#374151', display: 'block', marginBottom: 6 }}>Phone Number</label>
                  <input type="tel" value={profileEdit.phone}
                    onChange={e => setProfileEdit(p => ({ ...p, phone: e.target.value.replace(/\D/, '').slice(0, 10) }))}
                    placeholder="10-digit phone number"
                    style={{ width: '100%', padding: '10px 14px', border: '1.5px solid #e5e7eb', borderRadius: 9, fontSize: 14, boxSizing: 'border-box', outline: 'none' }} />
                </div>

                {/* Address */}
                <div style={{ marginBottom: 18 }}>
                  <label style={{ fontSize: 12, fontWeight: 600, color: '#374151', display: 'block', marginBottom: 6 }}>Residential Address</label>
                  <textarea value={profileEdit.address}
                    onChange={e => setProfileEdit(p => ({ ...p, address: e.target.value }))}
                    placeholder="Full address including city, state, pincode" rows={3}
                    style={{ width: '100%', padding: '10px 14px', border: '1.5px solid #e5e7eb', borderRadius: 9, fontSize: 14, boxSizing: 'border-box', resize: 'vertical', outline: 'none' }} />
                </div>

                <button onClick={handleProfileSave} style={{ ...btn(true) }}>
                  {profileSaved ? '✓ Saved!' : <><CheckCircle size={14} /> Save Changes</>}
                </button>
              </div>

              {/* Change Password */}
              <div style={{ ...card }}>
                <h3 style={{ fontSize: 14, fontWeight: 700, color: '#374151', margin: '0 0 16px', display: 'flex', alignItems: 'center', gap: 6 }}>
                  🔑 Change Password
                </h3>
                {['current', 'newPw', 'confirm'].map((field, i) => (
                  <div key={field} style={{ marginBottom: 14 }}>
                    <label style={{ fontSize: 12, fontWeight: 600, color: '#374151', display: 'block', marginBottom: 6 }}>
                      {field === 'current' ? 'Current Password' : field === 'newPw' ? 'New Password' : 'Confirm New Password'}
                    </label>
                    <div style={{ position: 'relative' }}>
                      <input
                        type={showPw ? 'text' : 'password'}
                        value={pwForm[field]}
                        onChange={e => setPwForm(p => ({ ...p, [field]: e.target.value }))}
                        placeholder={field === 'current' ? 'Enter current password' : field === 'newPw' ? 'Min. 6 characters' : 'Repeat new password'}
                        style={{ width: '100%', padding: '10px 40px 10px 14px', border: '1.5px solid #e5e7eb', borderRadius: 9, fontSize: 14, boxSizing: 'border-box', outline: 'none' }}
                      />
                      {i === 0 && (
                        <button onClick={() => setShowPw(v => !v)} style={{ position: 'absolute', right: 10, top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af' }}>
                          {showPw ? '🙈' : '👁️'}
                        </button>
                      )}
                    </div>
                  </div>
                ))}
                {pwMsg && (
                  <div style={{ padding: '9px 14px', borderRadius: 9, marginBottom: 14, fontSize: 13, fontWeight: 500,
                    ...(pwMsg.startsWith('✓') ? { background: '#f0fdf4', color: '#15803d', border: '1px solid #bbf7d0' } : { background: '#fff1f2', color: '#dc2626', border: '1px solid #fecdd3' }) }}>
                    {pwMsg}
                  </div>
                )}
                <button onClick={handlePwChange} style={{ ...btn(false), background: '#111827', color: 'white' }}>
                  🔒 Update Password
                </button>
              </div>
            </div>
          )}
        </main>
      </div>
    </div>
  );
}
