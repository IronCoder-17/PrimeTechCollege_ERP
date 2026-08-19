// ============================================================
// FeeManagementPanel — Admin: Fee Structure Management
//
// 100% database-driven. Every tab (College Fees, Registration &
// Other Charges, Hostel Fee Plans, Transportation Routes) reads
// and writes directly through the backend REST APIs
// (admission.php, fees.php, transportation.php). Nothing is
// cached in localStorage — every Admin save persists to MySQL
// and is instantly reflected on the Registration form, student
// dashboards, and the downloadable Fee Structure document.
// ============================================================

import React, { useEffect, useState, useCallback } from 'react';
import { Edit2, Trash2, PlusCircle, Save, X, CheckCircle, AlertTriangle, RefreshCw } from 'lucide-react';
import { admissionApi, feesApi, transportationApi } from '../../utils/api';

// ── Coverage-area locations available for new Transportation routes ──
export const TRANSPORT_LOCATIONS = [
  'Rajkot', 'Wankaner', 'Gondal', 'Porbandar', 'Morbi',
  'Jetpur', 'Jamnagar', 'Dhrol', 'Surendranagar', 'Maliya-Miyana',
];

// ── Shared styles ─────────────────────────────────────────────
const card    = { background:'white', borderRadius:16, padding:24, border:'1px solid #e5e7eb', marginBottom:16 };
const input   = { width:'100%', padding:'8px 11px', borderRadius:8, border:'1px solid #e5e7eb', fontSize:13, color:'#374151', boxSizing:'border-box' };
const lbl     = { fontSize:11, fontWeight:600, color:'#6b7280', display:'block', marginBottom:4 };
const iconBtn = (bg) => ({ padding:6, background:bg, border:'none', borderRadius:6, cursor:'pointer', display:'flex', alignItems:'center', justifyContent:'center' });
const fmt     = (n)  => `₹${Number(n||0).toLocaleString('en-IN')}`;

// ── Toast ──────────────────────────────────────────────────────
function Toast({ toast }) {
  if (!toast) return null;
  const err = toast.type === 'error';
  return (
    <div style={{
      position:'fixed', top:20, right:20, zIndex:2000, display:'flex', alignItems:'center', gap:8,
      padding:'12px 18px', borderRadius:10, boxShadow:'0 4px 16px rgba(0,0,0,0.10)',
      background: err ? '#fff1f2' : '#f0fdf4',
      border:`1px solid ${err ? '#fecdd3' : '#bbf7d0'}`,
      color: err ? '#dc2626' : '#16a34a', fontSize:13, fontWeight:600,
    }}>
      {err ? <AlertTriangle size={15}/> : <CheckCircle size={15}/>}
      {toast.message}
    </div>
  );
}

// ── Main Panel ─────────────────────────────────────────────────
export default function FeeManagementPanel() {
  const [section, setSection] = useState('college');
  const [toast,   setToast]   = useState(null);

  const showToast = (message, type = 'success') => {
    setToast({ message, type });
    setTimeout(() => setToast(null), 3200);
  };

  const tabs = [
    { key:'college',  label:'College Fees (Tuition & Exam)' },
    { key:'global',   label:'Registration & Other Charges'  },
    { key:'hostel',   label:'Hostel Fee Plans'               },
    { key:'transport', label:'Transportation Routes'         },
  ];

  return (
    <div>
      <Toast toast={toast} />

      {/* Live-sync notice */}
      <div style={{ display:'flex', alignItems:'center', gap:8, padding:'10px 16px', background:'#f0fdf4', border:'1px solid #bbf7d0', borderRadius:10, marginBottom:16, fontSize:13, color:'#16a34a' }}>
        <CheckCircle size={15}/>
        <span><b>Live sync enabled:</b> Any fee change you save here is immediately reflected on the student Registration Form — no page reload needed.</span>
      </div>

      {/* Sub-nav */}
      <div style={{ display:'flex', gap:8, marginBottom:16, flexWrap:'wrap' }}>
        {tabs.map(({ key, label }) => (
          <button key={key} onClick={() => setSection(key)} style={{
            padding:'9px 16px', borderRadius:9, cursor:'pointer', fontSize:13, fontWeight:600,
            background: section === key ? '#dc2626' : 'white',
            color:      section === key ? 'white'   : '#374151',
            border:    `1px solid ${section === key ? '#dc2626' : '#e5e7eb'}`,
          }}>
            {label}
          </button>
        ))}
      </div>

      {section === 'college'   && <CollegeFees      showToast={showToast} />}
      {section === 'global'    && <GlobalFees       showToast={showToast} />}
      {section === 'hostel'    && <HostelPlans      showToast={showToast} />}
      {section === 'transport' && <TransportRoutes  showToast={showToast} />}
    </div>
  );
}

// ============================================================
// 1. COLLEGE FEES — per-course, per-semester tuition + exam fee
// ============================================================
function CollegeFees({ showToast }) {
  // `courses` is loaded LIVE from the database (admission.php /fee-structure),
  // grouped per course with every semester's tuition/exam/total fee row —
  // nothing here is hard-coded on the frontend.
  const [courses,   setCourses]   = useState([]);
  const [examSettingId, setExamSettingId] = useState(null);
  const [examFee,   setExamFee]   = useState(0);
  const [loading,   setLoading]   = useState(true);
  const [expanded,  setExpanded]  = useState(null);
  const [editCell,  setEditCell]  = useState(null); // { rowId, courseId, semIdx }
  const [editVal,   setEditVal]   = useState('');
  const [editExam,  setEditExam]  = useState(false);
  const [examVal,   setExamVal]   = useState('');
  const [saving,    setSaving]    = useState(false);

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const { data } = await admissionApi.getFeeStructure();
      const list = data?.courses || [];
      setCourses(list);
      if (!expanded && list.length) setExpanded(list[0].course_id);
    } catch (e) {
      showToast('Could not load course fee structure from the server.', 'error');
    }
    try {
      const { data } = await feesApi.getSettings();
      const row = (data?.settings || []).find(s => s.fee_key === 'exam_fee');
      if (row) { setExamSettingId(row.id); setExamFee(Number(row.amount)); }
    } catch (e) {}
    setLoading(false);
  }, []); // eslint-disable-line

  useEffect(() => { load(); }, []); // eslint-disable-line

  // Save tuition cell — persists straight to the fee_structure table
  const saveTuition = async (rowId, courseId, semIdx) => {
    const v = Number(editVal);
    if (isNaN(v) || v < 0) { showToast('Enter a valid amount.', 'error'); return; }
    setSaving(true);
    try {
      await admissionApi.updateFeeStructure(rowId, { tuition_fee: v });
      await load();
      setEditCell(null);
      showToast('Tuition fee updated in the database — live on Registration Form now ✓');
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to update tuition fee.', 'error');
    }
    setSaving(false);
  };

  // Save the global Examination Fee (fee_settings) — applies to every course/semester
  const saveExamFee = async () => {
    const v = Number(examVal);
    if (isNaN(v) || v < 0) { showToast('Enter a valid amount.', 'error'); return; }
    if (!examSettingId) { showToast('Examination fee setting not found.', 'error'); return; }
    setSaving(true);
    try {
      await feesApi.updateSetting(examSettingId, { amount: v });
      setExamFee(v);
      setEditExam(false);
      showToast('Examination fee updated in the database — live on Registration Form now ✓');
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to update examination fee.', 'error');
    }
    setSaving(false);
  };

  if (loading) return <div style={card}>Loading fee structure…</div>;

  return (
    <div>
      {/* Exam Fee card */}
      <div style={{ ...card, display:'flex', alignItems:'center', justifyContent:'space-between', flexWrap:'wrap', gap:12 }}>
        <div>
          <div style={{ fontSize:15, fontWeight:700, color:'#111827' }}>Examination Fee (per semester, all courses)</div>
          <div style={{ fontSize:12, color:'#6b7280', marginTop:2 }}>Added to tuition fee every semester. Change here updates every course simultaneously.</div>
        </div>
        {editExam ? (
          <div style={{ display:'flex', alignItems:'center', gap:8 }}>
            <input autoFocus type="number" min="0" value={examVal} onChange={e => setExamVal(e.target.value)}
              style={{ ...input, width:130 }} onKeyDown={e => { if(e.key==='Enter') saveExamFee(); if(e.key==='Escape') setEditExam(false); }} />
            <button disabled={saving} onClick={saveExamFee} style={{ ...iconBtn('#f0fdf4'), padding:'8px 14px', fontWeight:600, color:'#16a34a', fontSize:13 }}><Save size={14} style={{marginRight:4}}/> Save</button>
            <button onClick={() => setEditExam(false)} style={iconBtn('#f3f4f6')}><X size={14} color="#6b7280"/></button>
          </div>
        ) : (
          <div style={{ display:'flex', alignItems:'center', gap:12 }}>
            <span style={{ fontSize:22, fontWeight:800, color:'#16a34a' }}>{fmt(examFee)}</span>
            <button onClick={() => { setEditExam(true); setExamVal(examFee); }}
              style={{ display:'flex', alignItems:'center', gap:6, padding:'8px 14px', background:'#eff6ff', border:'none', borderRadius:8, cursor:'pointer', fontSize:13, fontWeight:600, color:'#2563eb' }}>
              <Edit2 size={13}/> Edit
            </button>
          </div>
        )}
      </div>

      {/* Refresh button */}
      <div style={{ display:'flex', justifyContent:'flex-end', marginBottom:12 }}>
        <button onClick={load} style={{ display:'flex', alignItems:'center', gap:6, padding:'7px 14px', background:'#fff7ed', border:'1px solid #fed7aa', borderRadius:8, cursor:'pointer', fontSize:12, fontWeight:600, color:'#c2410c' }}>
          <RefreshCw size={12}/> Refresh from Database
        </button>
      </div>

      {/* Per-course fee tables — courses & semesters come straight from the DB */}
      {courses.map(course => (
        <div key={course.course_id} style={card}>
          <button onClick={() => setExpanded(expanded === course.course_id ? null : course.course_id)}
            style={{ width:'100%', display:'flex', justifyContent:'space-between', alignItems:'center', background:'none', border:'none', cursor:'pointer', padding:0, textAlign:'left' }}>
            <div>
              <div style={{ fontSize:14, fontWeight:700, color:'#111827' }}>{course.course_name}</div>
              <div style={{ fontSize:11, color:'#9ca3af', marginTop:2 }}>{course.course_code} · {course.department} · {course.total_semesters} semesters</div>
            </div>
            <span style={{ fontSize:12, color:'#2563eb', fontWeight:600 }}>{expanded === course.course_id ? '▲ Hide' : '▼ Show'}</span>
          </button>

          {expanded === course.course_id && (
            <table style={{ width:'100%', borderCollapse:'collapse', fontSize:13, marginTop:16 }}>
              <thead>
                <tr style={{ background:'#f9fafb' }}>
                  {['Semester','Tuition Fee','Exam Fee','Total Fee','Action'].map(h => (
                    <th key={h} style={{ padding:'9px 12px', textAlign:'left', fontSize:11, fontWeight:700, color:'#6b7280', textTransform:'uppercase', letterSpacing:'0.04em', borderBottom:'1px solid #e5e7eb' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {(course.fees || []).slice().sort((a,b) => a.semester - b.semester).map((row, i) => {
                  const tuition = Number(row.tuition_fee) || 0;
                  const isEditing = editCell?.rowId === row.id;
                  const displayTuition = isEditing ? Number(editVal || 0) : tuition;
                  return (
                    <tr key={row.id} style={{ borderBottom:'1px solid #f3f4f6' }}>
                      <td style={{ padding:'9px 12px', fontWeight:600, color:'#111827' }}>Sem {row.semester}</td>
                      <td style={{ padding:'9px 12px' }}>
                        {isEditing ? (
                          <input autoFocus type="number" min="0" value={editVal}
                            onChange={e => setEditVal(e.target.value)}
                            onKeyDown={e => { if(e.key==='Enter') saveTuition(row.id, course.course_id, i); if(e.key==='Escape') setEditCell(null); }}
                            style={{ ...input, width:120 }} />
                        ) : (
                          <span style={{ fontWeight:600 }}>{fmt(tuition)}</span>
                        )}
                      </td>
                      <td style={{ padding:'9px 12px', color:'#6b7280' }}>{fmt(examFee)}</td>
                      <td style={{ padding:'9px 12px', fontWeight:700, color:'#16a34a' }}>{fmt(displayTuition + examFee)}</td>
                      <td style={{ padding:'9px 12px' }}>
                        {isEditing ? (
                          <div style={{ display:'flex', gap:6 }}>
                            <button disabled={saving} onClick={() => saveTuition(row.id, course.course_id, i)} style={iconBtn('#f0fdf4')}><Save size={13} color="#16a34a"/></button>
                            <button onClick={() => setEditCell(null)} style={iconBtn('#f3f4f6')}><X size={13} color="#6b7280"/></button>
                          </div>
                        ) : (
                          <button onClick={() => { setEditCell({ rowId:row.id, courseId:course.course_id, semIdx:i }); setEditVal(tuition); }} style={iconBtn('#eff6ff')}>
                            <Edit2 size={13} color="#2563eb"/>
                          </button>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
        </div>
      ))}
      {!courses.length && (
        <div style={{ textAlign:'center', padding:48, color:'#9ca3af', fontSize:14 }}>No courses found. Add courses to the `courses` table to manage their fee structure.</div>
      )}
    </div>
  );
}

// ============================================================
// 2. GLOBAL FEE SETTINGS
// ============================================================
function GlobalFees({ showToast }) {
  const [fees,      setFees]    = useState([]);
  const [loading,   setLoading] = useState(true);
  const [editingId, setEditing] = useState(null);
  const [editVal,   setEditVal] = useState('');
  const [saving,    setSaving]  = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const { data } = await feesApi.getSettings();
      setFees(data?.settings || []);
    } catch (e) {
      showToast('Could not load fee settings from the server.', 'error');
    }
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const startEdit = (f) => { setEditing(f.id); setEditVal(f.amount); };
  const cancel    = ()  => { setEditing(null); setEditVal(''); };

  const save = async (f) => {
    const v = Number(editVal);
    if (isNaN(v) || v < 0) { showToast('Enter a valid non-negative amount.', 'error'); return; }
    setSaving(true);
    try {
      await feesApi.updateSetting(f.id, { amount: v });
      await load();
      setEditing(null);
      showToast(`${f.label} updated in the database — live on the Registration Form now ✓`);
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to update fee.', 'error');
    }
    setSaving(false);
  };

  const catLabel = { college:'College', registration:'Registration', hostel:'Hostel', other:'Other Charges' };
  const catColor = { college:'#eff6ff', registration:'#f0fdf4', hostel:'#fff7ed', other:'#f5f3ff' };
  const catText  = { college:'#2563eb', registration:'#16a34a', hostel:'#c2410c', other:'#7c3aed' };

  if (loading) return <div style={card}>Loading fee settings…</div>;

  return (
    <div style={card}>
      <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:6 }}>
        <h2 style={{ fontSize:16, fontWeight:600, color:'#111827', margin:0 }}>Registration &amp; Other Charges</h2>
        <button onClick={load} style={{ display:'flex', alignItems:'center', gap:6, padding:'7px 12px', background:'#fff7ed', border:'1px solid #fed7aa', borderRadius:8, cursor:'pointer', fontSize:12, fontWeight:600, color:'#c2410c' }}>
          <RefreshCw size={12}/> Refresh
        </button>
      </div>
      <p style={{ fontSize:13, color:'#6b7280', margin:'0 0 20px' }}>
        These charges are stored centrally in the <code>fee_settings</code> table and reflected automatically on the
        Admission page, student dashboards, and the downloadable Fee Structure. Edit any amount and click Save —
        changes are instant.
      </p>
      <table style={{ width:'100%', borderCollapse:'collapse', fontSize:13 }}>
        <thead>
          <tr style={{ background:'#f9fafb' }}>
            {['Fee Name','Category','Amount','Description','Action'].map(h => (
              <th key={h} style={{ padding:'9px 14px', textAlign:'left', fontSize:11, fontWeight:700, color:'#6b7280', textTransform:'uppercase', letterSpacing:'0.04em', borderBottom:'1px solid #e5e7eb' }}>{h}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {fees.map(f => (
            <tr key={f.id} style={{ borderBottom:'1px solid #f3f4f6' }}>
              <td style={{ padding:'11px 14px', fontWeight:600, color:'#111827' }}>{f.label}</td>
              <td style={{ padding:'11px 14px' }}>
                <span style={{ padding:'3px 10px', borderRadius:20, fontSize:11, fontWeight:700, background:catColor[f.category]||'#f3f4f6', color:catText[f.category]||'#374151' }}>
                  {catLabel[f.category]||f.category}
                </span>
              </td>
              <td style={{ padding:'11px 14px' }}>
                {editingId === f.id ? (
                  <input autoFocus type="number" min="0" value={editVal}
                    onChange={e => setEditVal(e.target.value)}
                    onKeyDown={e => { if(e.key==='Enter') save(f); if(e.key==='Escape') cancel(); }}
                    style={{ ...input, width:120 }} />
                ) : (
                  <span style={{ fontWeight:700, color:'#16a34a', fontSize:15 }}>{fmt(f.amount)}</span>
                )}
              </td>
              <td style={{ padding:'11px 14px', color:'#6b7280', fontSize:12 }}>{f.description}</td>
              <td style={{ padding:'11px 14px' }}>
                {editingId === f.id ? (
                  <div style={{ display:'flex', gap:6 }}>
                    <button disabled={saving} onClick={() => save(f)} style={iconBtn('#f0fdf4')}><Save size={13} color="#16a34a"/></button>
                    <button onClick={cancel} style={iconBtn('#f3f4f6')}><X size={13} color="#6b7280"/></button>
                  </div>
                ) : (
                  <button onClick={() => startEdit(f)} style={iconBtn('#eff6ff')}><Edit2 size={13} color="#2563eb"/></button>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

// ============================================================
// 3. HOSTEL FEE PLANS — full Add / Edit / Delete
// ============================================================
const HOSTEL_TYPES = ['Boys Hostel','Girls Hostel'];
const ROOM_TYPES   = ['Non-AC (3 Sharing)','Non-AC (2 Sharing)','AC (2 Sharing)'];
const EMPTY_PLAN   = { hostel_type:'Boys Hostel', room_type:'Non-AC (3 Sharing)', hostel_admission_fee:5000, security_deposit:10000, hostel_fee:0, mess_fee:25000, maintenance_fee:3000 };
const FEE_FIELDS   = [
  ['hostel_admission_fee','Admission Fee (One-Time)'],
  ['security_deposit',    'Security Deposit (Refundable)'],
  ['hostel_fee',          'Hostel Fee (Per Semester)'],
  ['mess_fee',            'Mess Fee (Per Semester)'],
  ['maintenance_fee',     'Maintenance Fee (Per Semester)'],
];

function HostelPlans({ showToast }) {
  const [plans,      setPlans]    = useState([]);
  const [loading,    setLoading]  = useState(true);
  const [showForm,   setShowForm] = useState(false);
  const [editingId,  setEditing]  = useState(null);
  const [form,       setForm]     = useState(EMPTY_PLAN);
  const [saving,     setSaving]   = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const { data } = await feesApi.getHostelPlans();
      setPlans(data?.plans || []);
    } catch (e) {
      showToast('Could not load hostel fee plans from the server.', 'error');
    }
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const openAdd  = ()  => { setForm(EMPTY_PLAN); setEditing(null); setShowForm(true); };
  const openEdit = (p) => {
    const { id, total_fee, ...rest } = p;
    setForm({ ...EMPTY_PLAN, ...rest });
    setEditing(id);
    setShowForm(true);
  };

  const setField = (k, v) => setForm(f => ({ ...f, [k]:v }));

  const total = FEE_FIELDS.reduce((s,[k]) => s + Number(form[k]||0), 0);

  const handleSave = async () => {
    for (const [k] of FEE_FIELDS) {
      if (isNaN(Number(form[k])) || Number(form[k]) < 0) {
        showToast('All fee amounts must be valid non-negative numbers.', 'error'); return;
      }
    }
    const payload = { hostel_type: form.hostel_type, room_type: form.room_type };
    FEE_FIELDS.forEach(([k]) => { payload[k] = Number(form[k]); });

    setSaving(true);
    try {
      if (editingId !== null) {
        await feesApi.updateHostelPlan(editingId, payload);
        showToast('Hostel fee plan updated in the database — live on the Admission page now ✓');
      } else {
        await feesApi.createHostelPlan(payload);
        showToast('Hostel fee plan created ✓');
      }
      await load();
      setShowForm(false);
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to save hostel fee plan.', 'error');
    }
    setSaving(false);
  };

  const handleDelete = async (p) => {
    if (!confirm(`Delete fee plan for ${p.hostel_type} / ${p.room_type}?`)) return;
    try {
      await feesApi.deleteHostelPlan(p.id);
      await load();
      showToast('Hostel fee plan deleted.');
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to delete hostel fee plan.', 'error');
    }
  };

  if (loading) return <div style={card}>Loading hostel fee plans…</div>;

  return (
    <div>
      <div style={card}>
        <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:6, flexWrap:'wrap', gap:8 }}>
          <h2 style={{ fontSize:16, fontWeight:600, color:'#111827', margin:0 }}>Hostel Fee Plans</h2>
          <div style={{ display:'flex', gap:8 }}>
            <button onClick={load} style={{ display:'flex', alignItems:'center', gap:6, padding:'7px 12px', background:'#fff7ed', border:'1px solid #fed7aa', borderRadius:8, cursor:'pointer', fontSize:12, fontWeight:600, color:'#c2410c' }}>
              <RefreshCw size={12}/> Refresh
            </button>
            <button onClick={openAdd} style={{ display:'flex', alignItems:'center', gap:6, padding:'8px 16px', background:'#dc2626', color:'white', border:'none', borderRadius:8, cursor:'pointer', fontSize:13, fontWeight:600 }}>
              <PlusCircle size={14}/> Add Plan
            </button>
          </div>
        </div>
        <p style={{ fontSize:13, color:'#6b7280', margin:'0 0 20px' }}>
          Changes here are immediately reflected on the student registration and hostel application forms.
        </p>

        {plans.length === 0 ? (
          <div style={{ textAlign:'center', padding:48, color:'#9ca3af', fontSize:14 }}>No hostel fee plans yet. Click "Add Plan" to create one.</div>
        ) : (
          <div style={{ overflowX:'auto' }}>
            <table style={{ width:'100%', borderCollapse:'collapse', fontSize:13, minWidth:780 }}>
              <thead>
                <tr style={{ background:'#f9fafb' }}>
                  {['Hostel Type','Room Type','Admission','Deposit','Hostel Fee','Mess','Maintenance','Total','Actions'].map(h => (
                    <th key={h} style={{ padding:'9px 11px', textAlign:'left', fontSize:11, fontWeight:700, color:'#6b7280', textTransform:'uppercase', letterSpacing:'0.03em', borderBottom:'1px solid #e5e7eb', whiteSpace:'nowrap' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {plans.map(p => (
                  <tr key={p.id} style={{ borderBottom:'1px solid #f3f4f6' }}>
                    <td style={{ padding:'10px 11px', fontWeight:600, color:'#111827' }}>{p.hostel_type}</td>
                    <td style={{ padding:'10px 11px', color:'#374151' }}>{p.room_type}</td>
                    <td style={{ padding:'10px 11px' }}>{fmt(p.hostel_admission_fee)}</td>
                    <td style={{ padding:'10px 11px' }}>{fmt(p.security_deposit)}</td>
                    <td style={{ padding:'10px 11px' }}>{fmt(p.hostel_fee)}</td>
                    <td style={{ padding:'10px 11px' }}>{fmt(p.mess_fee)}</td>
                    <td style={{ padding:'10px 11px' }}>{fmt(p.maintenance_fee)}</td>
                    <td style={{ padding:'10px 11px', fontWeight:800, color:'#16a34a' }}>{fmt(p.total_fee || (p.hostel_admission_fee+p.security_deposit+p.hostel_fee+p.mess_fee+p.maintenance_fee))}</td>
                    <td style={{ padding:'10px 11px' }}>
                      <div style={{ display:'flex', gap:6 }}>
                        <button onClick={() => openEdit(p)} style={iconBtn('#eff6ff')}><Edit2 size={13} color="#2563eb"/></button>
                        <button onClick={() => handleDelete(p)} style={iconBtn('#fff1f2')}><Trash2 size={13} color="#dc2626"/></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Add / Edit Modal */}
      {showForm && (
        <div style={{ position:'fixed', inset:0, background:'rgba(0,0,0,0.45)', display:'flex', alignItems:'center', justifyContent:'center', zIndex:1000 }}
          onClick={() => setShowForm(false)}>
          <div onClick={e => e.stopPropagation()} style={{ background:'white', borderRadius:16, padding:28, width:480, maxHeight:'88vh', overflowY:'auto' }}>
            <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:20 }}>
              <h2 style={{ fontSize:16, fontWeight:700, color:'#111827', margin:0 }}>
                {editingId !== null ? 'Edit Hostel Fee Plan' : 'Add Hostel Fee Plan'}
              </h2>
              <button onClick={() => setShowForm(false)} style={{ background:'none', border:'none', cursor:'pointer' }}><X size={18} color="#9ca3af"/></button>
            </div>

            <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:12, marginBottom:14 }}>
              <div>
                <label style={lbl}>Hostel Type</label>
                <select style={input} value={form.hostel_type} onChange={e => setField('hostel_type', e.target.value)}>
                  {HOSTEL_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                </select>
              </div>
              <div>
                <label style={lbl}>Room Type</label>
                <select style={input} value={form.room_type} onChange={e => setField('room_type', e.target.value)}>
                  {ROOM_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                </select>
              </div>
            </div>

            {FEE_FIELDS.map(([key, label]) => (
              <div key={key} style={{ marginBottom:12 }}>
                <label style={lbl}>{label}</label>
                <input type="number" min="0" style={input} value={form[key]}
                  onChange={e => setField(key, e.target.value)} />
              </div>
            ))}

            {/* Total preview */}
            <div style={{ display:'flex', justifyContent:'space-between', padding:'12px 14px', background:'#f9fafb', borderRadius:10, marginBottom:20, fontSize:14 }}>
              <span style={{ fontWeight:600, color:'#374151' }}>Total Fee Preview</span>
              <span style={{ fontWeight:800, color:'#16a34a', fontSize:16 }}>{fmt(total)}</span>
            </div>

            <div style={{ display:'flex', gap:10 }}>
              <button disabled={saving} onClick={handleSave} style={{ flex:1, padding:'11px 0', background:'#dc2626', color:'white', border:'none', borderRadius:9, cursor:'pointer', fontSize:14, fontWeight:700 }}>
                {editingId !== null ? 'Save Changes' : 'Create Plan'}
              </button>
              <button onClick={() => setShowForm(false)} style={{ padding:'11px 22px', background:'#f3f4f6', color:'#374151', border:'none', borderRadius:9, cursor:'pointer', fontSize:13, fontWeight:600 }}>
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

// ============================================================
// 4. TRANSPORTATION ROUTES — full Add / Edit / Delete
//
// Admin manages bus routes here: Route Name / Location, Bus
// Number, Transportation Fee, and Active/Inactive status. The
// Student Registration form's "Location" dropdown only shows
// Active routes, and auto-fetches the matching Bus Number +
// Transportation Fee the instant a location is selected — so any
// change saved here is "live" on the Registration form with no
// code changes needed.
// ============================================================
const EMPTY_ROUTE = { location:'', bus_number:'', transport_fee:0, status:'active' };

function TransportRoutes({ showToast }) {
  const [routes,    setRoutes]   = useState([]);
  const [loading,   setLoading]  = useState(true);
  const [showForm,  setShowForm] = useState(false);
  const [editingId, setEditing]  = useState(null);
  const [form,      setForm]     = useState(EMPTY_ROUTE);
  const [saving,    setSaving]   = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const { data } = await transportationApi.getAllRoutes();
      setRoutes(data?.routes || []);
    } catch (e) {
      showToast('Could not load transportation routes from the server.', 'error');
    }
    setLoading(false);
  };

  useEffect(() => { load(); }, []);

  const openAdd = () => {
    // Default to the first coverage-area location not already in use
    const used = routes.map(r => r.location);
    const next = TRANSPORT_LOCATIONS.find(loc => !used.includes(loc)) || TRANSPORT_LOCATIONS[0];
    setForm({ ...EMPTY_ROUTE, location: next });
    setEditing(null);
    setShowForm(true);
  };
  const openEdit = (r) => {
    const { id, created_at, updated_at, ...rest } = r;
    setForm({ ...EMPTY_ROUTE, ...rest });
    setEditing(id);
    setShowForm(true);
  };

  const setField = (k, v) => setForm(f => ({ ...f, [k]:v }));

  const handleSave = async () => {
    if (!form.location) { showToast('Location is required.', 'error'); return; }
    if (!String(form.bus_number).trim()) { showToast('Bus Number is mandatory for every route.', 'error'); return; }
    const fee = Number(form.transport_fee);
    if (isNaN(fee) || fee < 0) { showToast('Transportation Fee must be a valid non-negative amount.', 'error'); return; }

    // Location must stay unique across routes (DB has a UNIQUE constraint too)
    const duplicate = routes.some(r => r.location === form.location && r.id !== editingId);
    if (duplicate) { showToast(`A route for ${form.location} already exists.`, 'error'); return; }

    const payload = { location: form.location, bus_number: String(form.bus_number).trim(), transport_fee: fee, status: form.status };

    setSaving(true);
    try {
      if (editingId !== null) {
        await transportationApi.updateRoute(editingId, payload);
        showToast('Transportation route updated in the database — live on the Registration Form now ✓');
      } else {
        await transportationApi.createRoute(payload);
        showToast('Transportation route created ✓');
      }
      await load();
      setShowForm(false);
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to save transportation route.', 'error');
    }
    setSaving(false);
  };

  const handleDelete = async (r) => {
    if (!confirm(`Delete the transportation route for ${r.location}?`)) return;
    try {
      await transportationApi.deleteRoute(r.id);
      await load();
      showToast('Transportation route deleted.');
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to delete route.', 'error');
    }
  };

  const toggleStatus = async (r) => {
    const next = r.status === 'active' ? 'inactive' : 'active';
    try {
      await transportationApi.updateRoute(r.id, { status: next });
      await load();
      showToast(`${r.location} marked ${next === 'active' ? 'Active' : 'Inactive'} — ${next === 'active' ? 'now visible' : 'hidden'} on the Registration Form.`);
    } catch (e) {
      showToast(e?.response?.data?.error || 'Failed to update status.', 'error');
    }
  };

  if (loading) return <div style={card}>Loading transportation routes…</div>;

  return (
    <div>
      <div style={card}>
        <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:6, flexWrap:'wrap', gap:8 }}>
          <h2 style={{ fontSize:16, fontWeight:600, color:'#111827', margin:0 }}>Transportation Routes</h2>
          <div style={{ display:'flex', gap:8 }}>
            <button onClick={load} style={{ display:'flex', alignItems:'center', gap:6, padding:'7px 12px', background:'#fff7ed', border:'1px solid #fed7aa', borderRadius:8, cursor:'pointer', fontSize:12, fontWeight:600, color:'#c2410c' }}>
              <RefreshCw size={12}/> Refresh
            </button>
            <button onClick={openAdd} style={{ display:'flex', alignItems:'center', gap:6, padding:'8px 16px', background:'#dc2626', color:'white', border:'none', borderRadius:8, cursor:'pointer', fontSize:13, fontWeight:600 }}>
              <PlusCircle size={14}/> Add Route
            </button>
          </div>
        </div>
        <p style={{ fontSize:13, color:'#6b7280', margin:'0 0 20px' }}>
          Manage bus routes, bus numbers, and fees for each coverage area. Only <b>Active</b> routes appear on the
          student Registration form's Location dropdown — changes here (fees, bus numbers, status) are reflected
          there immediately.
        </p>

        {routes.length === 0 ? (
          <div style={{ textAlign:'center', padding:48, color:'#9ca3af', fontSize:14 }}>No transportation routes yet. Click "Add Route" to create one.</div>
        ) : (
          <div style={{ overflowX:'auto' }}>
            <table style={{ width:'100%', borderCollapse:'collapse', fontSize:13, minWidth:640 }}>
              <thead>
                <tr style={{ background:'#f9fafb' }}>
                  {['Location','Bus Number','Transportation Fee','Status','Actions'].map(h => (
                    <th key={h} style={{ padding:'9px 11px', textAlign:'left', fontSize:11, fontWeight:700, color:'#6b7280', textTransform:'uppercase', letterSpacing:'0.03em', borderBottom:'1px solid #e5e7eb', whiteSpace:'nowrap' }}>{h}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {routes.map(r => (
                  <tr key={r.id} style={{ borderBottom:'1px solid #f3f4f6' }}>
                    <td style={{ padding:'10px 11px', fontWeight:600, color:'#111827' }}>{r.location}</td>
                    <td style={{ padding:'10px 11px', color:'#374151' }}>{r.bus_number}</td>
                    <td style={{ padding:'10px 11px', fontWeight:700, color:'#16a34a' }}>{fmt(r.transport_fee)}</td>
                    <td style={{ padding:'10px 11px' }}>
                      <button onClick={() => toggleStatus(r)} style={{
                        padding:'4px 12px', borderRadius:20, fontSize:11, fontWeight:700, border:'none', cursor:'pointer',
                        background: r.status === 'active' ? '#f0fdf4' : '#f3f4f6',
                        color:      r.status === 'active' ? '#16a34a' : '#9ca3af',
                      }}>
                        {r.status === 'active' ? '● Active' : '○ Inactive'}
                      </button>
                    </td>
                    <td style={{ padding:'10px 11px' }}>
                      <div style={{ display:'flex', gap:6 }}>
                        <button onClick={() => openEdit(r)} style={iconBtn('#eff6ff')}><Edit2 size={13} color="#2563eb"/></button>
                        <button onClick={() => handleDelete(r)} style={iconBtn('#fff1f2')}><Trash2 size={13} color="#dc2626"/></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Add / Edit Modal */}
      {showForm && (
        <div style={{ position:'fixed', inset:0, background:'rgba(0,0,0,0.45)', display:'flex', alignItems:'center', justifyContent:'center', zIndex:1000 }}
          onClick={() => setShowForm(false)}>
          <div onClick={e => e.stopPropagation()} style={{ background:'white', borderRadius:16, padding:28, width:440, maxHeight:'88vh', overflowY:'auto' }}>
            <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', marginBottom:20 }}>
              <h2 style={{ fontSize:16, fontWeight:700, color:'#111827', margin:0 }}>
                {editingId !== null ? 'Edit Transportation Route' : 'Add Transportation Route'}
              </h2>
              <button onClick={() => setShowForm(false)} style={{ background:'none', border:'none', cursor:'pointer' }}><X size={18} color="#9ca3af"/></button>
            </div>

            <div style={{ marginBottom:14 }}>
              <label style={lbl}>Route Name / Location</label>
              <select style={input} value={form.location} onChange={e => setField('location', e.target.value)}>
                {TRANSPORT_LOCATIONS.map(t => <option key={t} value={t}>{t}</option>)}
              </select>
            </div>

            <div style={{ marginBottom:14 }}>
              <label style={lbl}>Bus Number</label>
              <input type="text" placeholder="e.g. BUS-01" style={input} value={form.bus_number}
                onChange={e => setField('bus_number', e.target.value)} />
            </div>

            <div style={{ marginBottom:14 }}>
              <label style={lbl}>Transportation Fee</label>
              <input type="number" min="0" style={input} value={form.transport_fee}
                onChange={e => setField('transport_fee', e.target.value)} />
            </div>

            <div style={{ marginBottom:20 }}>
              <label style={lbl}>Status</label>
              <select style={input} value={form.status} onChange={e => setField('status', e.target.value)}>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
              </select>
            </div>

            <div style={{ display:'flex', gap:10 }}>
              <button disabled={saving} onClick={handleSave} style={{ flex:1, padding:'11px 0', background:'#dc2626', color:'white', border:'none', borderRadius:9, cursor:'pointer', fontSize:14, fontWeight:700 }}>
                {editingId !== null ? 'Save Changes' : 'Create Route'}
              </button>
              <button onClick={() => setShowForm(false)} style={{ padding:'11px 22px', background:'#f3f4f6', color:'#374151', border:'none', borderRadius:9, cursor:'pointer', fontSize:13, fontWeight:600 }}>
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}