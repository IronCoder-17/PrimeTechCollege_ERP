// ============================================================
// College PrimeTech College — App Router
// Role-based routing: student → /dashboard
// ============================================================

import { useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider, useAuth } from './contexts/AuthContext';
import SplashLoader from './components/SplashLoader';
import './styles/globals.css';

// Pages
import LandingPage        from './pages/LandingPage';
import LoginPage          from './pages/LoginPage';
import AdminLoginPage     from './pages/AdminLoginPage';
import RegisterPage       from './pages/RegisterPage';
import AdmissionPage      from './pages/AdmissionPage';
import FacultyRegistrationPage from './pages/FacultyRegistrationPage';
import FeedPage           from './pages/FeedPage';
import EventsPage         from './pages/EventsPage';
import ClubsPage          from './pages/ClubsPage';
import ProfilePage        from './pages/ProfilePage';
import ChatPage           from './pages/ChatPage';
import StudyPage          from './pages/StudyPage';
import AdminDashboard     from './pages/AdminDashboard';
import FacultyDashboard   from './pages/FacultyDashboard';
import StudentDashboard   from './pages/StudentDashboard';
import TimetablePage      from './pages/TimetablePage';
import ResultsPage        from './pages/ResultsPage';
import NotificationsPage  from './pages/NotificationsPage';
import PlacementsPage     from './pages/PlacementsPage';
import ResourcesPage      from './pages/ResourcesPage';
import EditProfilePage    from './pages/EditProfilePage';
import FeeReceiptsPage    from './pages/FeeReceiptsPage';
import FeeStructurePage   from './pages/FeeStructurePage';
import RulesRegulationsPage from './pages/RulesRegulationsPage';

// Layout
import AppLayout from './components/layout/AppLayout';

function Spinner() {
  return (
    <div style={{ display:'flex', alignItems:'center', justifyContent:'center', height:'100vh' }}>
      <div className="spinner" style={{ width:36, height:36 }} />
    </div>
  );
}

function PrivateRoute({ children, role }) {
  const { user, loading } = useAuth();
  if (loading) return <Spinner />;
  if (!user) return <Navigate to="/login" replace />;
  // Admin is a superuser — unrestricted access to every route, regardless
  // of the route's required role.
  if (user.role === 'admin') return children;
  if (role && user.role !== role) {
    const dest = user.role === 'admin' ? '/admin' : user.role === 'faculty' ? '/faculty' : '/dashboard';
    return <Navigate to={dest} replace />;
  }
  return children;
}

function PublicRoute({ children }) {
  const { user, loading } = useAuth();
  if (loading) return null;
  if (user) {
    const dest = user.role === 'admin' ? '/admin' : user.role === 'faculty' ? '/faculty' : '/dashboard';
    return <Navigate to={dest} replace />;
  }
  return children;
}

// /admin is self-contained: it shows AdminLoginPage when there's no
// authenticated admin session, and AdminDashboard once there is — never
// redirecting to the shared public /login page. This keeps the Admin
// Panel's existence/branding off the general login screen entirely.
function AdminRoute() {
  const { user, loading } = useAuth();
  if (loading) return <Spinner />;
  if (user && user.role === 'admin') return <AdminDashboard />;
  return <AdminLoginPage />;
}

function AppRoutes() {
  return (
    <Routes>
      {/* Public */}
      <Route path="/"          element={<PublicRoute><LandingPage /></PublicRoute>} />
      <Route path="/fee-structure" element={<FeeStructurePage />} />
      <Route path="/rules-regulations" element={<RulesRegulationsPage />} />
      <Route path="/login"     element={<PublicRoute><LoginPage /></PublicRoute>} />

      {/* Student Admission ("Student Registration") — Admin Panel only.
          Public users are redirected to /login; direct URL access is blocked. */}
      <Route path="/admission" element={<PrivateRoute role="admin"><AdmissionPage /></PrivateRoute>} />
      {/* Faculty Registration — Admin Panel only. */}
      <Route path="/faculty-register" element={<PrivateRoute role="admin"><FacultyRegistrationPage /></PrivateRoute>} />
      {/* Legacy self-service account creation — also Admin Panel only now,
          since it creates student accounts directly. */}
      <Route path="/register"  element={<PrivateRoute role="admin"><RegisterPage /></PrivateRoute>} />

      {/* Admin — dedicated, self-contained login + dashboard, never
          redirects to the shared public /login page. */}
      <Route path="/admin" element={<AdminRoute />} />

      {/* Faculty */}
      <Route path="/faculty" element={<PrivateRoute role="faculty"><FacultyDashboard /></PrivateRoute>} />

      {/* Student pages — inside AppLayout */}
      <Route path="/*" element={<PrivateRoute role="student"><AppLayout /></PrivateRoute>}>
        <Route path="dashboard"      element={<StudentDashboard />} />
        <Route path="feed"           element={<FeedPage />} />
        <Route path="courses"        element={<CoursesRedirect />} />
        <Route path="assignments"    element={<AssignmentsRedirect />} />
        <Route path="timetable"      element={<TimetablePage />} />
        <Route path="results"        element={<ResultsPage />} />
        <Route path="fee-receipts"   element={<FeeReceiptsPage />} />
        <Route path="fee-structure"  element={<FeeStructurePage />} />
        <Route path="rules-regulations" element={<RulesRegulationsPage />} />
        <Route path="events"         element={<EventsPage />} />
        <Route path="clubs"          element={<ClubsPage />} />
        <Route path="study"          element={<StudyPage />} />
        <Route path="chat"           element={<ChatPage />} />
        <Route path="notifications"  element={<NotificationsPage />} />
        <Route path="placements"     element={<PlacementsPage />} />
        <Route path="resources"      element={<ResourcesPage />} />
        <Route path="profile/:id?"   element={<ProfilePage />} />
        <Route path="edit-profile"   element={<EditProfilePage />} />
        <Route path="settings"       element={<SettingsRedirect />} />
      </Route>

      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}

function CoursesRedirect()     { return <Navigate to="/dashboard" replace />; }
function AssignmentsRedirect() { return <Navigate to="/dashboard" replace />; }
function SettingsRedirect()    { return <Navigate to="/profile" replace />; }

export default function App() {
  const [showSplash, setShowSplash] = useState(true);

  return (
    <>
      {showSplash && <SplashLoader onFinished={() => setShowSplash(false)} />}
      <AuthProvider>
        <BrowserRouter>
          <AppRoutes />
        </BrowserRouter>
      </AuthProvider>
    </>
  );
}