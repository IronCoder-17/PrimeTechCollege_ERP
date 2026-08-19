// ============================================
// AdminDashboard — Campus Platform Management
// ============================================

import React, { useState, useEffect } from 'react';
import { useAuth } from '../contexts/AuthContext';
import {
  Shield, Users, CalendarDays, BookOpen, TrendingUp,
  Bell, Settings, LogOut, GraduationCap, BarChart2,
  AlertTriangle, CheckCircle, Clock, PlusCircle,
  Trash2, Edit2, Eye, UserCheck, UserX,
  Filter, ChevronLeft, ChevronRight, Download, X, Briefcase, Percent, Award, FileText, Menu
} from 'lucide-react';
import { useNavigate, useLocation } from 'react-router-dom';
import {
  getAllStudents, queryStudents, addStudent, updateStudent, deleteStudent,
  setStudentStatus, getStudentAttendanceSummary,
} from '../utils/studentMapping';
import { adminApi, admissionApi } from '../utils/api';
import FeeManagementPanel from './admin/FeeManagementPanel';
import FeeReceiptsPanel from './admin/FeeReceiptsPanel';
import AttendanceManagementPanel from './admin/AttendanceManagementPanel';
import ResultsManagementPanel from './admin/ResultsManagementPanel';
import TimetableManagementPanel from './admin/TimetableManagementPanel';
import './AdminResponsive.css';

const RECENT_USERS = [
  { id: 1, name: 'Alex Johnson', email: 'alex@university.edu', role: 'student', status: 'active', joined: '2 days ago' },
  { id: 2, name: 'Maya Patel', email: 'maya@university.edu', role: 'student', status: 'active', joined: '3 days ago' },
  { id: 3, name: 'Jordan Lee', email: 'jordan@university.edu', role: 'student', status: 'suspended', joined: '1 week ago' },
  { id: 4, name: 'Dr. Priya Singh', email: 'priya@university.edu', role: 'faculty', status: 'active', joined: '2 weeks ago' },
  { id: 5, name: 'Ravi Kumar', email: 'ravi@iit.ac.in', role: 'student', status: 'pending', joined: 'today' },
];

const PENDING_ACTIONS = [
  { id: 1, type: 'report', title: 'Reported post by @jordan_l', desc: 'Inappropriate content flagged by 3 users', time: '1h ago', urgent: true },
  { id: 2, type: 'event', title: 'Event approval: Hackathon 2026', desc: 'Tech Innovators Club submitted for review', time: '3h ago', urgent: false },
  { id: 3, type: 'club', title: 'New club request: Photography Society', desc: 'Awaiting admin approval to go live', time: '5h ago', urgent: false },
  { id: 4, type: 'report', title: 'Spam report in Chat', desc: 'User reported for sending spam messages', time: '8h ago', urgent: true },
];

// ── Faculty Management Panel ─────────────────────────────────────────────────
function FacultyManagementPanel() {
  const navigate = useNavigate();
  const [applications, setApplications] = React.useState(() => {
    try {
      const raw = localStorage.getItem('pt_faculty_applications');
      return raw ? JSON.parse(raw) : [];
    } catch { return []; }
  });
  const [search, setSearch] = React.useState('');

  const filtered = applications.filter(a =>
    !search ||
    a.name?.toLowerCase().includes(search.toLowerCase()) ||
    a.employeeId?.toLowerCase().includes(search.toLowerCase()) ||
    a.facultyEmail?.toLowerCase().includes(search.toLowerCase())
  );

  const approveApplication = (appId) => {
    const updated = applications.map(a =>
      a.applicationId === appId ? { ...a, status: 'Approved', accountStatus: 'Active' } : a
    );
    setApplications(updated);
    localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
  };

  const rejectApplication = (appId) => {
    const updated = applications.map(a =>
      a.applicationId === appId ? { ...a, status: 'Rejected', accountStatus: 'Inactive' } : a
    );
    setApplications(updated);
    localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
  };

  // RBAC: Admin (superuser) — activate/deactivate Faculty accounts
  const toggleApplicationActive = (appId) => {
    const updated = applications.map(a =>
      a.applicationId === appId
        ? { ...a, accountStatus: a.accountStatus === 'Active' ? 'Inactive' : 'Active' }
        : a
    );
    setApplications(updated);
    localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
  };

  // RBAC: Admin (superuser) — full CRUD over Faculty records
  const deleteApplication = (appId) => {
    if (!window.confirm('Permanently delete this faculty record?')) return;
    const updated = applications.filter(a => a.applicationId !== appId);
    setApplications(updated);
    localStorage.setItem('pt_faculty_applications', JSON.stringify(updated));
  };

  const card = { background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb', marginBottom: 16 };
  const statusStyle = (s) => ({
    Pending: { background: '#fffbeb', color: '#92400e' },
    Approved: { background: '#f0fdf4', color: '#15803d' },
    Rejected: { background: '#fff1f2', color: '#dc2626' },
  }[s] || { background: '#f3f4f6', color: '#374151' });

  return (
    <div>
      <div style={card}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: 0 }}>Faculty Applications ({applications.length})</h2>
          <button onClick={() => navigate('/faculty-register')}
            style={{ fontSize: 12, background: '#7c3aed', color: 'white', padding: '6px 14px', borderRadius: 8, border: 'none', cursor: 'pointer', fontWeight: 600 }}>
            + Register New Faculty (Admin)
          </button>
        </div>
        <input
          placeholder="Search by name, employee ID, or email…"
          value={search} onChange={e => setSearch(e.target.value)}
          style={{ width: '100%', padding: '9px 14px', border: '1px solid #e5e7eb', borderRadius: 9, fontSize: 13, marginBottom: 16, boxSizing: 'border-box' }}
        />
        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '40px 0', color: '#9ca3af', fontSize: 14 }}>
            No faculty applications yet. Share the registration link with faculty members.
          </div>
        ) : (
          filtered.map(a => (
            <div key={a.applicationId} style={{ border: '1px solid #e5e7eb', borderRadius: 12, padding: 16, marginBottom: 12 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div style={{ flex: 1 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 6 }}>
                    <div style={{ width: 36, height: 36, borderRadius: '50%', background: '#ede9fe', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, fontSize: 14, color: '#7c3aed' }}>
                      {(a.firstName || 'F')[0]}{(a.lastName || 'L')[0]}
                    </div>
                    <div>
                      <div style={{ fontWeight: 700, fontSize: 14, color: '#111827' }}>{a.name}</div>
                      <div style={{ fontSize: 12, color: '#6b7280' }}>{a.designation} · {a.department}</div>
                    </div>
                  </div>
                  <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 8, marginTop: 8 }}>
                    {[
                      ['Employee ID', a.employeeId],
                      ['Email', a.facultyEmail],
                      ['Qualification', a.qualification],
                      ['Experience', `${a.experience} yrs`],
                      ['Phone', a.phone],
                      ['Applied', new Date(a.registrationDate).toLocaleDateString('en-IN')],
                    ].map(([label, value]) => (
                      <div key={label}>
                        <div style={{ fontSize: 10, color: '#9ca3af', textTransform: 'uppercase', letterSpacing: '0.04em' }}>{label}</div>
                        <div style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>{value || '—'}</div>
                      </div>
                    ))}
                  </div>
                </div>
                <div style={{ display: 'flex', flexDirection: 'column', gap: 8, alignItems: 'flex-end', marginLeft: 16 }}>
                  <span style={{ ...statusStyle(a.status), padding: '3px 10px', borderRadius: 20, fontSize: 11, fontWeight: 700 }}>
                    {a.status || 'Pending'}
                  </span>
                  {(a.status === 'Pending' || !a.status) && (
                    <div style={{ display: 'flex', gap: 6 }}>
                      <button onClick={() => approveApplication(a.applicationId)}
                        style={{ padding: '6px 12px', background: '#16a34a', color: 'white', border: 'none', borderRadius: 7, fontSize: 12, fontWeight: 600, cursor: 'pointer' }}>
                        ✓ Approve
                      </button>
                      <button onClick={() => rejectApplication(a.applicationId)}
                        style={{ padding: '6px 12px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 7, fontSize: 12, fontWeight: 600, cursor: 'pointer' }}>
                        ✗ Reject
                      </button>
                    </div>
                  )}
                  {a.status === 'Approved' && (
                    <div style={{ display: 'flex', gap: 6 }}>
                      <button onClick={() => toggleApplicationActive(a.applicationId)}
                        style={{ padding: '6px 12px', background: a.accountStatus === 'Active' ? '#fff1f2' : '#f0fdf4', color: a.accountStatus === 'Active' ? '#dc2626' : '#16a34a', border: 'none', borderRadius: 7, fontSize: 12, fontWeight: 600, cursor: 'pointer' }}>
                        {a.accountStatus === 'Active' ? 'Deactivate' : 'Activate'}
                      </button>
                    </div>
                  )}
                  <button onClick={() => deleteApplication(a.applicationId)}
                    style={{ padding: '6px 12px', background: '#fff1f2', color: '#dc2626', border: '1px solid #fecdd3', borderRadius: 7, fontSize: 12, fontWeight: 600, cursor: 'pointer' }}>
                    🗑 Delete
                  </button>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}

// ── Hostel Management Panel ──────────────────────────────────────────────────
// ── Apply Now Inquiries Panel ────────────────────────────────────────────────
// Shows public "Apply Now" inquiries (basic contact info only). Admin can
// convert a promising inquiry into a full Student Admission record using the
// Student Admission module — Apply Now itself never creates a student account.
function InquiriesPanel() {
  const navigate = useNavigate();
  const [inquiries, setInquiries] = useState(() => {
    try {
      const raw = localStorage.getItem('pt_admission_inquiries');
      return raw ? JSON.parse(raw) : [];
    } catch { return []; }
  });
  const [search, setSearch] = useState('');

  const filtered = inquiries.filter(i =>
    i.name?.toLowerCase().includes(search.toLowerCase()) ||
    i.email?.toLowerCase().includes(search.toLowerCase()) ||
    i.course?.toLowerCase().includes(search.toLowerCase())
  );

  const updateStatus = (id, status) => {
    const updated = inquiries.map(i => i.id === id ? { ...i, status } : i);
    setInquiries(updated);
    localStorage.setItem('pt_admission_inquiries', JSON.stringify(updated));
  };

  const card = { background: 'white', borderRadius: 14, padding: 20, border: '1px solid #e5e7eb', boxShadow: '0 2px 8px rgba(0,0,0,0.04)' };

  return (
    <div style={card}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
        <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: 0 }}>Apply Now Inquiries ({inquiries.length})</h2>
        <button onClick={() => navigate('/admission')}
          style={{ fontSize: 12, background: '#2563eb', color: 'white', padding: '6px 14px', borderRadius: 8, border: 'none', cursor: 'pointer', fontWeight: 600 }}>
          + New Student Admission
        </button>
      </div>
      <input
        placeholder="Search by name, email, or course…"
        value={search} onChange={e => setSearch(e.target.value)}
        style={{ width: '100%', padding: '9px 14px', border: '1px solid #e5e7eb', borderRadius: 9, fontSize: 13, marginBottom: 16, boxSizing: 'border-box' }}
      />
      {filtered.length === 0 ? (
        <div style={{ textAlign: 'center', padding: '40px 0', color: '#9ca3af', fontSize: 14 }}>
          No inquiries yet. Submissions from the public "Apply Now" form will appear here.
        </div>
      ) : (
        filtered.map(i => (
          <div key={i.id} style={{ border: '1px solid #e5e7eb', borderRadius: 12, padding: 16, marginBottom: 12 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
              <div>
                <div style={{ fontWeight: 600, color: '#111827', fontSize: 14 }}>{i.name}</div>
                <div style={{ fontSize: 12, color: '#6b7280', marginTop: 2 }}>{i.email} · {i.phone}</div>
                <div style={{ fontSize: 12, color: '#7c3aed', marginTop: 2 }}>Interested in: {i.course}</div>
                {i.message && <div style={{ fontSize: 12, color: '#374151', marginTop: 6 }}>"{i.message}"</div>}
                <div style={{ fontSize: 11, color: '#9ca3af', marginTop: 6 }}>{new Date(i.submittedAt).toLocaleString()}</div>
              </div>
              <span style={{
                fontSize: 11, fontWeight: 700, padding: '3px 10px', borderRadius: 20,
                background: i.status === 'Converted' ? '#f0fdf4' : i.status === 'Contacted' ? '#eff6ff' : '#fffbeb',
                color: i.status === 'Converted' ? '#15803d' : i.status === 'Contacted' ? '#2563eb' : '#d97706',
              }}>{i.status}</span>
            </div>
            <div style={{ display: 'flex', gap: 8, marginTop: 12 }}>
              {i.status === 'New' && (
                <button onClick={() => updateStatus(i.id, 'Contacted')}
                  style={{ fontSize: 12, padding: '5px 12px', borderRadius: 7, border: '1px solid #bfdbfe', background: '#eff6ff', color: '#2563eb', fontWeight: 600, cursor: 'pointer' }}>
                  Mark Contacted
                </button>
              )}
              {i.status !== 'Converted' && (
                <button onClick={() => updateStatus(i.id, 'Converted')}
                  style={{ fontSize: 12, padding: '5px 12px', borderRadius: 7, border: '1px solid #bbf7d0', background: '#f0fdf4', color: '#15803d', fontWeight: 600, cursor: 'pointer' }}>
                  Mark Converted
                </button>
              )}
              <button onClick={() => navigate('/admission')}
                style={{ fontSize: 12, padding: '5px 12px', borderRadius: 7, border: '1px solid #e5e7eb', background: '#f9fafb', color: '#374151', fontWeight: 600, cursor: 'pointer' }}>
                Convert to Admission →
              </button>
            </div>
          </div>
        ))
      )}
    </div>
  );
}

function HostelManagementPanel() {
  const [hostelStudents, setHostelStudents] = React.useState(() => {
    try {
      const raw = localStorage.getItem('ccc_admission_accounts');
      const accounts = raw ? JSON.parse(raw) : [];
      return accounts.filter(a => a.hostelRequired === true);
    } catch { return []; }
  });
  const [search, setSearch] = React.useState('');
  const [roomInputs, setRoomInputs] = React.useState({});

  const filtered = hostelStudents.filter(s =>
    !search ||
    s.name?.toLowerCase().includes(search.toLowerCase()) ||
    s.grNumber?.toLowerCase().includes(search.toLowerCase()) ||
    s.enrollmentNumber?.toLowerCase().includes(search.toLowerCase())
  );

  const assignRoom = (studentEmail, roomNumber) => {
    try {
      const raw = localStorage.getItem('ccc_admission_accounts');
      const accounts = raw ? JSON.parse(raw) : [];
      const updated = accounts.map(a =>
        a.email === studentEmail
          ? { ...a, hostelRoomNumber: roomNumber, hostelAllocationStatus: 'Allocated' }
          : a
      );
      localStorage.setItem('ccc_admission_accounts', JSON.stringify(updated));
      setHostelStudents(updated.filter(a => a.hostelRequired === true));
      setRoomInputs(prev => ({ ...prev, [studentEmail]: '' }));
    } catch (err) { console.error(err); }
  };

  const card = { background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb', marginBottom: 16 };

  const stats = [
    { label: 'Total Hostel Students', value: hostelStudents.length, color: '#2563eb', bg: '#eff6ff' },
    { label: 'Allocated Rooms', value: hostelStudents.filter(s => s.hostelAllocationStatus === 'Allocated').length, color: '#16a34a', bg: '#f0fdf4' },
    { label: 'Pending Allocation', value: hostelStudents.filter(s => s.hostelAllocationStatus !== 'Allocated').length, color: '#d97706', bg: '#fffbeb' },
    { label: 'Boys Hostel', value: hostelStudents.filter(s => s.hostelType === 'Boys Hostel').length, color: '#7c3aed', bg: '#f5f3ff' },
    { label: 'Girls Hostel', value: hostelStudents.filter(s => s.hostelType === 'Girls Hostel').length, color: '#db2777', bg: '#fdf2f8' },
  ];

  return (
    <div>
      {/* Stats row */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(5,1fr)', gap: 12, marginBottom: 16 }}>
        {stats.map(({ label, value, color, bg }) => (
          <div key={label} style={{ ...card, marginBottom: 0, background: bg, border: `1px solid ${color}22` }}>
            <div style={{ fontSize: 24, fontWeight: 800, color }}>{value}</div>
            <div style={{ fontSize: 12, color: '#6b7280', marginTop: 2 }}>{label}</div>
          </div>
        ))}
      </div>

      <div style={card}>
        <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: '0 0 16px' }}>Hostel Students</h2>
        <input
          placeholder="Search by name, GR number, or enrollment number…"
          value={search} onChange={e => setSearch(e.target.value)}
          style={{ width: '100%', padding: '9px 14px', border: '1px solid #e5e7eb', borderRadius: 9, fontSize: 13, marginBottom: 16, boxSizing: 'border-box' }}
        />
        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: '40px 0', color: '#9ca3af', fontSize: 14 }}>
            No hostel students found. Students who opt for hostel during admission will appear here.
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
            <thead>
              <tr style={{ background: '#f9fafb' }}>
                {['Student Name','GR Number','Hostel Type','Room Type','Room Number','Status','Action'].map(h => (
                  <th key={h} style={{ padding: '10px 12px', textAlign: 'left', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #e5e7eb' }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filtered.map((s, i) => (
                <tr key={s.email} style={{ borderBottom: '1px solid #f3f4f6' }}>
                  <td style={{ padding: '10px 12px', fontWeight: 600, color: '#111827' }}>{s.name}</td>
                  <td style={{ padding: '10px 12px', color: '#6b7280', fontFamily: 'monospace', fontSize: 12 }}>{s.grNumber}</td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>{s.hostelType}</td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>{s.roomType}</td>
                  <td style={{ padding: '10px 12px' }}>
                    <span style={{ color: s.hostelAllocationStatus === 'Allocated' ? '#16a34a' : '#d97706', fontWeight: 600 }}>
                      {s.hostelRoomNumber || 'Pending'}
                    </span>
                  </td>
                  <td style={{ padding: '10px 12px' }}>
                    <span style={{
                      padding: '2px 8px', borderRadius: 20, fontSize: 11, fontWeight: 700,
                      ...(s.hostelAllocationStatus === 'Allocated'
                        ? { background: '#f0fdf4', color: '#15803d' }
                        : { background: '#fffbeb', color: '#92400e' })
                    }}>
                      {s.hostelAllocationStatus || 'Pending'}
                    </span>
                  </td>
                  <td style={{ padding: '10px 12px' }}>
                    <div style={{ display: 'flex', gap: 6 }}>
                      <input
                        placeholder="Room no."
                        value={roomInputs[s.email] || ''}
                        onChange={e => setRoomInputs(prev => ({ ...prev, [s.email]: e.target.value }))}
                        style={{ width: 80, padding: '4px 8px', border: '1px solid #e5e7eb', borderRadius: 6, fontSize: 12 }}
                      />
                      <button
                        onClick={() => roomInputs[s.email] && assignRoom(s.email, roomInputs[s.email])}
                        style={{ padding: '4px 10px', background: '#2563eb', color: 'white', border: 'none', borderRadius: 6, fontSize: 11, fontWeight: 600, cursor: 'pointer' }}>
                        Assign
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}

// ── Student Management Panel (Admin Superuser — full CRUD over ALL students) ──
const COURSE_OPTIONS = [
  { code: 'BTCE', name: 'B.Tech Computer Engineering', semesters: 8 },
  { code: 'BTIT', name: 'B.Tech Information Technology', semesters: 8 },
  { code: 'BTME', name: 'B.Tech Mechanical Engineering', semesters: 8 },
  { code: 'BTCV', name: 'B.Tech Civil Engineering', semesters: 8 },
  { code: 'BTEC', name: 'B.Tech Electronics & Communication', semesters: 8 },
  { code: 'MTCE', name: 'M.Tech Computer Engineering', semesters: 4 },
  { code: 'MTSE', name: 'M.Tech Structural Engineering', semesters: 4 },
  { code: 'BCA',  name: 'BCA', semesters: 6 },
  { code: 'MCA',  name: 'MCA', semesters: 4 },
  { code: 'BSCIT', name: 'B.Sc Information Technology', semesters: 6 },
  { code: 'BBA',  name: 'BBA', semesters: 6 },
  { code: 'MBA',  name: 'MBA', semesters: 4 },
  { code: 'BCBA', name: 'B.Com Business Analytics', semesters: 6 },
  { code: 'BSCMA', name: 'B.Sc Mathematics', semesters: 6 },
  { code: 'BSCPH', name: 'B.Sc Physics', semesters: 6 },
  { code: 'MSCDS', name: 'M.Sc Data Science', semesters: 4 },
  { code: 'BCOM', name: 'B.Com', semesters: 6 },
  { code: 'MCOM', name: 'M.Com', semesters: 4 },
  { code: 'BAEN', name: 'BA English', semesters: 6 },
  { code: 'BMMA', name: 'Bachelor of Multimedia & Animation', semesters: 6 },
];

const EMPTY_STUDENT_FORM = {
  firstName: '', middleName: '', lastName: '', email: '', phone: '',
  gender: 'Male', dob: '', address: '', courseCode: '', semester: '1',
  grNumber: '', enrollmentNumber: '',
};

function StudentManagementPanel() {
  const [version, setVersion] = useState(0); // bump to force re-read from localStorage
  const refresh = () => setVersion(v => v + 1);

  const allStudents = getAllStudents();

  const [search, setSearch] = useState('');
  const [courseFilter, setCourseFilter] = useState('');
  const [semFilter, setSemFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [sortBy, setSortBy] = useState('name');
  const [sortDir, setSortDir] = useState('asc');
  const [page, setPage] = useState(1);

  const [showForm, setShowForm] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [form, setForm] = useState(EMPTY_STUDENT_FORM);
  const [viewingStudent, setViewingStudent] = useState(null);

  const courseCodes = [...new Set(allStudents.map(s => s.courseCode).filter(Boolean))];
  const semesters = [...new Set(allStudents.map(s => s.semester).filter(Boolean))].sort();

  const result = queryStudents(allStudents, {
    search, course: courseFilter, semester: semFilter, status: statusFilter,
    sortBy, sortDir, page, pageSize: 8,
  });

  const card = { background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb', marginBottom: 16 };
  const inputStyle = { width: '100%', padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
  const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };

  const openAddForm = () => {
    setForm(EMPTY_STUDENT_FORM);
    setEditingId(null);
    setShowForm(true);
  };

  const openEditForm = (s) => {
    setForm({
      firstName: s.firstName || '', middleName: s.middleName || '', lastName: s.lastName || '',
      email: s.email || '', phone: s.phone || '', gender: s.gender || 'Male', dob: s.dob || '',
      address: s.address || '', courseCode: s.courseCode || '', semester: String(s.semester || '1'),
      grNumber: s.grNumber || '', enrollmentNumber: s.enrollmentNumber || '',
    });
    setEditingId(s.id);
    setShowForm(true);
  };

  const handleSubmit = () => {
    if (!form.firstName || !form.lastName || !form.email) {
      alert('First name, last name, and email are required.');
      return;
    }
    const selectedCourse = COURSE_OPTIONS.find(c => c.code === form.courseCode);
    const payload = {
      ...form,
      name: [form.firstName, form.middleName, form.lastName].filter(Boolean).join(' '),
      course: selectedCourse?.name || '',
      courseDept: '', // left for admin to refine; not required for save
    };
    if (editingId) {
      updateStudent(editingId, payload);
    } else {
      addStudent(payload);
    }
    setShowForm(false);
    setEditingId(null);
    setForm(EMPTY_STUDENT_FORM);
    refresh();
  };

  const handleDelete = (s) => {
    if (!window.confirm(`Permanently delete student "${s.name}"? This cannot be undone.`)) return;
    deleteStudent(s.id);
    refresh();
  };

  const toggleStatus = (s) => {
    const next = s.accountStatus === 'Active' ? 'Suspended' : 'Active';
    setStudentStatus(s.id, next);
    refresh();
  };

  const exportCSV = () => {
    const headers = ['Name', 'Email', 'Enrollment No', 'GR Number', 'Course', 'Semester', 'Status'];
    const rows = result.items.map(s => [s.name, s.email, s.enrollmentNumber, s.grNumber, s.courseCode, s.semester, s.accountStatus]);
    const csv = [headers, ...rows].map(r => r.map(v => `"${(v ?? '').toString().replace(/"/g, '""')}"`).join(',')).join('\n');
    const blob = new Blob([csv], { type: 'text/csv' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = 'students_export.csv';
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div>
      {/* Filters / Toolbar */}
      <div style={card}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: 0 }}>All Students ({allStudents.length})</h2>
          <div style={{ display: 'flex', gap: 8 }}>
            <button onClick={exportCSV} style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '8px 16px', background: '#eff6ff', color: '#2563eb', border: '1px solid #bfdbfe', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
              <Download size={14} /> Export CSV
            </button>
            <button onClick={openAddForm} style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '8px 16px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
              <PlusCircle size={14} /> Add Student
            </button>
          </div>
        </div>
        <div style={{ display: 'flex', gap: 10, flexWrap: 'wrap', alignItems: 'flex-end' }}>
          <div style={{ flex: '1 1 240px' }}>
            <label style={labelStyle}>Search</label>
            <input placeholder="Search by name, email, enrollment or GR number..." value={search}
              onChange={e => { setSearch(e.target.value); setPage(1); }} style={inputStyle} />
          </div>
          <div>
            <label style={labelStyle}>Course</label>
            <select value={courseFilter} onChange={e => { setCourseFilter(e.target.value); setPage(1); }} style={{ ...inputStyle, width: 'auto' }}>
              <option value="">All Courses</option>
              {courseCodes.map(c => <option key={c} value={c}>{c}</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Semester</label>
            <select value={semFilter} onChange={e => { setSemFilter(e.target.value); setPage(1); }} style={{ ...inputStyle, width: 'auto' }}>
              <option value="">All Semesters</option>
              {semesters.map(s => <option key={s} value={s}>Sem {s}</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Status</label>
            <select value={statusFilter} onChange={e => { setStatusFilter(e.target.value); setPage(1); }} style={{ ...inputStyle, width: 'auto' }}>
              <option value="">All Statuses</option>
              <option value="Active">Active</option>
              <option value="Suspended">Suspended</option>
              <option value="Inactive">Inactive</option>
            </select>
          </div>
          <div>
            <label style={labelStyle}>Sort By</label>
            <select value={sortBy} onChange={e => setSortBy(e.target.value)} style={{ ...inputStyle, width: 'auto' }}>
              <option value="name">Name</option>
              <option value="enrollmentNumber">Enrollment No.</option>
              <option value="courseCode">Course</option>
              <option value="semester">Semester</option>
              <option value="registrationDate">Registration Date</option>
            </select>
          </div>
          <button onClick={() => setSortDir(d => d === 'asc' ? 'desc' : 'asc')}
            style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', background: '#f9fafb', cursor: 'pointer', fontSize: 12, fontWeight: 600, color: '#374151' }}>
            {sortDir === 'asc' ? '↑ Asc' : '↓ Desc'}
          </button>
        </div>
      </div>

      {/* Add/Edit Form */}
      {showForm && (
        <div style={card}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
            <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: 0 }}>{editingId ? 'Edit Student' : 'Add New Student'}</h2>
            <button onClick={() => setShowForm(false)} style={{ background: 'none', border: 'none', cursor: 'pointer' }}><X size={18} color="#9ca3af" /></button>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3,1fr)', gap: 12, marginBottom: 12 }}>
            <div><label style={labelStyle}>First Name *</label><input value={form.firstName} onChange={e => setForm(f => ({ ...f, firstName: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Middle Name</label><input value={form.middleName} onChange={e => setForm(f => ({ ...f, middleName: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Last Name *</label><input value={form.lastName} onChange={e => setForm(f => ({ ...f, lastName: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Email *</label><input type="email" value={form.email} onChange={e => setForm(f => ({ ...f, email: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Phone</label><input value={form.phone} onChange={e => setForm(f => ({ ...f, phone: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Gender</label>
              <select value={form.gender} onChange={e => setForm(f => ({ ...f, gender: e.target.value }))} style={inputStyle}>
                <option>Male</option><option>Female</option><option>Other</option>
              </select>
            </div>
            <div><label style={labelStyle}>Date of Birth</label><input type="date" value={form.dob} onChange={e => setForm(f => ({ ...f, dob: e.target.value }))} style={inputStyle} /></div>
            <div><label style={labelStyle}>Course</label>
              <select value={form.courseCode} onChange={e => setForm(f => ({ ...f, courseCode: e.target.value, semester: '1' }))} style={inputStyle}>
                <option value="">Select course</option>
                {COURSE_OPTIONS.map(c => <option key={c.code} value={c.code}>{c.name}</option>)}
              </select>
            </div>
            <div><label style={labelStyle}>Semester</label>
              <select value={form.semester} onChange={e => setForm(f => ({ ...f, semester: e.target.value }))} style={inputStyle}>
                {Array.from({ length: COURSE_OPTIONS.find(c => c.code === form.courseCode)?.semesters || 8 }, (_, i) => i + 1).map(n => (
                  <option key={n} value={n}>Sem {n}</option>
                ))}
              </select>
            </div>
            <div><label style={labelStyle}>GR Number</label><input value={form.grNumber} onChange={e => setForm(f => ({ ...f, grNumber: e.target.value }))} style={inputStyle} placeholder="PTGR20260001" /></div>
            <div><label style={labelStyle}>Enrollment Number</label><input value={form.enrollmentNumber} onChange={e => setForm(f => ({ ...f, enrollmentNumber: e.target.value }))} style={inputStyle} placeholder="PT2026BTCE0001" /></div>
            <div style={{ gridColumn: '1 / -1' }}><label style={labelStyle}>Address</label><textarea value={form.address} onChange={e => setForm(f => ({ ...f, address: e.target.value }))} rows={2} style={{ ...inputStyle, resize: 'vertical' }} /></div>
          </div>
          <div style={{ display: 'flex', gap: 10 }}>
            <button onClick={handleSubmit} style={{ padding: '9px 20px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
              {editingId ? 'Save Changes' : 'Create Student'}
            </button>
            <button onClick={() => setShowForm(false)} style={{ padding: '9px 20px', background: '#f3f4f6', color: '#374151', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
              Cancel
            </button>
          </div>
        </div>
      )}

      {/* View Detail Modal */}
      {viewingStudent && (
        <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}
          onClick={() => setViewingStudent(null)}>
          <div onClick={e => e.stopPropagation()} style={{ background: 'white', borderRadius: 16, padding: 24, width: 480, maxHeight: '80vh', overflowY: 'auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
              <h2 style={{ fontSize: 16, fontWeight: 700, color: '#111827', margin: 0 }}>Student Details</h2>
              <button onClick={() => setViewingStudent(null)} style={{ background: 'none', border: 'none', cursor: 'pointer' }}><X size={18} color="#9ca3af" /></button>
            </div>
            <div style={{ display: 'flex', alignItems: 'center', gap: 14, marginBottom: 16 }}>
              {viewingStudent.photoDataUrl
                ? <img src={viewingStudent.photoDataUrl} alt={viewingStudent.name} style={{ width: 56, height: 56, borderRadius: '50%', objectFit: 'cover' }} />
                : <div style={{ width: 56, height: 56, borderRadius: '50%', background: '#fee2e2', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, color: '#dc2626', fontSize: 22 }}>{(viewingStudent.name || '?')[0]}</div>
              }
              <div>
                <div style={{ fontSize: 16, fontWeight: 700, color: '#111827' }}>{viewingStudent.name}</div>
                <div style={{ fontSize: 12, color: '#9ca3af' }}>{viewingStudent.email}</div>
              </div>
            </div>
            {(() => {
              const summary = getStudentAttendanceSummary(viewingStudent.id);
              return (
                <>
                  {[
                    ['Enrollment Number', viewingStudent.enrollmentNumber || '—'],
                    ['GR Number', viewingStudent.grNumber || '—'],
                    ['Student ID', viewingStudent.studentId || '—'],
                    ['Course', viewingStudent.course || viewingStudent.courseCode || '—'],
                    ['Semester', viewingStudent.semester ? `Sem ${viewingStudent.semester}` : '—'],
                    ['Phone', viewingStudent.phone || '—'],
                    ['Gender', viewingStudent.gender || '—'],
                    ['Address', viewingStudent.address || '—'],
                    ['Attendance', summary.total > 0 ? `${summary.pct}% (${summary.present}/${summary.total})` : 'No records'],
                    ['Fees', `Paid ₹${viewingStudent.paidFee || 0} / Total ₹${viewingStudent.totalFee || 0}`],
                    ['Hostel', viewingStudent.hostelRequired ? `${viewingStudent.hostelType || ''} — ${viewingStudent.hostelAllocationStatus || 'Pending'}` : 'Not opted'],
                    ['Transportation', viewingStudent.transportRequired ? `${viewingStudent.transportLocation || ''} — Bus ${viewingStudent.busNumber || '—'} (₹${viewingStudent.transportFee || 0})` : 'Not opted'],
                    ['Account Status', viewingStudent.accountStatus],
                  ].map(([label, value]) => (
                    <div key={label} style={{ display: 'flex', justifyContent: 'space-between', padding: '7px 0', borderBottom: '1px solid #f3f4f6', fontSize: 13 }}>
                      <span style={{ color: '#9ca3af', fontWeight: 500 }}>{label}</span>
                      <span style={{ color: '#111827', fontWeight: 600, textAlign: 'right', maxWidth: '60%' }}>{value}</span>
                    </div>
                  ))}
                </>
              );
            })()}
          </div>
        </div>
      )}

      {/* Results table */}
      <div style={{ background: 'white', borderRadius: 16, border: '1px solid #e5e7eb', overflow: 'hidden' }}>
        {result.items.length === 0 ? (
          <div style={{ textAlign: 'center', padding: 48, color: '#9ca3af', fontSize: 14 }}>
            <Filter size={32} color="#d1d5db" style={{ marginBottom: 10 }} />
            <div>{allStudents.length === 0 ? 'No students have been admitted yet.' : 'No students match your filters.'}</div>
          </div>
        ) : (
          <>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
              <thead>
                <tr style={{ background: '#f9fafb' }}>
                  {['Enrollment / GR', 'Name', 'Course', 'Semester', 'Attendance', 'Status', 'Actions'].map(h => (
                    <th key={h} style={{ padding: '10px 14px', textAlign: 'left', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #e5e7eb' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {result.items.map((s, i) => {
                  const summary = getStudentAttendanceSummary(s.id);
                  return (
                    <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                      <td style={{ padding: '11px 14px', fontFamily: 'monospace', fontSize: 12, fontWeight: 600, color: '#1f2937' }}>{s.enrollmentNumber || s.grNumber || '—'}</td>
                      <td style={{ padding: '11px 14px' }}>
                        <div style={{ fontWeight: 600, color: '#111827' }}>{s.name}</div>
                        <div style={{ fontSize: 11, color: '#9ca3af' }}>{s.email}</div>
                      </td>
                      <td style={{ padding: '11px 14px', color: '#374151' }}>{s.courseCode || '—'}</td>
                      <td style={{ padding: '11px 14px', color: '#374151' }}>{s.semester ? `Sem ${s.semester}` : '—'}</td>
                      <td style={{ padding: '11px 14px', fontWeight: 700, color: summary.total > 0 ? (summary.pct >= 75 ? '#16a34a' : '#d97706') : '#9ca3af' }}>
                        {summary.total > 0 ? `${summary.pct}%` : '—'}
                      </td>
                      <td style={{ padding: '11px 14px' }}>
                        <span style={{
                          padding: '3px 9px', borderRadius: 20, fontSize: 11, fontWeight: 700,
                          background: s.accountStatus === 'Active' ? '#f0fdf4' : '#fff1f2',
                          color: s.accountStatus === 'Active' ? '#16a34a' : '#dc2626',
                        }}>{s.accountStatus}</span>
                      </td>
                      <td style={{ padding: '11px 14px' }}>
                        <div style={{ display: 'flex', gap: 6 }}>
                          <button title="View" onClick={() => setViewingStudent(s)} style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Eye size={13} color="#6b7280" /></button>
                          <button title="Edit" onClick={() => openEditForm(s)} style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Edit2 size={13} color="#2563eb" /></button>
                          <button title={s.accountStatus === 'Active' ? 'Suspend' : 'Activate'} onClick={() => toggleStatus(s)} style={{ padding: 6, background: s.accountStatus === 'Active' ? '#fff1f2' : '#f0fdf4', border: 'none', borderRadius: 6, cursor: 'pointer' }}>
                            {s.accountStatus === 'Active' ? <UserX size={13} color="#dc2626" /> : <UserCheck size={13} color="#16a34a" />}
                          </button>
                          <button title="Delete" onClick={() => handleDelete(s)} style={{ padding: 6, background: '#fff1f2', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Trash2 size={13} color="#dc2626" /></button>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
            {/* Pagination */}
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px 16px', borderTop: '1px solid #f3f4f6' }}>
              <span style={{ fontSize: 12, color: '#9ca3af' }}>
                Showing {(result.page - 1) * result.pageSize + 1}–{Math.min(result.page * result.pageSize, result.total)} of {result.total} students
              </span>
              <div style={{ display: 'flex', gap: 6 }}>
                <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={result.page === 1}
                  style={{ padding: '6px 10px', border: '1px solid #e5e7eb', background: 'white', borderRadius: 6, cursor: 'pointer', opacity: result.page === 1 ? 0.4 : 1 }}>
                  <ChevronLeft size={14} />
                </button>
                <span style={{ fontSize: 12, color: '#374151', fontWeight: 600, padding: '6px 10px' }}>Page {result.page} of {result.totalPages}</span>
                <button onClick={() => setPage(p => Math.min(result.totalPages, p + 1))} disabled={result.page === result.totalPages}
                  style={{ padding: '6px 10px', border: '1px solid #e5e7eb', background: 'white', borderRadius: 6, cursor: 'pointer', opacity: result.page === result.totalPages ? 0.4 : 1 }}>
                  <ChevronRight size={14} />
                </button>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

export default function AdminDashboard() {
  const { user, logout } = useAuth();

  const navigate = useNavigate();
  const location = useLocation();
  const [activeTab, setActiveTab] = useState('overview');
  const [mobileNavOpen, setMobileNavOpen] = useState(false);
  const [users, setUsers] = useState(RECENT_USERS);

  // Allow deep-linking a specific tab, e.g. /admin?tab=timetable
  useEffect(() => {
    const tab = new URLSearchParams(location.search).get('tab');
    if (tab) setActiveTab(tab);
  }, [location.search]);

  // ── Live Dashboard Stats (from real DB via Admin API) ──
  // Falls back to localStorage-derived stats below if the API
  // call fails (e.g. backend not running in this environment).
  const [liveStats, setLiveStats] = useState(null);
  const [liveStatsError, setLiveStatsError] = useState(false);

  // ── Fee Structure Reference widget (Admissions tab) — pulled live
  //    from the centralized fee_structure table, no hard-coded amounts ──
  const [feeRef, setFeeRef] = useState([]);
  React.useEffect(() => {
    admissionApi.getFeeStructure()
      .then(({ data }) => {
        const rows = (data?.courses || []).map(c => {
          const fees = (c.fees || []).slice().sort((a,b) => a.semester - b.semester);
          const first = fees[0];
          const last  = fees[fees.length - 1];
          return {
            course: c.course_name,
            sem1: first ? `₹${Number(first.tuition_fee).toLocaleString('en-IN')}` : '—',
            semLast: last ? `₹${Number(last.tuition_fee).toLocaleString('en-IN')} (Sem${last.semester})` : '—',
          };
        });
        setFeeRef(rows);
      })
      .catch(() => setFeeRef([]));
  }, []);

  React.useEffect(() => {
    adminApi.getDashboard()
      .then(res => setLiveStats(res.data))
      .catch(() => setLiveStatsError(true));
  }, []);

  const handleLogout = () => { logout(); navigate('/'); };

  const toggleUserStatus = (id) => {
    setUsers(prev => prev.map(u =>
      u.id === id ? { ...u, status: u.status === 'active' ? 'suspended' : 'active' } : u
    ));
  };

  // RBAC: Admin (superuser) — delete any user record (student or faculty)
  const deleteUser = (id) => {
    if (!window.confirm('Delete this user record permanently?')) return;
    setUsers(prev => prev.filter(u => u.id !== id));
  };

  // ── Dashboard Analytics (computed from real localStorage data) ──
  const allStudentsForStats = getAllStudents();
  const facultyApps = (() => {
    try {
      const raw = localStorage.getItem('pt_faculty_applications');
      return raw ? JSON.parse(raw) : [];
    } catch { return []; }
  })();

  const totalStudents = liveStats?.total_students ?? allStudentsForStats.length;
  const totalFaculty = liveStats?.total_faculty ?? facultyApps.length;
  const totalDepartments = liveStats?.total_departments ?? new Set(facultyApps.map(f => f.department).filter(Boolean)).size;
  const totalCourses = liveStats?.total_courses ?? new Set(allStudentsForStats.map(s => s.courseCode).filter(Boolean)).size;
  const hostelStudents = liveStats?.total_hostel_residents ?? allStudentsForStats.filter(s => s.hostelRequired).length;
  const totalFeeCollected = liveStats?.total_fee_collected ?? allStudentsForStats.reduce((sum, s) => sum + (Number(s.paidFee) || 0), 0);
  const totalFeePending = liveStats?.pending_fees ?? allStudentsForStats.reduce((sum, s) => sum + (Number(s.pendingFee) || 0), 0);
  const admissionsThisYear = allStudentsForStats.filter(s => String(s.admissionYear) === String(new Date().getFullYear())).length;
  const recentRegistrations = liveStats?.recent_registrations || [];
  const recentActivities = liveStats?.recent_activities || [];

  // Overall attendance % across all students with any recorded attendance
  const attSummaries = allStudentsForStats.map(s => getStudentAttendanceSummary(s.id)).filter(s => s.total > 0);
  const overallAttendancePct = attSummaries.length > 0
    ? Math.round(attSummaries.reduce((sum, s) => sum + s.pct, 0) / attSummaries.length)
    : 0;

  const formatCurrency = (n) => `₹${Number(n).toLocaleString('en-IN')}`;

  const statusColor = (s) => ({
    active: { color: '#16a34a', bg: '#f0fdf4' },
    suspended: { color: '#dc2626', bg: '#fff1f2' },
    pending: { color: '#d97706', bg: '#fffbeb' },
  }[s] || { color: '#6b7280', bg: '#f9fafb' });

  return (
    <div className="admin-panel-root" style={{ minHeight: '100vh', background: '#f8fafc', fontFamily: 'Inter, sans-serif' }}>
      {/* ── Top Bar ── */}
      <header style={{
        background: 'white', borderBottom: '1px solid #e5e7eb',
        padding: '0 24px', height: 64, display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', position: 'sticky', top: 0, zIndex: 100,
        boxShadow: '0 1px 4px rgba(0,0,0,0.06)',
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <button
            className="admin-sidebar-toggle"
            onClick={() => setMobileNavOpen(o => !o)}
            aria-label="Toggle admin navigation"
            style={{ background: '#f3f4f6', border: 'none', borderRadius: 8, padding: 8, cursor: 'pointer', color: '#374151' }}
          >
            <Menu size={18} />
          </button>
          <div style={{ width: 36, height: 36, background: 'linear-gradient(135deg,#dc2626,#b91c1c)', borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <GraduationCap size={20} color="white" />
          </div>
          <div className="admin-topbar-brand-text">
            <div style={{ fontWeight: 700, fontSize: 16, color: '#111827' }}>PrimeTech College</div>
            <div style={{ fontSize: 11, color: '#6b7280' }}>Admin Dashboard</div>
          </div>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '6px 12px', background: '#fff1f2', borderRadius: 20, border: '1px solid #fecdd3' }}>
            <Shield size={14} color="#dc2626" />
            <span style={{ fontSize: 12, fontWeight: 600, color: '#dc2626' }}>Admin</span>
          </div>
          <img
            src={user?.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}`}
            alt={user?.name}
            style={{ width: 36, height: 36, borderRadius: '50%', objectFit: 'cover', border: '2px solid #fecdd3' }}
          />
          <span className="admin-topbar-username" style={{ fontSize: 14, fontWeight: 500, color: '#374151' }}>{user?.name}</span>
          <button
            onClick={handleLogout}
            style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '6px 14px', background: '#f3f4f6', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, color: '#374151', fontWeight: 500 }}
          >
            <LogOut size={14} /> Sign Out
          </button>
        </div>
      </header>

      <div className="admin-shell" style={{ display: 'flex', maxWidth: 1280, margin: '0 auto', padding: '24px 24px 40px' }}>
        {/* ── Sidebar ── */}
        <aside className={`admin-sidebar${mobileNavOpen ? ' admin-sidebar-open' : ''}`} style={{ width: 200, flexShrink: 0, marginRight: 24 }}>
          {[
            { key: 'overview',   label: 'Overview',        icon: BarChart2 },
            { key: 'students',   label: 'Students',         icon: GraduationCap },
            { key: 'users',      label: 'Users',            icon: Users },
            { key: 'faculty',    label: 'Faculty',          icon: BookOpen },
            { key: 'attendance', label: 'Faculty Attendance', icon: CalendarDays },
            { key: 'results',    label: 'Results Mgmt',     icon: Award },
            { key: 'timetable',  label: 'Timetable Mgmt',   icon: CalendarDays },
            { key: 'hostel',     label: 'Hostel Mgmt',      icon: GraduationCap },
            { key: 'fees',       label: 'Fee Structure Management', icon: TrendingUp },
            { key: 'receipts',   label: 'Fee Receipts',     icon: FileText },
            { key: 'admissions', label: 'Admissions',       icon: GraduationCap },
            { key: 'inquiries',  label: 'Apply Now Inquiries', icon: Bell },
            { key: 'student-admission-link', label: 'Student Admission', icon: GraduationCap, href: '/admission' },
            { key: 'faculty-registration-link', label: 'Faculty Registration', icon: BookOpen, href: '/faculty-register' },
            { key: 'actions',    label: 'Pending Actions',  icon: Bell },
            { key: 'settings',   label: 'Settings',         icon: Settings },
          ].map(({ key, label, icon: Icon, href }) => (
            <button
              key={key}
              onClick={() => { href ? navigate(href) : setActiveTab(key); setMobileNavOpen(false); }}
              style={{
                width: '100%', display: 'flex', alignItems: 'center', gap: 10,
                padding: '10px 14px', borderRadius: 10, border: 'none', cursor: 'pointer',
                background: activeTab === key ? '#fff1f2' : 'transparent',
                color: activeTab === key ? '#dc2626' : '#6b7280',
                fontWeight: activeTab === key ? 600 : 400, fontSize: 14, marginBottom: 4,
                transition: 'all 0.15s',
              }}
            >
              <Icon size={16} /> {label}
            </button>
          ))}
        </aside>

        {/* ── Main Content ── */}
        <main style={{ flex: 1, minWidth: 0 }}>
          <div style={{ marginBottom: 24 }}>
            <h1 style={{ fontSize: 22, fontWeight: 700, color: '#111827', margin: 0 }}>
              {activeTab === 'overview'   && '📊 Platform Overview'}
              {activeTab === 'students'   && '🎓 Student Management'}
              {activeTab === 'users'      && '👥 User Management'}
              {activeTab === 'faculty'    && '🎓 Faculty Management'}
              {activeTab === 'attendance' && '🕒 Faculty Attendance Management'}
              {activeTab === 'results'    && '🏅 Student Results Management'}
              {activeTab === 'timetable'  && '🗓️ Timetable Management'}
              {activeTab === 'hostel'     && '🏠 Hostel Management'}
                            {activeTab === 'fees'       && '💰 Fee Structure Management'}
              {activeTab === 'receipts'   && '🧾 Fee Receipt Management'}
              {activeTab === 'admissions' && '🎓 Admissions & Payments'}
              {activeTab === 'inquiries' && '📨 Apply Now Inquiries'}
              {activeTab === 'actions'    && '🔔 Pending Actions'}
              {activeTab === 'settings'   && '⚙️ Settings'}
            </h1>
            <p style={{ color: '#6b7280', fontSize: 14, margin: '4px 0 0' }}>
              Welcome back, {user?.name?.split(' ')[0]}. Here's what needs your attention.
            </p>
          </div>

          {/* Overview Tab */}
          {activeTab === 'overview' && (
            <>
              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 16, marginBottom: 16 }}>
                {[
                  { label: 'Total Students', value: totalStudents.toLocaleString('en-IN'), icon: Users, color: '#2563eb', bg: '#eff6ff', change: `${admissionsThisYear} admitted this year` },
                  { label: 'Total Faculty', value: totalFaculty.toLocaleString('en-IN'), icon: Briefcase, color: '#7c3aed', bg: '#f5f3ff', change: `${facultyApps.filter(f => f.status === 'Pending').length} pending approval` },
                  { label: 'Total Departments', value: totalDepartments, icon: BookOpen, color: '#16a34a', bg: '#f0fdf4', change: 'Across all faculties' },
                  { label: 'Total Courses', value: totalCourses, icon: GraduationCap, color: '#d97706', bg: '#fff7ed', change: 'Active programs' },
                ].map(({ label, value, icon: Icon, color, bg, change }) => (
                  <div key={label} style={{ background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
                      <span style={{ fontSize: 13, color: '#6b7280', fontWeight: 500 }}>{label}</span>
                      <div style={{ width: 36, height: 36, background: bg, borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <Icon size={18} color={color} />
                      </div>
                    </div>
                    <div style={{ fontSize: 28, fontWeight: 800, color: '#111827' }}>{value}</div>
                    <div style={{ fontSize: 12, color: '#9ca3af', marginTop: 4 }}>{change}</div>
                  </div>
                ))}
              </div>

              <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 16, marginBottom: 24 }}>
                {[
                  { label: 'Hostel Students', value: hostelStudents, icon: GraduationCap, color: '#0891b2', bg: '#ecfeff', change: `of ${totalStudents} total students` },
                  { label: 'Overall Attendance', value: `${overallAttendancePct}%`, icon: Percent, color: '#16a34a', bg: '#f0fdf4', change: `${attSummaries.length} students tracked` },
                  { label: 'Fee Collected', value: formatCurrency(totalFeeCollected), icon: TrendingUp, color: '#2563eb', bg: '#eff6ff', change: `Pending: ${formatCurrency(totalFeePending)}` },
                  { label: 'Admissions (This Year)', value: admissionsThisYear, icon: CalendarDays, color: '#7c3aed', bg: '#f5f3ff', change: `${new Date().getFullYear()} academic year` },
                ].map(({ label, value, icon: Icon, color, bg, change }) => (
                  <div key={label} style={{ background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', boxShadow: '0 1px 4px rgba(0,0,0,0.04)' }}>
                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
                      <span style={{ fontSize: 13, color: '#6b7280', fontWeight: 500 }}>{label}</span>
                      <div style={{ width: 36, height: 36, background: bg, borderRadius: 10, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                        <Icon size={18} color={color} />
                      </div>
                    </div>
                    <div style={{ fontSize: 28, fontWeight: 800, color: '#111827' }}>{value}</div>
                    <div style={{ fontSize: 12, color: '#9ca3af', marginTop: 4 }}>{change}</div>
                  </div>
                ))}
              </div>

              {/* Quick Actions */}
              <div style={{ background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', marginBottom: 20 }}>
                <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', marginBottom: 16 }}>Quick Actions</h2>
                <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap' }}>
                  {[
                    { label: 'Add User', icon: PlusCircle, color: '#2563eb' },
                    { label: 'Create Event', icon: CalendarDays, color: '#16a34a' },
                    { label: 'Send Announcement', icon: Bell, color: '#7c3aed' },
                    { label: 'View Reports', icon: AlertTriangle, color: '#dc2626' },
                  ].map(({ label, icon: Icon, color }) => (
                    <button key={label} style={{
                      display: 'flex', alignItems: 'center', gap: 8, padding: '10px 18px',
                      background: `${color}11`, border: `1px solid ${color}33`, borderRadius: 10,
                      color, fontWeight: 600, fontSize: 13, cursor: 'pointer',
                    }}>
                      <Icon size={15} /> {label}
                    </button>
                  ))}
                </div>
              </div>

              {/* Recent Registrations & Recent Activities (live from DB) */}
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16 }}>
                <div style={{ background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb' }}>
                  <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', marginBottom: 16 }}>Recent Registrations</h2>
                  {liveStatsError ? (
                    <div style={{ fontSize: 13, color: '#9ca3af' }}>Live data unavailable.</div>
                  ) : recentRegistrations.length === 0 ? (
                    <div style={{ fontSize: 13, color: '#9ca3af' }}>No registrations yet.</div>
                  ) : recentRegistrations.map((r, i) => (
                    <div key={r.id} style={{ display: 'flex', alignItems: 'center', gap: 12, padding: '10px 0', borderBottom: i < recentRegistrations.length - 1 ? '1px solid #f3f4f6' : 'none' }}>
                      <div style={{ width: 32, height: 32, borderRadius: '50%', background: '#eff6ff', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 700, color: '#2563eb', fontSize: 13, flexShrink: 0 }}>
                        {(r.name || '?')[0]}
                      </div>
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ fontSize: 13, fontWeight: 600, color: '#111827' }}>{r.name}</div>
                        <div style={{ fontSize: 11, color: '#9ca3af' }}>{r.course_name || '—'} · Sem {r.semester} · {r.gr_number}</div>
                      </div>
                      <span style={{
                        padding: '2px 8px', borderRadius: 20, fontSize: 11, fontWeight: 700, textTransform: 'capitalize',
                        background: r.status === 'active' ? '#f0fdf4' : '#fff1f2',
                        color: r.status === 'active' ? '#16a34a' : '#dc2626',
                      }}>{r.status}</span>
                    </div>
                  ))}
                </div>

                <div style={{ background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb' }}>
                  <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', marginBottom: 16 }}>Recent Activities</h2>
                  {liveStatsError ? (
                    <div style={{ fontSize: 13, color: '#9ca3af' }}>Live data unavailable.</div>
                  ) : recentActivities.length === 0 ? (
                    <div style={{ fontSize: 13, color: '#9ca3af' }}>No admin activity recorded yet.</div>
                  ) : recentActivities.map((a, i) => (
                    <div key={a.id} style={{ display: 'flex', alignItems: 'flex-start', gap: 12, padding: '10px 0', borderBottom: i < recentActivities.length - 1 ? '1px solid #f3f4f6' : 'none' }}>
                      <div style={{ width: 8, height: 8, borderRadius: '50%', background: '#dc2626', flexShrink: 0, marginTop: 5 }} />
                      <div style={{ flex: 1, minWidth: 0 }}>
                        <div style={{ fontSize: 13, color: '#374151' }}>{a.details || a.action}</div>
                        <div style={{ fontSize: 11, color: '#9ca3af', marginTop: 2 }}>
                          {a.admin_name ? `by ${a.admin_name} · ` : ''}{new Date(a.created_at).toLocaleString('en-IN')}
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

            </>
          )}

          {/* Students Tab — Admin superuser, full CRUD over ALL students */}
          {activeTab === 'students' && (
            <StudentManagementPanel />
          )}

          {/* Faculty Attendance Management Tab — Punch In/Out tracking, filters, edit, export */}
          {activeTab === 'attendance' && (
            <AttendanceManagementPanel />
          )}

          {/* Student Results Management Tab — SGPA/CGPA, subject-wise marks, bulk upload */}
          {activeTab === 'results' && (
            <ResultsManagementPanel />
          )}
          {activeTab === 'timetable' && (
            <TimetableManagementPanel />
          )}

          {/* Fee Management Tab — College Fees, Global Settings, Hostel Fee Plans */}
          {activeTab === 'fees' && (
            <FeeManagementPanel />
          )}

          {/* Fee Receipt Management Tab — View, search, filter & download receipts */}
          {activeTab === 'receipts' && (
            <FeeReceiptsPanel />
          )}

          {/* Users Tab */}
          {activeTab === 'users' && (
            <div style={{ background: 'white', borderRadius: 16, border: '1px solid #e5e7eb', overflow: 'hidden' }}>
              <div style={{ padding: '16px 20px', borderBottom: '1px solid #e5e7eb', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
                <h2 style={{ margin: 0, fontSize: 16, fontWeight: 600, color: '#111827' }}>Recent Users</h2>
                <button style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '8px 16px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
                  <PlusCircle size={14} /> Add User
                </button>
              </div>
              <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                <thead>
                  <tr style={{ background: '#f9fafb' }}>
                    {['Name', 'Email', 'Role', 'Status', 'Joined', 'Actions'].map(h => (
                      <th key={h} style={{ padding: '10px 16px', textAlign: 'left', fontSize: 12, fontWeight: 600, color: '#6b7280', borderBottom: '1px solid #e5e7eb' }}>{h}</th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {users.map(u => {
                    const sc = statusColor(u.status);
                    return (
                      <tr key={u.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                        <td style={{ padding: '12px 16px', fontSize: 14, fontWeight: 500, color: '#111827' }}>{u.name}</td>
                        <td style={{ padding: '12px 16px', fontSize: 13, color: '#6b7280' }}>{u.email}</td>
                        <td style={{ padding: '12px 16px' }}>
                          <span style={{ fontSize: 12, padding: '3px 8px', borderRadius: 20, background: u.role === 'faculty' ? '#f5f3ff' : '#eff6ff', color: u.role === 'faculty' ? '#7c3aed' : '#2563eb', fontWeight: 600, textTransform: 'capitalize' }}>{u.role}</span>
                        </td>
                        <td style={{ padding: '12px 16px' }}>
                          <span style={{ fontSize: 12, padding: '3px 8px', borderRadius: 20, background: sc.bg, color: sc.color, fontWeight: 600, textTransform: 'capitalize' }}>{u.status}</span>
                        </td>
                        <td style={{ padding: '12px 16px', fontSize: 13, color: '#9ca3af' }}>{u.joined}</td>
                        <td style={{ padding: '12px 16px' }}>
                          <div style={{ display: 'flex', gap: 8 }}>
                            <button title="View" style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Eye size={13} color="#6b7280" /></button>
                            <button title="Edit" style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Edit2 size={13} color="#2563eb" /></button>
                            <button title={u.status === 'active' ? 'Suspend' : 'Activate'} onClick={() => toggleUserStatus(u.id)} style={{ padding: 6, background: u.status === 'active' ? '#fff1f2' : '#f0fdf4', border: 'none', borderRadius: 6, cursor: 'pointer' }}>
                              {u.status === 'active' ? <UserX size={13} color="#dc2626" /> : <UserCheck size={13} color="#16a34a" />}
                            </button>
                            <button title="Delete" onClick={() => deleteUser(u.id)} style={{ padding: 6, background: '#fff1f2', border: 'none', borderRadius: 6, cursor: 'pointer' }}>
                              <Trash2 size={13} color="#dc2626" />
                            </button>
                          </div>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}

          {/* Pending Actions Tab */}
          {activeTab === 'actions' && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              {PENDING_ACTIONS.map(action => (
                <div key={action.id} style={{
                  background: 'white', borderRadius: 14, padding: 20,
                  border: `1px solid ${action.urgent ? '#fecdd3' : '#e5e7eb'}`,
                  borderLeft: `4px solid ${action.urgent ? '#dc2626' : '#e5e7eb'}`,
                  boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
                }}>
                  <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between' }}>
                    <div>
                      <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                        {action.urgent && <span style={{ fontSize: 11, padding: '2px 8px', background: '#fff1f2', color: '#dc2626', borderRadius: 20, fontWeight: 700 }}>URGENT</span>}
                        <h3 style={{ margin: 0, fontSize: 15, fontWeight: 600, color: '#111827' }}>{action.title}</h3>
                      </div>
                      <p style={{ margin: 0, fontSize: 13, color: '#6b7280' }}>{action.desc}</p>
                      <span style={{ fontSize: 12, color: '#9ca3af', marginTop: 4, display: 'block' }}>
                        <Clock size={11} style={{ display: 'inline', marginRight: 4 }} />{action.time}
                      </span>
                    </div>
                    <div style={{ display: 'flex', gap: 8, flexShrink: 0, marginLeft: 16 }}>
                      <button style={{ padding: '7px 14px', background: '#f0fdf4', color: '#16a34a', border: '1px solid #bbf7d0', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600, display: 'flex', alignItems: 'center', gap: 6 }}>
                        <CheckCircle size={13} /> Approve
                      </button>
                      <button style={{ padding: '7px 14px', background: '#fff1f2', color: '#dc2626', border: '1px solid #fecdd3', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600, display: 'flex', alignItems: 'center', gap: 6 }}>
                        <Trash2 size={13} /> Dismiss
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* Admissions Tab */}
          {activeTab === 'admissions' && (
            <div>
              {/* Stats row */}
              <div style={{ display:'grid', gridTemplateColumns:'repeat(3,1fr)', gap:16, marginBottom:24 }}>
                {[
                  { label:'Total Admissions', value:'156', color:'#2563eb', bg:'#eff6ff', icon:'🎓' },
                  { label:'Payments Received', value:'₹1.24 Cr', color:'#16a34a', bg:'#f0fdf4', icon:'💰' },
                  { label:'Pending Payments', value:'12', color:'#d97706', bg:'#fffbeb', icon:'⏳' },
                ].map((s,i)=>(
                  <div key={i} style={{ background:'white', borderRadius:14, padding:'18px 20px', border:'1px solid #e5e7eb', boxShadow:'0 2px 8px rgba(0,0,0,0.04)' }}>
                    <div style={{ fontSize:24, marginBottom:6 }}>{s.icon}</div>
                    <div style={{ fontSize:22, fontWeight:700, color:s.color }}>{s.value}</div>
                    <div style={{ fontSize:13, color:'#6b7280', marginTop:2 }}>{s.label}</div>
                  </div>
                ))}
              </div>

              {/* Recent admissions table */}
              <div style={{ background:'white', borderRadius:14, border:'1px solid #e5e7eb', overflow:'hidden' }}>
                <div style={{ padding:'16px 20px', borderBottom:'1px solid #f3f4f6', display:'flex', justifyContent:'space-between', alignItems:'center' }}>
                  <h3 style={{ margin:0, fontSize:15, fontWeight:700, color:'#111827' }}>Recent Admissions</h3>
                  <button style={{ padding:'7px 16px', background:'#eff6ff', color:'#2563eb', border:'1px solid #bfdbfe', borderRadius:8, fontSize:13, fontWeight:600, cursor:'pointer' }}>
                    Export CSV
                  </button>
                </div>
                <div style={{ overflowX:'auto' }}>
                  <table style={{ width:'100%', borderCollapse:'collapse', fontSize:13 }}>
                    <thead>
                      <tr style={{ background:'#f9fafb' }}>
                        {['GR Number','Student Name','Course','Semester','Amount','Status','Date'].map(h=>(
                          <th key={h} style={{ padding:'10px 14px', textAlign:'left', fontWeight:600, color:'#374151', whiteSpace:'nowrap' }}>{h}</th>
                        ))}
                      </tr>
                    </thead>
                    <tbody>
                      {[
                        { gr:'PT2026BTCE0001', name:'Rahul Patel',    course:'B.Tech Computer Engineering', sem:1, amount:'₹77,500', status:'Paid',    date:'Jun 07' },
                        { gr:'PT2026BCA0001',  name:'Priya Shah',     course:'BCA',                         sem:3, amount:'₹46,500', status:'Paid',    date:'Jun 07' },
                        { gr:'PT2026MBA0001',  name:'Amit Desai',     course:'MBA',                         sem:1, amount:'₹67,500', status:'Paid',    date:'Jun 06' },
                        { gr:'PT2026BTIT0001', name:'Sneha Mehta',    course:'B.Tech IT',                   sem:5, amount:'₹84,500', status:'Pending', date:'Jun 06' },
                        { gr:'PT2026MSCDS001', name:'Kavya Nair',     course:'M.Sc Data Science',           sem:1, amount:'₹62,500', status:'Paid',    date:'Jun 05' },
                        { gr:'PT2026BCOM001',  name:'Rohan Kumar',    course:'B.Com',                       sem:2, amount:'₹30,500', status:'Failed',  date:'Jun 05' },
                      ].map((row,i)=>(
                        <tr key={i} style={{ borderBottom:'1px solid #f3f4f6' }}>
                          <td style={{ padding:'11px 14px', fontFamily:'monospace', fontWeight:600, color:'#1f2937', fontSize:12 }}>{row.gr}</td>
                          <td style={{ padding:'11px 14px', fontWeight:500 }}>{row.name}</td>
                          <td style={{ padding:'11px 14px', color:'#374151', maxWidth:180 }}>{row.course}</td>
                          <td style={{ padding:'11px 14px', textAlign:'center' }}>Sem {row.sem}</td>
                          <td style={{ padding:'11px 14px', fontWeight:700, color:'#111827' }}>{row.amount}</td>
                          <td style={{ padding:'11px 14px' }}>
                            <span style={{
                              padding:'3px 10px', borderRadius:20, fontSize:11, fontWeight:700,
                              background: row.status==='Paid'?'#f0fdf4':row.status==='Pending'?'#fffbeb':'#fff1f2',
                              color: row.status==='Paid'?'#16a34a':row.status==='Pending'?'#d97706':'#dc2626',
                            }}>{row.status}</span>
                          </td>
                          <td style={{ padding:'11px 14px', color:'#6b7280' }}>{row.date}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>

              {/* Fee structure quick reference */}
              <div style={{ marginTop:24, background:'white', borderRadius:14, border:'1px solid #e5e7eb', padding:20 }}>
                <h3 style={{ margin:'0 0 16px', fontSize:15, fontWeight:700, color:'#111827' }}>📋 Fee Structure Reference</h3>
                <div style={{ display:'grid', gridTemplateColumns:'repeat(auto-fill,minmax(220px,1fr))', gap:10 }}>
                  {feeRef.map((f,i)=>(
                    <div key={i} style={{ background:'#f9fafb', borderRadius:10, padding:'12px 14px', border:'1px solid #e5e7eb' }}>
                      <div style={{ fontWeight:700, fontSize:13, color:'#1f2937', marginBottom:6 }}>{f.course}</div>
                      <div style={{ display:'flex', justifyContent:'space-between', fontSize:12, color:'#6b7280' }}>
                        <span>Sem 1: <strong style={{color:'#2563eb'}}>{f.sem1}</strong></span>
                        <span>Last: <strong style={{color:'#7c3aed'}}>{f.semLast}</strong></span>
                      </div>
                    </div>
                  ))}
                </div>
                <p style={{ margin:'12px 0 0', fontSize:12, color:'#6b7280' }}>
                  + Exam fee ₹2,500/semester applicable on all courses. One-time admission fees apply separately.
                </p>
              </div>
            </div>
          )}

          {/* Apply Now Inquiries Tab — public inquiries, not registrations */}
          {activeTab === 'inquiries' && (
            <InquiriesPanel />
          )}

          {/* Faculty Tab */}
          {activeTab === 'faculty' && (
            <FacultyManagementPanel />
          )}

          {/* Hostel Tab */}
          {activeTab === 'hostel' && (
            <HostelManagementPanel />
          )}

          {/* Settings Tab */}
          {activeTab === 'settings' && (
            <div style={{ background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb' }}>
              <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', marginBottom: 20 }}>Platform Settings</h2>
              {[
                { label: 'Allow new student registrations', enabled: true },
                { label: 'Require admin approval for new clubs', enabled: true },
                { label: 'Require admin approval for events', enabled: false },
                { label: 'Enable campus chat feature', enabled: true },
                { label: 'Enable study group creation', enabled: true },
                { label: 'Email notifications for reports', enabled: true },
              ].map((s, i) => (
                <div key={i} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '14px 0', borderBottom: i < 5 ? '1px solid #f3f4f6' : 'none' }}>
                  <span style={{ fontSize: 14, color: '#374151' }}>{s.label}</span>
                  <div style={{ width: 44, height: 24, background: s.enabled ? '#dc2626' : '#d1d5db', borderRadius: 12, cursor: 'pointer', position: 'relative', transition: 'background 0.2s' }}>
                    <div style={{ width: 18, height: 18, background: 'white', borderRadius: '50%', position: 'absolute', top: 3, left: s.enabled ? 23 : 3, transition: 'left 0.2s', boxShadow: '0 1px 3px rgba(0,0,0,0.2)' }} />
                  </div>
                </div>
              ))}
            </div>
          )}
        </main>
      </div>
    </div>
  );
}