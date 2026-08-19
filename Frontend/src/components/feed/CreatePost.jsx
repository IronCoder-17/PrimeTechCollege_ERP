// ============================================
// CreatePost Component
// ============================================

import { useState } from 'react';
import { Image, X, Send } from 'lucide-react';
import { postsApi } from '../../utils/api';
import { useAuth } from '../../contexts/AuthContext';
import styles from './CreatePost.module.css';

const POST_TYPES = [
  { key: 'general', label: '💬 General' },
  { key: 'announcement', label: '📢 Announcement' },
  { key: 'study', label: '📚 Study' },
  { key: 'event', label: '🎉 Event' },
];

export default function CreatePost({ onPost }) {
  const { user } = useAuth();
  const [content, setContent] = useState('');
  const [postType, setPostType] = useState('general');
  const [imageUrl, setImageUrl] = useState('');
  const [showImageInput, setShowImageInput] = useState(false);
  const [loading, setLoading] = useState(false);
  const [focused, setFocused] = useState(false);

  const handleSubmit = async () => {
    if (!content.trim()) return;
    setLoading(true);
    try {
      const res = await postsApi.create({ content, post_type: postType, image: imageUrl });
      onPost?.({ id: res.data.post_id, content, post_type: postType, image: imageUrl });
    } catch (err) { console.error(err);
      // Demo mode: still call onPost
      onPost?.({ id: Date.now(), content, post_type: postType, image: imageUrl });
    }
    setContent('');
    setImageUrl('');
    setShowImageInput(false);
    setFocused(false);
    setLoading(false);
  };

  return (
    <div className={`${styles.card} card`}>
      <div className={styles.top}>
        <img
          src={user?.avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}`}
          alt={user?.name}
          className="avatar avatar-md"
          style={{ border: '2px solid var(--surface-0)', boxShadow: 'var(--shadow-sm)' }}
        />
        <textarea
          className={styles.textarea}
          placeholder={`What's on your mind, ${user?.name?.split(' ')[0] || 'student'}?`}
          value={content}
          onChange={e => setContent(e.target.value)}
          onFocus={() => setFocused(true)}
          rows={focused ? 3 : 1}
        />
      </div>

      {focused && (
        <div className={`${styles.expanded} animate-fade-in`}>
          {/* Post type selector */}
          <div className={styles.typeRow}>
            {POST_TYPES.map(t => (
              <button
                key={t.key}
                className={`${styles.typeBtn} ${postType === t.key ? styles.typeBtnActive : ''}`}
                onClick={() => setPostType(t.key)}
              >
                {t.label}
              </button>
            ))}
          </div>

          {/* Image URL input */}
          {showImageInput && (
            <div className={styles.imageRow}>
              <input
                type="url"
                className="input"
                placeholder="Paste image URL…"
                value={imageUrl}
                onChange={e => setImageUrl(e.target.value)}
                style={{ fontSize: 13 }}
              />
              <button className="btn btn-ghost btn-sm" onClick={() => { setShowImageInput(false); setImageUrl(''); }}>
                <X size={14} />
              </button>
            </div>
          )}

          {/* Image preview */}
          {imageUrl && (
            <div className={styles.imagePreview}>
              <img src={imageUrl} alt="preview" onError={() => setImageUrl('')} />
            </div>
          )}

          {/* Bottom actions */}
          <div className={styles.bottomRow}>
            <div className={styles.bottomLeft}>
              <button className={`btn btn-ghost btn-sm ${showImageInput ? 'active' : ''}`} onClick={() => setShowImageInput(s => !s)}>
                <Image size={16} /> Add Image
              </button>
            </div>
            <div style={{ display: 'flex', gap: 8 }}>
              <button className="btn btn-secondary btn-sm" onClick={() => { setFocused(false); setContent(''); }}>
                Cancel
              </button>
              <button
                className="btn btn-primary btn-sm"
                onClick={handleSubmit}
                disabled={!content.trim() || loading}
              >
                {loading ? <div className="spinner" style={{ width: 14, height: 14 }} /> : <><Send size={14} /> Post</>}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
