// ============================================================
// ResultsPage — Student Academic Results
//
// Fully dynamic: fetches /results.php/my-results and shows
// - Current Semester Details
// - Previous Semester Results (SGPA per semester, subject-wise marks,
//   Pass/Fail status)
// - CGPA (derived, credit-weighted average of all SGPAs)
// - Academic Progress Graph
// - Download Result PDF (per semester, via browser print)
//
// No hardcoded values — everything reflects what the Admin has
// published for this student via the Results Management panel.
// ============================================================

import { useEffect, useState } from 'react';
import { BarChart2, Download, Printer, CheckCircle, XCircle, GraduationCap, Award } from 'lucide-react';
import { resultsApi } from '../utils/api';
import { generateMarksheetPdf } from '../utils/marksheetPdf';
import styles from './ResultsPage.module.css';

const gradeColor = {
  O: '#10b981', 'A+': '#10b981', A: '#C9963C', 'B+': '#8B7355',
  B: '#7c3aed', C: '#e08a3c', P: '#e08a3c', F: '#e05a5a',
};

// ── Academic Progress Graph: simple inline SVG line chart of SGPA per semester ──
function ProgressGraph({ progress }) {
  if (!progress || progress.length === 0) return null;

  const width = 640, height = 220, pad = 40;
  const maxSgpa = 10;
  const points = progress.map((p, i) => ({
    x: pad + (progress.length === 1 ? (width - 2 * pad) / 2 : (i * (width - 2 * pad)) / (progress.length - 1)),
    y: height - pad - (Math.min(p.sgpa, maxSgpa) / maxSgpa) * (height - 2 * pad),
    ...p,
  }));
  const pathD = points.map((pt, i) => `${i === 0 ? 'M' : 'L'} ${pt.x} ${pt.y}`).join(' ');

  return (
    <svg viewBox={`0 0 ${width} ${height}`} style={{ width: '100%', height: 'auto', display: 'block' }}>
      {[0, 2, 4, 6, 8, 10].map(v => {
        const y = height - pad - (v / maxSgpa) * (height - 2 * pad);
        return (
          <g key={v}>
            <line x1={pad} y1={y} x2={width - pad} y2={y} stroke="#eee5d8" strokeWidth="1" />
            <text x={pad - 8} y={y + 4} fontSize="10" textAnchor="end" fill="#a8a094">{v}</text>
          </g>
        );
      })}
      <path d={pathD} fill="none" stroke="#C9963C" strokeWidth="2.5" />
      {points.map((pt, i) => (
        <g key={i}>
          <circle cx={pt.x} cy={pt.y} r="4.5" fill="#C9963C" />
          <text x={pt.x} y={height - 12} fontSize="11" textAnchor="middle" fill="#8B7355">Sem {pt.semester}</text>
          <text x={pt.x} y={pt.y - 12} fontSize="12" fontWeight="700" textAnchor="middle" fill="#3a332b">{pt.sgpa}</text>
        </g>
      ))}
    </svg>
  );
}

// ── Download the official, university-style marksheet PDF (jsPDF) ──
async function downloadResultPDF(student, sem, cgpa, classification, setBusy) {
  try {
    setBusy?.(true);
    await generateMarksheetPdf(student, sem, cgpa, classification, true);
  } finally {
    setBusy?.(false);
  }
}

// ── Secondary option: quick browser print view (no PDF library needed) ──
function printResult(student, sem) {
  const win = window.open('', '_blank');
  if (!win) return;

  const rows = sem.subjects.map(s => `
    <tr>
      <td>${s.subject_code || '-'}</td>
      <td>${s.subject_name}</td>
      <td>${s.internal_marks ?? 0} / ${s.internal_max ?? 0}</td>
      <td>${s.external_marks ?? s.obtained_marks} / ${s.external_max ?? s.max_marks}</td>
      <td>${Number(s.practical_max) > 0 ? `${s.practical_marks ?? 0} / ${s.practical_max}` : '—'}</td>
      <td>${s.obtained_marks} / ${s.max_marks}</td>
      <td>${s.credits}</td>
      <td style="font-weight:700;color:${gradeColor[s.grade] || '#3a332b'}">${s.grade}</td>
      <td>${s.status}</td>
    </tr>`).join('');

  win.document.write(`
    <html>
      <head>
        <title>Semester ${sem.semester} Result — ${student.name}</title>
        <style>
          body { font-family: Georgia, serif; padding: 32px; color: #3a332b; }
          h1 { font-size: 20px; margin-bottom: 2px; }
          p { font-size: 12px; color: #8B7355; margin: 2px 0; }
          table { width: 100%; border-collapse: collapse; margin-top: 18px; font-size: 13px; }
          th, td { border: 1px solid #eee5d8; padding: 8px 10px; text-align: left; }
          th { background: #faf6ef; }
          .summary { display: flex; gap: 28px; margin-top: 16px; flex-wrap: wrap; }
          .summary div { font-size: 13px; }
          .summary b { font-size: 18px; display: block; color: #C9963C; }
        </style>
      </head>
      <body>
        <h1>${student.course_name || student.course_code || 'Academic'} — Semester ${sem.semester} Result</h1>
        <p>${student.name} · Enrollment No. ${student.enrollment_number}${student.department ? ` · ${student.department}` : ''}</p>
        <p>${sem.academic_year ? `Academic Year: ${sem.academic_year} · ` : ''}Result Declared: ${sem.result_declared_on ? new Date(sem.result_declared_on).toLocaleDateString() : '—'}</p>
        <div class="summary">
          <div><b>${sem.sgpa}</b>SGPA</div>
          <div><b>${sem.percentage ?? '-'}%</b>Percentage</div>
          <div><b>${sem.total_credits}</b>Total Credits</div>
          <div><b>${sem.result_status}</b>Result</div>
        </div>
        <table>
          <thead><tr><th>Code</th><th>Subject</th><th>Internal</th><th>External</th><th>Practical</th><th>Total</th><th>Credits</th><th>Grade</th><th>Status</th></tr></thead>
          <tbody>${rows}</tbody>
        </table>
        ${sem.remarks ? `<p style="margin-top:14px;">Remarks: ${sem.remarks}</p>` : ''}
        <script>window.onload = () => window.print();</script>
      </body>
    </html>
  `);
  win.document.close();
}

export default function ResultsPage() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [selectedIdx, setSelectedIdx] = useState(0);
  const [pdfBusy, setPdfBusy] = useState(false);

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        const res = await resultsApi.getMyResults();
        if (!active) return;
        setData(res.data);
        setSelectedIdx(Math.max(0, (res.data?.semesters?.length || 1) - 1));
      } catch (e) {
        if (active) setError('Could not load your results. Please try again later.');
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => { active = false; };
  }, []);

  if (loading) {
    return (
      <div className={styles.page}>
        <div className={styles.pageHeader}>
          <BarChart2 size={22} />
          <h1 className={styles.pageTitle}>Academic Results</h1>
        </div>
        <div className={styles.emptyState}>Loading Results…</div>
      </div>
    );
  }

  if (error || !data) {
    return (
      <div className={styles.page}>
        <div className={styles.pageHeader}>
          <BarChart2 size={22} />
          <h1 className={styles.pageTitle}>Academic Results</h1>
        </div>
        <div className={styles.emptyState}>{error || 'No data available.'}</div>
      </div>
    );
  }

  const { student, cgpa, classification, semesters, progress } = data;
  const sem = semesters[selectedIdx];

  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <BarChart2 size={22} />
        <h1 className={styles.pageTitle}>Academic Results</h1>
      </div>

      {/* ── Current Semester Details ── */}
      <div className={`${styles.currentSemCard} card`}>
        <div className={styles.currentSemInfo}>
          <div className={styles.currentSemItem}>
            <span className={styles.currentSemLabel}>Enrollment No.</span>
            <span className={styles.currentSemValue}>{student.enrollment_number}</span>
          </div>
          <div className={styles.currentSemItem}>
            <span className={styles.currentSemLabel}>Course</span>
            <span className={styles.currentSemValue}>{student.course_name || student.course_code || '—'}</span>
          </div>
          <div className={styles.currentSemItem}>
            <span className={styles.currentSemLabel}>Current Semester</span>
            <span className={styles.currentSemValue}>Semester {student.current_semester || '—'}</span>
          </div>
          {student.department && (
            <div className={styles.currentSemItem}>
              <span className={styles.currentSemLabel}>Department</span>
              <span className={styles.currentSemValue}>{student.department}</span>
            </div>
          )}
        </div>
        <div className={styles.cgpaPill}>
          <span className={styles.cgpaPillValue}>{cgpa}</span>
          <span className={styles.cgpaPillLabel}><GraduationCap size={11} style={{ verticalAlign: 'middle', marginRight: 4 }} />CGPA</span>
        </div>
      </div>

      {semesters.length === 0 ? (
        <div className={`${styles.emptyState} card`}>
          <strong>No Results Available</strong>
          <div style={{ marginTop: 6, fontWeight: 400 }}>Once the administration publishes your semester results, your SGPA, CGPA, subject-wise marks, and progress graph will appear here automatically.</div>
        </div>
      ) : (
        <>
          {/* ── Semester Selector ── */}
          <div className={styles.semTabs}>
            {semesters.map((s, i) => (
              <button
                key={s.id}
                className={`${styles.semBtn} ${selectedIdx === i ? styles.semActive : ''}`}
                onClick={() => setSelectedIdx(i)}
              >
                Semester {s.semester}{s.academic_year ? ` · ${s.academic_year}` : ''}
              </button>
            ))}
          </div>

          {/* ── SGPA + Subject-wise Marks ── */}
          <div className={styles.resultGrid}>
            <div className={`${styles.sgpaCard} card`}>
              <div className={styles.sgpaLabel}>SGPA — Semester {sem.semester}</div>
              <div className={styles.sgpaValue}>{sem.sgpa}</div>
              <div className={styles.sgpaSub}>{sem.total_credits} credits · {sem.percentage ?? '-'}%</div>
              <div
                className={`${styles.statusBadge} ${
                  sem.result_status === 'Pass' ? styles.statusPass
                  : sem.result_status === 'Fail' ? styles.statusFail
                  : sem.result_status === 'ATKT' ? styles.statusAtkt
                  : styles.statusPending
                }`}
                style={{ margin: '12px auto 0', justifyContent: 'center' }}
              >
                {sem.result_status === 'Pass' ? <CheckCircle size={12} /> : (sem.result_status === 'Fail' || sem.result_status === 'ATKT') ? <XCircle size={12} /> : null} {sem.result_status === 'ATKT' ? 'ATKT / Backlog' : sem.result_status}
              </div>
              <div className={styles.cgpaBadge}>CGPA so far: {cgpa}{classification ? ` · ${classification}` : ''}</div>
            </div>

            <div className={`${styles.subjectCard} card`}>
              <div className={styles.resultActions} style={{ display: 'flex', gap: 8 }}>
                <button className={styles.downloadBtn} disabled={pdfBusy} onClick={() => downloadResultPDF(student, sem, cgpa, classification, setPdfBusy)}>
                  <Download size={14} /> {pdfBusy ? 'Preparing PDF…' : 'Download Result (PDF)'}
                </button>
                <button className={styles.downloadBtn} onClick={() => printResult(student, sem)} style={{ background: 'transparent', border: '1px solid var(--beige-200)', color: 'var(--dark-beige)' }}>
                  <Printer size={14} /> Print
                </button>
              </div>
              <h2 className={styles.cardTitle}>Subject-wise Marks</h2>
              <div className={styles.metaRow}>
                {sem.academic_year && <span>Academic Year: <b>{sem.academic_year}</b></span>}
                <span>Result Declared: <b>{sem.result_declared_on ? new Date(sem.result_declared_on).toLocaleDateString() : '—'}</b></span>
              </div>
              <div className={styles.subjectTable}>
                <div className={styles.tableHeadFull}>
                  <span>Code</span><span>Subject</span><span>Internal</span><span>External</span><span>Practical</span><span>Total</span><span>Credits</span><span>Grade / Status</span>
                </div>
                {sem.subjects.map(s => (
                  <div key={s.id} className={styles.tableRowFull}>
                    <span className={styles.credits}>{s.subject_code || '-'}</span>
                    <span className={styles.subjectName}>{s.subject_name}</span>
                    <span className={styles.credits}>{s.internal_marks ?? 0}/{s.internal_max ?? 0}</span>
                    <span className={styles.credits}>{s.external_marks ?? s.obtained_marks}/{s.external_max ?? s.max_marks}</span>
                    <span className={styles.credits}>{Number(s.practical_max) > 0 ? `${s.practical_marks ?? 0}/${s.practical_max}` : '—'}</span>
                    <span className={styles.credits}>{s.obtained_marks}/{s.max_marks}</span>
                    <span className={styles.credits}>{s.credits}</span>
                    <span style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                      <span className={styles.gradeChip} style={{ color: gradeColor[s.grade] || '#3a332b', background: `${gradeColor[s.grade] || '#3a332b'}15` }}>{s.grade}</span>
                      <span className={`${styles.statusBadge} ${s.status === 'Pass' ? styles.statusPass : styles.statusFail}`}>
                        {s.status === 'Pass' ? <CheckCircle size={11} /> : <XCircle size={11} />} {s.status}
                      </span>
                    </span>
                  </div>
                ))}
              </div>
              <div style={{ display: 'flex', gap: 20, marginTop: 14, flexWrap: 'wrap', fontSize: 12, color: 'var(--charcoal-400)' }}>
                <span>Total Max Marks: <b style={{ color: 'var(--dark-beige)' }}>{sem.total_max_marks}</b></span>
                <span>Total Obtained: <b style={{ color: 'var(--dark-beige)' }}>{sem.total_obtained_marks}</b></span>
                <span>Percentage: <b style={{ color: 'var(--dark-beige)' }}>{sem.percentage}%</b></span>
                {classification && <span><Award size={12} style={{ verticalAlign: 'middle', marginRight: 3 }} />Classification: <b style={{ color: 'var(--dark-beige)' }}>{classification}</b></span>}
              </div>
              {sem.remarks && <p style={{ fontSize: 12, color: 'var(--charcoal-400)', marginTop: 12 }}>Remarks: {sem.remarks}</p>}
            </div>
          </div>

          {/* ── Academic Progress Graph ── */}
          <div className={`${styles.progressGraphCard} card`}>
            <h2 className={styles.cardTitle}>Academic Progress</h2>
            <ProgressGraph progress={progress} />
          </div>
        </>
      )}
    </div>
  );
}
