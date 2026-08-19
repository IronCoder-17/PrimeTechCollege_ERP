// ============================================================
// Role-Based Access Control (RBAC) — central permission rules
// ============================================================
// Roles: 'admin' | 'faculty' | 'student'
//
// Admin = superuser → unrestricted access to every module/route.
// Faculty/Student → restricted to their own permitted modules.

export const ROLES = {
  ADMIN: 'admin',
  FACULTY: 'faculty',
  STUDENT: 'student',
};

// Modules each non-admin role is permitted to access.
// (Admin bypasses this map entirely — see hasAccess below.)
const ROLE_MODULES = {
  [ROLES.FACULTY]: [
    'faculty-dashboard',
    'attendance',
    'results',
    'timetable',
    'notices',
    'profile',
  ],
  [ROLES.STUDENT]: [
    'student-dashboard',
    'attendance',
    'results',
    'timetable',
    'hostel',
    'admissions',
    'placements',
    'fees',
    'notices',
    'profile',
  ],
};

// Returns true if the given role may access the given module.
// Admin is a superuser and always has access.
export function hasAccess(role, module) {
  if (role === ROLES.ADMIN) return true;
  return (ROLE_MODULES[role] || []).includes(module);
}

// CRUD-level permission check for management resources
// (students, faculty, hostel, fees, placements, notices, etc.)
// Only admin has full create/read/update/delete/activate/deactivate
// rights across the system. Faculty/Student get read-only access
// to their own records (enforced separately at the data-fetch layer).
export function canManage(role, _resource) {
  return role === ROLES.ADMIN;
}

// True if the role is allowed to view *all* records of a resource
// (e.g. all students, all faculty) rather than only their own.
export function canViewAll(role, _resource) {
  return role === ROLES.ADMIN;
}

// Convenience: is this user a superuser (unrestricted access)?
export function isSuperuser(role) {
  return role === ROLES.ADMIN;
}
