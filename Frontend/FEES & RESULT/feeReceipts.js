// ============================================================
// Fee Receipts — Data Layer
// PrimeTech College — Fee Receipt Generation Module
//
// Persists fee receipts in localStorage so the Student "Fee
// Receipts" page and the Admin "Fee Receipt Management" panel
// always read/write the same live data with zero backend setup
// required — matching the pattern already used by
// FeeManagementPanel (ccc_fee_table / ccc_global_fees / etc).
//
// Storage keys:
//   ccc_fee_receipts — array of receipt records
//   ccc_receipt_seq  — { [year]: lastSeq } per-year sequence
//                       counters used to build PTC-{year}-{seq}
//                       receipt numbers (auto-increment, unique,
//                       never duplicated).
// ============================================================

import { feesApi } from './api';

const RECEIPTS_KEY = 'ccc_fee_receipts';
const SEQ_KEY      = 'ccc_receipt_seq';

// ── localStorage helpers ──────────────────────────────────────
function lsGet(key, fallback) {
  try {
    const v = localStorage.getItem(key);
    return v ? JSON.parse(v) : fallback;
  } catch {
    return fallback;
  }
}
function lsSet(key, value) {
  try { localStorage.setItem(key, JSON.stringify(value)); } catch { /* ignore */ }
}

// ── Demo seed data ──────────────────────────────────────────
// A handful of realistic receipts so the Admin "Fee Receipt
// Management" dashboard has data to search/filter immediately,
// and so the demo student accounts (Alex / Rahul) already have
// receipts waiting in "My Receipts" on first load.
const SEED_RECEIPTS = [
  {
    id: 1,
    studentId: 1,
    studentName: 'Alex Johnson',
    enrollmentNumber: 'PT2023BTCE0014',
    department: 'Computer Engineering',
    course: 'B.Tech Computer Engineering',
    semester: 4,
    academicYear: '2025-26',
    receiptNumber: 'PTC-2026-000001',
    transactionId: 'TXN20260110103245',
    feeType: 'Registration Fee',
    amount: 2000,
    paymentMethod: 'UPI',
    paymentDate: '2026-01-10T10:32:00',
    status: 'Paid',
    createdAt: '2026-01-10T10:32:00',
  },
  {
    id: 2,
    studentId: 1,
    studentName: 'Alex Johnson',
    enrollmentNumber: 'PT2023BTCE0014',
    department: 'Computer Engineering',
    course: 'B.Tech Computer Engineering',
    semester: 4,
    academicYear: '2025-26',
    receiptNumber: 'PTC-2026-000002',
    transactionId: 'TXN20260112091530',
    feeType: 'College Fee - Semester 4',
    amount: 80000,
    paymentMethod: 'Net Banking',
    paymentDate: '2026-01-12T09:15:00',
    status: 'Paid',
    createdAt: '2026-01-12T09:15:00',
  },
  {
    id: 3,
    studentId: 4,
    studentName: 'Rahul Sharma',
    enrollmentNumber: 'PT2022BTEC0009',
    department: 'Electronics & Communication',
    course: 'B.Tech Electronics & Communication',
    semester: 6,
    academicYear: '2025-26',
    receiptNumber: 'PTC-2026-000003',
    transactionId: 'TXN20260205143012',
    feeType: 'College Fee - Semester 6',
    amount: 85000,
    paymentMethod: 'Card',
    paymentDate: '2026-02-05T14:30:00',
    status: 'Paid',
    createdAt: '2026-02-05T14:30:00',
  },
  {
    id: 4,
    studentId: 1001,
    studentName: 'Sneha Desai',
    enrollmentNumber: 'PT2025BCA0027',
    department: 'Computer & IT',
    course: 'BCA',
    semester: 2,
    academicYear: '2025-26',
    receiptNumber: 'PTC-2026-000004',
    transactionId: 'TXN20260318110045',
    feeType: 'Examination Fee',
    amount: 2500,
    paymentMethod: 'UPI',
    paymentDate: '2026-03-18T11:00:00',
    status: 'Paid',
    createdAt: '2026-03-18T11:00:00',
  },
  {
    id: 5,
    studentId: 1002,
    studentName: 'Karan Patel',
    enrollmentNumber: 'PT2024MBA0011',
    department: 'Management',
    course: 'MBA',
    semester: 2,
    academicYear: '2025-26',
    receiptNumber: 'PTC-2026-000005',
    transactionId: 'TXN20260601163210',
    feeType: 'Hostel Fee - Semester 2',
    amount: 48000,
    paymentMethod: 'Net Banking',
    paymentDate: '2026-06-01T16:32:00',
    status: 'Partial Paid',
    createdAt: '2026-06-01T16:32:00',
  },
];

// Known demo student profiles, keyed by the mock-auth user id, so
// receipts created for these accounts stay consistent with the
// seeded receipts above (same enrollment number / department / etc).
const DEMO_STUDENT_PROFILES = {
  1: { enrollmentNumber: 'PT2023BTCE0014', department: 'Computer Engineering',          course: 'B.Tech Computer Engineering',         semester: 4 },
  4: { enrollmentNumber: 'PT2022BTEC0009', department: 'Electronics & Communication',   course: 'B.Tech Electronics & Communication',  semester: 6 },
};

// ── Seeding ──────────────────────────────────────────────────
function ensureSeeded() {
  if (localStorage.getItem(RECEIPTS_KEY) === null) {
    lsSet(RECEIPTS_KEY, SEED_RECEIPTS);
  }
  if (localStorage.getItem(SEQ_KEY) === null) {
    // All seed receipts use the 2026 prefix — start the 2026
    // counter at the number of seeded receipts.
    lsSet(SEQ_KEY, { 2026: SEED_RECEIPTS.length });
  }
}

// ── Reads ────────────────────────────────────────────────────
export function getAllReceipts() {
  ensureSeeded();
  return lsGet(RECEIPTS_KEY, []);
}

export function getReceiptsForStudent(studentId) {
  if (studentId === undefined || studentId === null) return [];
  return getAllReceipts().filter(r => String(r.studentId) === String(studentId));
}

export function getReceiptById(id) {
  return getAllReceipts().find(r => String(r.id) === String(id)) || null;
}

// ── Academic year helper ────────────────────────────────────
// PrimeTech's academic year runs June → May, so "2026-27" covers
// June 2026 through May 2027.
export function getCurrentAcademicYear(date = new Date()) {
  const month = date.getMonth() + 1; // 1-12
  const year  = date.getFullYear();
  if (month >= 6) return `${year}-${String((year + 1) % 100).padStart(2, '0')}`;
  return `${year - 1}-${String(year % 100).padStart(2, '0')}`;
}

// ── Receipt / Transaction number generation ─────────────────
// Format: PTC-{year}-{6-digit sequence}, e.g. PTC-2026-000001.
// Auto-increments per calendar year, never duplicates.
export function generateReceiptNumber(date = new Date()) {
  ensureSeeded();
  const year = date.getFullYear();
  const seqMap = lsGet(SEQ_KEY, {});
  const next = (seqMap[year] || 0) + 1;
  seqMap[year] = next;
  lsSet(SEQ_KEY, seqMap);
  return `PTC-${year}-${String(next).padStart(6, '0')}`;
}

function generateTransactionId(date = new Date()) {
  const stamp = date.toISOString().replace(/[-:.TZ]/g, '').slice(0, 14);
  const rand = Math.floor(100 + Math.random() * 900);
  return `TXN${stamp}${rand}`;
}

// ── Build a normalized student profile from the logged-in user ──
// Works for both the mock demo accounts (Alex/Rahul) and accounts
// created via the Admission flow (which already carry
// enrollmentNumber / grNumber / course / semester / admissionYear).
export function getStudentProfile(user) {
  if (!user) return null;
  const demo = DEMO_STUDENT_PROFILES[user.id];
  const semester = user.semester || demo?.semester || '—';
  const academicYear = user.admissionYear
    ? `${user.admissionYear}-${String((Number(user.admissionYear) + 1) % 100).padStart(2, '0')}`
    : getCurrentAcademicYear();

  return {
    id: user.id,
    name: user.name || 'Student',
    enrollmentNumber: user.enrollmentNumber || user.grNumber || demo?.enrollmentNumber || '—',
    department: demo?.department || user.major || user.course || '—',
    course: user.course || demo?.course || user.major || '—',
    // The real database course_id — the ONLY value ever used to look up
    // fees (see FeeReceiptsPage). Never derived from the course name,
    // since multiple course records can share a similar/identical name.
    courseId: user.courseId ?? null,
    hostelFee: user.hostelFee ?? 0,
    transportFee: user.transportFee ?? 0,
    semester,
    academicYear,
  };
}

// ── Writes ───────────────────────────────────────────────────
// Creates a new receipt record — this is the automatic
// "Payment Success Workflow": generates a unique receipt number,
// a transaction id (if not supplied), stamps the payment date,
// and persists the record so it instantly appears in both the
// Student Dashboard and Admin Dashboard.
export function createReceipt({
  studentId,
  studentName,
  enrollmentNumber,
  department,
  course,
  semester,
  academicYear,
  feeType,
  amount,
  paymentMethod = 'Online',
  status = 'Paid',
  transactionId,
  paymentDate,
  // Transportation Management — when a student opted for transportation,
  // these are shown on the printed/PDF fee receipt alongside the
  // payment details (see utils/receiptPdf.js).
  transportRoute = null,
  busNumber = null,
  // 'semester_fee' marks this receipt as the payment that satisfies the
  // student's tuition fee for `semester` — used by getSemesterReceipt /
  // isSemesterPaid to drive the Current/Next Semester Fee Payment workflow.
  paymentType = null,
}) {
  const receipts = getAllReceipts();
  const now = paymentDate ? new Date(paymentDate) : new Date();
  const nextId = receipts.reduce((max, r) => Math.max(max, Number(r.id) || 0), 0) + 1;

  const receipt = {
    id: nextId,
    studentId,
    studentName: studentName || 'Student',
    enrollmentNumber: enrollmentNumber || '—',
    department: department || '—',
    course: course || '—',
    semester: semester ?? '—',
    academicYear: academicYear || getCurrentAcademicYear(now),
    receiptNumber: generateReceiptNumber(now),
    transactionId: transactionId || generateTransactionId(now),
    feeType,
    amount: Number(amount) || 0,
    paymentMethod,
    paymentDate: now.toISOString(),
    status,
    createdAt: new Date().toISOString(),
    transportRoute,
    busNumber,
    paymentType,
  };

  receipts.push(receipt);
  lsSet(RECEIPTS_KEY, receipts);
  return receipt;
}

// ── Semester Fee helpers ─────────────────────────────────────
// Semester fee receipts are tagged with feeType 'College Fee - Semester N'
// (created either at Admission or via the Fee Receipt module's Current/Next
// Semester Fee Payment flow) — these helpers let the Fee Receipt module know
// which semesters have already been paid for a given student, without
// needing a schema change.
export function semesterFeeType(semester) {
  return `College Fee - Semester ${semester}`;
}

// Returns the paid semester-fee receipt for a given semester, or null.
export function getSemesterReceipt(receipts, semester) {
  if (!semester && semester !== 0) return null;
  return (
    receipts.find(r =>
      r.status === 'Paid'
      && Number(r.semester) === Number(semester)
      && (r.paymentType === 'semester_fee' || r.feeType === semesterFeeType(Number(semester)))
    ) || null
  );
}

export function isSemesterPaid(receipts, semester) {
  return !!getSemesterReceipt(receipts, semester);
}

// ── Search / Filter / Stats ─────────────────────────────────
export function searchReceipts(receipts, query) {
  const q = (query || '').trim().toLowerCase();
  if (!q) return receipts;
  return receipts.filter(r => (
    (r.receiptNumber    || '').toLowerCase().includes(q) ||
    (r.feeType          || '').toLowerCase().includes(q) ||
    (r.transactionId    || '').toLowerCase().includes(q) ||
    (r.studentName      || '').toLowerCase().includes(q) ||
    (r.enrollmentNumber || '').toLowerCase().includes(q)
  ));
}

// Filter by status and/or payment-date range ('YYYY-MM-DD' strings).
export function filterReceipts(receipts, { status, from, to } = {}) {
  return receipts.filter(r => {
    if (status && r.status !== status) return false;
    const d = (r.paymentDate || '').slice(0, 10);
    if (from && d < from) return false;
    if (to && d > to) return false;
    return true;
  });
}

// Admin Dashboard Statistics: Total Receipts, Today's Receipts,
// Monthly Receipts, Total Collection, Monthly Collection.
export function getReceiptStats(receipts) {
  const now      = new Date();
  const todayStr = now.toISOString().slice(0, 10);
  const month    = now.getMonth();
  const year     = now.getFullYear();

  let today = 0, monthly = 0, totalCollection = 0, monthlyCollection = 0;

  receipts.forEach(r => {
    const d = new Date(r.paymentDate);
    const inThisMonth = d.getMonth() === month && d.getFullYear() === year;
    if ((r.paymentDate || '').slice(0, 10) === todayStr) today++;
    if (inThisMonth) monthly++;
    if (r.status === 'Paid') {
      totalCollection += Number(r.amount) || 0;
      if (inThisMonth) monthlyCollection += Number(r.amount) || 0;
    }
  });

  return {
    total: receipts.length,
    today,
    monthly,
    totalCollection,
    monthlyCollection,
  };
}

// ── Fee types offered on the "Pay Fees" (Other Fees) form ───
// Every amount here is Admin-managed and database-driven — nothing
// below is hardcoded:
//   • Examination Fee / ID Card Fee / Library Deposit / Other Charges
//     come from `fee_settings` (Admin → Fee Management → College Fees /
//     Other Charges), via GET /api/fees.php/settings.
//   • Hostel Fee uses the amount already assigned to THIS student at
//     admission time (student.hostelFee, sourced from the
//     `hostel_fee_plans` row the student is on) if available, or the
//     current live plan for their hostel/room type otherwise.
//   • Transportation Fee uses the amount already assigned to THIS
//     student at admission time (student.transportFee, sourced from
//     `transportation_routes`) if available.
// If a value genuinely cannot be loaded, that option is simply
// omitted rather than filled in with a fake number.
export async function getFeeTypeOptionsAsync(student, user) {
  const semLabel = student?.semester && student.semester !== '—' ? ` - Semester ${student.semester}` : '';
  const options = [];

  let settingsMap = {};
  try {
    const { data } = await feesApi.getSettings();
    settingsMap = data?.map || {};
  } catch {
    settingsMap = {};
  }

  if (typeof settingsMap.exam_fee === 'number') {
    options.push({ key: 'exam_fee', label: 'Examination Fee', amount: settingsMap.exam_fee });
  }
  if (typeof settingsMap.library_deposit === 'number') {
    options.push({ key: 'library_fee', label: 'Library Deposit', amount: settingsMap.library_deposit });
  }
  if (typeof settingsMap.id_card_fee === 'number') {
    options.push({ key: 'id_card_fee', label: 'ID Card Fee', amount: settingsMap.id_card_fee });
  }

  // Hostel — prefer the amount already locked in for this student.
  const hostelFee = Number(user?.hostelFee ?? student?.hostelFee ?? 0);
  if (hostelFee > 0) {
    options.push({ key: 'hostel_fee', label: `Hostel Fee${semLabel}`, amount: hostelFee });
  }

  // Transportation — prefer the amount already locked in for this student.
  const transportFee = Number(user?.transportFee ?? student?.transportFee ?? 0);
  if (transportFee > 0) {
    options.push({ key: 'transport_fee', label: 'Transportation Fee', amount: transportFee });
  }

  if (typeof settingsMap.convocation_fee === 'number') {
    options.push({ key: 'other', label: 'Other Charges', amount: settingsMap.convocation_fee });
  }

  return options;
}

export const PAYMENT_METHODS = ['UPI', 'Net Banking', 'Card', 'Cash', 'Cheque'];