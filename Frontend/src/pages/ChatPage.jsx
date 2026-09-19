// ============================================
// ChatPage — Student → Faculty Messaging (real, DB-backed)
//
// Faculty contacts are auto-derived server-side from:
//   this student's course + semester → tt_subjects → assigned faculty
// The student never sees or can message an unrelated faculty member.
// Polls every few seconds for a real-time-style experience without
// requiring a websocket connection.
// ============================================================

import { useState, useRef, useEffect, useCallback } from 'react';
import { Send, Search, GraduationCap, AlertCircle } from 'lucide-react';
import { facultyChatApi } from '../utils/api';
import styles from './ChatPage.module.css';

const POLL_MS = 4000;

function timeAgo(iso) {
  if (!iso) return '';
  const d = new Date(iso.replace(' ', 'T'));
  const diffMs = Date.now() - d.getTime();
  const mins = Math.floor(diffMs / 60000);
  if (mins < 1) return 'now';
  if (mins < 60) return `${mins}m`;
  const hrs = Math.floor(mins / 60);
  if (hrs < 24) return `${hrs}h`;
  const days = Math.floor(hrs / 24);
  if (days < 7) return `${days}d`;
  return d.toLocaleDateString();
}

function formatClock(iso) {
  if (!iso) return '';
  const d = new Date(iso.replace(' ', 'T'));
  return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

export default function ChatPage() {
  const [contacts, setContacts] = useState([]);
  const [loadingContacts, setLoadingContacts] = useState(true);
  const [contactsError, setContactsError] = useState('');
  const [active, setActive] = useState(null); // { subject_id, faculty_id, ... }
  const [messages, setMessages] = useState([]);
  const [loadingConv, setLoadingConv] = useState(false);
  const [input, setInput] = useState('');
  const [sending, setSending] = useState(false);
  const [searchConv, setSearchConv] = useState('');
  const messagesEndRef = useRef(null);
  const pollRef = useRef(null);

  const loadContacts = useCallback(async (opts = {}) => {
    try {
      const { data } = await facultyChatApi.getContacts();
      setContacts(data.contacts || []);
      setContactsError('');
      return data.contacts || [];
    } catch (err) {
      setContactsError(
        err.response?.data?.error ||
        'Could not load your faculty list. Make sure your course and semester are on file.'
      );
      return [];
    } finally {
      if (!opts.silent) setLoadingContacts(false);
    }
  }, []);

  // Initial load
  useEffect(() => {
    (async () => {
      const list = await loadContacts();
      if (list.length > 0) setActive(list[0]);
    })();
  }, [loadContacts]);

  // Background refresh of the contact list (last message / unread badges)
  useEffect(() => {
    const id = setInterval(() => loadContacts({ silent: true }), POLL_MS);
    return () => clearInterval(id);
  }, [loadContacts]);

  const loadConversation = useCallback(async (contact, opts = {}) => {
    if (!contact) return;
    if (!opts.silent) setLoadingConv(true);
    try {
      const { data } = await facultyChatApi.getConversation(contact.subject_id, contact.faculty_id);
      setMessages(data.messages || []);
    } catch (err) {
      if (!opts.silent) setMessages([]);
    } finally {
      if (!opts.silent) setLoadingConv(false);
    }
  }, []);

  // Load conversation when active contact changes, and poll it
  useEffect(() => {
    if (!active) return;
    loadConversation(active);
    if (pollRef.current) clearInterval(pollRef.current);
    pollRef.current = setInterval(() => loadConversation(active, { silent: true }), POLL_MS);
    return () => clearInterval(pollRef.current);
  }, [active, loadConversation]);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, active]);

  const sendMessage = async () => {
    const text = input.trim();
    if (!text || !active || sending) return;
    setSending(true);
    setInput('');
    try {
      await facultyChatApi.send(active.subject_id, active.faculty_id, text);
      await loadConversation(active, { silent: true });
      loadContacts({ silent: true });
    } catch (err) {
      setInput(text); // restore so the student doesn't lose what they typed
      alert(err.response?.data?.error || 'Failed to send message. Please try again.');
    } finally {
      setSending(false);
    }
  };

  const handleKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  const filteredContacts = contacts.filter(c =>
    !searchConv ||
    c.faculty_name?.toLowerCase().includes(searchConv.toLowerCase()) ||
    c.subject_name?.toLowerCase().includes(searchConv.toLowerCase())
  );

  const isActive = (c) => active && c.subject_id === active.subject_id && c.faculty_id === active.faculty_id;

  // ── Empty / error states ──
  if (!loadingContacts && contactsError) {
    return (
      <div className={styles.chatLayout}>
        <div style={{ margin: 'auto', textAlign: 'center', maxWidth: 360, padding: 24 }}>
          <AlertCircle size={32} style={{ marginBottom: 10, color: '#f59e0b' }} />
          <p style={{ fontSize: 14, color: '#374151', margin: 0 }}>{contactsError}</p>
        </div>
      </div>
    );
  }

  if (!loadingContacts && contacts.length === 0) {
    return (
      <div className={styles.chatLayout}>
        <div style={{ margin: 'auto', textAlign: 'center', maxWidth: 360, padding: 24 }}>
          <GraduationCap size={32} style={{ marginBottom: 10, color: '#9ca3af' }} />
          <p style={{ fontSize: 14, color: '#374151', margin: 0 }}>
            No faculty are assigned to your subjects yet for this semester. Check back once your
            course's timetable/faculty assignments are published.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className={styles.chatLayout}>
      {/* ── Sidebar ── */}
      <div className={styles.convSidebar}>
        <div className={styles.convHeader}>
          <h2 className={styles.convTitle}>Messages</h2>
        </div>

        <div className={styles.convSearch}>
          <Search size={14} className={styles.convSearchIcon} />
          <input
            type="text"
            placeholder="Search faculty or subject…"
            className={styles.convSearchInput}
            value={searchConv}
            onChange={e => setSearchConv(e.target.value)}
          />
        </div>

        <div className={styles.convList}>
          {loadingContacts && (
            <div style={{ padding: 20, textAlign: 'center' }}><div className="spinner" style={{ width: 22, height: 22, margin: '0 auto' }} /></div>
          )}
          {filteredContacts.map(c => (
            <div
              key={`${c.faculty_id}-${c.subject_id}`}
              className={`${styles.convItem} ${isActive(c) ? styles.convItemActive : ''}`}
              onClick={() => setActive(c)}
            >
              <div className={styles.convAvatarWrap}>
                <img
                  src={c.photo || `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(c.faculty_name || 'Faculty')}`}
                  alt={c.faculty_name}
                  className="avatar avatar-md"
                />
              </div>
              <div className={styles.convInfo}>
                <div className={styles.convInfoTop}>
                  <span className={styles.convName}>{c.faculty_name}</span>
                  <span className={styles.convTime}>{timeAgo(c.last_message_at)}</span>
                </div>
                <div className={styles.convInfoBottom}>
                  <span className={styles.convLastMsg}>
                    {c.last_message
                      ? `${c.last_sender_role === 'student' ? 'You: ' : ''}${c.last_message}`
                      : `${c.subject_code ? c.subject_code + ' — ' : ''}${c.subject_name}`}
                  </span>
                  {c.unread_count > 0 && (
                    <span className={styles.unreadBadge}>{c.unread_count}</span>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* ── Chat Area ── */}
      <div className={styles.chatArea}>
        {active && (
          <>
            {/* Chat Header */}
            <div className={styles.chatHeader}>
              <div className={styles.chatHeaderLeft}>
                <div className={styles.chatAvatarWrap}>
                  <img
                    src={active.photo || `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(active.faculty_name || 'Faculty')}`}
                    alt={active.faculty_name}
                    className="avatar avatar-md"
                  />
                </div>
                <div>
                  <span className={styles.chatName}>{active.faculty_name}</span>
                  <span className={styles.chatStatus}>
                    {active.subject_code ? `${active.subject_code} — ` : ''}{active.subject_name}
                  </span>
                </div>
              </div>
            </div>

            {/* Messages */}
            <div className={styles.messagesArea}>
              {loadingConv ? (
                <div style={{ textAlign: 'center', padding: 30 }}><div className="spinner" style={{ width: 22, height: 22, margin: '0 auto' }} /></div>
              ) : messages.length === 0 ? (
                <div style={{ textAlign: 'center', padding: 30, color: '#9ca3af', fontSize: 13 }}>
                  Ask {active.faculty_name} a question about {active.subject_name} to start the conversation.
                </div>
              ) : (
                messages.map(msg => (
                  <div
                    key={msg.id}
                    className={`${styles.msgRow} ${msg.sender_role === 'student' ? styles.msgRowMe : ''}`}
                  >
                    {msg.sender_role === 'faculty' && (
                      <img
                        src={active.photo || `https://api.dicebear.com/7.x/avataaars/svg?seed=${encodeURIComponent(active.faculty_name || 'Faculty')}`}
                        alt=""
                        className="avatar avatar-sm"
                        style={{ flexShrink: 0 }}
                      />
                    )}
                    <div className={styles.msgBubbleWrap}>
                      <div className={`${styles.msgBubble} ${msg.sender_role === 'student' ? styles.msgBubbleMe : styles.msgBubbleThem}`}>
                        {msg.message}
                      </div>
                      <span className={styles.msgTime}>
                        {formatClock(msg.created_at)}
                        {msg.sender_role === 'student' && (msg.is_read ? ' · Read' : ' · Sent')}
                      </span>
                    </div>
                  </div>
                ))
              )}
              <div ref={messagesEndRef} />
            </div>

            {/* Input */}
            <div className={styles.inputArea}>
              <input
                type="text"
                placeholder={`Ask a question about ${active.subject_name}…`}
                className={styles.msgInput}
                value={input}
                onChange={e => setInput(e.target.value)}
                onKeyDown={handleKey}
                disabled={sending}
              />
              <button
                className={`${styles.sendBtn} ${input.trim() ? styles.sendBtnActive : ''}`}
                onClick={sendMessage}
                disabled={!input.trim() || sending}
              >
                <Send size={18} />
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}