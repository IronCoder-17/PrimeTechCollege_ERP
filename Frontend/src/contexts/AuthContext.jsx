// ============================================
// College PrimeTech College — Auth Context
// Mock authentication — no backend required
// Supports .edu and .ac.in email domains only
// Admission-created accounts stored in localStorage
// ============================================

import { createContext, useContext, useState } from 'react';
import { authApi } from '../utils/api';

const AuthContext = createContext(null);

// ── Allowed email domains ──────────────────────────────────────────────────────
const ALLOWED_DOMAINS = ['.edu', '.ac.in'];

export function isEducationalEmail(email) {
  if (!email) return false;
  const lower = email.toLowerCase().trim();
  return ALLOWED_DOMAINS.some(domain => lower.endsWith(domain));
}

// ── FIX 4: Employee ID detector ───────────────────────────────────────────────
// Faculty can authenticate with their Employee ID (PTFAC20260001) instead of
// an email address. This bypasses the domain check inside AuthContext.login().
function isFacultyEmployeeId(value) {
  return /^ptfac\d+$/i.test((value || '').trim());
}

// ── Storage key for admission-created accounts ────────────────────────────────
const ADMISSION_ACCOUNTS_KEY = 'ccc_admission_accounts';

// ── Storage key for faculty applications ─────────────────────────────────────
const FACULTY_APPS_KEY = 'pt_faculty_applications';

function getFacultyApplications() {
  try {
    const raw = localStorage.getItem(FACULTY_APPS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch { return []; }
}

// Read all admission accounts from localStorage
function getAdmissionAccounts() {
  try {
    const raw = localStorage.getItem(ADMISSION_ACCOUNTS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

// Save a new admission account to localStorage
export function saveAdmissionAccount(account) {
  try {
    const existing = getAdmissionAccounts();
    // Remove any existing entry for the same email (idempotent)
    const filtered = existing.filter(a => a.email.toLowerCase() !== account.email.toLowerCase());
    filtered.push(account);
    localStorage.setItem(ADMISSION_ACCOUNTS_KEY, JSON.stringify(filtered));
  } catch (err) {
    console.error('Failed to save admission account:', err);
  }
}

// ── Patch fields (e.g. semester) on an existing admission account ────────────
// Used by the Fee Receipt module's "Automatic Semester Update" step: once a
// student pays their next-semester fee, the underlying admission account
// record must be updated too — not just the in-memory session — so the new
// semester is still correct the next time the student logs in.
export function updateAdmissionAccount(email, updates) {
  if (!email) return;
  try {
    const existing = getAdmissionAccounts();
    const idx = existing.findIndex(a => a.email.toLowerCase() === email.toLowerCase());
    if (idx === -1) return;
    existing[idx] = { ...existing[idx], ...updates };
    localStorage.setItem(ADMISSION_ACCOUNTS_KEY, JSON.stringify(existing));
  } catch (err) {
    console.error('Failed to update admission account:', err);
  }
}

// ── Enrollment Number Generator ───────────────────────────────────────────────
// Format: PT + Year + CourseCode + RunningNumber (e.g. PT2026BCA0001)
export function generateEnrollmentNumber(courseCode, year) {
  try {
    const accounts = getAdmissionAccounts();
    const prefix = `PT${year}${courseCode}`;
    // Count existing enrollments with same prefix
    const existing = accounts.filter(a =>
      a.enrollmentNumber && a.enrollmentNumber.startsWith(prefix)
    );
    const seq = String(existing.length + 1).padStart(4, '0');
    return `${prefix}${seq}`;
  } catch {
    const seq = String(Math.floor(Math.random() * 9000) + 1000);
    return `PT${year}${courseCode}${seq}`;
  }
}

// ── GR Number Generator ───────────────────────────────────────────────────────
// Format: PTGR + Year + RunningNumber (e.g. PTGR20260001)
export function generateGRNumber(year) {
  try {
    const accounts = getAdmissionAccounts();
    const prefix = `PTGR${year}`;
    const existing = accounts.filter(a =>
      a.grNumber && a.grNumber.startsWith(prefix)
    );
    const seq = String(existing.length + 1).padStart(4, '0');
    return `${prefix}${seq}`;
  } catch {
    const seq = String(Math.floor(Math.random() * 9000) + 1000);
    return `PTGR${year}${seq}`;
  }
}

// ── Demo / seeded users ───────────────────────────────────────────────────────
const MOCK_USERS = [
  {
    id: 1,
    name: 'Alex Johnson',
    email: 'alex@university.edu',
    password: 'password123',
    role: 'student',
    major: 'Computer Science',
    year: 'Junior',
    avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop&crop=face',
    bio: 'Passionate about open source and AI.',
    followers: 128,
    following: 64,
    gender: 'male',
  },
  // NOTE: the admin demo account was previously hardcoded here
  // (admin@university.edu / admin123) and shipped in the public JS bundle.
  // Admin login now always goes through the real backend (see login()
  // below), verified against the `users` table — see
  // database/schema_admin_security_fix.sql for the real seeded admin
  // account and its temporary password.
  {
    id: 3,
    name: 'Dr. Sarah Faculty',
    email: 'faculty@university.edu',
    password: 'faculty123',
    role: 'faculty',
    major: 'Computer Science Dept.',
    year: '',
    avatar: 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=80&h=80&fit=crop&crop=face',
    bio: 'Professor of Computer Science.',
    followers: 245,
    following: 12,
  },
  {
    id: 4,
    name: 'Rahul Sharma',
    email: 'rahul@iit.ac.in',
    password: 'password123',
    role: 'student',
    major: 'Electronics Engineering',
    year: 'Senior',
    avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=80&h=80&fit=crop&crop=face',
    bio: 'Engineering student at IIT.',
    followers: 89,
    following: 43,
    gender: 'male',
  },
];

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => {
    try {
      const u = localStorage.getItem('ccc_user');
      return u ? JSON.parse(u) : null;
    } catch {
      return null;
    }
  });
  const [loading] = useState(false);

  const login = async (email, password, role = 'student') => {
    const emailLower = email.toLowerCase().trim();

    // 0. SECURITY: Admin accounts must be authenticated by the real backend
    // (a genuine password_hash check against the `users` table), which now
    // returns a server-signed, expiring token. Admin identities are no
    // longer granted from the hardcoded MOCK_USERS list or any client-side
    // localStorage data — that was what allowed anyone to open devtools,
    // fabricate a token, and reach the Admin Panel without credentials.
    if (role === 'admin') {
      let data;
      try {
        ({ data } = await authApi.login({ email: emailLower, password }));
      } catch (err) {
        throw new Error(err.response?.data?.error || 'Invalid email or password.');
      }
      if (data.user.role !== 'admin') {
        throw new Error('This account is not an administrator.');
      }
      localStorage.setItem('ccc_token', data.token);
      localStorage.setItem('ccc_user', JSON.stringify(data.user));
      setUser(data.user);
      return { user: data.user };
    }

    // 1. Domain / identifier check
    // ── Faculty may log in with Employee ID (PTFAC20260001) which is not an
    //    email address, so skip the domain gate for that format.
    if (!isFacultyEmployeeId(emailLower) && !isEducationalEmail(emailLower)) {
      throw new Error(
        'Only institutional email addresses are allowed. Please use a .edu or .ac.in email address.'
      );
    }

    // 2. Check hardcoded demo users first
    const mockMatch = MOCK_USERS.find(
      u => u.email.toLowerCase() === emailLower && u.password === password
    );

    if (mockMatch) {
      if (mockMatch.role !== role) {
        throw new Error(
          `This account is registered as "${mockMatch.role}". Please select the correct role.`
        );
      }
      const userData = { ...mockMatch };
      delete userData.password;
      localStorage.setItem('ccc_token', `mock-token-${mockMatch.id}-${Date.now()}`);
      localStorage.setItem('ccc_user', JSON.stringify(userData));
      setUser(userData);
      return { user: userData };
    }

    // 3. Check admission-created accounts stored in localStorage
    const admissionAccounts = getAdmissionAccounts();
    const admissionMatch = admissionAccounts.find(
      a => a.email.toLowerCase() === emailLower && a.password === password
    );

    if (admissionMatch) {
      // Admission accounts are always students
      if (role !== 'student') {
        throw new Error('This account is a student account. Please select "Student" role.');
      }

      // Determine avatar: use uploaded photo or gender-based animated avatar
      let avatar;
      if (admissionMatch.photoDataUrl) {
        avatar = admissionMatch.photoDataUrl;
      } else {
        const gender = (admissionMatch.gender || '').toLowerCase();
        if (gender === 'male') {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${admissionMatch.name}&backgroundColor=b6e3f4&topType=ShortHairShortRound&facialHairType=Blank&clotheType=BlazerShirt`;
        } else if (gender === 'female') {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${admissionMatch.name}&backgroundColor=ffdfba&topType=LongHairStraight&facialHairType=Blank&clotheType=BlazerShirt`;
        } else {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${admissionMatch.name}&backgroundColor=c0aede`;
        }
      }

      const userData = {
        id: admissionMatch.id || Date.now(),
        name: admissionMatch.name,
        email: admissionMatch.email,
        role: 'student',
        major: admissionMatch.course || '',
        year: `Semester ${admissionMatch.semester}`,
        avatar,
        bio: `${admissionMatch.course} — ${admissionMatch.enrollmentNumber || admissionMatch.grNumber}`,
        followers: 0,
        following: 0,
        // Full profile data
        gender: admissionMatch.gender || '',
        phone: admissionMatch.phone || '',
        address: admissionMatch.address || '',
        dob: admissionMatch.dob || '',
        grNumber: admissionMatch.grNumber || '',
        enrollmentNumber: admissionMatch.enrollmentNumber || '',
        studentId: admissionMatch.studentId || '',
        course: admissionMatch.course || '',
        courseCode: admissionMatch.courseCode || '',
        courseId: admissionMatch.courseId ?? null,
        totalSemesters: admissionMatch.totalSemesters ?? null,
        semester: admissionMatch.semester || '',
        admissionYear: admissionMatch.admissionYear || new Date().getFullYear(),
        registrationDate: admissionMatch.registrationDate || new Date().toISOString(),
        totalFee: admissionMatch.totalFee || 0,
        paidFee: admissionMatch.paidFee || 0,
        pendingFee: admissionMatch.pendingFee || 0,
        paymentHistory: admissionMatch.paymentHistory || [],
        firstName: admissionMatch.firstName || '',
        middleName: admissionMatch.middleName || '',
        lastName: admissionMatch.lastName || '',
        photoDataUrl: admissionMatch.photoDataUrl || null,
        accountStatus: 'Active',
        // Hostel Information
        hostelRequired: admissionMatch.hostelRequired || false,
        hostelType: admissionMatch.hostelType || null,
        roomType: admissionMatch.roomType || null,
        hostelFee: admissionMatch.hostelFee || 0,
        hostelStatus: admissionMatch.hostelStatus || null,
        hostelAllocationStatus: admissionMatch.hostelAllocationStatus || null,
        hostelRoomNumber: admissionMatch.hostelRoomNumber || null,
        hostelAdmissionDate: admissionMatch.hostelAdmissionDate || null,
        hostelPaymentStatus: admissionMatch.hostelPaymentStatus || null,
        // Transportation Information
        transportRequired: admissionMatch.transportRequired || false,
        transportLocation: admissionMatch.transportLocation || null,
        busNumber: admissionMatch.busNumber || null,
        transportFee: admissionMatch.transportFee || 0,
        transportPaymentStatus: admissionMatch.transportPaymentStatus || null,
      };
      localStorage.setItem('ccc_token', `pt-token-${admissionMatch.grNumber}-${Date.now()}`);
      localStorage.setItem('ccc_user', JSON.stringify(userData));
      setUser(userData);
      return { user: userData };
    }

    // 4. Check faculty applications — login with Employee ID or faculty email
    const facultyApps = getFacultyApplications();
    const facultyMatch = facultyApps.find(fa => {
      // ── FIX 5: Status gate uses OR — account must be Approved AND Active.
      // Previous AND logic allowed partially-valid statuses through.
      // An account is loginable only when BOTH status=Approved AND accountStatus=Active.
      const isApproved = fa.status === 'Approved';
      const isActive   = fa.accountStatus === 'Active';
      if (!isApproved || !isActive) return false;

      // Match by employee ID (case-insensitive) OR by faculty email
      const idMatch    = isFacultyEmployeeId(emailLower) &&
                         fa.employeeId?.toLowerCase() === emailLower;
      const emailMatch = fa.facultyEmail?.toLowerCase() === emailLower;

      return (idMatch || emailMatch) && fa.password === password;
    });

    if (facultyMatch) {
      if (role !== 'faculty') {
        throw new Error('This is a faculty account. Please select the "Faculty" role.');
      }
      let avatar;
      if (facultyMatch.photoDataUrl) {
        avatar = facultyMatch.photoDataUrl;
      } else {
        const gender = (facultyMatch.gender || '').toLowerCase();
        if (gender === 'male') {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${facultyMatch.name}&backgroundColor=b6e3f4&topType=ShortHairShortRound&clotheType=BlazerShirt`;
        } else if (gender === 'female') {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${facultyMatch.name}&backgroundColor=ffdfba&topType=LongHairStraight&clotheType=BlazerShirt`;
        } else {
          avatar = `https://api.dicebear.com/7.x/avataaars/svg?seed=${facultyMatch.name}&backgroundColor=c0aede`;
        }
      }
      const userData = {
        id: facultyMatch.applicationId || Date.now(),
        name: facultyMatch.name,
        email: facultyMatch.facultyEmail,
        role: 'faculty',
        major: facultyMatch.department || '',
        year: '',
        avatar,
        bio: `${facultyMatch.designation} · ${facultyMatch.department}`,
        followers: 0, following: 0,
        gender: facultyMatch.gender || '',
        phone: facultyMatch.phone || '',
        address: facultyMatch.address || '',
        dob: facultyMatch.dob || '',
        employeeId: facultyMatch.employeeId || '',
        facultyEmail: facultyMatch.facultyEmail || '',
        designation: facultyMatch.designation || '',
        department: facultyMatch.department || '',
        qualification: facultyMatch.qualification || '',
        specialization: facultyMatch.specialization || '',
        experience: facultyMatch.experience || '',
        joiningDate: facultyMatch.joiningDate || '',
        accountStatus: facultyMatch.accountStatus || 'Active',
        firstName: facultyMatch.firstName || '',
        middleName: facultyMatch.middleName || '',
        lastName: facultyMatch.lastName || '',
        photoDataUrl: facultyMatch.photoDataUrl || null,
      };
      localStorage.setItem('ccc_token', `ptfac-token-${facultyMatch.employeeId}-${Date.now()}`);
      localStorage.setItem('ccc_user', JSON.stringify(userData));
      setUser(userData);
      return { user: userData };
    }

    // 4b. Check if a faculty record exists but is not yet approved — give a
    //     specific error rather than the generic "invalid credentials" message.
    if (!facultyMatch) {
      const pendingFaculty = facultyApps.find(fa => {
        const idMatch    = isFacultyEmployeeId(emailLower) &&
                           fa.employeeId?.toLowerCase() === emailLower;
        const emailMatch = fa.facultyEmail?.toLowerCase() === emailLower;
        return (idMatch || emailMatch) && fa.password === password;
      });
      if (pendingFaculty) {
        throw new Error(
          `Your faculty account (${pendingFaculty.employeeId}) is currently ` +
          `"${pendingFaculty.status}". Please contact the administrator to activate your account.`
        );
      }
    }

    // 5. Nothing matched
    throw new Error('Invalid email or password. Please check your credentials and try again.');
  };

  const register = async (data) => {
    if (!isEducationalEmail(data.email)) {
      throw new Error(
        'Only institutional email addresses are allowed (.edu or .ac.in).'
      );
    }
    const newUser = {
      id: Date.now(),
      name: data.name,
      email: data.email,
      role: 'student',
      major: data.major || '',
      year: data.year || 'Freshman',
      avatar: `https://api.dicebear.com/7.x/avataaars/svg?seed=${data.name}`,
      bio: '',
      followers: 0,
      following: 0,
    };
    localStorage.setItem('ccc_token', `mock-token-${newUser.id}`);
    localStorage.setItem('ccc_user', JSON.stringify(newUser));
    setUser(newUser);
    return { user: newUser };
  };

  const logout = () => {
    localStorage.removeItem('ccc_token');
    localStorage.removeItem('ccc_user');
    setUser(null);
  };

  const updateUser = (updates) => {
    const updated = { ...user, ...updates };
    setUser(updated);
    localStorage.setItem('ccc_user', JSON.stringify(updated));
    // Student accounts created via Admission are also stored in
    // ccc_admission_accounts — keep that record in sync too (e.g. when the
    // Fee Receipt module advances the student's current semester after a
    // successful next-semester fee payment) so the change persists beyond
    // this session.
    if (updated?.role === 'student' && updated?.email) {
      updateAdmissionAccount(updated.email, updates);
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, login, register, logout, updateUser, isEducationalEmail }}>
      {children}
    </AuthContext.Provider>
  );
}

export const useAuth = () => {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be inside AuthProvider');
  return ctx;
};
