// ============================================================
// Student Directory & Faculty-Student Mapping
// ============================================================
// Single source of truth for reading student records (created via
// the Admission flow and stored in localStorage under
// 'ccc_admission_accounts') and for mapping faculty members to
// "their" students based on department / specialization / course.
//
// Visibility rules:
//  - Admin (superuser): sees ALL students — use getAllStudents().
//  - Faculty: sees ONLY students whose course/department matches
//    the faculty's department (and, where possible, specialization)
//    — use getStudentsForFaculty(facultyUser).
// ============================================================

const ADMISSION_ACCOUNTS_KEY = 'ccc_admission_accounts';
const STUDENT_ATTENDANCE_KEY = 'ccc_student_attendance'; // { [recordKey]: {status, ...} }
const STUDENT_STATUS_KEY = 'ccc_student_status';         // { [studentId]: 'Active'|'Suspended'|'Inactive' }

// ── Faculty Department → Course "dept" + course-code prefixes ──────────────
// Faculty registration uses broader department names (Computer Engineering,
// Mechanical Engineering, etc). Admission course records carry a `courseDept`
// (Engineering, Computer & IT, Management, Science, Commerce, Arts, Design)
// plus a specific `courseCode` (BTCE, BCA, MBA, ...).
//
// This map gives, for each faculty department, the list of admission course
// codes that should be considered "theirs". This is the most reliable
// available mapping given the current schema (no direct FK between faculty
// and courses table yet).
export const FACULTY_DEPT_TO_COURSE_CODES = {
  'Computer Engineering':         ['BTCE', 'MTCE'],
  'Information Technology':       ['BTIT', 'BSCIT'],
  'Mechanical Engineering':       ['BTME'],
  'Civil Engineering':            ['BTCV', 'MTSE'],
  'Electronics & Communication':  ['BTEC'],
  'Computer Applications':        ['BCA', 'MCA'],
  'Management':                   ['BBA', 'MBA', 'BCBA'],
  'Commerce':                     ['BCOM', 'MCOM'],
  'Science':                      ['BSCMA', 'BSCPH', 'MSCDS'],
  'Arts & Humanities':            ['BAEN'],
  'Design & Media':               ['BMMA'],
};

// Broad fallback: faculty DEPARTMENTS roughly map to admission courseDept too.
export const FACULTY_DEPT_TO_COURSE_DEPT = {
  'Computer Engineering':        'Engineering',
  'Information Technology':      'Engineering',
  'Mechanical Engineering':      'Engineering',
  'Civil Engineering':           'Engineering',
  'Electronics & Communication': 'Engineering',
  'Computer Applications':       'Computer & IT',
  'Management':                  'Management',
  'Commerce':                    'Commerce',
  'Science':                     'Science',
  'Arts & Humanities':           'Arts',
  'Design & Media':              'Design',
};

// ── Read raw admission accounts ─────────────────────────────────────────────
export function getAllStudents() {
  try {
    const raw = localStorage.getItem(ADMISSION_ACCOUNTS_KEY);
    const accounts = raw ? JSON.parse(raw) : [];
    const statusMap = getStudentStatusMap();
    return accounts.map(normalizeStudent).map(s => ({
      ...s,
      accountStatus: statusMap[s.id] || s.accountStatus || 'Active',
    }));
  } catch {
    return [];
  }
}

// Normalize an admission account into a consistent "student record" shape
function normalizeStudent(a) {
  return {
    id: a.id,
    name: a.name || [a.firstName, a.middleName, a.lastName].filter(Boolean).join(' '),
    firstName: a.firstName || '',
    middleName: a.middleName || '',
    lastName: a.lastName || '',
    email: a.email || '',
    phone: a.phone || '',
    gender: a.gender || '',
    dob: a.dob || '',
    address: a.address || '',
    grNumber: a.grNumber || '',
    enrollmentNumber: a.enrollmentNumber || '',
    studentId: a.studentId || '',
    course: a.course || '',
    courseCode: a.courseCode || '',
    courseDept: a.courseDept || '',
    semester: a.semester || '',
    admissionYear: a.admissionYear || '',
    photoDataUrl: a.photoDataUrl || null,
    totalFee: a.totalFee || 0,
    paidFee: a.paidFee || 0,
    pendingFee: a.pendingFee || 0,
    paymentHistory: a.paymentHistory || [],
    hostelRequired: a.hostelRequired || false,
    hostelType: a.hostelType || null,
    hostelStatus: a.hostelStatus || null,
    hostelAllocationStatus: a.hostelAllocationStatus || null,
    hostelRoomNumber: a.hostelRoomNumber || null,
    accountStatus: a.accountStatus || 'Active',
    registrationDate: a.registrationDate || a.createdAt || null,
    raw: a,
  };
}

// ── Faculty → Students filtering ────────────────────────────────────────────
// Matches students whose courseCode / courseDept correspond to the faculty's
// department or specialization. Falls back gracefully if no exact match
// is configured (returns students from the broad department instead).
export function getStudentsForFaculty(facultyUser) {
  const all = getAllStudents();
  if (!facultyUser) return [];

  const dept = facultyUser.department || facultyUser.major || '';
  const codes = FACULTY_DEPT_TO_COURSE_CODES[dept] || [];
  const broadDept = FACULTY_DEPT_TO_COURSE_DEPT[dept] || '';

  let matched = all.filter(s => codes.includes(s.courseCode));

  // Fallback: match on broad course department if no direct code matches
  if (matched.length === 0 && broadDept) {
    matched = all.filter(s => s.courseDept === broadDept);
  }

  return matched;
}

// ── Search / Filter / Sort / Pagination helper ──────────────────────────────
// Applies search (name/email/enrollment/GR), filters (course, semester,
// status), sorting, and pagination to a list of normalized students.
export function queryStudents(students, {
  search = '',
  course = '',
  semester = '',
  status = '',
  sortBy = 'name',
  sortDir = 'asc',
  page = 1,
  pageSize = 10,
} = {}) {
  let result = [...students];

  if (search) {
    const q = search.toLowerCase().trim();
    result = result.filter(s =>
      s.name?.toLowerCase().includes(q) ||
      s.email?.toLowerCase().includes(q) ||
      s.enrollmentNumber?.toLowerCase().includes(q) ||
      s.grNumber?.toLowerCase().includes(q) ||
      s.studentId?.toLowerCase().includes(q)
    );
  }
  if (course) result = result.filter(s => s.courseCode === course);
  if (semester) result = result.filter(s => String(s.semester) === String(semester));
  if (status) result = result.filter(s => (s.accountStatus || 'Active') === status);

  result.sort((a, b) => {
    const av = (a[sortBy] ?? '').toString().toLowerCase();
    const bv = (b[sortBy] ?? '').toString().toLowerCase();
    if (av < bv) return sortDir === 'asc' ? -1 : 1;
    if (av > bv) return sortDir === 'asc' ? 1 : -1;
    return 0;
  });

  const total = result.length;
  const totalPages = Math.max(1, Math.ceil(total / pageSize));
  const safePage = Math.min(Math.max(1, page), totalPages);
  const start = (safePage - 1) * pageSize;
  const items = result.slice(start, start + pageSize);

  return { items, total, totalPages, page: safePage, pageSize };
}

// ── Student account status (Admin: activate / suspend) ──────────────────────
export function getStudentStatusMap() {
  try {
    const raw = localStorage.getItem(STUDENT_STATUS_KEY);
    return raw ? JSON.parse(raw) : {};
  } catch {
    return {};
  }
}

export function setStudentStatus(studentId, status) {
  const map = getStudentStatusMap();
  map[studentId] = status;
  localStorage.setItem(STUDENT_STATUS_KEY, JSON.stringify(map));
}

// ── Admin: full CRUD over admission accounts ────────────────────────────────
export function saveAllStudents(accounts) {
  localStorage.setItem(ADMISSION_ACCOUNTS_KEY, JSON.stringify(accounts));
}

export function getRawAccounts() {
  try {
    const raw = localStorage.getItem(ADMISSION_ACCOUNTS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

export function addStudent(studentData) {
  const accounts = getRawAccounts();
  const newAccount = {
    id: Date.now(),
    accountStatus: 'Active',
    paymentHistory: [],
    totalFee: 0, paidFee: 0, pendingFee: 0,
    ...studentData,
  };
  accounts.push(newAccount);
  saveAllStudents(accounts);
  return newAccount;
}

export function updateStudent(studentId, updates) {
  const accounts = getRawAccounts();
  const idx = accounts.findIndex(a => a.id === studentId);
  if (idx === -1) return null;
  accounts[idx] = { ...accounts[idx], ...updates };
  saveAllStudents(accounts);
  return accounts[idx];
}

export function deleteStudent(studentId) {
  const accounts = getRawAccounts();
  const filtered = accounts.filter(a => a.id !== studentId);
  saveAllStudents(filtered);
  // also clean up status map
  const statusMap = getStudentStatusMap();
  delete statusMap[studentId];
  localStorage.setItem(STUDENT_STATUS_KEY, JSON.stringify(statusMap));
}

// ── Attendance storage (faculty marks students) ─────────────────────────────
// Record key: `${subjectCode}__${date}__${studentId}`
export function getAttendanceStore() {
  try {
    const raw = localStorage.getItem(STUDENT_ATTENDANCE_KEY);
    return raw ? JSON.parse(raw) : {};
  } catch {
    return {};
  }
}

export function saveAttendanceStore(store) {
  localStorage.setItem(STUDENT_ATTENDANCE_KEY, JSON.stringify(store));
}

// records: [{ studentId, studentName, status }]
export function saveAttendanceBatch({ subjectCode, subjectName, date, facultyId, facultyName, records }) {
  const store = getAttendanceStore();
  records.forEach(r => {
    const key = `${subjectCode}__${date}__${r.studentId}`;
    store[key] = {
      studentId: r.studentId,
      studentName: r.studentName,
      subjectCode,
      subjectName,
      date,
      facultyId,
      facultyName,
      status: r.status,
      timestamp: new Date().toISOString(),
    };
  });
  saveAttendanceStore(store);
  return store;
}

// Get attendance for a subject+date as a map { [studentId]: status }
export function getAttendanceForDate(subjectCode, date) {
  const store = getAttendanceStore();
  const result = {};
  Object.values(store).forEach(rec => {
    if (rec.subjectCode === subjectCode && rec.date === date) {
      result[rec.studentId] = rec.status;
    }
  });
  return result;
}

// Get full attendance history for a subject (all dates)
export function getAttendanceHistory(subjectCode) {
  const store = getAttendanceStore();
  return Object.values(store)
    .filter(rec => rec.subjectCode === subjectCode)
    .sort((a, b) => b.date.localeCompare(a.date));
}

// Get attendance % per student for a subject (or all subjects if null)
export function getStudentAttendanceSummary(studentId, subjectCode = null) {
  const store = getAttendanceStore();
  const records = Object.values(store).filter(rec =>
    rec.studentId === studentId && (!subjectCode || rec.subjectCode === subjectCode)
  );
  const total = records.length;
  const present = records.filter(r => r.status === 'Present').length;
  const absent = records.filter(r => r.status === 'Absent').length;
  const leave = records.filter(r => r.status === 'Leave').length;
  const pct = total > 0 ? Math.round((present / total) * 100) : 0;
  return { total, present, absent, leave, pct, records };
}

// Monthly report: per-day status counts for a subject in a given YYYY-MM
export function getMonthlyAttendanceReport(subjectCode, yearMonth) {
  const store = getAttendanceStore();
  const records = Object.values(store).filter(rec =>
    rec.subjectCode === subjectCode && rec.date.startsWith(yearMonth)
  );
  const byDate = {};
  records.forEach(r => {
    if (!byDate[r.date]) byDate[r.date] = { Present: 0, Absent: 0, Leave: 0 };
    byDate[r.date][r.status] = (byDate[r.date][r.status] || 0) + 1;
  });
  return byDate;
}
