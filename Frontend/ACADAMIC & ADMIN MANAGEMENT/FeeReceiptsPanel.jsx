// ============================================================
// FeeReceiptsPanel — Admin: Fee Receipt Management
// PrimeTech College Campus Connect — Fee Receipt Generation Module
//
// Reads from the same localStorage-backed data layer
// (utils/feeReceipts) used by the Student "Fee Receipts" page, so
// every receipt generated after a successful payment appears here
// instantly — no backend required.
//
// Admin can:
//   - View dashboard statistics (Total / Today's / Monthly receipts,
//     Total / Monthly collection)
//   - Search by student name, enrollment number, or receipt number
//   - Filter by payment status and date range
//   - View and download any student's receipt as a PDF
// ============================================================

import { useMemo, useState } from 'react';
import {
  FileText, Search, Filter, Eye, Download, TrendingUp, CalendarDays, RefreshCw,
} from 'lucide-react';
import {
  getAllReceipts, searchReceipts, filterReceipts, getReceiptStats,
} from '../../utils/feeReceipts';
import { downloadReceiptPDF, formatCurrency, formatReceiptDate } from '../../utils/receiptPdf';
import ReceiptModal from '../../components/ReceiptModal';

// ── Shared styles (matches other Admin panels) ─────────────────
const card  = { background: 'white', borderRadius: 16, padding: 24, border: '1px solid #e5e7eb', marginBottom: 16 };
const input = { padding: '9px 12px', borderRadius: 8, border: '1px solid #e5e7eb', fontSize: 13, color: '#374151', boxSizing: 'border-box' };
const lbl   = { fontSize: 11, fontWeight: 600, color: '#6b7280', display: 'block', marginBottom: 4 };
const fmt   = (n) => formatCurrency(n);

const STATUS_OPTIONS = ['Paid', 'Partial Paid', 'Pending'];

const STATUS_STYLES = {
  Paid:           { bg: '#f0fdf4', color: '#16a34a' },
  'Partial Paid': { bg: '#fef3e2', color: '#A67C52' },
  Pending:        { bg: '#fff1f2', color: '#dc2626' },
};

function StatusBadge({ status }) {
  const s = STATUS_STYLES[status] || STATUS_STYLES.Paid;
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', fontSize: 11, fontWeight: 800,
      padding: '3px 10px', borderRadius: 999, background: s.bg, color: s.color, letterSpacing: 0.4,
    }}>
      {status}
    </span>
  );
}

function iconBtn() {
  return {
    display: 'flex', alignItems: 'center', justifyContent: 'center', width: 32, height: 32,
    borderRadius: 8, border: '1px solid #e5e7eb', background: 'white', color: '#6b7280', cursor: 'pointer',
  };
}

export default function FeeReceiptsPanel() {
  const [receipts, setReceipts] = useState(() => getAllReceipts());
  const [search, setSearch]     = useState('');
  const [status, setStatus]     = useState('');
  const [from, setFrom]         = useState('');
  const [to, setTo]             = useState('');
  const [viewReceipt, setViewReceipt] = useState(null);

  const refresh = () => setReceipts(getAllReceipts());

  const stats = useMemo(() => getReceiptStats(receipts), [receipts]);

  const filtered = useMemo(() => {
    let list = searchReceipts(receipts, search);
    list = filterReceipts(list, { status: status || undefined, from: from || undefined, to: to || undefined });
    return list.slice().sort((a, b) => new Date(b.paymentDate) - new Date(a.paymentDate));
  }, [receipts, search, status, from, to]);

  const clearFilters = () => { setSearch(''); setStatus(''); setFrom(''); setTo(''); };
  const hasFilters = search || status || from || to;

  const statCards = [
    { label: 'Total Receipts',     value: stats.total,                  icon: FileText,     color: '#2563eb', bg: '#eff6ff' },
    { label: "Today's Receipts",   value: stats.today,                  icon: CalendarDays, color: '#16a34a', bg: '#f0fdf4' },
    { label: 'Monthly Receipts',   value: stats.monthly,                icon: CalendarDays, color: '#A67C52', bg: '#fef3e2' },
    { label: 'Total Collection',   value: fmt(stats.totalCollection),   icon: TrendingUp,   color: '#9333ea', bg: '#f5f3ff' },
    { label: 'Monthly Collection', value: fmt(stats.monthlyCollection), icon: TrendingUp,   color: '#dc2626', bg: '#fff1f2' },
  ];

  return (
    <div>
      {/* Dashboard statistics */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(170px, 1fr))', gap: 14, marginBottom: 16 }}>
        {statCards.map(({ label, value, icon: Icon, color, bg }) => (
          <div key={label} style={{ ...card, marginBottom: 0, padding: 18, display: 'flex', alignItems: 'center', gap: 12 }}>
            <div style={{ width: 40, height: 40, borderRadius: 10, background: bg, color, display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <Icon size={18} />
            </div>
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 18, fontWeight: 800, color: '#111827', lineHeight: 1.2 }}>{value}</div>
              <div style={{ fontSize: 11, color: '#6b7280', fontWeight: 600, marginTop: 2, whiteSpace: 'nowrap' }}>{label}</div>
            </div>
          </div>
        ))}
      </div>

      {/* Search & filters */}
      <div style={card}>
        <div style={{ display: 'flex', gap: 12, flexWrap: 'wrap', alignItems: 'flex-end' }}>
          <div style={{ flex: '2 1 220px', minWidth: 200 }}>
            <label style={lbl}>Search</label>
            <div style={{ position: 'relative' }}>
              <Search size={14} style={{ position: 'absolute', left: 11, top: 10, color: '#9ca3af' }} />
              <input
                style={{ ...input, width: '100%', paddingLeft: 32 }}
                placeholder="Student name, enrollment no, receipt no…"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
            </div>
          </div>

          <div style={{ flex: '1 1 140px', minWidth: 130 }}>
            <label style={lbl}>Status</label>
            <select style={{ ...input, width: '100%' }} value={status} onChange={(e) => setStatus(e.target.value)}>
              <option value="">All Statuses</option>
              {STATUS_OPTIONS.map(s => <option key={s} value={s}>{s}</option>)}
            </select>
          </div>

          <div style={{ flex: '1 1 130px', minWidth: 120 }}>
            <label style={lbl}>From</label>
            <input type="date" style={{ ...input, width: '100%' }} value={from} onChange={(e) => setFrom(e.target.value)} />
          </div>

          <div style={{ flex: '1 1 130px', minWidth: 120 }}>
            <label style={lbl}>To</label>
            <input type="date" style={{ ...input, width: '100%' }} value={to} onChange={(e) => setTo(e.target.value)} />
          </div>

          <button
            onClick={refresh}
            style={{ ...input, display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer', fontWeight: 600, color: '#374151', background: '#f9fafb' }}
            title="Refresh"
          >
            <RefreshCw size={14} /> Refresh
          </button>

          {hasFilters && (
            <button
              onClick={clearFilters}
              style={{ ...input, display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer', fontWeight: 600, color: '#dc2626', background: '#fff1f2', border: '1px solid #fecdd3' }}
            >
              <Filter size={14} /> Clear Filters
            </button>
          )}
        </div>
      </div>

      {/* Receipts table */}
      <div style={card}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 14 }}>
          <div style={{ fontSize: 15, fontWeight: 700, color: '#111827' }}>All Fee Receipts</div>
          <div style={{ fontSize: 12, color: '#6b7280' }}>{filtered.length} of {receipts.length} receipts</div>
        </div>

        {filtered.length === 0 ? (
          <div style={{ padding: '40px 12px', textAlign: 'center', color: '#9ca3af', fontSize: 13 }}>
            No receipts match the current filters.
          </div>
        ) : (
          <div style={{ overflowX: 'auto' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 13, minWidth: 760 }}>
              <thead>
                <tr>
                  {['Receipt No', 'Student', 'Enrollment No', 'Fee Type', 'Amount', 'Date', 'Status', 'Action'].map(h => (
                    <th key={h} style={{ textAlign: 'left', padding: '10px 12px', fontSize: 11, fontWeight: 700, color: '#6b7280', textTransform: 'uppercase', letterSpacing: 0.4, borderBottom: '1px solid #f3f4f6' }}>
                      {h}
                    </th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {filtered.map((r) => (
                  <tr key={r.id}>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', fontWeight: 700, color: '#111827' }}>{r.receiptNumber}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', color: '#374151' }}>{r.studentName}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', color: '#6b7280' }}>{r.enrollmentNumber}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', color: '#374151' }}>{r.feeType}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', fontWeight: 700, color: '#111827' }}>{fmt(r.amount)}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6', color: '#6b7280' }}>{formatReceiptDate(r.paymentDate)}</td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6' }}><StatusBadge status={r.status} /></td>
                    <td style={{ padding: 12, borderBottom: '1px solid #f3f4f6' }}>
                      <div style={{ display: 'flex', gap: 6 }}>
                        <button style={iconBtn()} title="View Receipt" onClick={() => setViewReceipt(r)}><Eye size={14} /></button>
                        <button style={iconBtn()} title="Download PDF" onClick={() => downloadReceiptPDF(r)}><Download size={14} /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      <ReceiptModal receipt={viewReceipt} onClose={() => setViewReceipt(null)} />
    </div>
  );
}
