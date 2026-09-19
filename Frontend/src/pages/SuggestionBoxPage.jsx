// ============================================
// SuggestionBoxPage — shared by Student & Faculty
// Submit a suggestion, view own suggestions + status + admin response.
// Database-backed via backend/api/suggestions.php.
// ============================================

import { useState, useEffect, useCallback } from 'react';
import { Lightbulb, Plus, CheckCircle2, AlertCircle, X } from 'lucide-react';
import { suggestionsApi } from '../utils/api';
import styles from './SuggestionBoxPage.module.css';

const CATEGORIES = [
  'Academic', 'Faculty', 'Infrastructure', 'Technology', 'Events',
  'Library', 'Campus', 'Hostel', 'Transport', 'Fees', 'General', 'Other',
];

const STATUS_CLASS = {
  'Pending': 'statusPending',
  'Under Review': 'statusUnderReview',
  'In Progress': 'statusInProgress',
  'Implemented': 'statusImplemented',
  'Rejected': 'statusRejected',
};

function formatDate(iso) {
  if (!iso) return '';
  const d = new Date(iso.replace(' ', 'T'));
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
}

export default function SuggestionBoxPage() {
  const [suggestions, setSuggestions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState('');

  const [showForm, setShowForm] = useState(false);
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [category, setCategory] = useState('General');
  const [submitting, setSubmitting] = useState(false);
  const [formError, setFormError] = useState('');
  const [successMsg, setSuccessMsg] = useState('');

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const { data } = await suggestionsApi.getMine();
      setSuggestions(data.suggestions || []);
      setLoadError('');
    } catch (err) {
      setLoadError(err.response?.data?.error || 'Could not load your suggestions right now.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { load(); }, [load]);

  const resetForm = () => {
    setTitle(''); setDescription(''); setCategory('General'); setFormError('');
  };

  const submit = async (e) => {
    e.preventDefault();
    setFormError('');
    if (title.trim().length < 3) return setFormError('Title must be at least 3 characters.');
    if (description.trim().length < 10) return setFormError('Description must be at least 10 characters.');

    setSubmitting(true);
    try {
      const { data } = await suggestionsApi.create({ title: title.trim(), description: description.trim(), category });
      setSuggestions(prev => [data.suggestion, ...prev]);
      setSuccessMsg(data.message || 'Your suggestion has been submitted successfully.');
      resetForm();
      setShowForm(false);
      setTimeout(() => setSuccessMsg(''), 5000);
    } catch (err) {
      setFormError(err.response?.data?.error || 'Failed to submit suggestion. Please try again.');
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className={styles.wrap}>
      <div className={styles.pageHeader}>
        <div>
          <h1 className={styles.pageTitle}><Lightbulb size={22} /> Suggestion Box</h1>
          <p className={styles.pageSubtitle}>Share ideas to improve the campus. Track your submissions and admin responses below.</p>
        </div>
        <button className={styles.newBtn} onClick={() => { setShowForm(v => !v); setFormError(''); }}>
          {showForm ? <X size={16} /> : <Plus size={16} />} {showForm ? 'Cancel' : 'New Suggestion'}
        </button>
      </div>

      {successMsg && (
        <div className={styles.successBanner}><CheckCircle2 size={16} /> {successMsg}</div>
      )}

      {showForm && (
        <form className={`${styles.formCard} card`} onSubmit={submit}>
          {formError && <div className={styles.errorBanner}><AlertCircle size={16} /> {formError}</div>}
          <div className={styles.formRow}>
            <label className={styles.formLabel}>Suggestion Title</label>
            <input
              className="input"
              value={title}
              onChange={e => setTitle(e.target.value)}
              placeholder="e.g. Add more seating in the library"
              maxLength={200}
              disabled={submitting}
            />
          </div>
          <div className={styles.formRow}>
            <label className={styles.formLabel}>Description</label>
            <textarea
              className="input"
              rows={4}
              value={description}
              onChange={e => setDescription(e.target.value)}
              placeholder="Describe your suggestion in detail…"
              maxLength={4000}
              disabled={submitting}
              style={{ resize: 'vertical' }}
            />
          </div>
          <div className={styles.formRow}>
            <label className={styles.formLabel}>Category</label>
            <select className="input" value={category} onChange={e => setCategory(e.target.value)} disabled={submitting}>
              {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
            </select>
          </div>
          <div className={styles.formActions}>
            <button type="submit" className="btn btn-primary" disabled={submitting}>
              {submitting ? 'Submitting…' : 'Submit Suggestion'}
            </button>
          </div>
        </form>
      )}

      {loading ? (
        <div style={{ textAlign: 'center', padding: 40 }}><div className="spinner" style={{ width: 24, height: 24, margin: '0 auto' }} /></div>
      ) : loadError ? (
        <div className={styles.errorBanner}><AlertCircle size={16} /> {loadError}</div>
      ) : suggestions.length === 0 ? (
        <div className={`${styles.emptyState} card`}>
          <Lightbulb size={28} style={{ marginBottom: 10, opacity: 0.5 }} />
          <p>You haven't submitted any suggestions yet. Click "New Suggestion" to share your first idea.</p>
        </div>
      ) : (
        <div className={styles.list}>
          {suggestions.map(s => (
            <div key={s.id} className={`${styles.suggestionCard} card`}>
              <div className={styles.suggestionTop}>
                <div>
                  <div className={styles.suggestionTitle}>{s.title}</div>
                  <div className={styles.suggestionMeta}>{s.category} · Submitted {formatDate(s.created_at)}</div>
                </div>
                <span className={`badge ${styles[STATUS_CLASS[s.status]] || ''}`}>{s.status}</span>
              </div>
              <p className={styles.suggestionDesc}>{s.description}</p>
              {s.admin_response && (
                <div className={styles.responseBox}>
                  <span className={styles.responseLabel}>Admin Response</span>
                  {s.admin_response}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
