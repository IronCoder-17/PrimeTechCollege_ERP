// ============================================
// ProfilePage
// ============================================

import { useState, useEffect, useCallback } from 'react';
import { useParams } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { usersApi } from '../utils/api';
import { MapPin, BookOpen, GraduationCap, Users, Heart, MessageCircle, Edit3, UserPlus, UserCheck } from 'lucide-react';
import PostCard from '../components/feed/PostCard';
import styles from './ProfilePage.module.css';


const TABS = ['Posts', 'About', 'Clubs', 'Events'];

export default function ProfilePage() {
  const { user: authUser } = useAuth();
  const { id } = useParams();
  const [profileUser, setProfileUser] = useState(null);
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState('Posts');
  const [following, setFollowing] = useState(false);

  const userId = id || authUser?.id;
  const isOwnProfile = !id || String(userId) === String(authUser?.id);

  // Build a fallback from the authenticated user so we never show "Alex Johnson"
  const authUserFallback = authUser ? {
    id:          authUser.id,
    name:        authUser.name        || 'Student',
    email:       authUser.email       || '',
    avatar:      authUser.avatar      || authUser.photoDataUrl || `https://api.dicebear.com/7.x/avataaars/svg?seed=${authUser.name}&backgroundColor=c0aede`,
    cover_photo: 'https://images.unsplash.com/photo-1562774053-701939374585?w=900&h=300&fit=crop',
    bio:         authUser.bio         || authUser.enrollmentNumber || '',
    major:       authUser.major       || authUser.course || '',
    year:        authUser.year        || (authUser.semester ? `Semester ${authUser.semester}` : ''),
    campus:      authUser.campus      || 'Main Campus',
    followers:   authUser.followers   ?? 0,
    following:   authUser.following   ?? 0,
    is_verified: 1,
  } : null;

  const loadProfile = useCallback(async () => {
    setLoading(true);
    try {
      const res = await usersApi.getProfile(userId);
      setProfileUser(res.data);
      const postsRes = await usersApi.getUserPosts(userId);
      if (postsRes.data.posts?.length) setPosts(postsRes.data.posts);
    } catch {
      // Fall back to the authenticated user's own data (not a hardcoded demo user)
      setProfileUser(authUserFallback);
    }
    setLoading(false);
  }, [userId]);

  useEffect(() => {
    loadProfile();
  }, [loadProfile]);

  const handleFollow = async () => {
    setFollowing(f => !f);
    try { await usersApi.follow(userId); } catch (err) { console.error(err); }
  };

  if (loading) return (
    <div style={{ display: 'flex', justifyContent: 'center', padding: 60 }}>
      <div className="spinner" style={{ width: 36, height: 36 }} />
    </div>
  );

  const user = profileUser || authUserFallback;

  if (!user) return (
    <div style={{ display: 'flex', justifyContent: 'center', padding: 60 }}>
      <p>Unable to load profile. Please log in again.</p>
    </div>
  );

  return (
    <div className={styles.page}>
      {/* Cover Photo */}
      <div className={styles.cover}>
        <img
          src={user.cover_photo || 'https://images.unsplash.com/photo-1562774053-701939374585?w=900&h=300&fit=crop'}
          alt="Cover"
          className={styles.coverImg}
        />
        <div className={styles.coverOverlay} />
      </div>

      {/* Profile Header */}
      <div className={`${styles.profileHeader} card`}>
        <div className={styles.avatarSection}>
          <div className={styles.avatarWrap}>
            <img
              src={user.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user.name}`}
              alt={user.name}
              className={styles.profileAvatar}
            />
            {user.is_verified === 1 && (
              <div className={styles.verifiedBadge} title="Verified Student">✓</div>
            )}
          </div>

          <div className={styles.profileInfo}>
            <div className={styles.nameRow}>
              <h1 className={styles.profileName}>{user.name}</h1>
              {user.is_verified === 1 && (
                <span className="badge badge-blue" style={{ fontSize: 11 }}>✓ Verified</span>
              )}
            </div>

            <div className={styles.profileMeta}>
              {user.major && <span><BookOpen size={13} /> {user.major}</span>}
              {user.year && <span><GraduationCap size={13} /> {user.year}</span>}
              {user.campus && <span><MapPin size={13} /> {user.campus}</span>}
            </div>

            {user.bio && <p className={styles.profileBio}>{user.bio}</p>}
          </div>
        </div>

        {/* Stats & Actions */}
        <div className={styles.profileRight}>
          <div className={styles.statsRow}>
            <div className={styles.stat}>
              <span className={styles.statVal}>{posts.length}</span>
              <span className={styles.statLabel}>Posts</span>
            </div>
            <div className={styles.stat}>
              <span className={styles.statVal}>{user.followers ?? 0}</span>
              <span className={styles.statLabel}>Followers</span>
            </div>
            <div className={styles.stat}>
              <span className={styles.statVal}>{user.following ?? 0}</span>
              <span className={styles.statLabel}>Following</span>
            </div>
          </div>

          <div className={styles.actionRow}>
            {isOwnProfile ? (
              <button className="btn btn-secondary" onClick={() => {}}>
                <Edit3 size={15} /> Edit Profile
              </button>
            ) : (
              <>
                <button
                  className={`btn ${following ? 'btn-secondary' : 'btn-primary'}`}
                  onClick={handleFollow}
                >
                  {following ? <><UserCheck size={15} /> Following</> : <><UserPlus size={15} /> Follow</>}
                </button>
                <button className="btn btn-secondary">
                  <MessageCircle size={15} /> Message
                </button>
              </>
            )}
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className={styles.tabs}>
        {TABS.map(tab => (
          <button
            key={tab}
            className={`${styles.tab} ${activeTab === tab ? styles.tabActive : ''}`}
            onClick={() => setActiveTab(tab)}
          >
            {tab}
            {tab === 'Posts' && <span className={styles.tabCount}>{posts.length}</span>}
          </button>
        ))}
      </div>

      {/* Content */}
      <div className={styles.content}>
        {activeTab === 'Posts' && (
          <div className={styles.postsGrid}>
            {posts.map(post => (
              <PostCard key={post.id} post={post} />
            ))}
            {posts.length === 0 && (
              <div className="empty-state">
                <Heart size={40} />
                <h3>No posts yet</h3>
                <p>When {isOwnProfile ? 'you post' : `${user.name} posts`}, it&apos;ll show here</p>
              </div>
            )}
          </div>
        )}

        {activeTab === 'About' && (
          <div className={`${styles.aboutCard} card`}>
            <h3 className={styles.aboutTitle}>About {user.name}</h3>
            <div className={styles.aboutItems}>
              {user.bio && (
                <div className={styles.aboutItem}>
                  <BookOpen size={16} className={styles.aboutIcon} />
                  <span className={styles.aboutValue}>{user.bio}</span>
                </div>
              )}
              {user.major && (
                <div className={styles.aboutItem}>
                  <BookOpen size={16} className={styles.aboutIcon} />
                  <span className={styles.aboutValue}>Studying <strong>{user.major}</strong></span>
                </div>
              )}
              {user.year && (
                <div className={styles.aboutItem}>
                  <GraduationCap size={16} className={styles.aboutIcon} />
                  <span className={styles.aboutValue}><strong>{user.year}</strong> year student</span>
                </div>
              )}
              {user.campus && (
                <div className={styles.aboutItem}>
                  <MapPin size={16} className={styles.aboutIcon} />
                  <span className={styles.aboutValue}>{user.campus}</span>
                </div>
              )}
              {/* Faculty professional info */}
              {authUser?.role === 'faculty' && isOwnProfile && (
                <>
                  {authUser.designation && (
                    <div className={styles.aboutItem}>
                      <Users size={16} className={styles.aboutIcon} />
                      <span className={styles.aboutValue}><strong>{authUser.designation}</strong> · {authUser.department}</span>
                    </div>
                  )}
                  {authUser.employeeId && (
                    <div className={styles.aboutItem}>
                      <GraduationCap size={16} className={styles.aboutIcon} />
                      <span className={styles.aboutValue}>Employee ID: <strong>{authUser.employeeId}</strong></span>
                    </div>
                  )}
                  {authUser.qualification && (
                    <div className={styles.aboutItem}>
                      <BookOpen size={16} className={styles.aboutIcon} />
                      <span className={styles.aboutValue}>{authUser.qualification}{authUser.specialization ? ` · ${authUser.specialization}` : ''}</span>
                    </div>
                  )}
                  {authUser.experience && (
                    <div className={styles.aboutItem}>
                      <Users size={16} className={styles.aboutIcon} />
                      <span className={styles.aboutValue}>{authUser.experience} years teaching experience</span>
                    </div>
                  )}
                </>
              )}
              {/* Student hostel info */}
              {authUser?.role === 'student' && isOwnProfile && authUser?.hostelRequired && (
                <div style={{ marginTop: 16, padding: '14px 16px', background: '#eff6ff', borderRadius: 12, border: '1px solid #bfdbfe' }}>
                  <div style={{ fontSize: 13, fontWeight: 700, color: '#1e40af', marginBottom: 10 }}>🏠 Hostel Information</div>
                  {[
                    ['Hostel Type', authUser.hostelType],
                    ['Room Type', authUser.roomType],
                    ['Room Number', authUser.hostelRoomNumber || 'Pending Allocation'],
                    ['Allocation Status', authUser.hostelAllocationStatus || 'Pending'],
                    ['Hostel Status', authUser.hostelStatus || 'Active'],
                    ['Payment Status', authUser.hostelPaymentStatus || 'Paid'],
                  ].map(([label, value]) => (
                    <div key={label} style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, padding: '5px 0', borderBottom: '1px solid #dbeafe' }}>
                      <span style={{ color: '#6b7280' }}>{label}</span>
                      <strong style={{ color: '#1e40af' }}>{value || '—'}</strong>
                    </div>
                  ))}
                </div>
              )}
              {/* Student transportation info */}
              {authUser?.role === 'student' && isOwnProfile && authUser?.transportRequired && (
                <div style={{ marginTop: 16, padding: '14px 16px', background: '#f0fdf4', borderRadius: 12, border: '1px solid #bbf7d0' }}>
                  <div style={{ fontSize: 13, fontWeight: 700, color: '#15803d', marginBottom: 10 }}>🚌 Transportation Information</div>
                  {[
                    ['Transportation Required', 'Yes'],
                    ['Location', authUser.transportLocation],
                    ['Bus Number', authUser.busNumber],
                    ['Transportation Fee', authUser.transportFee ? `₹${Number(authUser.transportFee).toLocaleString('en-IN')}` : '—'],
                    ['Payment Status', authUser.transportPaymentStatus || 'Paid'],
                  ].map(([label, value]) => (
                    <div key={label} style={{ display: 'flex', justifyContent: 'space-between', fontSize: 13, padding: '5px 0', borderBottom: '1px solid #dcfce7' }}>
                      <span style={{ color: '#6b7280' }}>{label}</span>
                      <strong style={{ color: '#15803d' }}>{value || '—'}</strong>
                    </div>
                  ))}
                </div>
              )}
              {authUser?.role === 'student' && isOwnProfile && !authUser?.transportRequired && authUser?.grNumber && (
                <div style={{ marginTop: 16, padding: '12px 16px', background: '#f9fafb', borderRadius: 12, border: '1px solid #e5e7eb', fontSize: 13, color: '#6b7280' }}>
                  🚌 Transportation Required: <strong style={{ color: '#374151' }}>No</strong>
                </div>
              )}
            </div>
          </div>
        )}

        {activeTab === 'Clubs' && (
          <div className={styles.clubsList}>
            {['Tech Innovators Club', 'Robotics & AI Club', 'Campus Green Initiative'].map(club => (
              <div key={club} className={`${styles.clubItem} card`}>
                <Users size={16} color="var(--blue-600)" />
                <span>{club}</span>
              </div>
            ))}
          </div>
        )}

        {activeTab === 'Events' && (
          <div className="empty-state">
            <span style={{ fontSize: 40 }}>📅</span>
            <h3>No upcoming events</h3>
            <p>Events that {isOwnProfile ? 'you RSVP' : `${user.name} RSVPs`} to will appear here</p>
          </div>
        )}
      </div>
    </div>
  );
}
