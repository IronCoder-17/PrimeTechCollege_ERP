// ============================================================
// ApplyNowModal — Public, lightweight admission INQUIRY form.
// This is NOT a registration: it only collects basic contact
// details. Submissions are stored for Admin review, and Admin
// can later convert a qualifying inquiry into a full Student
// Admission record from inside the Admin Panel. No student
// account or login credentials are created from this form.
// ============================================================

import { useState } from 'react';
import { X, Send, CheckCircle, User, Mail, Phone, BookOpen } from 'lucide-react';

const COURSES_OF_INTEREST = [
  'B.Tech Computer Engineering', 'B.Tech Information Technology', 'B.Tech Mechanical Engineering',
  'B.Tech Civil Engineering', 'B.Tech Electronics & Communication', 'M.Tech Computer Engineering',
  'BCA', 'MCA', 'B.Sc Information Technology', 'BBA', 'MBA', 'B.Com Business Analytics',
  'B.Sc Mathematics', 'B.Sc Physics', 'M.Sc Data Science', 'B.Com', 'M.Com',
  'BA English', 'Bachelor of Multimedia & Animation', 'Other / Not sure yet',
];

const STORAGE_KEY = 'pt_admission_inquiries';

export function saveInquiry(inquiry) {
  const raw = localStorage.getItem(STORAGE_KEY);
  const list = raw ? JSON.parse(raw) : [];
  const record = {
    id: `INQ-${Date.now()}`,
    submittedAt: new Date().toISOString(),
    status: 'New',
    ...inquiry,
  };
  list.unshift(record);
  localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
  return record;
}

export default function ApplyNowModal({ onClose }) {
  const [form, setForm] = useState({ name: '', email: '', phone: '', course: COURSES_OF_INTEREST[0], message: '' });
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState('');

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }));

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');
    if (!form.name.trim() || !form.email.trim() || !form.phone.trim()) {
      setError('Please fill in your name, email, and phone number.');
      return;
    }
    saveInquiry(form);
    setSubmitted(true);
  };

  return (
    <div
      onClick={(e) => e.target === e.currentTarget && onClose()}
      style={{ position: 'fixed', inset: 0, background: 'rgba(15,23,42,0.55)', zIndex: 1000, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 16 }}
    >
      <div style={{ background: 'white', borderRadius: 18, width: '100%', maxWidth: 460, padding: 28, position: 'relative', boxShadow: '0 20px 60px rgba(0,0,0,0.25)' }}>
        <button onClick={onClose} aria-label="Close" style={{ position: 'absolute', top: 16, right: 16, background: '#f3f4f6', border: 'none', borderRadius: '50%', width: 32, height: 32, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer' }}>
          <X size={16} />
        </button>

        {submitted ? (
          <div style={{ textAlign: 'center', padding: '24px 0' }}>
            <CheckCircle size={48} color="#16a34a" style={{ marginBottom: 12 }} />
            <h2 style={{ margin: '0 0 8px', fontSize: 19, fontWeight: 700, color: '#111827' }}>Inquiry received!</h2>
            <p style={{ color: '#6b7280', fontSize: 14, margin: 0 }}>
              Thanks for your interest in PrimeTech College. Our admissions team will reach out to you shortly to guide you through the next steps.
            </p>
            <button onClick={onClose} className="btn btn-primary" style={{ marginTop: 20 }}>Done</button>
          </div>
        ) : (
          <>
            <h2 style={{ margin: '0 0 4px', fontSize: 19, fontWeight: 700, color: '#111827' }}>Apply Now</h2>
            <p style={{ color: '#6b7280', fontSize: 13, margin: '0 0 18px' }}>
              Share a few basic details and our admissions team will get in touch. This is a quick inquiry, not a final registration.
            </p>

            {error && (
              <div style={{ background: '#fff1f2', color: '#dc2626', border: '1px solid #fecdd3', borderRadius: 8, padding: '8px 12px', fontSize: 13, marginBottom: 14 }}>
                {error}
              </div>
            )}

            <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>Full Name</label>
                <div style={{ position: 'relative', marginTop: 4 }}>
                  <User size={15} style={{ position: 'absolute', left: 10, top: 11, color: '#9ca3af' }} />
                  <input value={form.name} onChange={e => set('name', e.target.value)} placeholder="Your full name"
                    style={{ width: '100%', padding: '9px 12px 9px 32px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, boxSizing: 'border-box' }} required />
                </div>
              </div>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>Email</label>
                <div style={{ position: 'relative', marginTop: 4 }}>
                  <Mail size={15} style={{ position: 'absolute', left: 10, top: 11, color: '#9ca3af' }} />
                  <input type="email" value={form.email} onChange={e => set('email', e.target.value)} placeholder="you@example.com"
                    style={{ width: '100%', padding: '9px 12px 9px 32px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, boxSizing: 'border-box' }} required />
                </div>
              </div>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>Phone Number</label>
                <div style={{ position: 'relative', marginTop: 4 }}>
                  <Phone size={15} style={{ position: 'absolute', left: 10, top: 11, color: '#9ca3af' }} />
                  <input value={form.phone} onChange={e => set('phone', e.target.value)} placeholder="98765 43210"
                    style={{ width: '100%', padding: '9px 12px 9px 32px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, boxSizing: 'border-box' }} required />
                </div>
              </div>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>Course of Interest</label>
                <div style={{ position: 'relative', marginTop: 4 }}>
                  <BookOpen size={15} style={{ position: 'absolute', left: 10, top: 11, color: '#9ca3af' }} />
                  <select value={form.course} onChange={e => set('course', e.target.value)}
                    style={{ width: '100%', padding: '9px 12px 9px 32px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, boxSizing: 'border-box', background: 'white' }}>
                    {COURSES_OF_INTEREST.map(c => <option key={c}>{c}</option>)}
                  </select>
                </div>
              </div>
              <div>
                <label style={{ fontSize: 12, fontWeight: 600, color: '#374151' }}>Message (optional)</label>
                <textarea value={form.message} onChange={e => set('message', e.target.value)} rows={3} placeholder="Any questions for our admissions team?"
                  style={{ width: '100%', padding: '9px 12px', borderRadius: 9, border: '1px solid #e5e7eb', fontSize: 13, boxSizing: 'border-box', marginTop: 4, fontFamily: 'inherit', resize: 'vertical' }} />
              </div>

              <button type="submit" className="btn btn-primary" style={{ width: '100%', justifyContent: 'center', marginTop: 4 }}>
                Submit Inquiry <Send size={15} />
              </button>
            </form>
          </>
        )}
      </div>
    </div>
  );
}
