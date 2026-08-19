// ============================================================
// feeStructurePdf — Fee Structure Document Generator
// PrimeTech College — Fee Structure Management Module
//
// Builds a college-branded, printable PDF of the CURRENT (live)
// fee structure pulled straight from the centralized fee
// database (fee_structure, fee_settings, hostel_fee_plans,
// transportation_routes). Used by the "Fee Structure" navbar
// item for the one-click, always-current download — nothing in
// this file hard-codes a fee amount; every number is passed in
// from the live API responses.
// ============================================================

import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import { getLogoDataUrl } from './receiptPdf';

// ── Theme — mirrors the "Premium Beige & White" brand used across
//    the rest of the platform (receiptPdf.js) for visual consistency ──
const THEME = {
  accent:      [166, 124, 82],   // #A67C52
  accentDark:  [62, 50, 40],     // #3E3228
  border:      [214, 199, 176],  // #D6C7B0
  headBg:      [245, 239, 230],  // #F5EFE6
  muted:       [107, 91, 77],    // #6B5B4D
};

const COLLEGE = {
  name: 'PRIMETECH COLLEGE',
  tagline: 'Excellence in Education',
  address: 'Ahmedabad, Gujarat, India',
  website: 'https://primetechcollege.online',
};

function fmt(n) {
  return `Rs. ${Number(n || 0).toLocaleString('en-IN')}`;
}

function currentAcademicYear() {
  const now = new Date();
  const y = now.getFullYear();
  // Indian academic year typically starts in June/July
  const startYear = now.getMonth() >= 5 ? y : y - 1;
  return `${startYear}-${String(startYear + 1).slice(-2)}`;
}

/**
 * Generate (and optionally auto-download) the full Fee Structure PDF.
 *
 * @param {Object} data
 * @param {Array}  data.courses   — from admissionApi.getFeeStructure(): [{course_name, course_code, department, level, total_semesters, fees:[{semester, tuition_fee, exam_fee, total_fee}]}]
 * @param {Array}  data.settings  — from feesApi.getSettings(): [{fee_key, label, amount, category, description}]
 * @param {Array}  data.hostelPlans — from feesApi.getHostelPlans(): [{hostel_type, room_type, hostel_admission_fee, security_deposit, hostel_fee, mess_fee, maintenance_fee, total_fee}]
 * @param {Array}  data.routes    — from transportationApi.getRoutes(): [{location, bus_number, transport_fee, status}]
 * @param {boolean} autoDownload  — trigger doc.save() immediately (default true)
 * @returns {Promise<jsPDF>} the generated document (for preview / re-download)
 */
export async function generateFeeStructurePdf({ courses = [], settings = [], hostelPlans = [], routes = [] }, autoDownload = true) {
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
  doc.text('OFFICIAL FEE STRUCTURE', pageWidth - marginX, y + 18, { align: 'right' });
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(10);
  doc.setTextColor(...THEME.muted);
  doc.text(`Academic Year: ${currentAcademicYear()}`, pageWidth - marginX, y + 33, { align: 'right' });
  doc.text(`Generated: ${new Date().toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' })}`, pageWidth - marginX, y + 46, { align: 'right' });

  y += 64;
  doc.setDrawColor(...THEME.border);
  doc.setLineWidth(1.2);
  doc.line(marginX, y, pageWidth - marginX, y);
  y += 18;

  const sectionTitle = (title) => {
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(12);
    doc.setTextColor(...THEME.accent);
    doc.text(title, marginX, y);
    y += 8;
  };

  // ── 1. Academic Fees (course-wise / year-wise) ────────
  // Year 1 = Sem 1+2, Year 2 = Sem 3+4, Year 3 = Sem 5+6, Year 4 = Sem 7+8
  sectionTitle('1. Academic Fees — Course-wise & Year-wise');
  const examFee = settings.find(s => s.fee_key === 'exam_fee');
  const libFee  = settings.find(s => s.fee_key === 'lab_fee');

  const groupByYear = (fees = []) => {
    const years = {};
    fees.forEach(f => {
      const year = Math.ceil(Number(f.semester) / 2);
      const exam = Number(examFee ? examFee.amount : f.exam_fee);
      const lab  = Number(libFee ? libFee.amount : 0);
      if (!years[year]) years[year] = { year, tuition: 0, exam: 0, lab: 0, total: 0 };
      years[year].tuition += Number(f.tuition_fee || 0);
      years[year].exam    += exam;
      years[year].lab     += lab;
      years[year].total   += Number(f.tuition_fee || 0) + exam + lab;
    });
    return Object.values(years).sort((a, b) => a.year - b.year);
  };

  const academicBody = [];
  courses.forEach(c => {
    groupByYear(c.fees || []).forEach(yr => {
      academicBody.push([
        c.course_name,
        c.course_code,
        `Year ${yr.year}`,
        fmt(yr.tuition),
        fmt(yr.exam),
        yr.lab ? fmt(yr.lab) : '—',
        fmt(yr.total),
      ]);
    });
  });

  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Course', 'Code', 'Academic Year', 'Tuition Fee', 'Exam Fee', 'Lab Fee', 'Total']],
    body: academicBody.length ? academicBody : [['No course fee data available', '', '', '', '', '', '']],
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 4, textColor: THEME.accentDark, lineColor: THEME.border },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    alternateRowStyles: { fillColor: [252, 250, 247] },
  });
  y = doc.lastAutoTable.finalY + 22;

  // ── 2. Hostel Fees ─────────────────────────────────────────
  if (y > 680) { doc.addPage(); y = 40; }
  sectionTitle('2. Hostel Fees');
  const hostelBody = hostelPlans.map(p => [
    p.hostel_type, p.room_type,
    fmt(p.hostel_admission_fee), fmt(p.security_deposit),
    fmt(p.hostel_fee), fmt(p.mess_fee), fmt(p.maintenance_fee),
    fmt(p.total_fee),
  ]);
  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Hostel', 'Room Type', 'Admission', 'Deposit', 'Hostel Fee', 'Mess', 'Maintenance', 'Total']],
    body: hostelBody.length ? hostelBody : [['No hostel fee plans available', '', '', '', '', '', '', '']],
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 4, textColor: THEME.accentDark, lineColor: THEME.border },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    alternateRowStyles: { fillColor: [252, 250, 247] },
  });
  y = doc.lastAutoTable.finalY + 22;

  // ── 3. Transportation Fees ──────────────────────────────────
  if (y > 680) { doc.addPage(); y = 40; }
  sectionTitle('3. Transportation Fees');
  const activeRoutes = routes.filter(r => r.status === 'active');
  const transportBody = activeRoutes.map(r => [r.location, r.bus_number, fmt(r.transport_fee)]);
  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Route / Location', 'Bus Number', 'Fee (per year)']],
    body: transportBody.length ? transportBody : [['No active transportation routes', '', '']],
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 4, textColor: THEME.accentDark, lineColor: THEME.border },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    alternateRowStyles: { fillColor: [252, 250, 247] },
  });
  y = doc.lastAutoTable.finalY + 22;

  // ── 4. Other / Registration Fees ───────────────────────────
  if (y > 680) { doc.addPage(); y = 40; }
  sectionTitle('4. Registration & Other Charges');
  const otherBody = settings
    .filter(s => !['exam_fee', 'lab_fee'].includes(s.fee_key)) // exam & lab fee already shown per-semester above
    .map(s => [s.label, fmt(s.amount), s.description || '']);
  autoTable(doc, {
    startY: y,
    margin: { left: marginX, right: marginX },
    head: [['Fee', 'Amount', 'Notes']],
    body: otherBody.length ? otherBody : [['No additional charges configured', '', '']],
    theme: 'grid',
    styles: { fontSize: 8, cellPadding: 4, textColor: THEME.accentDark, lineColor: THEME.border },
    headStyles: { fillColor: THEME.headBg, textColor: THEME.accentDark, fontStyle: 'bold' },
    alternateRowStyles: { fillColor: [252, 250, 247] },
    columnStyles: { 2: { cellWidth: 260 } },
  });
  y = doc.lastAutoTable.finalY + 24;

  // ── Notes / Terms & Conditions ──────────────────────────────
  if (y > 700) { doc.addPage(); y = 40; }
  sectionTitle('Notes & Terms');
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(8.5);
  doc.setTextColor(...THEME.muted);
  const notes = [
    '1. All fees are payable per semester unless explicitly marked as a one-time or per-year charge.',
    '2. Hostel and Transportation fees apply only to students who opt into those facilities.',
    '3. Security deposits (hostel) are refundable, subject to the college\u2019s refund policy, on vacating the hostel.',
    '4. This document reflects the fee structure as configured by the Admissions Office at the time of generation and is',
    '   subject to revision; the most recent version can always be re-downloaded from the student portal.',
    '5. For queries regarding fee payment or concessions, please contact the Accounts Office.',
  ];
  notes.forEach(line => { doc.text(line, marginX, y); y += 13; });

  // ── Footer on every page ────────────────────────────────────
  const pageCount = doc.internal.getNumberOfPages();
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i);
    doc.setDrawColor(...THEME.border);
    doc.line(marginX, 805, pageWidth - marginX, 805);
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(...THEME.muted);
    doc.text('This is a system-generated document and does not require a physical signature.', marginX, 818);
    doc.text(`Page ${i} of ${pageCount}`, pageWidth - marginX, 818, { align: 'right' });
  }

  if (autoDownload) {
    doc.save(`Fee-Structure-${currentAcademicYear()}.pdf`);
  }
  return doc;
}