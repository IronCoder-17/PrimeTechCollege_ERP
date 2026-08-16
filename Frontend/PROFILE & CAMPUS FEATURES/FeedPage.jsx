// ============================================
// FeedPage — Campus Feed with Posts
// ============================================

import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { postsApi } from '../utils/api';
import PostCard from '../components/feed/PostCard';
import CreatePost from '../components/feed/CreatePost';
import TrendingWidget from '../components/widgets/TrendingWidget';
import SuggestedPeople from '../components/widgets/SuggestedPeople';
import styles from './FeedPage.module.css';

// Demo posts (used when API is not connected)
const DEMO_POSTS = [
  {
    id: 1,
    author_name: 'Alex Johnson',
    author_avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80&h=80&fit=crop&crop=face',
    author_major: 'Computer Science',
    author_year: 'Junior',
    content: '🚀 Just got accepted into the Google Summer of Code program! Hard work really pays off. Huge thanks to the Tech Innovators Club for all the support and mock interviews. If anyone needs help applying next year, hit me up! #GSoC #OpenSource #CampusLife',
    image: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=600&h=300&fit=crop',
    likes_count: 87,
    comments_count: 23,
    post_type: 'general',
    created_at: new Date(Date.now() - 120000).toISOString(),
  },
  {
    id: 2,
    author_name: 'Maya Patel',
    author_avatar: 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=80&h=80&fit=crop&crop=face',
    author_major: 'Biology',
    author_year: 'Sophomore',
    content: '📚 Study tip that changed my life: the Pomodoro Technique + background lo-fi music = unstoppable. 25 min focus, 5 min break. Try it for finals week. Also forming a Bio study group for the midterm next Friday — DM me if interested! Who\'s in? 🙋‍♀️',
    likes_count: 64,
    comments_count: 18,
    post_type: 'study',
    created_at: new Date(Date.now() - 900000).toISOString(),
  },
  {
    id: 3,
    author_name: 'Jordan Lee',
    author_avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=80&h=80&fit=crop&crop=face',
    author_major: 'Business Administration',
    author_year: 'Senior',
    content: '🎉 BIG NEWS: Our campus startup "EcoRide" just closed its first seed round! We\'re building sustainable campus transportation and we\'re LIVE. Check us out and support student entrepreneurs! This wouldn\'t have been possible without the Entrepreneurship Hub community. 🌱',
    image: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&h=300&fit=crop',
    likes_count: 112,
    comments_count: 45,
    post_type: 'announcement',
    created_at: new Date(Date.now() - 3600000).toISOString(),
  },
  {
    id: 4,
    author_name: 'Priya Sharma',
    author_avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=80&h=80&fit=crop&crop=face',
    author_major: 'Graphic Design',
    author_year: 'Junior',
    content: '🎨 Just finished my senior thesis project — a digital mural celebrating campus diversity. 3 weeks, 200+ reference photos, countless iterations. Presenting Friday in the Art Gallery if you want to come and see it in person! All are welcome 💙',
    image: 'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=600&h=300&fit=crop',
    likes_count: 93,
    comments_count: 31,
    post_type: 'general',
    created_at: new Date(Date.now() - 7200000).toISOString(),
  },
  {
    id: 5,
    author_name: 'Carlos Rivera',
    author_avatar: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=80&h=80&fit=crop&crop=face',
    author_major: 'Mechanical Engineering',
    author_year: 'Senior',
    content: '🤖 Our robotics team just won FIRST place at the Regional Autonomous Vehicle Competition! Absolutely incredible. 6 months of late nights in the lab paid off big time. Thank you to everyone who supported us. Next stop: nationals! 🏆 #Robotics #Engineering',
    likes_count: 156,
    comments_count: 52,
    post_type: 'announcement',
    created_at: new Date(Date.now() - 86400000).toISOString(),
  },
];

const FILTER_TABS = [
  { key: null, label: 'All' },
  { key: 'general', label: 'General' },
  { key: 'announcement', label: 'Announcements' },
  { key: 'study', label: 'Study' },
  { key: 'event', label: 'Events' },
];

export default function FeedPage() {
  const { user } = useAuth();
  const [posts, setPosts] = useState(DEMO_POSTS);
  const [loading, setLoading] = useState(false);
  const [filter, setFilter] = useState(null);

  const loadPosts = useCallback(async () => {
    setLoading(true);
    try {
      const res = await postsApi.getFeed(1, filter);
      if (res.data.posts?.length) setPosts(res.data.posts);
    } catch {
      // Use demo posts
    } finally {
      setLoading(false);
    }
  }, [filter]);

  useEffect(() => {
    loadPosts();
  }, [loadPosts]);

  const handleNewPost = (post) => {
    setPosts(prev => [
      {
        ...post,
        author_name: user.name,
        author_avatar: user.avatar,
        author_major: user.major,
        author_year: user.year,
        likes_count: 0,
        comments_count: 0,
        created_at: new Date().toISOString(),
      },
      ...prev
    ]);
  };

  return (
    <div className={styles.layout}>
      {/* ── Feed Column ── */}
      <div className={styles.feedCol}>
        {/* Create Post */}
        <CreatePost onPost={handleNewPost} />

        {/* Filter Tabs */}
        <div className={styles.filterTabs}>
          {FILTER_TABS.map(tab => (
            <button
              key={String(tab.key)}
              className={`${styles.filterTab} ${filter === tab.key ? styles.filterTabActive : ''}`}
              onClick={() => setFilter(tab.key)}
            >
              {tab.label}
            </button>
          ))}
        </div>

        {/* Posts */}
        {loading ? (
          <div className={styles.loadingCenter}>
            <div className="spinner" style={{ width: 32, height: 32 }} />
          </div>
        ) : (
          <div className={styles.posts}>
            {posts.map((post, i) => (
              <div key={post.id} className={`animate-fade-in-up delay-${Math.min(i+1, 5)}`}>
                <PostCard post={post} onUpdate={loadPosts} />
              </div>
            ))}
          </div>
        )}
      </div>

      {/* ── Sidebar Widgets ── */}
      <aside className={styles.sidebarWidgets}>
        <TrendingWidget />
        <SuggestedPeople />
      </aside>
    </div>
  );
}
