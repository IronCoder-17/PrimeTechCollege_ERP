// ============================================
// PostCard Component
// ============================================

import { useState } from 'react';
import { Heart, MessageCircle, Share2, MoreHorizontal, Bookmark } from 'lucide-react';
import { formatDistanceToNow } from 'date-fns';
import { postsApi } from '../../utils/api';
import { useAuth } from '../../contexts/AuthContext';
import styles from './PostCard.module.css';

const TYPE_BADGE = {
  announcement: { label: 'Announcement', cls: 'badge-rose' },
  study:        { label: 'Study',         cls: 'badge-blue' },
  event:        { label: 'Event',         cls: 'badge-purple' },
  lost_found:   { label: 'Lost & Found',  cls: 'badge-amber' },
};

export default function PostCard({ post }) {
  const { user } = useAuth();
  const [liked, setLiked] = useState(false);
  const [likes, setLikes] = useState(post.likes_count || 0);
  const [saved, setSaved] = useState(false);
  const [showComments, setShowComments] = useState(false);
  const [comment, setComment] = useState('');
  const [comments, setComments] = useState([]);
  const [commentsLoaded, setCommentsLoaded] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  const timeAgo = post.created_at
    ? formatDistanceToNow(new Date(post.created_at), { addSuffix: true })
    : 'just now';

  const typeBadge = TYPE_BADGE[post.post_type];

  const handleLike = async () => {
    setLiked(l => !l);
    setLikes(n => liked ? n - 1 : n + 1);
    try { await postsApi.like(post.id); } catch (err) { console.error(err); }
  };

  const handleCommentToggle = async () => {
    setShowComments(s => !s);
    if (!commentsLoaded) {
      try {
        const res = await postsApi.getComments(post.id);
        setComments(res.data.comments || []);
        setCommentsLoaded(true);
      } catch {
        setCommentsLoaded(true);
      }
    }
  };

  const handleComment = async (e) => {
    e.preventDefault();
    if (!comment.trim()) return;
    setSubmitting(true);
    try {
      await postsApi.comment(post.id, comment);
      setComments(c => [...c, {
        id: Date.now(),
        content: comment,
        author_name: user?.name,
        author_avatar: user?.avatar,
        created_at: new Date().toISOString(),
      }]);
      setComment('');
    } catch (err) { console.error(err); }
    setSubmitting(false);
  };

  return (
    <article className={`${styles.card} card animate-fade-in`}>
      {/* Header */}
      <div className={styles.header}>
        <img
          src={post.author_avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${post.author_name}`}
          alt={post.author_name}
          className={`avatar avatar-md ${styles.avatar}`}
        />
        <div className={styles.authorInfo}>
          <div className={styles.authorTop}>
            <span className={styles.authorName}>{post.author_name}</span>
            {typeBadge && (
              <span className={`badge ${typeBadge.cls}`}>{typeBadge.label}</span>
            )}
          </div>
          <span className={styles.authorMeta}>
            {post.author_major && `${post.author_major} · `}{post.author_year} · {timeAgo}
          </span>
        </div>
        <button className={styles.moreBtn}>
          <MoreHorizontal size={18} />
        </button>
      </div>

      {/* Content */}
      <div className={styles.content}>
        <p className={styles.text}>{post.content}</p>
      </div>

      {/* Image */}
      {post.image && (
        <div className={styles.imageWrap}>
          <img src={post.image} alt="Post" className={styles.postImage} />
        </div>
      )}

      {/* Actions */}
      <div className={styles.actions}>
        <div className={styles.actionsLeft}>
          <button
            className={`${styles.actionBtn} ${liked ? styles.liked : ''}`}
            onClick={handleLike}
          >
            <Heart size={17} fill={liked ? 'currentColor' : 'none'} />
            <span>{likes}</span>
          </button>

          <button className={styles.actionBtn} onClick={handleCommentToggle}>
            <MessageCircle size={17} />
            <span>{post.comments_count || 0}</span>
          </button>

          <button className={styles.actionBtn}>
            <Share2 size={17} />
            <span>Share</span>
          </button>
        </div>

        <button
          className={`${styles.actionBtn} ${saved ? styles.saved : ''}`}
          onClick={() => setSaved(s => !s)}
        >
          <Bookmark size={17} fill={saved ? 'currentColor' : 'none'} />
        </button>
      </div>

      {/* Comments Section */}
      {showComments && (
        <div className={styles.commentsSection}>
          <div className={styles.divider} />

          {/* Comment list */}
          {comments.length > 0 && (
            <div className={styles.commentsList}>
              {comments.map(c => (
                <div key={c.id} className={styles.comment}>
                  <img
                    src={c.author_avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${c.author_name}`}
                    alt={c.author_name}
                    className="avatar avatar-sm"
                  />
                  <div className={styles.commentBubble}>
                    <span className={styles.commentName}>{c.author_name}</span>
                    <span className={styles.commentText}>{c.content}</span>
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* Add comment */}
          <form className={styles.commentForm} onSubmit={handleComment}>
            <img
              src={user?.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}`}
              alt={user?.name}
              className="avatar avatar-sm"
            />
            <input
              type="text"
              className={`input ${styles.commentInput}`}
              placeholder="Add a comment…"
              value={comment}
              onChange={e => setComment(e.target.value)}
            />
            <button type="submit" className="btn btn-primary btn-sm" disabled={submitting || !comment.trim()}>
              {submitting ? '…' : 'Post'}
            </button>
          </form>
        </div>
      )}
    </article>
  );
}
