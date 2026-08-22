// ============================================
// AppLayout — Full Student Sidebar + Topbar
// PrimeTech College Campus Connect
// ============================================

import { useState } from 'react';
import { Outlet, NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import {
  LayoutDashboard, Newspaper, BookOpen, FileText,
  Clock, BarChart2, Users, GraduationCap, MessageCircle,
  Bell, Briefcase, FolderOpen, UserCircle, Settings,
  Search, LogOut, Menu, X, ChevronRight, CreditCard, ShieldCheck
} from 'lucide-react';
import styles from './AppLayout.module.css';

const activeStyle = ({ isActive }) =>
  isActive ? `${styles.navItem} ${styles.navActive}` : styles.navItem;

export default function AppLayout() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [searchVal, setSearchVal] = useState('');
  const close = () => setSidebarOpen(false);

  const handleLogout = () => { logout(); navigate('/'); };

  return (
    <div className={styles.shell}>
      {/* ── Sidebar ── */}
      <aside className={`${styles.sidebar} ${sidebarOpen ? styles.open : ''}`}>

        {/* Logo */}
        <div className={styles.logo}>
          <div className={styles.logoIcon}>
            <GraduationCap size={18} color="white" />
          </div>
          <div className={styles.logoText}>
            <span className={styles.logoBrand}>PrimeTech</span>
            <span className={styles.logoCollege}>Campus Connect</span>
          </div>
          <button className={styles.sidebarClose} onClick={close}><X size={18} /></button>
        </div>

        {/* User card */}
        <NavLink to={`/profile/${user?.id}`} className={styles.userCard} onClick={close}>
          <img
            src={user?.avatar || (
              user?.photoDataUrl ? user.photoDataUrl :
              user?.gender === 'female'
                ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=ffdfba&topType=LongHairStraight&facialHairType=Blank&clotheType=BlazerShirt`
                : user?.gender === 'male'
                ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=b6e3f4&topType=ShortHairShortRound&facialHairType=Blank&clotheType=BlazerShirt`
                : `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=c0aede`
            )}
            alt={user?.name}
            className={`avatar avatar-sm ${styles.userAvatar}`}
          />
          <div className={styles.userInfo}>
            <span className={styles.userName}>{user?.name || 'Student'}</span>
            <span className={styles.userMeta}>{user?.major || 'Computer Science'} · {user?.year || '3rd Year'}</span>
          </div>
        </NavLink>

        {/* ── Nav — inline scroll container, no CSS tricks needed ── */}
        <nav style={{ flex: 1, overflowY: 'auto', overflowX: 'hidden', padding: '4px 6px', minHeight: 0 }}>

          {/* MAIN */}
          <p className={styles.navSectionLabel}>Main</p>
          <NavLink to="/dashboard"     className={activeStyle} onClick={close}><LayoutDashboard size={15} strokeWidth={1.8}/><span>Dashboard</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/feed"          className={activeStyle} onClick={close}><Newspaper        size={15} strokeWidth={1.8}/><span>Feed</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

          {/* ACADEMIC */}
          <p className={styles.navSectionLabel}>Academic</p>
          <NavLink to="/courses"       className={activeStyle} onClick={close}><BookOpen  size={15} strokeWidth={1.8}/><span>Courses</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/assignments"   className={activeStyle} onClick={close}><FileText  size={15} strokeWidth={1.8}/><span>Assignments</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/timetable"     className={activeStyle} onClick={close}><Clock     size={15} strokeWidth={1.8}/><span>Timetable</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/results"       className={activeStyle} onClick={close}><BarChart2 size={15} strokeWidth={1.8}/><span>Results</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

          {/* FEES & PAYMENTS */}
          <p className={styles.navSectionLabel}>Fees &amp; Payments</p>
          <NavLink to="/fee-receipts"  className={activeStyle} onClick={close}><CreditCard size={15} strokeWidth={1.8}/><span>Fee Receipts</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/fee-structure" className={activeStyle} onClick={close} title="Download the latest fee structure"><FileText size={15} strokeWidth={1.8}/><span>Fee Structure</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/rules-regulations" className={activeStyle} onClick={close}><ShieldCheck size={15} strokeWidth={1.8}/><span>R &amp; R</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

          {/* CAMPUS */}
          <p className={styles.navSectionLabel}>Campus</p>
          <NavLink to="/clubs"         className={activeStyle} onClick={close}><Users        size={15} strokeWidth={1.8}/><span>Clubs</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/study"         className={activeStyle} onClick={close}><GraduationCap size={15} strokeWidth={1.8}/><span>Study Groups</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/events"        className={activeStyle} onClick={close}><Bell         size={15} strokeWidth={1.8}/><span>Events</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

          {/* COMMUNICATION */}
          <p className={styles.navSectionLabel}>Communication</p>
          <NavLink to="/chat"          className={activeStyle} onClick={close}><MessageCircle size={15} strokeWidth={1.8}/><span>Messages</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/notifications" className={activeStyle} onClick={close}>
            <Bell size={15} strokeWidth={1.8}/><span>Notifications</span>
            <span className={styles.navBadge}>2</span>
          </NavLink>

          {/* CAREER & RESOURCES */}
          <p className={styles.navSectionLabel}>Career &amp; Resources</p>
          <NavLink to="/placements"    className={activeStyle} onClick={close}><Briefcase  size={15} strokeWidth={1.8}/><span>Placements</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/resources"     className={activeStyle} onClick={close}><FolderOpen size={15} strokeWidth={1.8}/><span>Resources</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

          {/* ACCOUNT */}
          <p className={styles.navSectionLabel}>Account</p>
          <NavLink to="/profile"       className={activeStyle} onClick={close}><UserCircle size={15} strokeWidth={1.8}/><span>Profile</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/edit-profile"  className={activeStyle} onClick={close}><Settings   size={15} strokeWidth={1.8}/><span>Edit Profile</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>
          <NavLink to="/settings"      className={activeStyle} onClick={close}><Settings   size={15} strokeWidth={1.8}/><span>Settings</span><ChevronRight size={12} className={styles.navArrow}/></NavLink>

        </nav>

        {/* Logout */}
        <div className={styles.sidebarBottom}>
          <button className={styles.logoutBtn} onClick={handleLogout}>
            <LogOut size={15} /><span>Sign Out</span>
          </button>
        </div>
      </aside>

      {sidebarOpen && <div className={styles.overlay} onClick={close} />}

      {/* ── Main ── */}
      <div className={styles.main}>
        <header className={styles.topbar}>
          <button className={styles.menuBtn} onClick={() => setSidebarOpen(true)}>
            <Menu size={20} />
          </button>
          <div className={styles.searchBar}>
            <Search size={15} className={styles.searchIcon} />
            <input
              type="text"
              placeholder="Search students, clubs, events…"
              value={searchVal}
              onChange={e => setSearchVal(e.target.value)}
              className={styles.searchInput}
            />
          </div>
          <div className={styles.topbarRight}>
            <a
              href="https://t.me/PrimeTechCollegeBot"
              target="_blank"
              rel="noopener noreferrer"
              className={styles.telegramIconBtn}
              title="Chat with us on Telegram"
              aria-label="Chat with us on Telegram"
            >
              <svg viewBox="0 0 240 240" width="18" height="18" aria-hidden="true" focusable="false">
                <circle cx="120" cy="120" r="120" fill="#229ED9" />
                <path
                  fill="#fff"
                  d="M170.6 72.6 149 178.1c-1.6 7.2-5.9 9-11.9 5.6l-33-24.3-15.9 15.3c-1.8 1.8-3.3 3.3-6.7 3.3l2.4-33.9 61.7-55.8c2.7-2.4-.6-3.7-4.2-1.3l-76.3 48-32.8-10.3c-7.1-2.2-7.3-7.1 1.5-10.6l128.2-49.4c6-2.2 11.2 1.4 9.3 10z"
                />
              </svg>
            </a>
            <NavLink to="/notifications" className={styles.iconBtn} title="Notifications">
              <Bell size={17} />
              <span className={styles.notifDot} />
            </NavLink>
            <NavLink to={`/profile/${user?.id}`} className={styles.topbarAvatar}>
              <img
                src={user?.avatar || (
                  user?.photoDataUrl ? user.photoDataUrl :
                  user?.gender === 'female'
                    ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=ffdfba&topType=LongHairStraight&facialHairType=Blank&clotheType=BlazerShirt`
                    : user?.gender === 'male'
                    ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=b6e3f4&topType=ShortHairShortRound&facialHairType=Blank&clotheType=BlazerShirt`
                    : `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=c0aede`
                )}
                alt={user?.name}
                className="avatar avatar-sm"
              />
            </NavLink>
          </div>
        </header>
        <main className={styles.content}>
          <Outlet />
        </main>
      </div>
    </div>
  );
}
