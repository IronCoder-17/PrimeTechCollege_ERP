// ============================================
// EventsPage
// ============================================

import { useState, useEffect, useCallback } from 'react';
import { CalendarDays, MapPin, Users, Clock, Plus, Search } from 'lucide-react';
import { eventsApi } from '../utils/api';
import styles from './EventsPage.module.css';
import { format, parseISO } from 'date-fns';

const DEMO_EVENTS = [
  {
    id: 1,
    title: 'Spring Tech Hackathon 2025',
    description: '48-hour hackathon to solve real campus problems. Form teams, build fast, win prizes worth $5,000+!',
    location: 'Engineering Hall, Room 201',
    start_datetime: '2025-04-12T09:00:00',
    event_type: 'academic',
    attendees_count: 180,
    is_free: 1,
    organizer_name: 'Tech Innovators Club',
    organizer_avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=40&h=40&fit=crop',
    image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=600&h=300&fit=crop',
  },
  {
    id: 2,
    title: 'Campus Career Fair 2025',
    description: 'Meet 50+ employers from tech, finance, healthcare & more. Bring your resume and dress to impress!',
    location: 'Student Union Ballroom',
    start_datetime: '2025-04-20T10:00:00',
    event_type: 'career',
    attendees_count: 450,
    is_free: 1,
    organizer_name: 'Career Services',
    organizer_avatar: null,
    image: 'https://images.unsplash.com/photo-1515187029135-18ee286d815b?w=600&h=300&fit=crop',
  },
  {
    id: 3,
    title: 'Spring Music Festival',
    description: 'Live performances by student bands and artists. Food trucks, vendors, and great vibes all evening!',
    location: 'Campus Amphitheater',
    start_datetime: '2025-04-18T17:00:00',
    event_type: 'arts',
    attendees_count: 600,
    is_free: 1,
    organizer_name: 'Creative Arts Collective',
    organizer_avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=40&h=40&fit=crop',
    image: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=600&h=300&fit=crop',
  },
  {
    id: 4,
    title: 'Mental Wellness Week Kickoff',
    description: 'Opening ceremony for campus mental health awareness week featuring workshops, meditation, and talks.',
    location: 'Campus Quad',
    start_datetime: '2025-04-15T14:00:00',
    event_type: 'social',
    attendees_count: 200,
    is_free: 1,
    organizer_name: 'Student Health Center',
    organizer_avatar: null,
    image: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=600&h=300&fit=crop',
  },
  {
    id: 5,
    title: 'Robotics Demo Day',
    description: 'Watch teams showcase their semester-long robotics projects live. See autonomous vehicles, drones & more!',
    location: 'Engineering Lab B',
    start_datetime: '2025-04-22T13:00:00',
    event_type: 'academic',
    attendees_count: 120,
    is_free: 1,
    organizer_name: 'Robotics & AI Club',
    organizer_avatar: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=40&h=40&fit=crop',
    image: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=600&h=300&fit=crop',
  },
  {
    id: 6,
    title: 'Startup Pitch Night',
    description: 'Student entrepreneurs pitch their startup ideas to a panel of real investors and mentors.',
    location: 'Business School Auditorium',
    start_datetime: '2025-04-25T18:00:00',
    event_type: 'career',
    attendees_count: 150,
    is_free: 1,
    organizer_name: 'Entrepreneurship Hub',
    organizer_avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=40&h=40&fit=crop',
    image: 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?w=600&h=300&fit=crop',
  },
];

const TYPE_COLORS = {
  academic: { bg: '#eff6ff', color: '#2563eb', label: 'Academic' },
  career:   { bg: '#f0fdf4', color: '#16a34a', label: 'Career' },
  social:   { bg: '#fff7ed', color: '#c2410c', label: 'Social' },
  arts:     { bg: '#f5f3ff', color: '#7c3aed', label: 'Arts' },
  sports:   { bg: '#fefce8', color: '#a16207', label: 'Sports' },
  other:    { bg: '#f9fafb', color: '#6b7280', label: 'Other' },
};

const FILTERS = ['All', 'academic', 'career', 'social', 'arts', 'sports'];

function EventCard({ event }) {
  const [rsvp, setRsvp] = useState(false);
  const typeStyle = TYPE_COLORS[event.event_type] || TYPE_COLORS.other;

  const dateStr = (() => {
    try { return format(parseISO(event.start_datetime), 'EEE, MMM d · h:mm a'); }
    catch { return event.start_datetime; }
  })();

  const handleRsvp = async () => {
    setRsvp(r => !r);
    try { await eventsApi.rsvp(event.id, rsvp ? 'not_going' : 'going'); } catch (err) { console.error(err); }
  };

  return (
    <div className={`${styles.eventCard} card float-card`}>
      {event.image && (
        <div className={styles.eventImageWrap}>
          <img src={event.image} alt={event.title} className={styles.eventImage} />
          <div className={styles.eventImageOverlay} />
          <span className={styles.eventTypeBadge} style={{ background: typeStyle.bg, color: typeStyle.color }}>
            {typeStyle.label}
          </span>
          {event.is_free && <span className={styles.freeBadge}>Free</span>}
        </div>
      )}
      <div className={styles.eventBody}>
        <h3 className={styles.eventTitle}>{event.title}</h3>
        <p className={styles.eventDesc}>{event.description}</p>

        <div className={styles.eventMeta}>
          <span className={styles.metaItem}><Clock size={13} />{dateStr}</span>
          <span className={styles.metaItem}><MapPin size={13} />{event.location}</span>
          <span className={styles.metaItem}><Users size={13} />{event.attendees_count} going</span>
        </div>

        <div className={styles.eventFooter}>
          <div className={styles.organizerInfo}>
            <img
              src={event.organizer_avatar || `https://api.dicebear.com/7.x/identicon/svg?seed=${event.organizer_name}`}
              alt={event.organizer_name}
              className="avatar avatar-sm"
            />
            <span className={styles.organizerName}>{event.organizer_name}</span>
          </div>
          <button
            className={`btn btn-sm ${rsvp ? 'btn-secondary' : 'btn-primary'}`}
            onClick={handleRsvp}
          >
            {rsvp ? '✓ Going' : 'RSVP'}
          </button>
        </div>
      </div>
    </div>
  );
}

export default function EventsPage() {
  const [events, setEvents] = useState(DEMO_EVENTS);
  const [filter, setFilter] = useState('All');
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(false);

  const loadEvents = useCallback(async () => {
    setLoading(true);
    try {
      const params = filter !== 'All' ? { type: filter } : {};
      const res = await eventsApi.getAll(params);
      if (res.data.events?.length) setEvents(res.data.events);
    } catch (err) { console.error(err); }
    setLoading(false);
  }, [filter]);

  useEffect(() => {
    loadEvents();
  }, [loadEvents]);

  const filtered = events.filter(e =>
    filter === 'All' || e.event_type === filter
  ).filter(e =>
    !search || e.title.toLowerCase().includes(search.toLowerCase()) || e.description?.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className={styles.page}>
      {/* Header */}
      <div className={styles.pageHeader}>
        <div>
          <h1 className={`${styles.pageTitle} section-title`}>
            <CalendarDays size={26} color="var(--blue-600)" /> Campus Events
          </h1>
          <p className={styles.pageSubtitle}>Discover what&apos;s happening on campus</p>
        </div>
        <button className="btn btn-primary">
          <Plus size={16} /> Create Event
        </button>
      </div>

      {/* Search + Filter Bar */}
      <div className={styles.controlsBar}>
        <div className={styles.searchWrap}>
          <Search size={15} className={styles.searchIcon} />
          <input
            type="text"
            className={`input ${styles.searchInput}`}
            placeholder="Search events…"
            value={search}
            onChange={e => setSearch(e.target.value)}
          />
        </div>
        <div className={styles.filterTabs}>
          {FILTERS.map(f => (
            <button
              key={f}
              className={`${styles.filterTab} ${filter === f ? styles.filterTabActive : ''}`}
              onClick={() => setFilter(f)}
            >
              {f === 'All' ? 'All Events' : TYPE_COLORS[f]?.label || f}
            </button>
          ))}
        </div>
      </div>

      {/* Hero featured event */}
      {filtered[0] && (
        <div className={`${styles.featuredEvent} card animate-fade-in`}>
          <div className={styles.featuredLeft}>
            <span className="badge badge-blue">⭐ Featured Event</span>
            <h2 className={styles.featuredTitle}>{filtered[0].title}</h2>
            <p className={styles.featuredDesc}>{filtered[0].description}</p>
            <div className={styles.eventMeta}>
              <span className={styles.metaItem}><Clock size={13} />
                {(() => { try { return format(parseISO(filtered[0].start_datetime), 'EEE, MMM d · h:mm a'); } catch { return ''; } })()}
              </span>
              <span className={styles.metaItem}><MapPin size={13} />{filtered[0].location}</span>
              <span className={styles.metaItem}><Users size={13} />{filtered[0].attendees_count} going</span>
            </div>
            <button className="btn btn-primary">RSVP Now</button>
          </div>
          {filtered[0].image && (
            <div className={styles.featuredRight}>
              <img src={filtered[0].image} alt={filtered[0].title} />
            </div>
          )}
        </div>
      )}

      {/* Events Grid */}
      {loading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 40 }}>
          <div className="spinner" style={{ width: 32, height: 32 }} />
        </div>
      ) : (
        <div className={styles.eventsGrid}>
          {filtered.slice(1).map((event, i) => (
            <div key={event.id} className={`animate-fade-in-up delay-${Math.min(i+1, 5)}`}>
              <EventCard event={event} />
            </div>
          ))}
        </div>
      )}

      {filtered.length === 0 && !loading && (
        <div className="empty-state">
          <CalendarDays size={48} />
          <h3>No events found</h3>
          <p>Try a different filter or search term</p>
        </div>
      )}
    </div>
  );
}
