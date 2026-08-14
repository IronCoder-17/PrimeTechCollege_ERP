// ============================================
// College Campus Connect — API Client
// ============================================

import axios from 'axios';

const PHP_BASE = 'https://primetechcollege.online/api';
const NODE_BASE = 'https://primetechcollege.online/api';
// PHP API instance
export const phpApi = axios.create({ baseURL: PHP_BASE });
// Node API instance  
export const nodeApi = axios.create({ baseURL: NODE_BASE });

// Attach token
[phpApi, nodeApi].forEach(api => {
  api.interceptors.request.use(config => {
    const token = localStorage.getItem('ccc_token');
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
  });

  api.interceptors.response.use(
    res => res,
    err => {
      if (err.response?.status === 401) {
        // Don't touch anything on login/register requests — those handle
        // their own error display inline (wrong password, etc.) and must
        // never trigger a session wipe.
        const requestUrl = err.config?.url || '';
        const isAuthRequest = /\/auth\.php\/(login|register)/.test(requestUrl);
        if (isAuthRequest) {
          return Promise.reject(err);
        }

        // ── IMPORTANT: Student and Faculty sessions are issued and managed
        // entirely on the client (AuthContext.login()) — they are NOT
        // server-signed tokens, so background calls to PHP endpoints
        // (e.g. results.php, faculty.php dashboard widgets) can 401 for
        // them even while their login is perfectly valid. Previously this
        // handler nuked ccc_token/ccc_user and did a hard
        // `window.location.href` redirect on ANY 401 from ANY endpoint —
        // which meant a Student/Faculty user got instantly logged out and
        // bounced back to Login the moment they opened Dashboard/Course/
        // Assignments/Result (each fires one of these background calls on
        // mount). That is the exact bug reported: "already logged in but
        // clicking a menu item redirects to Login".
        //
        // Fix: only treat a 401 as "your session has actually expired"
        // for the real, server-verified session — the Admin session
        // (the only one that goes through the signed-token backend flow
        // in auth.php). For Student/Faculty, let the 401 propagate back
        // to the calling component so it can show its own inline error
        // (already implemented via try/catch on every page) WITHOUT
        // destroying the stored login.
        let currentUser = null;
        try {
          const raw = localStorage.getItem('ccc_user');
          currentUser = raw ? JSON.parse(raw) : null;
        } catch {
          currentUser = null;
        }

        if (currentUser?.role === 'admin') {
          localStorage.removeItem('ccc_token');
          localStorage.removeItem('ccc_user');
          window.location.href = '/admin';
        }
        // Student / Faculty: session stays intact — just let the request
        // fail so the individual page can handle it gracefully.
      }
      return Promise.reject(err);
    }
  );
});

// ── Auth ──
export const authApi = {
  login: (data) => phpApi.post('/auth.php/login', data),
  register: (data) => phpApi.post('/auth.php/register', data),
  me: () => phpApi.get('/auth.php/me'),
};

// ── Posts ──
export const postsApi = {
  getFeed: (page = 1, type) => phpApi.get('/posts.php', { params: { page, type } }),
  create: (data) => phpApi.post('/posts.php', data),
  delete: (id) => phpApi.delete(`/posts.php/${id}`),
  like: (id) => phpApi.post(`/posts.php/${id}/like`),
  getComments: (id) => phpApi.get(`/posts.php/${id}/comments`),
  comment: (id, content) => phpApi.post(`/posts.php/${id}/comment`, { content }),
};

// ── Events ──
export const eventsApi = {
  getAll: (params) => phpApi.get('/events.php', { params }),
  getOne: (id) => phpApi.get(`/events.php/${id}`),
  create: (data) => phpApi.post('/events.php', data),
  rsvp: (id, status) => phpApi.post(`/events.php/${id}/rsvp`, { status }),
};

// ── Clubs ──
export const clubsApi = {
  getAll: (params) => phpApi.get('/clubs.php', { params }),
  getOne: (id) => phpApi.get(`/clubs.php/${id}`),
  create: (data) => phpApi.post('/clubs.php', data),
  join: (id) => phpApi.post(`/clubs.php/${id}/join`),
};

// ── Users ──
export const usersApi = {
  getMe: () => phpApi.get('/users.php/me'),
  getProfile: (id) => phpApi.get(`/users.php/${id}`),
  getUserPosts: (id) => phpApi.get(`/users.php/${id}/posts`),
  updateProfile: (data) => phpApi.put('/users.php/me', data),
  follow: (id) => phpApi.post(`/users.php/${id}/follow`),
  search: (q) => phpApi.get('/users.php/search', { params: { q } }),
};

// ── Messages (Node) ──
export const messagesApi = {
  getConversations: (userId) => nodeApi.get(`/conversations/${userId}`),
  getMessages: (convId) => nodeApi.get(`/messages/${convId}`),
};

// ── Notifications (Node) ──
export const notificationsApi = {
  getAll: (userId) => nodeApi.get(`/notifications/${userId}`),
  markRead: (userId) => nodeApi.put(`/notifications/${userId}/read`),
};

// ── Faculty (Modules 10-14) ──
export const facultyApi = {
  // Module 10: Self Attendance
  getMyAttendance: (month) =>
    phpApi.get('/faculty.php', { params: { action: 'my_attendance', month } }),

  // Module 11: Punch In/Out
  punchIn: (data) =>
    phpApi.post('/faculty.php?action=punch_in', data),
  punchOut: () =>
    phpApi.post('/faculty.php?action=punch_out'),
  getPunchLogs: (limit = 30) =>
    phpApi.get('/faculty.php', { params: { action: 'punch_logs', limit } }),

  // Module 12: Syllabus
  getSyllabus: () =>
    phpApi.get('/faculty.php', { params: { action: 'syllabus' } }),
  updateSyllabusUnit: (unitId, completedLectures) =>
    phpApi.put('/faculty.php?action=syllabus', { unit_id: unitId, completed_lectures: completedLectures }),
  addSyllabusUnit: (data) =>
    phpApi.post('/faculty.php?action=syllabus', data),

  // Student Attendance
  getStudentAttendance: (subjectId, date) =>
    phpApi.get('/faculty.php', { params: { action: 'student_attendance', subject_id: subjectId, date } }),
  saveStudentAttendance: (subjectId, date, records) =>
    phpApi.post('/faculty.php?action=student_attendance', { subject_id: subjectId, date, records }),

  // Module 14: Faculty Notifications
  getNotifications: (unreadOnly = false) =>
    phpApi.get('/faculty.php', { params: { action: 'notifications', ...(unreadOnly ? { unread_only: 1 } : {}) } }),
  markNotificationsRead: (ids = []) =>
    phpApi.put('/faculty.php?action=notifications', { ids }),

  // Dashboard Summary
  getDashboardSummary: () =>
    phpApi.get('/faculty.php', { params: { action: 'dashboard_summary' } }),
};

// ── Admission / Courses / Fee Structure ──
export const admissionApi = {
  getCourses: () => phpApi.get('/admission.php/courses'),
  // _t cache-busts the request (GET responses can otherwise be served
  // from an intermediate/browser cache) so Admin fee changes are picked
  // up immediately instead of showing a stale amount.
  getFee: (courseId, semester) =>
    phpApi.get('/admission.php/fee', { params: { course_id: courseId, semester, _t: Date.now() } }),
  // Full fee structure for all courses — used by Admin Fee Management
  // (College Fees) and the Admission/Registration page. Always reflects
  // the latest DB values; no hardcoded fee tables.
  getFeeStructure: (params) => phpApi.get('/admission.php/fee-structure', { params }),
  // Admin: update tuition_fee / exam_fee for a single course+semester row
  updateFeeStructure: (id, data) => phpApi.put(`/admission.php/fee-structure/${id}`, data),
  register: (data) => phpApi.post('/admission.php/register', data),
  payment: (data) => phpApi.post('/admission.php/payment', data),
  // Backend re-checks course_id + semester + amount against the live
  // fee_structure table before a semester-fee payment is accepted —
  // guards against a stale/manipulated frontend amount. Throws (409)
  // with the correct `expected_fee` if the amount no longer matches.
  verifyFee: (courseId, semester, amount) =>
    phpApi.post('/admission.php/verify-fee', { course_id: courseId, semester, amount }),
  // Student-only: called the instant next-semester fee payment succeeds,
  // so students.semester (what Timetable/Results read from) advances
  // together with the fee payment.
  advanceSemester: (semester) => phpApi.put('/admission.php/advance-semester', { semester }),
};

// ── Fee Management (Admin) ──
// Global fee settings (registration fee, admission fee, exam fee, etc.)
// and Hostel Fee Plans. GET /settings and GET /hostel-plans are public
// so the Registration page and student dashboards always show the
// latest admin-configured values with no code changes required.
export const feesApi = {
  // Public reads
  getSettings: (params) => phpApi.get('/fees.php/settings', { params }),
  getHostelPlans: (params) => phpApi.get('/fees.php/hostel-plans', { params }),

  // Admin: fee settings (College/Registration/Other charges)
  getSetting: (id) => phpApi.get(`/fees.php/settings/${id}`),
  updateSetting: (id, data) => phpApi.put(`/fees.php/settings/${id}`, data),

  // Admin: hostel fee plan CRUD
  getHostelPlan: (id) => phpApi.get(`/fees.php/hostel-plans/${id}`),
  createHostelPlan: (data) => phpApi.post('/fees.php/hostel-plans', data),
  updateHostelPlan: (id, data) => phpApi.put(`/fees.php/hostel-plans/${id}`, data),
  deleteHostelPlan: (id) => phpApi.delete(`/fees.php/hostel-plans/${id}`),
};

// ── Transportation Management (Admin) ──
// Public read returns ACTIVE routes only — used by the Registration
// page "Location" dropdown so it always reflects the latest
// Admin-configured routes with no code changes required.
export const transportationApi = {
  // Public reads
  getRoutes: (params) => phpApi.get('/transportation.php/routes', { params }),

  // Admin: full route CRUD
  getAllRoutes: () => phpApi.get('/transportation.php/routes/all'),
  getRoute: (id) => phpApi.get(`/transportation.php/routes/${id}`),
  createRoute: (data) => phpApi.post('/transportation.php/routes', data),
  updateRoute: (id, data) => phpApi.put(`/transportation.php/routes/${id}`, data),
  deleteRoute: (id) => phpApi.delete(`/transportation.php/routes/${id}`),
};

// ── Admin: Student & Faculty Management, Dashboard, Activity ──
export const adminApi = {
  // Dashboard
  getDashboard: () => phpApi.get('/admin.php/dashboard'),
  getActivity: (limit = 30) => phpApi.get('/admin.php/activity', { params: { limit } }),

  // Students (full CRUD over the `students` admission table)
  getStudents: () => phpApi.get('/admin.php/students'),
  getStudent: (id) => phpApi.get(`/admin.php/students/${id}`),
  updateStudent: (id, data) => phpApi.put(`/admin.php/students/${id}`, data),
  deleteStudent: (id) => phpApi.delete(`/admin.php/students/${id}`),
  setStudentStatus: (id, active) => phpApi.put(`/admin.php/students/${id}/status`, { active }),
  resetStudentPassword: (id, password) => phpApi.put(`/admin.php/students/${id}/password`, { password }),

  // Faculty (full CRUD over the `faculty` table)
  getFacultyList: () => phpApi.get('/admin.php/faculty'),
  getFacultyMember: (id) => phpApi.get(`/admin.php/faculty/${id}`),
  updateFaculty: (id, data) => phpApi.put(`/admin.php/faculty/${id}`, data),
  deleteFaculty: (id) => phpApi.delete(`/admin.php/faculty/${id}`),
  setFacultyStatus: (id, active) => phpApi.put(`/admin.php/faculty/${id}/status`, { active }),
  resetFacultyPassword: (id, password) => phpApi.put(`/admin.php/faculty/${id}/password`, { password }),

  // ── Faculty Attendance Management ──
  // List + filter (date, month, faculty_id, department), edit records,
  // dashboard summary stats, and CSV export. Reads/writes the same
  // tables the Faculty self-service "Punch In/Out" API uses, so changes
  // sync instantly between Admin and Faculty dashboards.
  getAttendanceList: (params = {}) => phpApi.get('/admin.php/attendance', { params }),
  getAttendanceDashboard: (month) => phpApi.get('/admin.php/attendance/dashboard', { params: { month } }),
  updateAttendance: (id, data) => phpApi.put(`/admin.php/attendance/${id}`, data),
  // Triggers a CSV (Excel-compatible) download of the filtered records.
  exportAttendanceCSV: async (params = {}) => {
    const res = await phpApi.get('/admin.php/attendance/export', { params, responseType: 'blob' });
    const url = window.URL.createObjectURL(new Blob([res.data], { type: 'text/csv' }));
    const link = document.createElement('a');
    link.href = url;
    link.download = `faculty_attendance_${new Date().toISOString().slice(0, 10)}.csv`;
    document.body.appendChild(link);
    link.click();
    link.remove();
    window.URL.revokeObjectURL(url);
  },
};

// ── Results (Student Previous Semester Results / SGPA / CGPA) ──
export const resultsApi = {
  // Student: own results — current semester, all previous semesters'
  // SGPA + subject-wise marks + pass/fail, and derived CGPA.
  getMyResults: () => phpApi.get('/results.php/my-results'),

  // Admin: search students (by name / enrollment number) for the
  // Add/Upload Result picker.
  searchStudents: (search = '') => phpApi.get('/results.php/students', { params: { search } }),

  // Admin: full result history (all semesters) for one student.
  getStudentResults: (studentId) => phpApi.get(`/results.php/student/${studentId}`),

  // Admin: subjects assigned to a course+semester, straight from the
  // Course/Timetable module (tt_subjects) — powers the auto-fetch on
  // the "Add Student Marks" screen so subjects are never retyped.
  getCourseSubjects: (courseId, semester) =>
    phpApi.get('/results.php/course-subjects', { params: { course_id: courseId, semester } }),

  // Admin: add a semester result for one student.
  // data = { student_id, semester, subjects: [{subject_id, internal_max, internal_marks, external_max, external_marks, practical_max, practical_marks}], remarks?, sgpa?, result_status? }
  // subject_code/subject_name/credits are resolved server-side from subject_id — never trusted from the client.
  addResult: (data) => phpApi.post('/results.php', data),

  // Admin: edit an existing semester result (replaces subjects).
  updateResult: (id, data) => phpApi.put(`/results.php/${id}`, data),

  // Admin: delete a semester result.
  deleteResult: (id) => phpApi.delete(`/results.php/${id}`),

  // Admin: bulk-upload marks for multiple students (same course) for one semester.
  // data = { course_id, semester, subjects: [{subject_id, subject_code, subject_name, credits, internal_max, external_max, practical_max}],
  //          students: [{student_id, marks_split: {<subject_id>: {internal, external, practical}}}], remarks? }
  bulkUpload: (data) => phpApi.post('/results.php/bulk', data),
};

// ── Timetable (Predefined + Admin-managed) ──
export const timetableApi = {
  // Public / any authenticated role
  getPeriods: () => phpApi.get('/timetable.php/periods'),
  getCourses: () => phpApi.get('/timetable.php/courses'),
  getGrid: (courseId, semester) =>
    phpApi.get('/timetable.php/grid', { params: { course_id: courseId, semester } }),
  getMy: () => phpApi.get('/timetable.php/my'),

  // Admin
  search: (params = {}) => phpApi.get('/timetable.php/search', { params }),
  getSubjects: (courseId, semester) =>
    phpApi.get('/timetable.php/subjects', { params: { course_id: courseId, semester } }),
  addSubject: (data) => phpApi.post('/timetable.php/subjects', data),
  getClassrooms: () => phpApi.get('/timetable.php/classrooms'),
  getFacultyList: () => phpApi.get('/timetable.php/faculty-list'),
  createSlot: (data) => phpApi.post('/timetable.php/slot', data),
  updateSlot: (id, data) => phpApi.put(`/timetable.php/slot/${id}`, data),
  deleteSlot: (id) => phpApi.delete(`/timetable.php/slot/${id}`),
  replaceTimetable: (data) => phpApi.post('/timetable.php/replace', data),
  exportCSV: async (courseId, semester) => {
    const res = await phpApi.get('/timetable.php/export', {
      params: { course_id: courseId, semester, format: 'csv' }, responseType: 'blob',
    });
    const url = window.URL.createObjectURL(new Blob([res.data], { type: 'text/csv' }));
    const link = document.createElement('a');
    link.href = url;
    link.download = `timetable_course${courseId}_sem${semester}.csv`;
    document.body.appendChild(link);
    link.click();
    link.remove();
    window.URL.revokeObjectURL(url);
  },
  exportPDF: (courseId, semester) => {
    window.open(
      `${PHP_BASE}/timetable.php/export?course_id=${courseId}&semester=${semester}&format=pdf`,
      '_blank'
    );
  },
};