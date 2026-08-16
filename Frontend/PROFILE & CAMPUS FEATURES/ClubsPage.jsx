// ============================================
// ClubsPage
// ============================================

import { useState } from 'react';
import { Users, Search, Plus, Star, Shield } from 'lucide-react';
import styles from './ClubsPage.module.css';

const DEMO_CLUBS = [
  {
    id: 1, name: 'Tech Innovators Club', category: 'Technology', members_count: 142, is_official: 1,
    description: 'Building the future with code, hardware, and entrepreneurial thinking.',
    logo: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=400&h=200&fit=crop',
    president_name: 'Alex Johnson',
  },
  {
    id: 2, name: 'Pre-Med Society', category: 'Academic', members_count: 98, is_official: 1,
    description: 'Preparing future healthcare leaders through mentorship and research opportunities.',
    logo: 'https://images.unsplash.com/photo-1584820927498-cfe5211fd8bf?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=200&fit=crop',
    president_name: 'Maya Patel',
  },
  {
    id: 3, name: 'Entrepreneurship Hub', category: 'Business', members_count: 75, is_official: 1,
    description: 'Connect, pitch, and grow your startup ideas on campus.',
    logo: 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1556761175-4b46a572b786?w=400&h=200&fit=crop',
    president_name: 'Jordan Lee',
  },
  {
    id: 4, name: 'Creative Arts Collective', category: 'Arts', members_count: 63, is_official: 0,
    description: 'A space for artists, designers, photographers, and creatives of all kinds.',
    logo: 'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1547036967-23d11aacaee0?w=400&h=200&fit=crop',
    president_name: 'Priya Sharma',
  },
  {
    id: 5, name: 'Robotics & AI Club', category: 'Technology', members_count: 110, is_official: 1,
    description: 'Engineering the future with intelligent machines, drones, and autonomous systems.',
    logo: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=400&h=200&fit=crop',
    president_name: 'Carlos Rivera',
  },
  {
    id: 6, name: 'Campus Green Initiative', category: 'Environment', members_count: 89, is_official: 1,
    description: 'Making our campus and community more sustainable, one green project at a time.',
    logo: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?w=400&h=200&fit=crop',
    president_name: 'Sam Chen',
  },
  {
    id: 7, name: 'Photography Club', category: 'Arts', members_count: 54, is_official: 0,
    description: 'Capturing moments, stories, and the beauty of campus life through the lens.',
    logo: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1452587925148-ce544e77e70d?w=400&h=200&fit=crop',
    president_name: 'Aisha Okonkwo',
  },
  {
    id: 8, name: 'Data Science Society', category: 'Technology', members_count: 93, is_official: 1,
    description: 'Exploring data, machine learning, and analytics through real-world projects.',
    logo: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=80&h=80&fit=crop',
    cover_image: 'https://images.unsplash.com/photo-1504868584819-f8e8b4b6d7e3?w=400&h=200&fit=crop',
    president_name: 'Raj Krishnamurthy',
  },
];

const CATEGORIES = ['All', 'Technology', 'Academic', 'Business', 'Arts', 'Environment', 'Sports'];

const CAT_COLORS = {
  Technology:  { bg: '#eff6ff', color: '#2563eb' },
  Academic:    { bg: '#f0fdf4', color: '#16a34a' },
  Business:    { bg: '#fff7ed', color: '#c2410c' },
  Arts:        { bg: '#f5f3ff', color: '#7c3aed' },
  Environment: { bg: '#ecfdf5', color: '#059669' },
  Sports:      { bg: '#fefce8', color: '#a16207' },
};

function ClubCard({ club }) {
  const [joined, setJoined] = useState(false);
  const catStyle = CAT_COLORS[club.category] || { bg: '#f9fafb', color: '#6b7280' };

  return (
    <div className={`${styles.clubCard} card float-card`}>
      {/* Cover */}
      <div className={styles.coverWrap}>
        <img src={club.cover_image} alt={club.name} className={styles.coverImg} />
        <div className={styles.coverOverlay} />
        {club.is_official === 1 && (
          <div className={styles.officialBadge} title="Official Club">
            <Shield size={12} fill="currentColor" /> Official
          </div>
        )}
        {/* Logo */}
        <div className={styles.clubLogo}>
          <img src={club.logo} alt={club.name} />
        </div>
      </div>

      {/* Body */}
      <div className={styles.clubBody}>
        <div className={styles.clubHeader}>
          <div>
            <h3 className={styles.clubName}>{club.name}</h3>
            <span className={styles.catBadge} style={{ background: catStyle.bg, color: catStyle.color }}>
              {club.category}
            </span>
          </div>
        </div>

        <p className={styles.clubDesc}>{club.description}</p>

        <div className={styles.clubStats}>
          <span className={styles.stat}><Users size={13} /> {club.members_count} members</span>
          <span className={styles.stat}><Star size={13} /> Led by {club.president_name}</span>
        </div>

        <button
          className={`btn btn-sm ${joined ? 'btn-secondary' : 'btn-primary'}`}
          style={{ width: '100%', justifyContent: 'center' }}
          onClick={() => setJoined(j => !j)}
        >
          {joined ? '✓ Joined' : '+ Join Club'}
        </button>
      </div>
    </div>
  );
}

export default function ClubsPage() {
  const [category, setCategory] = useState('All');
  const [search, setSearch] = useState('');

  const filtered = DEMO_CLUBS
    .filter(c => category === 'All' || c.category === category)
    .filter(c => !search || c.name.toLowerCase().includes(search.toLowerCase()));

  return (
    <div className={styles.page}>
      {/* Header */}
      <div className={styles.pageHeader}>
        <div>
          <h1 className="section-title" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <Users size={26} color="var(--blue-600)" /> Clubs & Organizations
          </h1>
          <p style={{ color: 'var(--gray-500)', fontSize: 14, marginTop: 4 }}>
            Find your community — {DEMO_CLUBS.length} clubs and counting
          </p>
        </div>
        <button className="btn btn-primary"><Plus size={16} /> Start a Club</button>
      </div>

      {/* Stats banner */}
      <div className={`${styles.statsBanner} card`}>
        {[
          { val: '200+', label: 'Active Clubs' },
          { val: '8,400+', label: 'Club Members' },
          { val: '50+', label: 'Events/Month' },
          { val: '12', label: 'Categories' },
        ].map(s => (
          <div key={s.label} className={styles.bannerStat}>
            <span className={styles.bannerStatVal}>{s.val}</span>
            <span className={styles.bannerStatLabel}>{s.label}</span>
          </div>
        ))}
      </div>

      {/* Controls */}
      <div className={styles.controls}>
        <div className={styles.searchWrap}>
          <Search size={15} className={styles.searchIcon} />
          <input
            type="text"
            className="input"
            placeholder="Search clubs…"
            value={search}
            onChange={e => setSearch(e.target.value)}
            style={{ paddingLeft: 36 }}
          />
        </div>
        <div className={styles.catTabs}>
          {CATEGORIES.map(c => (
            <button
              key={c}
              className={`${styles.catTab} ${category === c ? styles.catTabActive : ''}`}
              onClick={() => setCategory(c)}
            >
              {c}
            </button>
          ))}
        </div>
      </div>

      {/* Grid */}
      <div className={styles.grid}>
        {filtered.map((club, i) => (
          <div key={club.id} className={`animate-fade-in-up delay-${Math.min(i+1, 5)}`}>
            <ClubCard club={club} />
          </div>
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <Users size={48} />
          <h3>No clubs found</h3>
          <p>Try a different search or be the first to start one!</p>
        </div>
      )}
    </div>
  );
}
