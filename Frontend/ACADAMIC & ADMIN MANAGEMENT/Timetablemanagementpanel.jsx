// ============================================================
// TimetableManagementPanel — Admin: Predefined Timetable System
//
// Every course + semester already ships with a complete predefined
// (default) timetable. This panel lets the Admin view any course's
// timetable grid, edit/create/delete individual lectures, replace an
// entire timetable in one save, search/filter across all timetables,
// and export (CSV/Excel or print-to-PDF). All writes go straight to
// `timetable_slots` — the same table students/faculty read — so
// changes are reflected everywhere immediately.
// ============================================================

import React, { useEffect, useMemo, useState } from 'react';
import {
  CalendarClock, Search, Download, Printer, Plus, Trash2, Edit2, X,
  Loader, AlertTriangle, CheckCircle, Filter,
} from 'lucide-react';
import { timetableApi } from '../../utils/api';

const card = { background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', marginBottom: 16 };
const inputStyle = { padding: '8px 11px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };
const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

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

// ── Edit / Create Lecture Modal ─────────────────────────────
function SlotModal({ courseId, semester, day, periodNo, slot, subjects, classrooms, facultyList, onClose, onSaved, showToast, onSubjectAdded }) {
  const [subjectId, setSubjectId] = useState(slot?.subject_id || '');
  const [classroomId, setClassroomId] = useState(slot?.classroom_id || '');
  const [facultyId, setFacultyId] = useState(slot?.faculty_id || '');
  const [saving, setSaving] = useState(false);
  const [addingSubject, setAddingSubject] = useState(false);
  const [newSubjectName, setNewSubjectName] = useState('');

  const save = async () => {
    setSaving(true);
    try {
      const payload = {
        subject_id: subjectId || null,
        classroom_id: classroomId || null,
        faculty_id: facultyId || null,
      };
      if (slot?.slot_id) {
        await timetableApi.updateSlot(slot.slot_id, payload);
      } else {
        await timetableApi.createSlot({ course_id: courseId, semester, day_of_week: day, period_no: periodNo, ...payload });
      }
      showToast('Lecture saved.', 'success');
      onSaved();
    } catch (err) {
      showToast(err.response?.data?.error || 'Failed to save lecture.', 'error');
    } finally {
      setSaving(false);
    }
  };

  const remove = async () => {
    if (!slot?.slot_id) { onClose(); return; }
    if (!window.confirm('Delete this lecture?')) return;
    setSaving(true);
    try {
      await timetableApi.deleteSlot(slot.slot_id);
      showToast('Lecture deleted.', 'success');
      onSaved();
    } catch (err) {
      showToast(err.response?.data?.error || 'Failed to delete lecture.', 'error');
    } finally {
      setSaving(false);
    }
  };

  const addSubject = async () => {
    if (!newSubjectName.trim()) return;
    try {
      const res = await timetableApi.addSubject({ course_id: courseId, semester, subject_name: newSubjectName.trim() });
      setSubjectId(res.data.id);
      setNewSubjectName('');
      setAddingSubject(false);
      onSubjectAdded();
      showToast('Subject added.', 'success');
    } catch (err) {
      showToast(err.response?.data?.error || 'Failed to add subject.', 'error');
    }
  };

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', zIndex: 3000, display: 'flex', alignItems: 'center', justifyContent: 'center' }} onClick={onClose}>
      <div style={{ background: 'white', borderRadius: 16, padding: 24, width: 420, maxWidth: '92vw' }} onClick={e => e.stopPropagation()}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h3 style={{ margin: 0, fontSize: 16, fontWeight: 700, color: '#111827' }}>{day} · Period {periodNo}</h3>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer' }}><X size={18} /></button>
        </div>

        <label style={labelStyle}>Subject</label>
        <select style={{ ...inputStyle, width: '100%', marginBottom: 10 }} value={subjectId} onChange={e => setSubjectId(e.target.value)}>
          <option value="">— None (free period) —</option>
          {subjects.map(s => <option key={s.id} value={s.id}>{s.subject_name} ({s.subject_code})</option>)}
        </select>
        {!addingSubject ? (
          <button onClick={() => setAddingSubject(true)} style={{ ...inputStyle, background: '#f3f4f6', border: 'none', cursor: 'pointer', marginBottom: 14, fontSize: 12 }}>
            <Plus size={12} style={{ verticalAlign: -1 }} /> Add new subject for this semester
          </button>
        ) : (
          <div style={{ display: 'flex', gap: 6, marginBottom: 14 }}>
            <input style={{ ...inputStyle, flex: 1 }} placeholder="New subject name" value={newSubjectName} onChange={e => setNewSubjectName(e.target.value)} />
            <button onClick={addSubject} style={{ ...inputStyle, background: '#111827', color: 'white', border: 'none', cursor: 'pointer' }}>Add</button>
          </div>
        )}

        <label style={labelStyle}>Faculty</label>
        <select style={{ ...inputStyle, width: '100%', marginBottom: 10 }} value={facultyId} onChange={e => setFacultyId(e.target.value)}>
          <option value="">— Use subject's default faculty —</option>
          {facultyList.map(f => <option key={f.faculty_id} value={f.faculty_id}>{f.name} ({f.department})</option>)}
        </select>

        <label style={labelStyle}>Classroom</label>
        <select style={{ ...inputStyle, width: '100%', marginBottom: 20 }} value={classroomId} onChange={e => setClassroomId(e.target.value)}>
          <option value="">— None —</option>
          {classrooms.map(c => <option key={c.id} value={c.id}>{c.room_code} ({c.department})</option>)}
        </select>

        <div style={{ display: 'flex', gap: 8 }}>
          <button onClick={save} disabled={saving} style={{ flex: 1, padding: '10px', borderRadius: 8, border: 'none', background: '#111827', color: 'white', fontWeight: 600, cursor: 'pointer' }}>
            {saving ? 'Saving…' : 'Save'}
          </button>
          {slot?.slot_id && (
            <button onClick={remove} disabled={saving} style={{ padding: '10px 14px', borderRadius: 8, border: '1px solid #fecdd3', background: '#fff1f2', color: '#dc2626', cursor: 'pointer' }}>
              <Trash2 size={14} />
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

export default function TimetableManagementPanel() {
  const [courses, setCourses] = useState([]);
  const [courseId, setCourseId] = useState('');
  const [semester, setSemester] = useState('');
  const [grid, setGrid] = useState(null);
  const [subjects, setSubjects] = useState([]);
  const [classrooms, setClassrooms] = useState([]);
  const [facultyList, setFacultyList] = useState([]);
  const [loading, setLoading] = useState(false);
  const [modalCell, setModalCell] = useState(null); // {day, periodNo, slot}
  const [toast, setToast] = useState(null);

  const [filterFaculty, setFilterFaculty] = useState('');
  const [filterClassroom, setFilterClassroom] = useState('');
  const [filterDept, setFilterDept] = useState('');
  const [searchResults, setSearchResults] = useState(null);
  const [searching, setSearching] = useState(false);

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };

  useEffect(() => {
    timetableApi.getCourses().then(res => setCourses(res.data.courses)).catch(() => {});
    timetableApi.getClassrooms().then(res => setClassrooms(res.data.classrooms)).catch(() => {});
    timetableApi.getFacultyList().then(res => setFacultyList(res.data.faculty)).catch(() => {});
  }, []);

  const selectedCourse = useMemo(() => courses.find(c => String(c.id) === String(courseId)), [courses, courseId]);

  const loadGrid = async (cid, sem) => {
    if (!cid || !sem) return;
    setLoading(true);
    try {
      const [gridRes, subRes] = await Promise.all([
        timetableApi.getGrid(cid, sem),
        timetableApi.getSubjects(cid, sem),
      ]);
      setGrid(gridRes.data.grid);
      setSubjects(subRes.data.subjects);
    } catch (err) {
      showToast(err.response?.data?.error || 'Failed to load timetable.', 'error');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (courseId && semester) loadGrid(courseId, semester);
    else { setGrid(null); setSubjects([]); }
  }, [courseId, semester]);

  const runSearch = async () => {
    setSearching(true);
    try {
      const res = await timetableApi.search({
        course_id: courseId || undefined,
        semester: semester || undefined,
        faculty_id: filterFaculty || undefined,
        classroom_id: filterClassroom || undefined,
        department: filterDept || undefined,
      });
      setSearchResults(res.data.results);
    } catch (err) {
      showToast(err.response?.data?.error || 'Search failed.', 'error');
    } finally {
      setSearching(false);
    }
  };

  const periodCols = grid && grid[0] ? grid[0].periods : [];
  const departments = useMemo(() => [...new Set(courses.map(c => c.department))], [courses]);

  return (
    <div>
      <Toast toast={toast} />
      <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16 }}>
        <CalendarClock size={20} color="#dc2626" />
        <h2 style={{ margin: 0, fontSize: 18, fontWeight: 700, color: '#111827' }}>Timetable Management</h2>
      </div>

      {/* ── Course / Semester selector ── */}
      <div style={card}>
        <div style={{ display: 'flex', gap: 16, flexWrap: 'wrap', alignItems: 'flex-end' }}>
          <div style={{ minWidth: 260 }}>
            <label style={labelStyle}>Course</label>
            <select style={{ ...inputStyle, width: '100%' }} value={courseId} onChange={e => { setCourseId(e.target.value); setSemester(''); }}>
              <option value="">Select a course…</option>
              {departments.map(dept => (
                <optgroup key={dept} label={dept}>
                  {courses.filter(c => c.department === dept).map(c => (
                    <option key={c.id} value={c.id}>{c.course_name}</option>
                  ))}
                </optgroup>
              ))}
            </select>
          </div>
          <div style={{ minWidth: 160 }}>
            <label style={labelStyle}>Semester</label>
            <select style={{ ...inputStyle, width: '100%' }} value={semester} onChange={e => setSemester(e.target.value)} disabled={!selectedCourse}>
              <option value="">Select…</option>
              {selectedCourse && Array.from({ length: selectedCourse.total_semesters }, (_, i) => i + 1).map(s => (
                <option key={s} value={s}>Semester {s}</option>
              ))}
            </select>
          </div>
          {courseId && semester && (
            <div style={{ display: 'flex', gap: 8, marginLeft: 'auto' }}>
              <button onClick={() => timetableApi.exportCSV(courseId, semester)} style={{ ...inputStyle, background: '#f3f4f6', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6 }}>
                <Download size={14} /> Export
              </button>
              <button onClick={() => timetableApi.exportPDF(courseId, semester)} style={{ ...inputStyle, background: '#f3f4f6', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6 }}>
                <Printer size={14} /> Print
              </button>
            </div>
          )}
        </div>
      </div>

      {/* ── Grid editor ── */}
      {loading && <div style={card}><Loader size={16} className="spin" /> Loading timetable…</div>}

      {!loading && grid && (
        <div style={{ ...card, overflowX: 'auto' }}>
          <p style={{ fontSize: 12, color: '#6b7280', marginTop: 0 }}>
            Click any lecture cell to edit the subject, faculty, or classroom. Cells marked <b>default</b> still show the predefined timetable — saving any change replaces it immediately for students and faculty.
          </p>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12, minWidth: 900 }}>
            <thead>
              <tr>
                <th style={{ padding: 8, border: '1px solid #e5e7eb', background: '#f9fafb' }}>Day</th>
                {periodCols.map(p => (
                  <th key={p.period_no} style={{ padding: 8, border: '1px solid #e5e7eb', background: '#f9fafb', minWidth: 110 }}>
                    {p.label}<br /><span style={{ fontWeight: 400, color: '#9ca3af' }}>{String(p.start_time).slice(0,5)}-{String(p.end_time).slice(0,5)}</span>
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {grid.map(row => (
                <tr key={row.day}>
                  <td style={{ padding: 8, border: '1px solid #e5e7eb', fontWeight: 700, background: '#f9fafb' }}>{row.day}</td>
                  {row.periods.map((cell, pi) => {
                    if (cell.is_break) {
                      return <td key={pi} style={{ padding: 8, border: '1px solid #e5e7eb', background: '#fdf6ec', color: '#b8a68a', textAlign: 'center' }}>Break</td>;
                    }
                    return (
                      <td key={pi}
                        onClick={() => setModalCell({ day: row.day, periodNo: cell.period_no, slot: cell })}
                        style={{ padding: 8, border: '1px solid #e5e7eb', cursor: 'pointer', verticalAlign: 'top', background: cell.subject_name ? '#fff' : '#fafafa' }}>
                        {cell.subject_name ? (
                          <div>
                            <div style={{ fontWeight: 700, color: '#111827' }}>{cell.subject_name}</div>
                            <div style={{ color: '#6b7280' }}>{cell.faculty_name}</div>
                            <div style={{ color: '#9ca3af' }}>{cell.room_code}</div>
                            {!cell.is_predefined && <span style={{ fontSize: 9, color: '#dc2626', fontWeight: 700 }}>CUSTOMIZED</span>}
                          </div>
                        ) : (
                          <div style={{ color: '#d1d5db', textAlign: 'center', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 4 }}><Plus size={12} /> Add</div>
                        )}
                      </td>
                    );
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {modalCell && (
        <SlotModal
          courseId={courseId}
          semester={semester}
          day={modalCell.day}
          periodNo={modalCell.periodNo}
          slot={modalCell.slot}
          subjects={subjects}
          classrooms={classrooms}
          facultyList={facultyList}
          showToast={showToast}
          onClose={() => setModalCell(null)}
          onSaved={() => { setModalCell(null); loadGrid(courseId, semester); }}
          onSubjectAdded={() => timetableApi.getSubjects(courseId, semester).then(res => setSubjects(res.data.subjects))}
        />
      )}

      {/* ── Search / Filter across all timetables ── */}
      <div style={card}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 12 }}>
          <Filter size={16} color="#6b7280" />
          <h3 style={{ margin: 0, fontSize: 14, fontWeight: 700, color: '#111827' }}>Search &amp; Filter Timetables</h3>
        </div>
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', alignItems: 'flex-end', marginBottom: 12 }}>
          <div>
            <label style={labelStyle}>Department</label>
            <select style={inputStyle} value={filterDept} onChange={e => setFilterDept(e.target.value)}>
              <option value="">All</option>
              {departments.map(d => <option key={d} value={d}>{d}</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Faculty</label>
            <select style={inputStyle} value={filterFaculty} onChange={e => setFilterFaculty(e.target.value)}>
              <option value="">All</option>
              {facultyList.map(f => <option key={f.faculty_id} value={f.faculty_id}>{f.name}</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Classroom</label>
            <select style={inputStyle} value={filterClassroom} onChange={e => setFilterClassroom(e.target.value)}>
              <option value="">All</option>
              {classrooms.map(c => <option key={c.id} value={c.id}>{c.room_code}</option>)}
            </select>
          </div>
          <button onClick={runSearch} disabled={searching} style={{ ...inputStyle, background: '#111827', color: 'white', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6 }}>
            <Search size={14} /> {searching ? 'Searching…' : 'Search'}
          </button>
        </div>

        {searchResults && (
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr style={{ background: '#f9fafb' }}>
                  {['Course','Sem','Day','Period','Time','Subject','Faculty','Room'].map(h => (
                    <th key={h} style={{ padding: 8, border: '1px solid #e5e7eb', textAlign: 'left' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {searchResults.length === 0 && (
                  <tr><td colSpan={8} style={{ padding: 12, textAlign: 'center', color: '#9ca3af' }}>No matching lectures.</td></tr>
                )}
                {searchResults.map(r => (
                  <tr key={r.id}>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.course_name}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.semester}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.day_of_week}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.period_no}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{String(r.start_time).slice(0,5)}-{String(r.end_time).slice(0,5)}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.subject_name || '-'}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.faculty_name || '-'}</td>
                    <td style={{ padding: 8, border: '1px solid #e5e7eb' }}>{r.room_code || '-'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}