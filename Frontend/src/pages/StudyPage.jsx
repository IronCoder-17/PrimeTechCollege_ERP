// ============================================
// StudyPage — Study Groups
// ============================================

import { useState } from 'react';
import { BookOpen, MapPin, Clock, Plus, Search, Lock } from 'lucide-react';
import styles from './StudyPage.module.css';

const DEMO_GROUPS = [
  {
    id: 1, name: 'CS301 Algorithm Prep', course_code: 'CS301', subject: 'Data Structures & Algorithms',
    description: 'Weekly sessions covering sorting, graphs, dynamic programming. Past papers + LeetCode grind.',
    creator_id: 1, members_count: 6, max_members: 8,
    meeting_time: 'Tues & Thurs 7–9 PM', location: 'Library Room 3B', is_open: 1,
    members: [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=40&h=40&fit=crop',
    ],
  },
  {
    id: 2, name: 'Bio202 Midterm Crew', course_code: 'BIO202', subject: 'Molecular Biology',
    description: 'Focused on cell division, protein synthesis, and CRISPR for the upcoming midterm.',
    creator_id: 2, members_count: 5, max_members: 6,
    meeting_time: 'Mondays 6–8 PM', location: 'Science Building Lounge', is_open: 1,
    members: [
      'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=40&h=40&fit=crop',
    ],
  },
  {
    id: 3, name: 'Calc III Study Squad', course_code: 'MATH301', subject: 'Multivariable Calculus',
    description: 'Line integrals, surface integrals, Stokes theorem — we suffer together.',
    creator_id: 3, members_count: 4, max_members: 6,
    meeting_time: 'Weekends 2–4 PM', location: 'Math Building 105', is_open: 1,
    members: [
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=40&h=40&fit=crop',
    ],
  },
  {
    id: 4, name: 'Organic Chem Survivors', course_code: 'CHEM301', subject: 'Organic Chemistry',
    description: 'Reaction mechanisms, nomenclature, spectroscopy. Closed group — message to request.',
    creator_id: 2, members_count: 7, max_members: 7,
    meeting_time: 'Wed 5–7 PM', location: 'Chemistry Lab Lobby', is_open: 0,
    members: [
      'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=40&h=40&fit=crop',
    ],
  },
  {
    id: 5, name: 'Physics 201 Prep', course_code: 'PHYS201', subject: 'Classical Mechanics',
    description: 'Newtonian mechanics, energy, momentum, and rotational dynamics. Problem sets every week.',
    creator_id: 5, members_count: 3, max_members: 8,
    meeting_time: 'Fridays 4–6 PM', location: 'Physics Building 202', is_open: 1,
    members: [
      'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=40&h=40&fit=crop',
    ],
  },
  {
    id: 6, name: 'Economics Deep Dive', course_code: 'ECON401', subject: 'Macroeconomics',
    description: 'GDP, inflation, monetary policy, fiscal policy — understanding the real world through econ.',
    creator_id: 3, members_count: 5, max_members: 10,
    meeting_time: 'Tuesdays 5–7 PM', location: 'Business Building 310', is_open: 1,
    members: [
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=40&h=40&fit=crop',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=40&h=40&fit=crop',
    ],
  },
];

function StudyCard({ group }) {
  const [joined, setJoined] = useState(false);
  const pct = Math.round((group.members_count / group.max_members) * 100);
  const full = group.members_count >= group.max_members;

  return (
    <div className={`${styles.groupCard} card`}>
      <div className={styles.groupTop}>
        <div className={styles.courseCode}>{group.course_code}</div>
        {!group.is_open && <span className={styles.lockBadge}><Lock size={11} /> Closed</span>}
        {full && group.is_open && <span className={styles.fullBadge}>Full</span>}
      </div>

      <h3 className={styles.groupName}>{group.name}</h3>
      <p className={styles.groupSubject}>{group.subject}</p>
      <p className={styles.groupDesc}>{group.description}</p>

      <div className={styles.groupMeta}>
        <span className={styles.metaItem}><Clock size={13} />{group.meeting_time}</span>
        <span className={styles.metaItem}><MapPin size={13} />{group.location}</span>
      </div>

      {/* Members avatars */}
      <div className={styles.membersRow}>
        <div className={styles.memberAvatars}>
          {group.members.slice(0, 3).map((src, i) => (
            <img key={i} src={src} alt="Member" className={`avatar avatar-sm ${styles.memberAvatar}`} style={{ zIndex: 3 - i }} />
          ))}
          {group.members_count > 3 && (
            <div className={`${styles.memberAvatar} ${styles.memberExtra}`}>+{group.members_count - 3}</div>
          )}
        </div>
        <span className={styles.memberCount}>{group.members_count}/{group.max_members} members</span>
      </div>

      {/* Capacity bar */}
      <div className={styles.capacityBar}>
        <div className={styles.capacityFill} style={{ width: `${pct}%`, background: full ? '#ef4444' : 'var(--blue-500)' }} />
      </div>

      <button
        className={`btn btn-sm ${joined ? 'btn-secondary' : 'btn-primary'}`}
        style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}
        disabled={!group.is_open || (full && !joined)}
        onClick={() => setJoined(j => !j)}
      >
        {joined ? '✓ Joined' : !group.is_open ? '🔒 Request to Join' : full ? 'Group Full' : '+ Join Group'}
      </button>
    </div>
  );
}

export default function StudyPage() {
  const [search, setSearch] = useState('');

  const filtered = DEMO_GROUPS.filter(g =>
    (!search || g.name.toLowerCase().includes(search.toLowerCase()) || g.course_code.toLowerCase().includes(search.toLowerCase()))
  );

  return (
    <div className={styles.page}>
      {/* Header */}
      <div className={styles.pageHeader}>
        <div>
          <h1 className="section-title" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <BookOpen size={26} color="var(--blue-600)" /> Study Groups
          </h1>
          <p style={{ color: 'var(--gray-500)', fontSize: 14, marginTop: 4 }}>
            Find your study crew for any course
          </p>
        </div>
      </div>

      {/* Tips Card */}
      <div className={`${styles.tipsCard} card`}>
        <div className={styles.tipsContent}>
          <span className={styles.tipsEmoji}>💡</span>
          <div>
            <strong>Pro tip:</strong> Students in study groups score 23% higher on exams on average. Find your crew!
          </div>
        </div>
      </div>

      {/* Controls */}
      <div className={styles.controls}>
        <div className={styles.searchWrap}>
          <Search size={15} className={styles.searchIcon} />
          <input
            type="text"
            className="input"
            placeholder="Search by course or subject…"
            value={search}
            onChange={e => setSearch(e.target.value)}
            style={{ paddingLeft: 36 }}
          />
        </div>
      </div>

      {/* Grid */}
      <div className={styles.grid}>
        {filtered.map((group, i) => (
          <div key={group.id} className={`animate-fade-in-up delay-${Math.min(i+1,5)}`}>
            <StudyCard group={group} />
          </div>
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <BookOpen size={48} />
          <h3>No groups found</h3>
          <p>Be the first to create a study group for this course!</p>
          <button className="btn btn-primary">
            <Plus size={16} /> Create Group
          </button>
        </div>
      )}
    </div>
  );
}
