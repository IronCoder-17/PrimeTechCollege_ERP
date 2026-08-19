// ============================================================
// marksheetPdf — Student Semester Marksheet PDF Generator
// PrimeTech College — Results Module
//
// Builds a professional, university-style marksheet PDF for one
// semester's result: college logo/name, student + semester info,
// full subject-wise marks table (internal/external/practical,
// grade, credit points), SGPA/CGPA/percentage/classification
// summary, date of issue, and an authorized signature area.
//
// Mirrors the visual language of Feestructurepdf.js so all
// downloadable documents look consistent across the portal.
// ============================================================

import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { getLogoDataUrl } from './receiptPdf';

const THEME = {
  accent:      [166, 124, 82],   // #A67C52
  accentDark:  [62, 50, 40],     // #3E3228
  border:      [214, 199, 176],  // #D6C7B0
  headBg:      [245, 239, 230],  // #F5EFE6
  muted:       [107, 91, 77],    // #6B5B4D
  pass:        [22, 163, 74],
  fail:        [220, 38, 38],
};

const COLLEGE = {
  name: 'PRIMETECH COLLEGE',
  tagline: 'Excellence in Education',
  address: 'Ahmedabad, Gujarat, India',
  website: 'https://primetechcollege.online',
};

function fmtDate(d) {
  return new Date(d || Date.now()).toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' });
}

/**
 * Generate (and auto-download) a semester marksheet PDF.
 *
 * @param {Object} student — { name, enrollment_number, roll_number, course_name, course_code, department }
 * @param {Object} sem     — one entry from resultsApi's `semesters` array
 *                           { semester, academic_year, sgpa, total_credits, total_max_marks,
 *                             total_obtained_marks, percentage, result_status, result_declared_on, subjects: [...] }
 * @param {number} cgpa
 * @param {string} classification
 * @param {boolean} autoDownload
 */
export async function generateMarksheetPdf(student, sem, cgpa, classification, autoDownload = true) {
  const doc = new jsPDF({ unit: 'pt', format: 'a4' });
  const pageWidth = doc.internal.pageSize.getWidth();
  const marginX = 40;
  let y = 40;

  const logo = await getLogoDataUrl().catch(() => null);

  // ── Header ───────────────────────────────────────────────
  if (logo) {
    try { doc.addImage(logo, 'PNG', marginX, y, 46, 46); } catch (e) { /* ignore bad image */ }
  }
  doc.setTextColor(...THEME.accentDark);
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(18);
  doc.text(COLLEGE.name, marginX + (logo ? 58 : 0), y + 18);
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(10);
  doc.setTextColor(...THEME.muted);
  doc.text(COLLEGE.tagline, marginX + (logo ? 58 : 0), y + 33);
  doc.text(`${COLLEGE.address}  |  ${COLLEGE.website}`, marginX + (logo ? 58 : 0), y + 46);

  doc.setTextColor(...THEME.accentDark);
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(13);
  doc.text('STATEMENT OF MARKS', pageWidth - marginX, y + 18, { align: 'right' });
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(10);
  doc.setTextColor(...THEME.muted);
  doc.text(`Semester ${sem.semester}${sem.academic_year ? ` · AY ${sem.academic_year}` : ''}`, pageWidth - marginX, y + 33, { align: 'right' });
  doc.text(`Date of Issue: ${fmtDate(Date.now())}`, pageWidth - marginX, y + 46, { align: 'right' });

  y += 64;
  doc.setDrawColor(...THEME.border);
  doc.setLineWidth(1.2);
  doc.line(marginX, y, pageWidth - marginX, y);
  y += 22;

  // ── Student Information ─────────────────────────────────
  const infoLeft = [
    ['Student Name', student.name],
    ['Enrollment No.', student.enrollment_number || '—'],
    ['Roll Number', student.roll_number || student.enrollment_number || '—'],
  ];
  const infoRight = [
    ['Course', student.course_name || student.course_code || '—'],
    ['Semester', `Semester ${sem.semester}`],
    ['Academic Year', sem.academic_year || '—'],
  ];
  doc.setFontSize(10);
  infoLeft.forEach((row, i) => {
    doc.setFont('helvetica', 'bold'); doc.setTextColor(...THEME.muted);
    doc.text(row[0] + ':', marginX, y + i * 16);
    doc.setFont('helvetica', 'normal'); doc.setTextColor(...THEME.accentDark);
    doc.text(String(row[1]), marginX + 100, y + i * 16);
  });
  infoRight.forEach((row, i) => {
    const xLabel = pageWidth / 2 + 10;
    doc.setFont('helvetica', 'bold'); doc.setTextColor(...THEME.muted);
    doc.text(row[0] + ':', xLabel, y + i * 16);
    doc.setFont('helvetica', 'normal'); doc.setTextColor(...THEME.accentDark);
    doc.text(String(row[1]), xLabel + 100, y + i * 16);
  });
  y += infoLeft.length * 16 + 20;

  // ── Subject-wise Marks Table ────────────────────────────
  const body = (sem.subjects || []).map(s => [
    s.subject_code || '-',
    s.subject_name,
    s.credits,
    `${s.internal_marks ?? 0}/${s.internal_max ?? 0}`,
    `${s.external_marks ?? 0}/${s.external_max ?? 0}`,
    Number(s.practical_max) > 0 ? `${s.practical_marks ?? 0}/${s.practical_max}` : '—',
    `${s.obtained_marks}/${s.max_marks}`,
    s.grade_point ?? '-',
    s.grade,
    Number(s.credit_points ?? 0).toFixed(1),
    s.status,
  ]);

  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Code', 'Subject', 'Credit', 'Internal', 'External', 'Practical', 'Total', 'GP', 'Grade', 'Credit Pts', 'Result']],
    body,
    theme: 'grid',
    styles: { fontSize: 7.5, cellPadding: 4, textColor: THEME.accentDark, lineColor: THEME.border },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    alternateRowStyles: { fillColor: [252, 250, 247] },
    columnStyles: { 1: { cellWidth: 100 } },
    didParseCell: (data) => {
      if (data.section === 'body' && data.column.index === 10) {
        data.cell.styles.textColor = data.cell.raw === 'Pass' ? THEME.pass : THEME.fail;
        data.cell.styles.fontStyle = 'bold';
      }
    },
  });
  y = doc.lastAutoTable.finalY + 22;

  // ── Result Summary ───────────────────────────────────────
  if (y > 620) { doc.addPage(); y = 40; }
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(12);
  doc.setTextColor(...THEME.accent);
  doc.text('Result Summary', marginX, y);
  y += 8;

  const summaryBody = [[
    String((sem.subjects || []).length),
    String(sem.total_credits ?? 0),
    String(sem.total_max_marks ?? '-'),
    String(sem.total_obtained_marks ?? '-'),
    `${sem.percentage ?? '-'}%`,
    Number(sem.sgpa ?? 0).toFixed(2),
    Number(cgpa ?? 0).toFixed(2),
    classification || '-',
    sem.result_status,
  ]];
  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Subjects', 'Credits', 'Max Marks', 'Obtained', 'Percentage', 'SGPA', 'CGPA', 'Classification', 'Final Result']],
    body: summaryBody,
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 5, textColor: THEME.accentDark, lineColor: THEME.border, halign: 'center' },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    didParseCell: (data) => {
      if (data.section === 'body' && data.column.index === 8) {
        data.cell.styles.textColor = data.cell.raw === 'Pass' ? THEME.pass : THEME.fail;
        data.cell.styles.fontStyle = 'bold';
      }
    },
  });
  y = doc.lastAutoTable.finalY + 22;

  if (sem.remarks) {
    doc.setFont('helvetica', 'italic');
    doc.setFontSize(9);
    doc.setTextColor(...THEME.muted);
    doc.text(`Remarks: ${sem.remarks}`, marginX, y);
    y += 20;
  }

  // ── Signature Area ───────────────────────────────────────
  const sigY = Math.max(y + 40, 740);
  doc.setDrawColor(...THEME.border);
  doc.line(marginX, sigY, marginX + 160, sigY);
  doc.line(pageWidth - marginX - 160, sigY, pageWidth - marginX, sigY);
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(9);
  doc.setTextColor(...THEME.muted);
  doc.text('Controller of Examinations', marginX, sigY + 14);
  doc.text('Registrar / Principal', pageWidth - marginX - 160, sigY + 14);
  doc.text(`Result Declared: ${sem.result_declared_on ? fmtDate(sem.result_declared_on) : '—'}`, pageWidth / 2, sigY + 14, { align: 'center' });

  // ── Footer ───────────────────────────────────────────────
  const pageCount = doc.internal.getNumberOfPages();
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i);
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(7.5);
    doc.setTextColor(...THEME.muted);
    doc.text('This is a system-generated marksheet and reflects results as published by the Examinations Office.', marginX, 812);
    doc.text(`Page ${i} of ${pageCount}`, pageWidth - marginX, 812, { align: 'right' });
  }

  if (autoDownload) {
    doc.save(`Marksheet-Sem${sem.semester}-${(student.enrollment_number || 'student').replace(/\s+/g, '')}.pdf`);
  }
  return doc;
}
