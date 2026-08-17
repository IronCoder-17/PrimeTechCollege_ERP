// ============================================================
// RecordsManagementPanel — Admin: Student & Faculty Records (DB)
//
// Full CRUD over real admitted students (`students` table) and
// registered faculty (`faculty` table) via the Admin API.
// Supports: edit profile (name, email, mobile, address, department/
// course, semester, enrollment number, hostel details, fee status,
// profile photo for students; name, email, mobile, department,
// designation, qualification, salary, profile photo for faculty),
// activate/deactivate, password reset, and delete.
//
// All changes are persisted to the database and immediately
// reflected in the corresponding student/faculty dashboards.
// ============================================================

import React, { useEffect, useState } from 'react';
import {
  Edit2, Trash2, UserCheck, UserX, KeyRound, X, Loader,
  AlertTriangle, CheckCircle, Search,
} from 'lucide-react';
import { adminApi, admissionApi } from '../../utils/api';

const card = { background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb', marginBottom: 16 };
const inputStyle = { width: '100%', padding: '8px 11px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };
const iconBtn = (bg) => ({ padding: 6, background: bg, border: 'none', borderRadius: 6, cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center' });
const fmt = (n) => `₹${Number(n || 0).toLocaleString('en-IN')}`;

function Toast({ toast }) {
  if (!toast) return null;
  const isError = toast.type === 'error';
  return (
    <div style={{
      position: 'fixed', top: 20, right: 20, zIndex: 2000,
      display: 'flex', alignItems: 'center', gap: 8,
      padding: '12px 18px', borderRadius: 10,
      background: isError ? '#fff1f2' : '#f0fdf4',
      border: `1px solid ${isError ? '#fecdd3' : '#bbf7d0'}`,
      color: isError ? '#dc2626' : '#16a34a', fontSize: 13, fontWeight: 600,
      boxShadow: '0 4px 16px rgba(0,0,0,0.08)',
    }}>
      {isError ? <AlertTriangle size={15} /> : <CheckCircle size={15} />}
      {toast.message}
    </div>
  );
}

function LoadingCard({ text }) {
  return (
    <div style={{ ...card, textAlign: 'center', padding: 48, color: '#9ca3af', fontSize: 14 }}>
      <Loader size={24} style={{ marginBottom: 10 }} />
      <div>{text}</div>
    </div>
  );
}

function ErrorCard({ text, onRetry }) {
  return (
    <div style={{ ...card, textAlign: 'center', padding: 48 }}>
      <AlertTriangle size={28} color="#dc2626" style={{ marginBottom: 10 }} />
      <div style={{ color: '#dc2626', fontSize: 14, fontWeight: 600, marginBottom: 12 }}>{text}</div>
      <button onClick={onRetry} style={{ padding: '8px 18px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
        Retry
      </button>
    </div>
  );
}

export default function RecordsManagementPanel({ type }) {
  return type === 'faculty' ? <FacultyRecords /> : <StudentRecords />;
}

// ============================================================
// STUDENT RECORDS
// ============================================================
function StudentRecords() {
  const [students, setStudents] = useState([]);
  const [courses, setCourses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [search, setSearch] = useState('');
  const [editing, setEditing] = useState(null); // full profile object
  const [toast, setToast] = useState(null);

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };

  const load = () => {
    setLoading(true);
    setError('');
    Promise.all([adminApi.getStudents(), admissionApi.getCourses().catch(() => ({ data: { courses: [] } }))])
      .then(([sRes, cRes]) => {
        setStudents(sRes.data.students || []);
        setCourses(cRes.data.courses || []);
      })
      .catch(err => setError(err?.response?.data?.error || `Failed to load students (HTTP ${err?.response?.status ?? 'network error'}). Check that the PHP server is running with PATH_INFO routing enabled (use router.php) and that schema_fix_missing_columns.sql has been applied.`))
      .finally(() => setLoading(false));
  };

  useEffect(() => { load(); }, []);

  const openEdit = async (s) => {
    try {
      const res = await adminApi.getStudent(s.id);
      setEditing(res.data);
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to load student profile.', 'error');
    }
  };

  const toggleStatus = async (s) => {
    const active = s.status !== 'active';
    try {
      await adminApi.setStudentStatus(s.id, active);
      showToast(`Student ${active ? 'activated' : 'deactivated'}.`);
      load();
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to update status.', 'error');
    }
  };

  const handleDelete = async (s) => {
    if (!window.confirm(`Permanently delete ${s.first_name} ${s.last_name}? This cannot be undone.`)) return;
    try {
      await adminApi.deleteStudent(s.id);
      showToast('Student deleted.');
      load();
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to delete student.', 'error');
    }
  };

  const handleResetPassword = async (s) => {
    if (!window.confirm(`Reset password for ${s.first_name} ${s.last_name}? A new temporary password will be generated.`)) return;
    try {
      const res = await adminApi.resetStudentPassword(s.id);
      if (res.data.new_password) {
        showToast(`Password reset. New password: ${res.data.new_password}`);
      } else {
        showToast('Password reset successfully.');
      }
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to reset password.', 'error');
    }
  };

  const filtered = students.filter(s => {
    if (!search) return true;
    const q = search.toLowerCase();
    return [`${s.first_name} ${s.last_name}`, s.email, s.gr_number, s.course_name]
      .filter(Boolean).some(v => v.toLowerCase().includes(q));
  });

  if (loading) return <LoadingCard text="Loading student records…" />;
  if (error) return <ErrorCard text={error} onRetry={load} />;

  return (
    <div>
      <Toast toast={toast} />

      <div style={card}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: 0 }}>Student Records ({students.length})</h2>
        </div>
        <div style={{ position: 'relative', marginBottom: 16 }}>
          <Search size={15} color="#9ca3af" style={{ position: 'absolute', left: 12, top: 11 }} />
          <input placeholder="Search by name, email, GR number, or course…" value={search}
            onChange={e => setSearch(e.target.value)} style={{ ...inputStyle, paddingLeft: 36 }} />
        </div>

        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 14 }}>
            {students.length === 0 ? 'No admitted students yet. Students who complete admission will appear here.' : 'No students match your search.'}
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
            <thead>
              <tr style={{ background: '#f9fafb' }}>
                {['GR Number', 'Name', 'Course', 'Semester', 'Email', 'Status', 'Actions'].map(h => (
                  <th key={h} style={{ padding: '9px 12px', textAlign: 'left', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #e5e7eb' }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filtered.map(s => (
                <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                  <td style={{ padding: '10px 12px', fontFamily: 'monospace', fontSize: 12, fontWeight: 600 }}>{s.gr_number || '—'}</td>
                  <td style={{ padding: '10px 12px', fontWeight: 600, color: '#111827' }}>
                    {s.profile_photo
                      ? <img src={s.profile_photo} alt="" style={{ width: 26, height: 26, borderRadius: '50%', objectFit: 'cover', marginRight: 8, verticalAlign: 'middle' }} />
                      : null}
                    {s.first_name} {s.middle_name} {s.last_name}
                  </td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>{s.course_name || '—'}</td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>Sem {s.semester}</td>
                  <td style={{ padding: '10px 12px', color: '#6b7280', fontSize: 12 }}>{s.email || s.login_email || '—'}</td>
                  <td style={{ padding: '10px 12px' }}>
                    <span style={{
                      padding: '3px 9px', borderRadius: 20, fontSize: 11, fontWeight: 700,
                      background: s.status === 'active' ? '#f0fdf4' : '#fff1f2',
                      color: s.status === 'active' ? '#16a34a' : '#dc2626',
                      textTransform: 'capitalize',
                    }}>{s.status}</span>
                  </td>
                  <td style={{ padding: '10px 12px' }}>
                    <div style={{ display: 'flex', gap: 6 }}>
                      <button title="Edit profile" onClick={() => openEdit(s)} style={iconBtn('#eff6ff')}><Edit2 size={13} color="#2563eb" /></button>
                      <button title={s.status === 'active' ? 'Deactivate' : 'Activate'} onClick={() => toggleStatus(s)} style={iconBtn(s.status === 'active' ? '#fff1f2' : '#f0fdf4')}>
                        {s.status === 'active' ? <UserX size={13} color="#dc2626" /> : <UserCheck size={13} color="#16a34a" />}
                      </button>
                      <button title="Reset password" onClick={() => handleResetPassword(s)} style={iconBtn('#fffbeb')}><KeyRound size={13} color="#d97706" /></button>
                      <button title="Delete" onClick={() => handleDelete(s)} style={iconBtn('#fff1f2')}><Trash2 size={13} color="#dc2626" /></button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {editing && (
        <StudentEditModal
          student={editing}
          courses={courses}
          onClose={() => setEditing(null)}
          onSaved={() => { setEditing(null); showToast('Student profile updated.'); load(); }}
          onError={(msg) => showToast(msg, 'error')}
        />
      )}
    </div>
  );
}

function StudentEditModal({ student, courses, onClose, onSaved, onError }) {
  const [form, setForm] = useState({
    first_name: student.first_name || '',
    middle_name: student.middle_name || '',
    last_name: student.last_name || '',
    email: student.email || '',
    phone: student.phone || '',
    address: student.address || '',
    course_id: student.course_id || '',
    semester: student.semester || 1,
    gr_number: student.gr_number || '',
    profile_photo: student.profile_photo || '',
    // hostel
    hostel_type: student.hostel?.hostel_type || '',
    room_type: student.hostel?.room_type || '',
    room_number: student.hostel?.room_number || '',
    allocation_status: student.hostel?.allocation_status || 'Pending',
    hostel_status: student.hostel?.status || 'Active',
    // fee
    record_payment: '',
  });
  const [saving, setSaving] = useState(false);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const handleSave = async () => {
    if (!form.first_name || !form.last_name) { onError('First and last name are required.'); return; }
    if (form.phone && !/^[0-9+\-\s]{7,15}$/.test(form.phone)) { onError('Invalid mobile number format.'); return; }

    setSaving(true);
    try {
      const payload = {
        first_name: form.first_name,
        middle_name: form.middle_name,
        last_name: form.last_name,
        email: form.email,
        phone: form.phone,
        address: form.address,
        course_id: Number(form.course_id),
        semester: Number(form.semester),
        gr_number: form.gr_number,
        profile_photo: form.profile_photo,
        hostel: {
          hostel_type: form.hostel_type || null,
          room_type: form.room_type || null,
          room_number: form.room_number || 'Pending Allocation',
          allocation_status: form.allocation_status,
          status: form.hostel_status,
        },
      };
      if (form.record_payment && Number(form.record_payment) > 0) {
        payload.fee_status = { record_payment: Number(form.record_payment) };
      }
      await adminApi.updateStudent(student.id, payload);
      onSaved();
    } catch (err) {
      onError(err?.response?.data?.error || 'Failed to save student profile.');
    } finally {
      setSaving(false);
    }
  };

  const selectedCourse = courses.find(c => c.id === Number(form.course_id));
  const semOptions = selectedCourse ? Array.from({ length: selectedCourse.total_semesters || 8 }, (_, i) => i + 1) : Array.from({ length: 8 }, (_, i) => i + 1);

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} onClick={onClose}>
      <div onClick={e => e.stopPropagation()} style={{ background: 'white', borderRadius: 16, padding: 24, width: 560, maxHeight: '88vh', overflowY: 'auto' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h2 style={{ fontSize: 16, fontWeight: 700, color: '#111827', margin: 0 }}>Edit Student Profile</h2>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer' }}><X size={18} color="#9ca3af" /></button>
        </div>

        <SectionLabel>Personal Details</SectionLabel>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="First Name"><input style={inputStyle} value={form.first_name} onChange={e => set('first_name', e.target.value)} /></Field>
          <Field label="Middle Name"><input style={inputStyle} value={form.middle_name} onChange={e => set('middle_name', e.target.value)} /></Field>
          <Field label="Last Name"><input style={inputStyle} value={form.last_name} onChange={e => set('last_name', e.target.value)} /></Field>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="Email"><input type="email" style={inputStyle} value={form.email} onChange={e => set('email', e.target.value)} /></Field>
          <Field label="Mobile Number"><input style={inputStyle} value={form.phone} onChange={e => set('phone', e.target.value)} /></Field>
        </div>
        <Field label="Address" style={{ marginBottom: 12 }}>
          <textarea style={{ ...inputStyle, minHeight: 60, resize: 'vertical' }} value={form.address} onChange={e => set('address', e.target.value)} />
        </Field>
        <Field label="Profile Photo URL" style={{ marginBottom: 12 }}>
          <input style={inputStyle} value={form.profile_photo} onChange={e => set('profile_photo', e.target.value)} placeholder="https://…" />
        </Field>

        <SectionLabel>Academic</SectionLabel>
        <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr 1fr', gap: 10, marginBottom: 16 }}>
          <Field label="Department / Course">
            <select style={inputStyle} value={form.course_id} onChange={e => set('course_id', e.target.value)}>
              {courses.map(c => <option key={c.id} value={c.id}>{c.course_name}</option>)}
            </select>
          </Field>
          <Field label="Semester">
            <select style={inputStyle} value={form.semester} onChange={e => set('semester', e.target.value)}>
              {semOptions.map(s => <option key={s} value={s}>Sem {s}</option>)}
            </select>
          </Field>
          <Field label="Enrollment / GR No.">
            <input style={inputStyle} value={form.gr_number} onChange={e => set('gr_number', e.target.value)} />
          </Field>
        </div>

        <SectionLabel>Hostel Details</SectionLabel>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="Hostel Type">
            <select style={inputStyle} value={form.hostel_type} onChange={e => set('hostel_type', e.target.value)}>
              <option value="">Not opted</option>
              <option value="Boys Hostel">Boys Hostel</option>
              <option value="Girls Hostel">Girls Hostel</option>
            </select>
          </Field>
          <Field label="Room Type">
            <select style={inputStyle} value={form.room_type} onChange={e => set('room_type', e.target.value)}>
              <option value="">—</option>
              <option value="Non-AC (3 Sharing)">Non-AC (3 Sharing)</option>
              <option value="Non-AC (2 Sharing)">Non-AC (2 Sharing)</option>
              <option value="AC (2 Sharing)">AC (2 Sharing)</option>
            </select>
          </Field>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 16 }}>
          <Field label="Room Number"><input style={inputStyle} value={form.room_number} onChange={e => set('room_number', e.target.value)} /></Field>
          <Field label="Allocation Status">
            <select style={inputStyle} value={form.allocation_status} onChange={e => set('allocation_status', e.target.value)}>
              <option value="Pending">Pending</option>
              <option value="Allocated">Allocated</option>
            </select>
          </Field>
          <Field label="Hostel Status">
            <select style={inputStyle} value={form.hostel_status} onChange={e => set('hostel_status', e.target.value)}>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
            </select>
          </Field>
        </div>

        <SectionLabel>Fee Status</SectionLabel>
        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '10px 12px', background: '#f9fafb', borderRadius: 8, marginBottom: 10, fontSize: 13 }}>
          <span>Expected: <b>{fmt(student.fee_status?.expected)}</b></span>
          <span>Paid: <b style={{ color: '#16a34a' }}>{fmt(student.fee_status?.paid)}</b></span>
          <span>Pending: <b style={{ color: student.fee_status?.pending > 0 ? '#dc2626' : '#16a34a' }}>{fmt(student.fee_status?.pending)}</b></span>
        </div>
        <Field label="Record a Payment (₹) — optional" style={{ marginBottom: 16 }}>
          <input type="number" min="0" style={inputStyle} value={form.record_payment} onChange={e => set('record_payment', e.target.value)} placeholder="e.g. 25000" />
        </Field>

        <div style={{ display: 'flex', gap: 8 }}>
          <button disabled={saving} onClick={handleSave} style={{ flex: 1, padding: '10px 0', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            {saving ? 'Saving…' : 'Save Changes'}
          </button>
          <button onClick={onClose} style={{ padding: '10px 20px', background: '#f3f4f6', color: '#374151', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            Cancel
          </button>
        </div>
      </div>
    </div>
  );
}

// ============================================================
// FACULTY RECORDS
// ============================================================
const DESIGNATIONS = ['Professor', 'Assistant Professor', 'Associate Professor', 'HOD', 'Lab Assistant', 'Lecturer', 'Visiting Faculty'];

function FacultyRecords() {
  const [faculty, setFaculty] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [search, setSearch] = useState('');
  const [editing, setEditing] = useState(null);
  const [toast, setToast] = useState(null);

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };

  const load = () => {
    setLoading(true);
    setError('');
    adminApi.getFacultyList()
      .then(res => setFaculty(res.data.faculty || []))
      .catch(err => setError(err?.response?.data?.error || `Failed to load faculty (HTTP ${err?.response?.status ?? 'network error'}). Check that the PHP server is running with PATH_INFO routing enabled (use router.php) and that schema_fix_missing_columns.sql has been applied.`))
      .finally(() => setLoading(false));
  };

  useEffect(() => { load(); }, []);

  const openEdit = async (f) => {
    try {
      const res = await adminApi.getFacultyMember(f.faculty_id);
      setEditing(res.data);
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to load faculty profile.', 'error');
    }
  };

  const toggleStatus = async (f) => {
    const active = f.status !== 'Active';
    try {
      await adminApi.setFacultyStatus(f.faculty_id, active);
      showToast(`Faculty ${active ? 'activated' : 'deactivated'}.`);
      load();
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to update status.', 'error');
    }
  };

  const handleDelete = async (f) => {
    if (!window.confirm(`Permanently delete ${f.first_name} ${f.last_name}? This cannot be undone.`)) return;
    try {
      await adminApi.deleteFaculty(f.faculty_id);
      showToast('Faculty member deleted.');
      load();
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to delete faculty member.', 'error');
    }
  };

  const handleResetPassword = async (f) => {
    if (!window.confirm(`Reset password for ${f.first_name} ${f.last_name}? A new temporary password will be generated.`)) return;
    try {
      const res = await adminApi.resetFacultyPassword(f.faculty_id);
      if (res.data.new_password) {
        showToast(`Password reset. New password: ${res.data.new_password}`);
      } else {
        showToast('Password reset successfully.');
      }
    } catch (err) {
      showToast(err?.response?.data?.error || 'Failed to reset password.', 'error');
    }
  };

  const filtered = faculty.filter(f => {
    if (!search) return true;
    const q = search.toLowerCase();
    return [`${f.first_name} ${f.last_name}`, f.email, f.employee_id, f.department, f.designation]
      .filter(Boolean).some(v => v.toLowerCase().includes(q));
  });

  if (loading) return <LoadingCard text="Loading faculty records…" />;
  if (error) return <ErrorCard text={error} onRetry={load} />;

  return (
    <div>
      <Toast toast={toast} />

      <div style={card}>
        <h2 style={{ fontSize: 16, fontWeight: 600, color: '#111827', margin: '0 0 16px' }}>Faculty Records ({faculty.length})</h2>
        <div style={{ position: 'relative', marginBottom: 16 }}>
          <Search size={15} color="#9ca3af" style={{ position: 'absolute', left: 12, top: 11 }} />
          <input placeholder="Search by name, email, employee ID, department, or designation…" value={search}
            onChange={e => setSearch(e.target.value)} style={{ ...inputStyle, paddingLeft: 36 }} />
        </div>

        {filtered.length === 0 ? (
          <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 14 }}>
            {faculty.length === 0 ? 'No registered faculty yet.' : 'No faculty match your search.'}
          </div>
        ) : (
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
            <thead>
              <tr style={{ background: '#f9fafb' }}>
                {['Employee ID', 'Name', 'Department', 'Designation', 'Email', 'Status', 'Actions'].map(h => (
                  <th key={h} style={{ padding: '9px 12px', textAlign: 'left', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: '0.04em', borderBottom: '1px solid #e5e7eb' }}>{h}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {filtered.map(f => (
                <tr key={f.faculty_id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                  <td style={{ padding: '10px 12px', fontFamily: 'monospace', fontSize: 12, fontWeight: 600 }}>{f.employee_id}</td>
                  <td style={{ padding: '10px 12px', fontWeight: 600, color: '#111827' }}>{f.first_name} {f.middle_name} {f.last_name}</td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>{f.department}</td>
                  <td style={{ padding: '10px 12px', color: '#374151' }}>{f.designation}</td>
                  <td style={{ padding: '10px 12px', color: '#6b7280', fontSize: 12 }}>{f.email}</td>
                  <td style={{ padding: '10px 12px' }}>
                    <span style={{
                      padding: '3px 9px', borderRadius: 20, fontSize: 11, fontWeight: 700,
                      background: f.status === 'Active' ? '#f0fdf4' : '#fff1f2',
                      color: f.status === 'Active' ? '#16a34a' : '#dc2626',
                    }}>{f.status}</span>
                  </td>
                  <td style={{ padding: '10px 12px' }}>
                    <div style={{ display: 'flex', gap: 6 }}>
                      <button title="Edit profile" onClick={() => openEdit(f)} style={iconBtn('#eff6ff')}><Edit2 size={13} color="#2563eb" /></button>
                      <button title={f.status === 'Active' ? 'Deactivate' : 'Activate'} onClick={() => toggleStatus(f)} style={iconBtn(f.status === 'Active' ? '#fff1f2' : '#f0fdf4')}>
                        {f.status === 'Active' ? <UserX size={13} color="#dc2626" /> : <UserCheck size={13} color="#16a34a" />}
                      </button>
                      <button title="Reset password" onClick={() => handleResetPassword(f)} style={iconBtn('#fffbeb')}><KeyRound size={13} color="#d97706" /></button>
                      <button title="Delete" onClick={() => handleDelete(f)} style={iconBtn('#fff1f2')}><Trash2 size={13} color="#dc2626" /></button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      {editing && (
        <FacultyEditModal
          faculty={editing}
          onClose={() => setEditing(null)}
          onSaved={() => { setEditing(null); showToast('Faculty profile updated.'); load(); }}
          onError={(msg) => showToast(msg, 'error')}
        />
      )}
    </div>
  );
}

function FacultyEditModal({ faculty, onClose, onSaved, onError }) {
  const [form, setForm] = useState({
    first_name: faculty.first_name || '',
    middle_name: faculty.middle_name || '',
    last_name: faculty.last_name || '',
    email: faculty.email || '',
    phone: faculty.phone || '',
    department: faculty.department || '',
    designation: faculty.designation || 'Assistant Professor',
    qualification: faculty.qualification || '',
    salary: faculty.salary ?? '',
    profile_photo: faculty.documents?.profile_photo || '',
  });
  const [saving, setSaving] = useState(false);

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const handleSave = async () => {
    if (!form.first_name || !form.last_name) { onError('First and last name are required.'); return; }
    if (form.phone && !/^[0-9+\-\s]{7,15}$/.test(form.phone)) { onError('Invalid mobile number format.'); return; }

    setSaving(true);
    try {
      const payload = {
        first_name: form.first_name,
        middle_name: form.middle_name,
        last_name: form.last_name,
        email: form.email,
        phone: form.phone,
        department: form.department,
        designation: form.designation,
        qualification: form.qualification,
        profile_photo: form.profile_photo,
        salary: form.salary === '' ? null : Number(form.salary),
      };
      await adminApi.updateFaculty(faculty.faculty_id, payload);
      onSaved();
    } catch (err) {
      onError(err?.response?.data?.error || 'Failed to save faculty profile.');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }} onClick={onClose}>
      <div onClick={e => e.stopPropagation()} style={{ background: 'white', borderRadius: 16, padding: 24, width: 520, maxHeight: '85vh', overflowY: 'auto' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h2 style={{ fontSize: 16, fontWeight: 700, color: '#111827', margin: 0 }}>Edit Faculty Profile</h2>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer' }}><X size={18} color="#9ca3af" /></button>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="First Name"><input style={inputStyle} value={form.first_name} onChange={e => set('first_name', e.target.value)} /></Field>
          <Field label="Middle Name"><input style={inputStyle} value={form.middle_name} onChange={e => set('middle_name', e.target.value)} /></Field>
          <Field label="Last Name"><input style={inputStyle} value={form.last_name} onChange={e => set('last_name', e.target.value)} /></Field>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="Email"><input type="email" style={inputStyle} value={form.email} onChange={e => set('email', e.target.value)} /></Field>
          <Field label="Mobile Number"><input style={inputStyle} value={form.phone} onChange={e => set('phone', e.target.value)} /></Field>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 12 }}>
          <Field label="Department"><input style={inputStyle} value={form.department} onChange={e => set('department', e.target.value)} /></Field>
          <Field label="Designation">
            <select style={inputStyle} value={form.designation} onChange={e => set('designation', e.target.value)}>
              {DESIGNATIONS.map(d => <option key={d} value={d}>{d}</option>)}
            </select>
          </Field>
        </div>
        <Field label="Qualification" style={{ marginBottom: 12 }}>
          <input style={inputStyle} value={form.qualification} onChange={e => set('qualification', e.target.value)} />
        </Field>
        <Field label="Profile Photo URL" style={{ marginBottom: 12 }}>
          <input style={inputStyle} value={form.profile_photo} onChange={e => set('profile_photo', e.target.value)} placeholder="https://…" />
        </Field>
        <Field label="Salary Details (₹ per month) — Admin only" style={{ marginBottom: 16 }}>
          <input type="number" min="0" style={inputStyle} value={form.salary} onChange={e => set('salary', e.target.value)} placeholder="e.g. 65000" />
        </Field>

        <div style={{ display: 'flex', gap: 8 }}>
          <button disabled={saving} onClick={handleSave} style={{ flex: 1, padding: '10px 0', background: '#dc2626', color: 'white', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            {saving ? 'Saving…' : 'Save Changes'}
          </button>
          <button onClick={onClose} style={{ padding: '10px 20px', background: '#f3f4f6', color: '#374151', border: 'none', borderRadius: 8, cursor: 'pointer', fontSize: 13, fontWeight: 600 }}>
            Cancel
          </button>
        </div>
      </div>
    </div>
  );
}

// ── Shared form components ──────────────────────────────────
function Field({ label, children, style }) {
  return (
    <div style={style}>
      <label style={labelStyle}>{label}</label>
      {children}
    </div>
  );
}

function SectionLabel({ children }) {
  return (
    <div style={{ fontSize: 12, fontWeight: 700, color: '#dc2626', textTransform: 'uppercase', letterSpacing: '0.05em', margin: '4px 0 10px' }}>
      {children}
    </div>
  );
}
