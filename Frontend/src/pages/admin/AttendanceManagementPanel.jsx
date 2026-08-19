// ============================================================
// AttendanceManagementPanel — Admin: Faculty Attendance Management
//
// - Dashboard: Total Faculty Present/Absent Today, Avg Working
//   Hours, Monthly Attendance Statistics.
// - Filter attendance records by date, month, faculty, or
//   department.
// - Edit attendance records (status, punch in/out, working hours).
// - Export filtered reports to CSV (Excel) and PDF (print).
//
// All data is read live from `faculty_attendance` /
// `faculty_punch_logs` via the Admin API — the same tables the
// Faculty "Punch In/Out" self-service dashboard uses, so edits made
// here are reflected immediately on both sides. No hardcoded values.
// ============================================================

import React, { useEffect, useState } from 'react';
import {
  Users, UserCheck, UserX, Clock, Percent, Calendar,
  Filter, Download, FileText, Edit2, X, Loader, AlertTriangle, CheckCircle,
} from 'lucide-react';
import { adminApi } from '../../utils/api';

const card = { background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', marginBottom: 16 };
const inputStyle = { padding: '8px 11px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };

const statusColor = (s) => ({
  Present: { bg: '#f0fdf4', color: '#16a34a' },
  Absent:  { bg: '#fff1f2', color: '#dc2626' },
  Leave:   { bg: '#fff7ed', color: '#d97706' },
}[s] || { bg: '#f3f4f6', color: '#6b7280' });

const fmtTime = (t) => {
  if (!t) return '-';
  const timePart = t.includes(' ') ? t.split(' ')[1] : t;
  const [hStr, mStr] = timePart.split(':');
  const hour = parseInt(hStr, 10);
  const ampm = hour >= 12 ? 'PM' : 'AM';
  const hour12 = hour % 12 === 0 ? 12 : hour % 12;
  return `${hour12}:${mStr} ${ampm}`;
};

const fmtHours = (h) => (h === null || h === undefined || h === '' ? '-' : `${h} hrs`);

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

function StatCard({ label, value, icon: Icon, color, bg, sub }) {
  return (
    <div style={{ ...card, marginBottom: 0 }}>
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

// ── Edit Modal ─────────────────────────────────────────────
function EditAttendanceModal({ record, onClose, onSaved, showToast }) {
  const [status, setStatus] = useState(record.status);
  const [punchIn, setPunchIn] = useState((record.punch_in_time || '').slice(0, 5));
  const [punchOut, setPunchOut] = useState((record.punch_out_time || '').slice(0, 5));
  const [saving, setSaving] = useState(false);

  const save = async () => {
    setSaving(true);
    try {
      const res = await adminApi.updateAttendance(record.id, {
        status,
        punch_in_time: punchIn || null,
        punch_out_time: punchOut || null,
      });
      showToast('Attendance record updated.');
      onSaved(res.data?.record);
      onClose();
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to update attendance.', 'error');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1500 }}>
      <div style={{ background: 'white', borderRadius: 14, padding: 24, width: 380, maxWidth: '90vw' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h3 style={{ margin: 0, fontSize: 15, fontWeight: 700, color: '#111827' }}>Edit Attendance — {record.faculty_name}</h3>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af' }}><X size={18} /></button>
        </div>
        <div style={{ fontSize: 12, color: '#6b7280', marginBottom: 14 }}>{record.date} · {record.department || '—'}</div>

        <div style={{ marginBottom: 12 }}>
          <label style={labelStyle}>Status</label>
          <select value={status} onChange={e => setStatus(e.target.value)} style={{ ...inputStyle, width: '100%' }}>
            <option value="Present">Present</option>
            <option value="Absent">Absent</option>
            <option value="Leave">Leave</option>
          </select>
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 12 }}>
          <div>
            <label style={labelStyle}>Punch In</label>
            <input type="time" value={punchIn} onChange={e => setPunchIn(e.target.value)} style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Punch Out</label>
            <input type="time" value={punchOut} onChange={e => setPunchOut(e.target.value)} style={{ ...inputStyle, width: '100%' }} />
          </div>
        </div>
        <div style={{ fontSize: 11, color: '#9ca3af', marginBottom: 16 }}>
          Working hours are recalculated automatically from punch in/out times.
        </div>

        <div style={{ display: 'flex', gap: 10, justifyContent: 'flex-end' }}>
          <button onClick={onClose} style={{ padding: '8px 16px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#374151' }}>Cancel</button>
          <button onClick={save} disabled={saving} style={{ padding: '8px 16px', borderRadius: 8, border: 'none', background: '#dc2626', color: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, opacity: saving ? 0.6 : 1 }}>
            {saving ? 'Saving…' : 'Save Changes'}
          </button>
        </div>
      </div>
    </div>
  );
}

// ── Printable PDF report (opens in a new window for print/save-as-PDF) ──
function openPrintableReport(records, filters) {
  const win = window.open('', '_blank');
  if (!win) return;

  const filterDesc = [
    filters.date && `Date: ${filters.date}`,
    filters.month && `Month: ${filters.month}`,
    filters.department && `Department: ${filters.department}`,
    filters.facultyName && `Faculty: ${filters.facultyName}`,
  ].filter(Boolean).join(' · ') || 'All Records';

  const rows = records.map(r => `
    <tr>
      <td>${r.employee_id}</td>
      <td>${r.faculty_name}</td>
      <td>${r.department || '-'}</td>
      <td>${r.date}</td>
      <td>${fmtTime(r.punch_in_time)}</td>
      <td>${fmtTime(r.punch_out_time)}</td>
      <td>${r.working_hours != null ? r.working_hours : '-'}</td>
      <td>${r.status}</td>
    </tr>`).join('');

  win.document.write(`
    <html>
      <head>
        <title>Faculty Attendance Report</title>
        <style>
          body { font-family: Arial, sans-serif; padding: 24px; color: #111827; }
          h1 { font-size: 18px; margin-bottom: 4px; }
          p { font-size: 12px; color: #6b7280; margin-top: 0; }
          table { width: 100%; border-collapse: collapse; margin-top: 16px; font-size: 12px; }
          th, td { border: 1px solid #e5e7eb; padding: 6px 8px; text-align: left; }
          th { background: #f8fafc; }
        </style>
      </head>
      <body>
        <h1>Faculty Attendance Report</h1>
        <p>${filterDesc} · Generated ${new Date().toLocaleString('en-IN')}</p>
        <table>
          <thead>
            <tr><th>Employee ID</th><th>Faculty</th><th>Department</th><th>Date</th><th>Punch In</th><th>Punch Out</th><th>Working Hours</th><th>Status</th></tr>
          </thead>
          <tbody>${rows || '<tr><td colspan="8" style="text-align:center;color:#9ca3af;">No records</td></tr>'}</tbody>
        </table>
        <script>window.onload = () => window.print();</script>
      </body>
    </html>
  `);
  win.document.close();
}

export default function AttendanceManagementPanel() {
  const [dashboard, setDashboard] = useState(null);
  const [records, setRecords] = useState([]);
  const [summary, setSummary] = useState({ total: 0, present: 0, absent: 0, leave: 0 });
  const [departments, setDepartments] = useState([]);
  const [facultyList, setFacultyList] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [toast, setToast] = useState(null);
  const [editing, setEditing] = useState(null);

  const [filters, setFilters] = useState({ date: '', month: '', faculty_id: '', department: '' });

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };

  const loadDashboard = async (month) => {
    try {
      const res = await adminApi.getAttendanceDashboard(month || undefined);
      setDashboard(res.data);
      setDepartments(res.data?.departments || []);
      setFacultyList(res.data?.faculty || []);
    } catch (e) {
      // dashboard is supplementary; list still works without it
    }
  };

  const loadRecords = async () => {
    setLoading(true);
    setError('');
    try {
      const params = {};
      if (filters.date) params.date = filters.date;
      if (filters.month) params.month = filters.month;
      if (filters.faculty_id) params.faculty_id = filters.faculty_id;
      if (filters.department) params.department = filters.department;

      const res = await adminApi.getAttendanceList(params);
      setRecords(res.data?.records || []);
      setSummary(res.data?.summary || { total: 0, present: 0, absent: 0, leave: 0 });
      if (res.data?.departments?.length) setDepartments(res.data.departments);
      if (res.data?.faculty?.length) setFacultyList(res.data.faculty);
    } catch (e) {
      setError('Could not load attendance records.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadDashboard();
    loadRecords();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const applyFilters = () => {
    loadRecords();
    if (filters.month) loadDashboard(filters.month);
  };

  const resetFilters = () => {
    setFilters({ date: '', month: '', faculty_id: '', department: '' });
    setTimeout(loadRecords, 0);
    loadDashboard();
  };

  const handleSaved = (updatedRecord) => {
    if (!updatedRecord) { loadRecords(); return; }
    setRecords(prev => prev.map(r => r.id === updatedRecord.id ? { ...r, ...updatedRecord } : r));
    loadDashboard(filters.month);
  };

  const facultyName = facultyList.find(f => String(f.faculty_id) === String(filters.faculty_id))?.name;

  return (
    <div>
      <Toast toast={toast} />
      {editing && (
        <EditAttendanceModal
          record={editing}
          onClose={() => setEditing(null)}
          onSaved={handleSaved}
          showToast={showToast}
        />
      )}

      {/* ── Dashboard Summary ── */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr)', gap: 16, marginBottom: 16 }}>
        <StatCard label="Total Faculty Present Today" value={dashboard?.present_today ?? '—'} icon={UserCheck} color="#16a34a" bg="#f0fdf4" sub={`of ${dashboard?.total_faculty ?? '—'} active faculty`} />
        <StatCard label="Total Faculty Absent Today" value={dashboard?.absent_today ?? '—'} icon={UserX} color="#dc2626" bg="#fff1f2" sub={`${dashboard?.on_leave_today ?? 0} on leave today`} />
        <StatCard label="Avg. Working Hours (Today)" value={dashboard?.avg_working_hours_today ?? '—'} icon={Clock} color="#2563eb" bg="#eff6ff" sub="hours per faculty" />
        <StatCard label="Avg. Working Hours (Month)" value={dashboard?.avg_working_hours_month ?? '—'} icon={Percent} color="#7c3aed" bg="#f5f3ff" sub={dashboard?.month} />
      </div>

      {/* ── Monthly Attendance Statistics ── */}
      {dashboard?.monthly_stats?.length > 0 && (
        <div style={{ ...card }}>
          <h3 style={{ fontSize: 14, fontWeight: 700, color: '#111827', margin: '0 0 12px' }}>Monthly Attendance Statistics — {dashboard.month}</h3>
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr style={{ background: '#f8fafc', textAlign: 'left' }}>
                  <th style={{ padding: '6px 10px' }}>Date</th>
                  <th style={{ padding: '6px 10px' }}>Present</th>
                  <th style={{ padding: '6px 10px' }}>Absent</th>
                  <th style={{ padding: '6px 10px' }}>Leave</th>
                </tr>
              </thead>
              <tbody>
                {dashboard.monthly_stats.map(d => (
                  <tr key={d.date} style={{ borderTop: '1px solid #f3f4f6' }}>
                    <td style={{ padding: '6px 10px' }}>{d.date}</td>
                    <td style={{ padding: '6px 10px', color: '#16a34a', fontWeight: 600 }}>{d.present_count}</td>
                    <td style={{ padding: '6px 10px', color: '#dc2626', fontWeight: 600 }}>{d.absent_count}</td>
                    <td style={{ padding: '6px 10px', color: '#d97706', fontWeight: 600 }}>{d.leave_count}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* ── Filters ── */}
      <div style={{ ...card }}>
        <h3 style={{ fontSize: 14, fontWeight: 700, color: '#111827', margin: '0 0 12px', display: 'flex', alignItems: 'center', gap: 6 }}>
          <Filter size={15} color="#dc2626" /> Filter Attendance
        </h3>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4,1fr) auto auto auto', gap: 10, alignItems: 'end' }}>
          <div>
            <label style={labelStyle}>Date</label>
            <input type="date" value={filters.date} onChange={e => setFilters(f => ({ ...f, date: e.target.value, month: '' }))} style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Month</label>
            <input type="month" value={filters.month} onChange={e => setFilters(f => ({ ...f, month: e.target.value, date: '' }))} style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Faculty</label>
            <select value={filters.faculty_id} onChange={e => setFilters(f => ({ ...f, faculty_id: e.target.value }))} style={{ ...inputStyle, width: '100%' }}>
              <option value="">All Faculty</option>
              {facultyList.map(f => <option key={f.faculty_id} value={f.faculty_id}>{f.name} ({f.employee_id})</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Department</label>
            <select value={filters.department} onChange={e => setFilters(f => ({ ...f, department: e.target.value }))} style={{ ...inputStyle, width: '100%' }}>
              <option value="">All Departments</option>
              {departments.map(d => <option key={d} value={d}>{d}</option>)}
            </select>
          </div>
          <button onClick={applyFilters} style={{ padding: '9px 16px', borderRadius: 8, border: 'none', background: '#dc2626', color: 'white', fontWeight: 600, fontSize: 13, cursor: 'pointer' }}>Apply</button>
          <button onClick={resetFilters} style={{ padding: '9px 16px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', color: '#374151', fontWeight: 600, fontSize: 13, cursor: 'pointer' }}>Reset</button>
          <div style={{ display: 'flex', gap: 8 }}>
            <button onClick={() => adminApi.exportAttendanceCSV(filters)} title="Export to Excel (CSV)" style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', color: '#16a34a', fontWeight: 600, fontSize: 13, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6 }}>
              <Download size={14} /> Excel
            </button>
            <button onClick={() => openPrintableReport(records, { ...filters, facultyName })} title="Export to PDF (print)" style={{ padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', color: '#dc2626', fontWeight: 600, fontSize: 13, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6 }}>
              <FileText size={14} /> PDF
            </button>
          </div>
        </div>
      </div>

      {/* ── Records Table ── */}
      <div style={{ ...card, marginBottom: 0 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
          <h3 style={{ fontSize: 14, fontWeight: 700, color: '#111827', margin: 0, display: 'flex', alignItems: 'center', gap: 6 }}>
            <Calendar size={15} color="#dc2626" /> Attendance Records
          </h3>
          <div style={{ fontSize: 12, color: '#6b7280' }}>
            {summary.total} record{summary.total === 1 ? '' : 's'} ·
            <span style={{ color: '#16a34a', fontWeight: 700 }}> {summary.present} Present</span> ·
            <span style={{ color: '#dc2626', fontWeight: 700 }}> {summary.absent} Absent</span> ·
            <span style={{ color: '#d97706', fontWeight: 700 }}> {summary.leave} Leave</span>
          </div>
        </div>

        {loading ? (
          <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 13 }}>
            <Loader size={22} style={{ marginBottom: 8 }} /><div>Loading attendance records…</div>
          </div>
        ) : error ? (
          <div style={{ textAlign: 'center', padding: 40, color: '#dc2626', fontSize: 13 }}>{error}</div>
        ) : records.length === 0 ? (
          <div style={{ textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 13 }}>No attendance records match these filters.</div>
        ) : (
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
              <thead>
                <tr style={{ background: '#f8fafc', textAlign: 'left', fontSize: 11, textTransform: 'uppercase', color: '#6b7280', letterSpacing: 0.5 }}>
                  <th style={{ padding: '8px 10px' }}>Faculty</th>
                  <th style={{ padding: '8px 10px' }}>Department</th>
                  <th style={{ padding: '8px 10px' }}>Date</th>
                  <th style={{ padding: '8px 10px' }}>Punch In</th>
                  <th style={{ padding: '8px 10px' }}>Punch Out</th>
                  <th style={{ padding: '8px 10px' }}>Working Hours</th>
                  <th style={{ padding: '8px 10px' }}>Status</th>
                  <th style={{ padding: '8px 10px' }}></th>
                </tr>
              </thead>
              <tbody>
                {records.map((r, i) => {
                  const sc = statusColor(r.status);
                  return (
                    <tr key={r.id} style={{ borderTop: '1px solid #f3f4f6', background: i % 2 === 0 ? 'white' : '#fafafa' }}>
                      <td style={{ padding: '8px 10px' }}>
                        <div style={{ fontWeight: 600, color: '#111827' }}>{r.faculty_name}</div>
                        <div style={{ fontSize: 11, color: '#9ca3af' }}>{r.employee_id}</div>
                      </td>
                      <td style={{ padding: '8px 10px', color: '#374151' }}>{r.department || '-'}</td>
                      <td style={{ padding: '8px 10px', color: '#374151' }}>{r.date}</td>
                      <td style={{ padding: '8px 10px', color: '#374151' }}>{fmtTime(r.punch_in_time)}</td>
                      <td style={{ padding: '8px 10px', color: '#374151' }}>{fmtTime(r.punch_out_time)}</td>
                      <td style={{ padding: '8px 10px', color: '#374151', fontWeight: r.working_hours != null ? 600 : 400 }}>{fmtHours(r.working_hours)}</td>
                      <td style={{ padding: '8px 10px' }}>
                        <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: sc.bg, color: sc.color, fontWeight: 700 }}>{r.status}</span>
                      </td>
                      <td style={{ padding: '8px 10px', textAlign: 'right' }}>
                        <button onClick={() => setEditing(r)} title="Edit" style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer', display: 'inline-flex' }}>
                          <Edit2 size={13} color="#374151" />
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}
