// ============================================================
// ResultsManagementPanel — Admin: Student Semester Results
//
// - Search for a student (by name / enrollment number).
// - View their full result history (SGPA per semester + derived
//   CGPA + classification).
// - Add / Edit / Delete a semester result. Subjects are AUTO-FETCHED
//   from the Course/Timetable module (tt_subjects) for the student's
//   course + chosen semester — Subject Code / Subject Name / Credit
//   are read-only. The admin only enters Internal / External /
//   Practical marks; everything else (Total, Grade Point, Letter
//   Grade, Credit Points, Pass/Fail, SGPA, CGPA, Classification) is
//   calculated automatically on the server.
// - Bulk-upload marks for multiple students in the same course +
//   semester in one go (subjects auto-fetched once, applied to all).
//
// All data is read/written via /results.php (PHP + MySQL) — no
// hardcoded values; results are linked to the student's Enrollment
// Number (gr_number) through students.id, and subjects are linked
// via tt_subjects.id (never retyped).
// ============================================================

import React, { useEffect, useMemo, useState } from 'react';
import {
  Search, Plus, Edit2, Trash2, X, GraduationCap, Award, Layers,
  CheckCircle, AlertTriangle, Loader, Upload, User, Info,
} from 'lucide-react';
import { resultsApi, timetableApi } from '../../utils/api';

const card = { background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', marginBottom: 16 };
const inputStyle = { padding: '8px 11px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const roInputStyle = { ...inputStyle, background: '#f9fafb', color: '#6b7280', border: '1px solid #f3f4f6' };
const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };

const statusColor = (s) => ({
  Pass:    { bg: '#f0fdf4', color: '#16a34a' },
  Fail:    { bg: '#fff1f2', color: '#dc2626' },
  ATKT:    { bg: '#fff7ed', color: '#ea580c' },
  Pending: { bg: '#f3f4f6', color: '#6b7280' },
}[s] || { bg: '#f3f4f6', color: '#6b7280' });

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

function InfoNote({ children }) {
  return (
    <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start', background: '#eff6ff', border: '1px solid #bfdbfe', color: '#1d4ed8', borderRadius: 8, padding: '8px 10px', fontSize: 11.5, marginBottom: 10 }}>
      <Info size={13} style={{ flexShrink: 0, marginTop: 1 }} />
      <span>{children}</span>
    </div>
  );
}

// Build one editable subject-marks row from an auto-fetched tt_subjects
// row, pre-filling marks from an existing result if editing.
function toEditableRow(subj, existingMap) {
  const ex = existingMap.get(subj.subject_id);
  return {
    subject_id: subj.subject_id,
    subject_code: subj.subject_code,
    subject_name: subj.subject_name,
    credits: subj.credits,
    internal_max: ex?.internal_max ?? 40,
    internal_marks: ex?.internal_marks ?? '',
    external_max: ex?.external_max ?? 60,
    external_marks: ex?.external_marks ?? '',
    practical_max: ex?.practical_max ?? 0,
    practical_marks: ex?.practical_marks ?? '',
    legacy: false,
  };
}

// ── Add / Edit a single semester result ─────────────────────
function ResultFormModal({ student, existing, onClose, onSaved, showToast }) {
  const [semester, setSemester] = useState(existing?.semester ?? Math.max(1, (student.current_semester || 1) - 1));
  const [academicYear, setAcademicYear] = useState(existing?.academic_year || '');
  const [declaredOn, setDeclaredOn] = useState(existing?.result_declared_on ? existing.result_declared_on.slice(0, 10) : '');
  const [remarks, setRemarks] = useState(existing?.remarks || '');
  const [rows, setRows] = useState([]);
  const [legacyRows, setLegacyRows] = useState([]); // subjects on the existing result with no subject_id (pre-upgrade data)
  const [loadingSubjects, setLoadingSubjects] = useState(false);
  const [subjectsNote, setSubjectsNote] = useState('');
  const [saving, setSaving] = useState(false);

  // Auto-fetch subjects for this course + semester whenever the semester changes.
  useEffect(() => {
    let active = true;
    if (!student.course_id) {
      setSubjectsNote('This student has no course on file — assign a course in Student Management first.');
      setRows([]);
      return;
    }
    if (!semester || semester < 1) return;

    setLoadingSubjects(true);
    (async () => {
      try {
        const res = await resultsApi.getCourseSubjects(student.course_id, semester);
        if (!active) return;
        const existingSubjects = (existing && Number(existing.semester) === Number(semester)) ? (existing.subjects || []) : [];
        const existingMap = new Map(existingSubjects.filter(s => s.subject_id).map(s => [s.subject_id, s]));
        const fetched = res.data?.subjects || [];
        setRows(fetched.map(s => toEditableRow(s, existingMap)));
        setSubjectsNote(res.data?.note || '');

        // Legacy rows: existing marks that don't correspond to any current tt_subjects id
        // (e.g. entered before this upgrade). Keep them so nothing is silently dropped.
        const fetchedIds = new Set(fetched.map(s => s.subject_id));
        const legacy = existingSubjects.filter(s => !s.subject_id || !fetchedIds.has(s.subject_id));
        setLegacyRows(legacy.map(s => ({ ...s, legacy: true })));
      } catch (e) {
        if (active) showToast('Could not load subjects for this course/semester.', 'error');
      } finally {
        if (active) setLoadingSubjects(false);
      }
    })();
    return () => { active = false; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [student.course_id, semester]);

  const updateRow = (idx, field, value) => setRows(prev => prev.map((r, i) => i === idx ? { ...r, [field]: value } : r));
  const updateLegacyRow = (idx, field, value) => setLegacyRows(prev => prev.map((r, i) => i === idx ? { ...r, [field]: value } : r));
  const removeLegacyRow = (idx) => setLegacyRows(prev => prev.filter((_, i) => i !== idx));

  const save = async () => {
    if (!semester || semester < 1) { showToast('Please enter a valid semester number.', 'error'); return; }
    if (rows.length === 0 && legacyRows.length === 0) { showToast('No subjects to save. Make sure subjects are assigned to this course/semester in Timetable Management.', 'error'); return; }

    const subjects = [
      ...rows.map(r => ({
        subject_id: r.subject_id,
        internal_max: Number(r.internal_max) || 0,
        internal_marks: Number(r.internal_marks) || 0,
        external_max: Number(r.external_max) || 0,
        external_marks: Number(r.external_marks) || 0,
        practical_max: Number(r.practical_max) || 0,
        practical_marks: Number(r.practical_marks) || 0,
      })),
      ...legacyRows.map(r => ({
        subject_code: r.subject_code,
        subject_name: r.subject_name,
        internal_max: Number(r.internal_max) || 0,
        internal_marks: Number(r.internal_marks) || 0,
        external_max: Number(r.external_max) || 0,
        external_marks: Number(r.external_marks) || 0,
        practical_max: Number(r.practical_max) || 0,
        practical_marks: Number(r.practical_marks) || 0,
        credits: Number(r.credits) || 4,
      })),
    ];

    setSaving(true);
    try {
      const payload = {
        student_id: student.id, semester: Number(semester), subjects, remarks,
        academic_year: academicYear || undefined, result_declared_on: declaredOn || undefined,
      };
      const res = existing
        ? await resultsApi.updateResult(existing.id, payload)
        : await resultsApi.addResult(payload);
      showToast(`Result saved — SGPA ${res.data?.result?.sgpa ?? '-'}, CGPA ${res.data?.cgpa ?? '-'}.`);
      onSaved();
      onClose();
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to save result.', 'error');
    } finally {
      setSaving(false);
    }
  };

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1500, padding: 20 }}>
      <div style={{ background: 'white', borderRadius: 14, padding: 24, width: 760, maxWidth: '95vw', maxHeight: '90vh', overflowY: 'auto' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 4 }}>
          <h3 style={{ margin: 0, fontSize: 15, fontWeight: 700, color: '#111827' }}>{existing ? 'Edit' : 'Add'} Semester Result</h3>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af' }}><X size={18} /></button>
        </div>
        <div style={{ fontSize: 12, color: '#6b7280', marginBottom: 16 }}>
          {student.name} · Enrollment No. {student.gr_number || student.enrollment_number}{student.course_name ? ` · ${student.course_name}` : ''}
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '0.7fr 1fr 1fr', gap: 12, marginBottom: 12 }}>
          <div>
            <label style={labelStyle}>Semester</label>
            <input type="number" min="1" max="12" value={semester} onChange={e => setSemester(Number(e.target.value))} style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Academic Year</label>
            <input type="text" value={academicYear} onChange={e => setAcademicYear(e.target.value)} placeholder="2023-2024" style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Result Declaration Date</label>
            <input type="date" value={declaredOn} onChange={e => setDeclaredOn(e.target.value)} style={{ ...inputStyle, width: '100%' }} />
          </div>
        </div>
        <div style={{ marginBottom: 14 }}>
          <label style={labelStyle}>Remarks (optional)</label>
          <input type="text" value={remarks} onChange={e => setRemarks(e.target.value)} placeholder="e.g. Re-evaluation pending for Subject X" style={{ ...inputStyle, width: '100%' }} />
        </div>

        <label style={labelStyle}>Subject-wise Marks — auto-fetched from this student's course &amp; semester</label>
        {subjectsNote && <InfoNote>{subjectsNote}</InfoNote>}

        {loadingSubjects ? (
          <div style={{ textAlign: 'center', padding: 24, color: '#9ca3af', fontSize: 12 }}><Loader size={16} /> Loading subjects…</div>
        ) : (
          <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflowX: 'auto', overflowY: 'hidden', marginBottom: 10 }}>
            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(150px,1.3fr) minmax(50px,0.5fr) minmax(120px,0.9fr) minmax(120px,0.9fr) minmax(120px,0.9fr)', minWidth: 680, gap: 6, background: '#f8fafc', padding: '8px 10px', fontSize: 10.5, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase' }}>
              <span>Code</span><span>Subject Name</span><span>Credit</span><span>Internal (Max)</span><span>External (Max)</span><span>Practical (Max)</span>
            </div>
            {rows.map((r, i) => (
              <div key={r.subject_id} style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(150px,1.3fr) minmax(50px,0.5fr) minmax(120px,0.9fr) minmax(120px,0.9fr) minmax(120px,0.9fr)', minWidth: 680, gap: 6, padding: '6px 10px', borderTop: '1px solid #f3f4f6', alignItems: 'center' }}>
                <input value={r.subject_code || '-'} readOnly style={{ ...roInputStyle, width: '100%' }} />
                <input value={r.subject_name} readOnly style={{ ...roInputStyle, width: '100%' }} />
                <input value={r.credits} readOnly style={{ ...roInputStyle, width: '100%', textAlign: 'center' }} />
                <div style={{ display: 'flex', gap: 4 }}>
                  <input type="number" value={r.internal_marks} onChange={e => updateRow(i, 'internal_marks', e.target.value)} placeholder="Marks" style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                  <input type="number" value={r.internal_max} onChange={e => updateRow(i, 'internal_max', e.target.value)} title="Max marks" style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                </div>
                <div style={{ display: 'flex', gap: 4 }}>
                  <input type="number" value={r.external_marks} onChange={e => updateRow(i, 'external_marks', e.target.value)} placeholder="Marks" style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                  <input type="number" value={r.external_max} onChange={e => updateRow(i, 'external_max', e.target.value)} title="Max marks" style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                </div>
                <div style={{ display: 'flex', gap: 4 }}>
                  <input type="number" value={r.practical_marks} onChange={e => updateRow(i, 'practical_marks', e.target.value)} placeholder="Marks" style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                  <input type="number" value={r.practical_max} onChange={e => updateRow(i, 'practical_max', e.target.value)} title="Max marks (0 if N/A)" style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                </div>
              </div>
            ))}
            {rows.length === 0 && !subjectsNote && (
              <div style={{ padding: 16, textAlign: 'center', color: '#9ca3af', fontSize: 12 }}>No subjects found for semester {semester}.</div>
            )}
          </div>
        )}

        {legacyRows.length > 0 && (
          <>
            <label style={labelStyle}>Legacy Subjects (entered before auto-fetch was enabled)</label>
            <div style={{ border: '1px solid #fde68a', background: '#fffbeb', borderRadius: 10, overflowX: 'auto', overflowY: 'hidden', marginBottom: 10 }}>
              <div style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(150px,1.3fr) minmax(50px,0.5fr) minmax(120px,0.9fr) minmax(120px,0.9fr) minmax(120px,0.9fr) 28px', minWidth: 700, gap: 6, background: '#fef3c7', padding: '8px 10px', fontSize: 10.5, fontWeight: 700, color: '#92400e', textTransform: 'uppercase' }}>
                <span>Code</span><span>Subject Name</span><span>Credit</span><span>Internal (Max)</span><span>External (Max)</span><span>Practical (Max)</span><span></span>
              </div>
              {legacyRows.map((r, i) => (
                <div key={i} style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(150px,1.3fr) minmax(50px,0.5fr) minmax(120px,0.9fr) minmax(120px,0.9fr) minmax(120px,0.9fr) 28px', minWidth: 700, gap: 6, padding: '6px 10px', borderTop: '1px solid #fde68a', alignItems: 'center' }}>
                  <input value={r.subject_code || ''} onChange={e => updateLegacyRow(i, 'subject_code', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
                  <input value={r.subject_name || ''} onChange={e => updateLegacyRow(i, 'subject_name', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
                  <input type="number" value={r.credits} onChange={e => updateLegacyRow(i, 'credits', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
                  <div style={{ display: 'flex', gap: 4 }}>
                    <input type="number" value={r.internal_marks} onChange={e => updateLegacyRow(i, 'internal_marks', e.target.value)} style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                    <input type="number" value={r.internal_max} onChange={e => updateLegacyRow(i, 'internal_max', e.target.value)} style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                  </div>
                  <div style={{ display: 'flex', gap: 4 }}>
                    <input type="number" value={r.external_marks} onChange={e => updateLegacyRow(i, 'external_marks', e.target.value)} style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                    <input type="number" value={r.external_max} onChange={e => updateLegacyRow(i, 'external_max', e.target.value)} style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                  </div>
                  <div style={{ display: 'flex', gap: 4 }}>
                    <input type="number" value={r.practical_marks} onChange={e => updateLegacyRow(i, 'practical_marks', e.target.value)} style={{ ...inputStyle, flex: 1, minWidth: 0 }} />
                    <input type="number" value={r.practical_max} onChange={e => updateLegacyRow(i, 'practical_max', e.target.value)} style={{ ...inputStyle, width: 52, flexShrink: 0, textAlign: 'center', padding: '8px 2px' }} />
                  </div>
                  <button onClick={() => removeLegacyRow(i)} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#dc2626' }}><Trash2 size={13} /></button>
                </div>
              ))}
            </div>
          </>
        )}

        <div style={{ fontSize: 11, color: '#9ca3af', marginBottom: 16 }}>
          Total marks, Grade Point, Letter Grade, Credit Points, Pass/Fail, SGPA and CGPA are calculated automatically from these marks (10-point scale, pass mark 40%).
        </div>

        <div style={{ display: 'flex', gap: 10, justifyContent: 'flex-end' }}>
          <button onClick={onClose} style={{ padding: '8px 16px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#374151' }}>Cancel</button>
          <button onClick={save} disabled={saving || loadingSubjects} style={{ padding: '8px 16px', borderRadius: 8, border: 'none', background: '#dc2626', color: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, opacity: (saving || loadingSubjects) ? 0.6 : 1 }}>
            {saving ? 'Saving…' : 'Save Result'}
          </button>
        </div>
      </div>
    </div>
  );
}

// ── Bulk Upload: one course + semester, subjects auto-fetched once,
//    marks entered for many students ─────────────────────────────
function BulkUploadModal({ onClose, showToast, onDone }) {
  const [courses, setCourses] = useState([]);
  const [courseId, setCourseId] = useState('');
  const [semester, setSemester] = useState(1);
  const [remarks, setRemarks] = useState('');
  const [subjectDefs, setSubjectDefs] = useState([]); // [{subject_id, subject_code, subject_name, credits, internal_max, external_max, practical_max}]
  const [loadingSubjects, setLoadingSubjects] = useState(false);
  const [subjectsNote, setSubjectsNote] = useState('');
  const [search, setSearch] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [selected, setSelected] = useState([]); // [{id, name, gr_number, marks: {subject_id: {internal, external, practical}}}]
  const [searching, setSaving] = useState(false);
  const [saving, setUploading] = useState(false);

  useEffect(() => {
    (async () => {
      try {
        const res = await timetableApi.getCourses();
        setCourses(res.data?.courses || []);
      } catch (e) { /* non-fatal */ }
    })();
  }, []);

  // Auto-fetch subjects whenever course/semester changes.
  useEffect(() => {
    if (!courseId || !semester) { setSubjectDefs([]); return; }
    let active = true;
    setLoadingSubjects(true);
    (async () => {
      try {
        const res = await resultsApi.getCourseSubjects(courseId, semester);
        if (!active) return;
        setSubjectDefs((res.data?.subjects || []).map(s => ({ ...s, internal_max: 40, external_max: 60, practical_max: 0 })));
        setSubjectsNote(res.data?.note || '');
      } catch (e) {
        if (active) showToast('Could not load subjects for this course/semester.', 'error');
      } finally {
        if (active) setLoadingSubjects(false);
      }
    })();
    return () => { active = false; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [courseId, semester]);

  const updateSubjectDef = (idx, field, value) => setSubjectDefs(prev => prev.map((s, i) => i === idx ? { ...s, [field]: value } : s));

  const doSearch = async () => {
    setSaving(true);
    try {
      const res = await resultsApi.searchStudents(search);
      setSearchResults(res.data?.students || []);
    } catch (e) {
      showToast('Search failed.', 'error');
    } finally {
      setSaving(false);
    }
  };

  const addStudent = (s) => {
    if (selected.some(x => x.id === s.id)) return;
    if (courseId && s.course_id && Number(s.course_id) !== Number(courseId)) {
      showToast(`${s.name} is not enrolled in the selected course.`, 'error');
      return;
    }
    setSelected(prev => [...prev, { id: s.id, name: s.name, gr_number: s.gr_number, marks: {} }]);
  };
  const removeStudent = (id) => setSelected(prev => prev.filter(s => s.id !== id));
  const setMark = (studentId, subjectId, field, value) => {
    setSelected(prev => prev.map(s => s.id === studentId
      ? { ...s, marks: { ...s.marks, [subjectId]: { ...s.marks[subjectId], [field]: value } } }
      : s));
  };

  const submit = async () => {
    if (!courseId) { showToast('Select a course first.', 'error'); return; }
    if (subjectDefs.length === 0) { showToast('No subjects available for this course/semester.', 'error'); return; }
    if (selected.length === 0) { showToast('Add at least one student.', 'error'); return; }

    const subjects = subjectDefs.map(s => ({
      subject_id: s.subject_id, subject_code: s.subject_code, subject_name: s.subject_name, credits: s.credits,
      internal_max: Number(s.internal_max) || 0, external_max: Number(s.external_max) || 0, practical_max: Number(s.practical_max) || 0,
    }));

    const students = selected.map(s => {
      const marksSplit = {};
      subjectDefs.forEach(subj => {
        const m = s.marks[subj.subject_id] || {};
        marksSplit[subj.subject_id] = {
          internal: Number(m.internal) || 0,
          external: Number(m.external) || 0,
          practical: Number(m.practical) || 0,
        };
      });
      return { student_id: s.id, marks_split: marksSplit };
    });

    setUploading(true);
    try {
      const res = await resultsApi.bulkUpload({ course_id: Number(courseId), semester: Number(semester), subjects, students, remarks });
      const { saved = [], failed = [] } = res.data || {};
      showToast(`Saved results for ${saved.length} student(s)${failed.length ? `, ${failed.length} failed` : ''}.`, failed.length ? 'error' : 'success');
      onDone();
      onClose();
    } catch (e) {
      showToast(e?.response?.data?.error || 'Bulk upload failed.', 'error');
    } finally {
      setUploading(false);
    }
  };

  return (
    <div style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1500, padding: 20 }}>
      <div style={{ background: 'white', borderRadius: 14, padding: 24, width: 860, maxWidth: '95vw', maxHeight: '90vh', overflowY: 'auto' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
          <h3 style={{ margin: 0, fontSize: 15, fontWeight: 700, color: '#111827' }}>Bulk Upload — Semester Results</h3>
          <button onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af' }}><X size={18} /></button>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1.4fr 0.7fr 2fr', gap: 12, marginBottom: 14 }}>
          <div>
            <label style={labelStyle}>Course</label>
            <select value={courseId} onChange={e => setCourseId(e.target.value)} style={{ ...inputStyle, width: '100%' }}>
              <option value="">Select course…</option>
              {courses.map(c => <option key={c.id} value={c.id}>{c.course_name} ({c.course_code})</option>)}
            </select>
          </div>
          <div>
            <label style={labelStyle}>Semester</label>
            <input type="number" min="1" max="12" value={semester} onChange={e => setSemester(Number(e.target.value))} style={{ ...inputStyle, width: '100%' }} />
          </div>
          <div>
            <label style={labelStyle}>Remarks (optional, applied to all)</label>
            <input type="text" value={remarks} onChange={e => setRemarks(e.target.value)} style={{ ...inputStyle, width: '100%' }} />
          </div>
        </div>

        <label style={labelStyle}>1. Subjects — auto-fetched from Course/Timetable for this course &amp; semester</label>
        {subjectsNote && <InfoNote>{subjectsNote}</InfoNote>}
        {loadingSubjects ? (
          <div style={{ textAlign: 'center', padding: 16, color: '#9ca3af', fontSize: 12 }}><Loader size={14} /> Loading subjects…</div>
        ) : (
          <div style={{ border: '1px solid #e5e7eb', borderRadius: 10, overflowX: 'auto', overflowY: 'hidden', marginBottom: 14 }}>
            <div style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(160px,1.6fr) minmax(50px,0.5fr) minmax(80px,0.7fr) minmax(80px,0.7fr) minmax(80px,0.7fr)', minWidth: 620, gap: 6, background: '#f8fafc', padding: '8px 10px', fontSize: 10.5, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase' }}>
              <span>Code</span><span>Subject Name</span><span>Credit</span><span>Int. Max</span><span>Ext. Max</span><span>Prac. Max</span>
            </div>
            {subjectDefs.map((s, i) => (
              <div key={s.subject_id} style={{ display: 'grid', gridTemplateColumns: 'minmax(64px,0.7fr) minmax(160px,1.6fr) minmax(50px,0.5fr) minmax(80px,0.7fr) minmax(80px,0.7fr) minmax(80px,0.7fr)', minWidth: 620, gap: 6, padding: '6px 10px', borderTop: '1px solid #f3f4f6', alignItems: 'center' }}>
                <input value={s.subject_code} readOnly style={{ ...roInputStyle, width: '100%' }} />
                <input value={s.subject_name} readOnly style={{ ...roInputStyle, width: '100%' }} />
                <input value={s.credits} readOnly style={{ ...roInputStyle, width: '100%', textAlign: 'center' }} />
                <input type="number" value={s.internal_max} onChange={e => updateSubjectDef(i, 'internal_max', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
                <input type="number" value={s.external_max} onChange={e => updateSubjectDef(i, 'external_max', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
                <input type="number" value={s.practical_max} onChange={e => updateSubjectDef(i, 'practical_max', e.target.value)} style={{ ...inputStyle, width: '100%' }} />
              </div>
            ))}
            {subjectDefs.length === 0 && !subjectsNote && (
              <div style={{ padding: 16, textAlign: 'center', color: '#9ca3af', fontSize: 12 }}>Select a course and semester to load subjects.</div>
            )}
          </div>
        )}

        <label style={labelStyle}>2. Add Students (must belong to the selected course)</label>
        <div style={{ display: 'flex', gap: 8, marginBottom: 10 }}>
          <input value={search} onChange={e => setSearch(e.target.value)} onKeyDown={e => e.key === 'Enter' && doSearch()} placeholder="Search by name / enrollment no." style={{ ...inputStyle, flex: 1 }} />
          <button onClick={doSearch} style={{ padding: '8px 12px', borderRadius: 8, border: 'none', background: '#f3f4f6', cursor: 'pointer' }}>
            <Search size={14} color="#374151" />
          </button>
        </div>
        {searchResults.length > 0 && (
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginBottom: 14 }}>
            {searchResults.map(s => (
              <button key={s.id} onClick={() => addStudent(s)} style={{
                padding: '6px 10px', borderRadius: 8, fontSize: 12, cursor: 'pointer',
                border: '1px solid #e5e7eb', background: selected.some(x => x.id === s.id) ? '#fff1f2' : 'white',
              }}>
                {s.name} <span style={{ color: '#9ca3af' }}>({s.gr_number})</span>
              </button>
            ))}
          </div>
        )}

        {selected.length > 0 && subjectDefs.length > 0 && (
          <>
            <label style={labelStyle}>3. Enter Marks (Internal / External / Practical)</label>
            <div style={{ overflowX: 'auto', border: '1px solid #e5e7eb', borderRadius: 10, marginBottom: 16 }}>
              <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
                <thead>
                  <tr style={{ background: '#f8fafc', textAlign: 'left' }}>
                    <th style={{ padding: '6px 10px' }}>Student</th>
                    {subjectDefs.map(s => <th key={s.subject_id} style={{ padding: '6px 10px' }}>{s.subject_code}</th>)}
                    <th style={{ padding: '6px 10px' }}></th>
                  </tr>
                </thead>
                <tbody>
                  {selected.map(s => (
                    <tr key={s.id} style={{ borderTop: '1px solid #f3f4f6' }}>
                      <td style={{ padding: '6px 10px', fontWeight: 600 }}>{s.name}<div style={{ fontSize: 11, color: '#9ca3af', fontWeight: 400 }}>{s.gr_number}</div></td>
                      {subjectDefs.map(sub => (
                        <td key={sub.subject_id} style={{ padding: '6px 10px' }}>
                          <div style={{ display: 'flex', gap: 3 }}>
                            <input type="number" placeholder="I" title="Internal" value={s.marks[sub.subject_id]?.internal ?? ''} onChange={e => setMark(s.id, sub.subject_id, 'internal', e.target.value)} style={{ ...inputStyle, width: 40 }} />
                            <input type="number" placeholder="E" title="External" value={s.marks[sub.subject_id]?.external ?? ''} onChange={e => setMark(s.id, sub.subject_id, 'external', e.target.value)} style={{ ...inputStyle, width: 40 }} />
                            {Number(sub.practical_max) > 0 && (
                              <input type="number" placeholder="P" title="Practical" value={s.marks[sub.subject_id]?.practical ?? ''} onChange={e => setMark(s.id, sub.subject_id, 'practical', e.target.value)} style={{ ...inputStyle, width: 40 }} />
                            )}
                          </div>
                        </td>
                      ))}
                      <td style={{ padding: '6px 10px' }}>
                        <button onClick={() => removeStudent(s.id)} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#dc2626' }}><Trash2 size={13} /></button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </>
        )}

        <div style={{ display: 'flex', gap: 10, justifyContent: 'flex-end' }}>
          <button onClick={onClose} style={{ padding: '8px 16px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#374151' }}>Cancel</button>
          <button onClick={submit} disabled={saving} style={{ padding: '8px 16px', borderRadius: 8, border: 'none', background: '#dc2626', color: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, opacity: saving ? 0.6 : 1 }}>
            {saving ? 'Uploading…' : `Upload for ${selected.length} student(s)`}
          </button>
        </div>
      </div>
    </div>
  );
}

export default function ResultsManagementPanel() {
  const [search, setSearch] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [searching, setSearching] = useState(false);
  const [selectedStudent, setSelectedStudent] = useState(null);
  const [studentData, setStudentData] = useState(null);
  const [loadingResults, setLoadingResults] = useState(false);
  const [toast, setToast] = useState(null);
  const [formState, setFormState] = useState(null); // { existing } | null
  const [showBulk, setShowBulk] = useState(false);

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3000);
  };

  const doSearch = async () => {
    setSearching(true);
    try {
      const res = await resultsApi.searchStudents(search);
      setSearchResults(res.data?.students || []);
    } catch (e) {
      showToast('Search failed.', 'error');
    } finally {
      setSearching(false);
    }
  };

  // Search on mount with empty query to show recent students
  useEffect(() => { doSearch(); // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const loadStudentResults = async (studentId) => {
    setLoadingResults(true);
    try {
      const res = await resultsApi.getStudentResults(studentId);
      setStudentData(res.data);
    } catch (e) {
      showToast('Could not load results for this student.', 'error');
    } finally {
      setLoadingResults(false);
    }
  };

  const selectStudent = (s) => {
    setSelectedStudent(s);
    loadStudentResults(s.id);
  };

  const deleteResult = async (resultId) => {
    if (!window.confirm('Delete this semester result? This cannot be undone.')) return;
    try {
      await resultsApi.deleteResult(resultId);
      showToast('Result deleted.');
      loadStudentResults(selectedStudent.id);
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to delete result.', 'error');
    }
  };

  const studentForForm = useMemo(() => (
    selectedStudent && studentData
      ? {
          id: selectedStudent.id, name: studentData.student.name, gr_number: studentData.student.enrollment_number,
          course_id: studentData.student.course_id, course_name: studentData.student.course_name,
          current_semester: studentData.student.current_semester,
        }
      : null
  ), [selectedStudent, studentData]);

  return (
    <div>
      <Toast toast={toast} />
      {formState && studentForForm && (
        <ResultFormModal
          student={studentForForm}
          existing={formState.existing}
          onClose={() => setFormState(null)}
          onSaved={() => loadStudentResults(selectedStudent.id)}
          showToast={showToast}
        />
      )}
      {showBulk && (
        <BulkUploadModal
          onClose={() => setShowBulk(false)}
          showToast={showToast}
          onDone={() => { if (selectedStudent) loadStudentResults(selectedStudent.id); }}
        />
      )}

      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 4 }}>
        <h3 style={{ fontSize: 14, fontWeight: 700, color: '#111827', margin: '0 0 12px', display: 'flex', alignItems: 'center', gap: 6 }}>
          <GraduationCap size={15} color="#dc2626" /> Student Results Management
        </h3>
        <button onClick={() => setShowBulk(true)} style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '8px 14px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', color: '#7c3aed', fontWeight: 600, fontSize: 13, cursor: 'pointer' }}>
          <Upload size={14} /> Bulk Upload
        </button>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '320px 1fr', gap: 16, alignItems: 'start' }}>
        {/* ── Student search / list ── */}
        <div style={{ ...card, marginBottom: 0 }}>
          <div style={{ display: 'flex', gap: 8, marginBottom: 10 }}>
            <input value={search} onChange={e => setSearch(e.target.value)} onKeyDown={e => e.key === 'Enter' && doSearch()} placeholder="Search by name / enrollment no." style={{ ...inputStyle, flex: 1 }} />
            <button onClick={doSearch} style={{ padding: '8px 12px', borderRadius: 8, border: 'none', background: '#f3f4f6', cursor: 'pointer' }}>
              <Search size={14} color="#374151" />
            </button>
          </div>
          {searching ? (
            <div style={{ textAlign: 'center', padding: 20, color: '#9ca3af', fontSize: 12 }}><Loader size={16} /></div>
          ) : searchResults.length === 0 ? (
            <div style={{ textAlign: 'center', padding: 20, color: '#9ca3af', fontSize: 12 }}>No students found.</div>
          ) : (
            <div style={{ display: 'flex', flexDirection: 'column', gap: 4, maxHeight: 480, overflowY: 'auto' }}>
              {searchResults.map(s => (
                <div key={s.id} onClick={() => selectStudent(s)} style={{
                  padding: '10px 12px', borderRadius: 8, cursor: 'pointer', fontSize: 13,
                  background: selectedStudent?.id === s.id ? '#fff1f2' : 'transparent',
                  border: selectedStudent?.id === s.id ? '1px solid #fecdd3' : '1px solid transparent',
                }}>
                  <div style={{ fontWeight: 600, color: '#111827', display: 'flex', alignItems: 'center', gap: 6 }}><User size={13} /> {s.name}</div>
                  <div style={{ fontSize: 11, color: '#9ca3af', marginTop: 2 }}>{s.gr_number} · {s.course_code || s.course_name || '—'} · Sem {s.semester}</div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* ── Selected student's results ── */}
        <div>
          {!selectedStudent ? (
            <div style={{ ...card, textAlign: 'center', padding: 48, color: '#9ca3af', fontSize: 13 }}>
              Select a student to view and manage their semester results.
            </div>
          ) : loadingResults ? (
            <div style={{ ...card, textAlign: 'center', padding: 48, color: '#9ca3af', fontSize: 13 }}>Loading results…</div>
          ) : studentData ? (
            <>
              <div style={{ ...card, display: 'flex', justifyContent: 'space-between', alignItems: 'center', flexWrap: 'wrap', gap: 12 }}>
                <div>
                  <div style={{ fontSize: 15, fontWeight: 700, color: '#111827' }}>{studentData.student.name}</div>
                  <div style={{ fontSize: 12, color: '#6b7280', marginTop: 2 }}>
                    Enrollment No. {studentData.student.enrollment_number} · {studentData.student.course_name || studentData.student.course_code} · Current Semester {studentData.student.current_semester}
                  </div>
                </div>
                <div style={{ display: 'flex', gap: 20, alignItems: 'center' }}>
                  <div style={{ textAlign: 'center' }}>
                    <div style={{ fontSize: 22, fontWeight: 800, color: '#7c3aed' }}>{studentData.cgpa}</div>
                    <div style={{ fontSize: 11, color: '#9ca3af' }}>CGPA</div>
                  </div>
                  {studentData.classification && (
                    <div style={{ textAlign: 'center' }}>
                      <div style={{ fontSize: 13, fontWeight: 700, color: '#111827' }}>{studentData.classification}</div>
                      <div style={{ fontSize: 11, color: '#9ca3af' }}>Classification</div>
                    </div>
                  )}
                  <button onClick={() => setFormState({ existing: null })} style={{ display: 'flex', alignItems: 'center', gap: 6, padding: '9px 14px', borderRadius: 8, border: 'none', background: '#dc2626', color: 'white', fontWeight: 600, fontSize: 13, cursor: 'pointer' }}>
                    <Plus size={14} /> Add Result
                  </button>
                </div>
              </div>

              {!studentData.student.course_id && (
                <InfoNote>This student has no course assigned yet, so subjects cannot be auto-fetched. Assign a course in Student Management first.</InfoNote>
              )}

              {studentData.semesters.length === 0 ? (
                <div style={{ ...card, textAlign: 'center', padding: 40, color: '#9ca3af', fontSize: 13 }}>
                  No results published yet for this student. Click "Add Result" to publish a semester result.
                </div>
              ) : (
                studentData.semesters.map(sem => {
                  const sc = statusColor(sem.result_status);
                  return (
                    <div key={sem.id} style={{ ...card }}>
                      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 10, flexWrap: 'wrap', gap: 10 }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                          <div style={{ width: 34, height: 34, borderRadius: 9, background: '#f5f3ff', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                            <Layers size={16} color="#7c3aed" />
                          </div>
                          <div>
                            <div style={{ fontWeight: 700, color: '#111827', fontSize: 14 }}>
                              Semester {sem.semester}{sem.academic_year ? ` · ${sem.academic_year}` : ''}
                            </div>
                            <div style={{ fontSize: 11, color: '#9ca3af' }}>
                              {sem.subjects.length} subjects · {sem.total_credits} credits · {sem.percentage}%
                              {sem.result_declared_on ? ` · Declared ${new Date(sem.result_declared_on).toLocaleDateString()}` : ''}
                            </div>
                          </div>
                          <span style={{ fontSize: 11, padding: '3px 9px', borderRadius: 20, background: sc.bg, color: sc.color, fontWeight: 700 }}>{sem.result_status}</span>
                        </div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 16 }}>
                          <div style={{ textAlign: 'center' }}>
                            <div style={{ fontSize: 18, fontWeight: 800, color: '#16a34a' }}>{sem.sgpa}</div>
                            <div style={{ fontSize: 10, color: '#9ca3af' }}>SGPA</div>
                          </div>
                          <button onClick={() => setFormState({ existing: sem })} style={{ padding: 6, background: '#f3f4f6', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Edit2 size={13} color="#374151" /></button>
                          <button onClick={() => deleteResult(sem.id)} style={{ padding: 6, background: '#fff1f2', border: 'none', borderRadius: 6, cursor: 'pointer' }}><Trash2 size={13} color="#dc2626" /></button>
                        </div>
                      </div>
                      <div style={{ overflowX: 'auto' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
                          <thead>
                            <tr style={{ background: '#f8fafc', textAlign: 'left', color: '#6b7280' }}>
                              <th style={{ padding: '6px 8px' }}>Code</th>
                              <th style={{ padding: '6px 8px' }}>Subject</th>
                              <th style={{ padding: '6px 8px' }}>Internal</th>
                              <th style={{ padding: '6px 8px' }}>External</th>
                              <th style={{ padding: '6px 8px' }}>Practical</th>
                              <th style={{ padding: '6px 8px' }}>Total</th>
                              <th style={{ padding: '6px 8px' }}>Credits</th>
                              <th style={{ padding: '6px 8px' }}>GP</th>
                              <th style={{ padding: '6px 8px' }}>Grade</th>
                              <th style={{ padding: '6px 8px' }}>Credit Pts</th>
                              <th style={{ padding: '6px 8px' }}>Status</th>
                            </tr>
                          </thead>
                          <tbody>
                            {sem.subjects.map(sub => {
                              const subc = statusColor(sub.status);
                              return (
                                <tr key={sub.id} style={{ borderTop: '1px solid #f3f4f6' }}>
                                  <td style={{ padding: '6px 8px', color: '#9ca3af' }}>{sub.subject_code || '-'}</td>
                                  <td style={{ padding: '6px 8px', fontWeight: 600 }}>{sub.subject_name}</td>
                                  <td style={{ padding: '6px 8px' }}>{sub.internal_marks ?? 0} / {sub.internal_max ?? 0}</td>
                                  <td style={{ padding: '6px 8px' }}>{sub.external_marks ?? sub.obtained_marks} / {sub.external_max ?? sub.max_marks}</td>
                                  <td style={{ padding: '6px 8px' }}>{Number(sub.practical_max) > 0 ? `${sub.practical_marks ?? 0} / ${sub.practical_max}` : '—'}</td>
                                  <td style={{ padding: '6px 8px' }}>{sub.obtained_marks} / {sub.max_marks}</td>
                                  <td style={{ padding: '6px 8px' }}>{sub.credits}</td>
                                  <td style={{ padding: '6px 8px' }}>{sub.grade_point ?? '-'}</td>
                                  <td style={{ padding: '6px 8px', fontWeight: 700 }}>{sub.grade}</td>
                                  <td style={{ padding: '6px 8px' }}>{Number(sub.credit_points ?? 0).toFixed(1)}</td>
                                  <td style={{ padding: '6px 8px' }}>
                                    <span style={{ fontSize: 11, padding: '2px 8px', borderRadius: 20, background: subc.bg, color: subc.color, fontWeight: 700 }}>{sub.status}</span>
                                  </td>
                                </tr>
                              );
                            })}
                          </tbody>
                        </table>
                      </div>
                      {sem.remarks && <div style={{ fontSize: 11, color: '#9ca3af', marginTop: 8 }}><Award size={11} style={{ verticalAlign: 'middle', marginRight: 4 }} />{sem.remarks}</div>}
                    </div>
                  );
                })
              )}
            </>
          ) : null}
        </div>
      </div>
    </div>
  );
}