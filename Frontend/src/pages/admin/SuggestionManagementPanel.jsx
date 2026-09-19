// ============================================================
// SuggestionManagementPanel — Admin: Suggestion Box Management
//
// - Stats cards: Total, Pending, Under Review, In Progress,
//   Implemented, Rejected, Student vs Faculty (all DB-backed via
//   GET /api/suggestions.php/admin/stats — no hardcoded numbers).
// - Search by title/description/user name/category.
// - Filter by role (student/faculty), category, status, date.
// - View full suggestion, change status, add admin response.
// ============================================================

import React, { useEffect, useState, useCallback } from 'react';
import {
  Lightbulb, Search, Filter, X, CheckCircle, Clock, AlertTriangle,
  User, GraduationCap, Loader, MessageSquare,
} from 'lucide-react';
import { suggestionsApi } from '../../utils/api';

const card = { background: 'white', borderRadius: 16, padding: 20, border: '1px solid #e5e7eb', marginBottom: 16 };
const inputStyle = { padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const labelStyle = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };

const CATEGORIES = [
  'Academic', 'Faculty', 'Infrastructure', 'Technology', 'Events',
  'Library', 'Campus', 'Hostel', 'Transport', 'Fees', 'General', 'Other',
];
const STATUSES = ['Pending', 'Under Review', 'In Progress', 'Implemented', 'Rejected'];

const statusColor = (s) => ({
  'Pending':      { bg: '#fff7ed', color: '#d97706' },
  'Under Review': { bg: '#eff6ff', color: '#2563eb' },
  'In Progress':  { bg: '#f5f3ff', color: '#7c3aed' },
  'Implemented':  { bg: '#f0fdf4', color: '#16a34a' },
  'Rejected':     { bg: '#fff1f2', color: '#dc2626' },
}[s] || { bg: '#f3f4f6', color: '#6b7280' });

function fmtDate(iso) {
  if (!iso) return '-';
  const d = new Date(iso.replace(' ', 'T'));
  return d.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
}

const STAT_CARDS = [
  { key: 'total',        label: 'Total Suggestions', icon: Lightbulb,     bg: '#eef2ff', fg: '#4f46e5' },
  { key: 'Pending',      label: 'Pending',            icon: Clock,         bg: '#fff7ed', fg: '#d97706' },
  { key: 'Under Review', label: 'Under Review',       icon: Search,        fg: '#2563eb', bg: '#eff6ff' },
  { key: 'In Progress',  label: 'In Progress',        icon: Loader,        fg: '#7c3aed', bg: '#f5f3ff' },
  { key: 'Implemented',  label: 'Implemented',        icon: CheckCircle,   fg: '#16a34a', bg: '#f0fdf4' },
  { key: 'Rejected',     label: 'Rejected',           icon: AlertTriangle, fg: '#dc2626', bg: '#fff1f2' },
];

export default function SuggestionManagementPanel() {
  const [suggestions, setSuggestions] = useState([]);
  const [stats, setStats] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const [search, setSearch] = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [dateFilter, setDateFilter] = useState('');

  const [selected, setSelected] = useState(null);
  const [draftStatus, setDraftStatus] = useState('');
  const [draftResponse, setDraftResponse] = useState('');
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState('');

  const loadStats = useCallback(async () => {
    try {
      const { data } = await suggestionsApi.getStats();
      setStats(data);
    } catch { /* stats are supplementary — don't block the list on failure */ }
  }, []);

  const load = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const params = {};
      if (search) params.search = search;
      if (roleFilter) params.role = roleFilter;
      if (categoryFilter) params.category = categoryFilter;
      if (statusFilter) params.status = statusFilter;
      if (dateFilter) params.date = dateFilter;
      const { data } = await suggestionsApi.getAll(params);
      setSuggestions(data.suggestions || []);
    } catch (err) {
      setError(err.response?.data?.error || 'Could not load suggestions.');
    } finally {
      setLoading(false);
    }
  }, [search, roleFilter, categoryFilter, statusFilter, dateFilter]);

  useEffect(() => { loadStats(); }, [loadStats]);
  useEffect(() => {
    const t = setTimeout(load, 300); // debounce search/filter changes
    return () => clearTimeout(t);
  }, [load]);

  const openDetail = (s) => {
    setSelected(s);
    setDraftStatus(s.status);
    setDraftResponse(s.admin_response || '');
    setSaveError('');
  };

  const closeDetail = () => setSelected(null);

  const saveUpdate = async () => {
    if (!selected) return;
    setSaving(true);
    setSaveError('');
    try {
      const { data } = await suggestionsApi.update(selected.id, {
        status: draftStatus,
        admin_response: draftResponse,
      });
      setSuggestions(prev => prev.map(s => s.id === data.suggestion.id ? data.suggestion : s));
      setSelected(data.suggestion);
      loadStats();
    } catch (err) {
      setSaveError(err.response?.data?.error || 'Failed to save changes.');
    } finally {
      setSaving(false);
    }
  };

  const clearFilters = () => {
    setSearch(''); setRoleFilter(''); setCategoryFilter(''); setStatusFilter(''); setDateFilter('');
  };

  return (
    <div>
      {/* ── Stat cards ── */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))', gap: 14, marginBottom: 18 }}>
        {STAT_CARDS.map(({ key, label, icon: Icon, bg, fg }) => (
          <div key={key} style={{ ...card, marginBottom: 0, display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{ width: 40, height: 40, borderRadius: 10, background: bg, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Icon size={18} color={fg} />
            </div>
            <div>
              <div style={{ fontSize: 20, fontWeight: 700, color: '#111827' }}>
                {stats ? (key === 'total' ? stats.total : stats.by_status?.[key] ?? 0) : '—'}
              </div>
              <div style={{ fontSize: 11.5, color: '#6b7280' }}>{label}</div>
            </div>
          </div>
        ))}
      </div>

      {stats && (
        <div style={{ display: 'flex', gap: 16, marginBottom: 16, fontSize: 12.5, color: '#6b7280' }}>
          <span><GraduationCap size={13} style={{ verticalAlign: -2, marginRight: 4 }} />Student suggestions: <b style={{ color: '#111827' }}>{stats.by_role?.student ?? 0}</b></span>
          <span><User size={13} style={{ verticalAlign: -2, marginRight: 4 }} />Faculty suggestions: <b style={{ color: '#111827' }}>{stats.by_role?.faculty ?? 0}</b></span>
        </div>
      )}

      {/* ── Search & filters ── */}
      <div style={{ ...card, display: 'flex', flexWrap: 'wrap', gap: 12, alignItems: 'flex-end' }}>
        <div style={{ flex: '1 1 220px' }}>
          <label style={labelStyle}>Search</label>
          <div style={{ position: 'relative' }}>
            <Search size={14} style={{ position: 'absolute', left: 10, top: 10, color: '#9ca3af' }} />
            <input
              style={{ ...inputStyle, width: '100%', paddingLeft: 30 }}
              placeholder="Title, description, name, category…"
              value={search}
              onChange={e => setSearch(e.target.value)}
            />
          </div>
        </div>
        <div>
          <label style={labelStyle}>Role</label>
          <select style={inputStyle} value={roleFilter} onChange={e => setRoleFilter(e.target.value)}>
            <option value="">All</option>
            <option value="student">Student</option>
            <option value="faculty">Faculty</option>
          </select>
        </div>
        <div>
          <label style={labelStyle}>Category</label>
          <select style={inputStyle} value={categoryFilter} onChange={e => setCategoryFilter(e.target.value)}>
            <option value="">All</option>
            {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
          </select>
        </div>
        <div>
          <label style={labelStyle}>Status</label>
          <select style={inputStyle} value={statusFilter} onChange={e => setStatusFilter(e.target.value)}>
            <option value="">All</option>
            {STATUSES.map(s => <option key={s} value={s}>{s}</option>)}
          </select>
        </div>
        <div>
          <label style={labelStyle}>Date</label>
          <input type="date" style={inputStyle} value={dateFilter} onChange={e => setDateFilter(e.target.value)} />
        </div>
        <button
          onClick={clearFilters}
          style={{ ...inputStyle, background: '#f3f4f6', cursor: 'pointer', fontWeight: 600, display: 'flex', alignItems: 'center', gap: 6 }}
        >
          <X size={14} /> Clear
        </button>
      </div>

      {/* ── List ── */}
      <div style={card}>
        {loading ? (
          <div style={{ textAlign: 'center', padding: 30 }}><div className="spinner" style={{ width: 22, height: 22, margin: '0 auto' }} /></div>
        ) : error ? (
          <div style={{ color: '#dc2626', fontSize: 13, textAlign: 'center', padding: 20 }}>{error}</div>
        ) : suggestions.length === 0 ? (
          <div style={{ textAlign: 'center', padding: 30, color: '#9ca3af', fontSize: 13 }}>
            <Lightbulb size={26} style={{ opacity: 0.4, marginBottom: 8 }} />
            <div>No suggestions match your filters.</div>
          </div>
        ) : (
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13 }}>
              <thead>
                <tr style={{ textAlign: 'left', color: '#6b7280', fontSize: 11.5, textTransform: 'uppercase', borderBottom: '1px solid #e5e7eb' }}>
                  <th style={{ padding: '8px 10px' }}>#</th>
                  <th style={{ padding: '8px 10px' }}>Title</th>
                  <th style={{ padding: '8px 10px' }}>Submitted By</th>
                  <th style={{ padding: '8px 10px' }}>Role</th>
                  <th style={{ padding: '8px 10px' }}>Category</th>
                  <th style={{ padding: '8px 10px' }}>Date</th>
                  <th style={{ padding: '8px 10px' }}>Status</th>
                  <th style={{ padding: '8px 10px' }}></th>
                </tr>
              </thead>
              <tbody>
                {suggestions.map(s => {
                  const sc = statusColor(s.status);
                  return (
                    <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                      <td style={{ padding: '10px' }}>{s.id}</td>
                      <td style={{ padding: '10px', fontWeight: 600, color: '#111827', maxWidth: 260 }}>{s.title}</td>
                      <td style={{ padding: '10px' }}>{s.user_name}</td>
                      <td style={{ padding: '10px', textTransform: 'capitalize' }}>{s.user_role}</td>
                      <td style={{ padding: '10px' }}>{s.category}</td>
                      <td style={{ padding: '10px', color: '#6b7280' }}>{fmtDate(s.created_at)}</td>
                      <td style={{ padding: '10px' }}>
                        <span style={{ background: sc.bg, color: sc.color, padding: '3px 10px', borderRadius: 99, fontSize: 11.5, fontWeight: 600 }}>
                          {s.status}
                        </span>
                      </td>
                      <td style={{ padding: '10px' }}>
                        <button
                          onClick={() => openDetail(s)}
                          style={{ padding: '6px 12px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', cursor: 'pointer', fontSize: 12, fontWeight: 600, color: '#374151' }}
                        >
                          Open
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* ── Detail / manage modal ── */}
      {selected && (
        <div
          style={{ position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.4)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 16 }}
          onClick={closeDetail}
        >
          <div
            style={{ background: 'white', borderRadius: 16, padding: 24, maxWidth: 560, width: '100%', maxHeight: '86vh', overflowY: 'auto' }}
            onClick={e => e.stopPropagation()}
          >
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 12 }}>
              <div>
                <h3 style={{ margin: 0, fontSize: 17, fontWeight: 700, color: '#111827' }}>{selected.title}</h3>
                <p style={{ margin: '4px 0 0', fontSize: 12.5, color: '#6b7280' }}>
                  {selected.user_name} ({selected.user_role}) · {selected.category} · {fmtDate(selected.created_at)}
                </p>
              </div>
              <button onClick={closeDetail} style={{ background: 'none', border: 'none', cursor: 'pointer', color: '#9ca3af' }}><X size={20} /></button>
            </div>

            <p style={{ fontSize: 13.5, color: '#374151', lineHeight: 1.6, background: '#f9fafb', padding: 12, borderRadius: 10 }}>
              {selected.description}
            </p>

            {saveError && (
              <div style={{ display: 'flex', gap: 6, alignItems: 'center', background: '#fef2f2', color: '#b91c1c', padding: '8px 12px', borderRadius: 8, fontSize: 12.5, marginBottom: 10 }}>
                <AlertTriangle size={14} /> {saveError}
              </div>
            )}

            <div style={{ marginTop: 12 }}>
              <label style={labelStyle}>Status</label>
              <select style={{ ...inputStyle, width: '100%' }} value={draftStatus} onChange={e => setDraftStatus(e.target.value)}>
                {STATUSES.map(s => <option key={s} value={s}>{s}</option>)}
              </select>
            </div>

            <div style={{ marginTop: 12 }}>
              <label style={labelStyle}><MessageSquare size={12} style={{ verticalAlign: -1, marginRight: 4 }} />Admin Response</label>
              <textarea
                style={{ ...inputStyle, width: '100%', minHeight: 90, resize: 'vertical', fontFamily: 'inherit' }}
                placeholder="Write a response visible to the submitter…"
                value={draftResponse}
                onChange={e => setDraftResponse(e.target.value)}
                maxLength={4000}
              />
            </div>

            {(selected.reviewed_by || selected.reviewed_at) && (
              <p style={{ fontSize: 11.5, color: '#9ca3af', marginTop: 8 }}>
                Last reviewed by {selected.reviewed_by || '—'} on {fmtDate(selected.reviewed_at)}
              </p>
            )}

            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: 10, marginTop: 18 }}>
              <button
                onClick={closeDetail}
                style={{ padding: '9px 18px', borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', cursor: 'pointer', fontSize: 13, fontWeight: 600, color: '#374151' }}
              >
                Cancel
              </button>
              <button
                onClick={saveUpdate}
                disabled={saving}
                style={{ padding: '9px 18px', borderRadius: 8, border: 'none', background: '#4f46e5', color: 'white', cursor: saving ? 'not-allowed' : 'pointer', fontSize: 13, fontWeight: 700, opacity: saving ? 0.7 : 1 }}
              >
                {saving ? 'Saving…' : 'Save Changes'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
