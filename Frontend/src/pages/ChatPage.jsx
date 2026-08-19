// ============================================
// ChatPage — Messaging UI
// ============================================

import { useState, useRef, useEffect } from 'react';
import { Send, Search, Phone, Video, MoreHorizontal, Smile } from 'lucide-react';
import styles from './ChatPage.module.css';

const DEMO_CONVERSATIONS = [
  {
    id: 1,
    name: 'Maya Patel',
    avatar: 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=60&h=60&fit=crop&crop=face',
    lastMsg: 'Are you coming to the study session?',
    time: '2m',
    unread: 2,
    online: true,
  },
  {
    id: 2,
    name: 'Jordan Lee',
    avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=60&h=60&fit=crop&crop=face',
    lastMsg: 'The hackathon was amazing! We should team up.',
    time: '15m',
    unread: 0,
    online: true,
  },
  {
    id: 3,
    name: 'Priya Sharma',
    avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=60&h=60&fit=crop&crop=face',
    lastMsg: 'Check out my thesis project photos!',
    time: '1h',
    unread: 1,
    online: false,
  },
  {
    id: 4,
    name: 'Carlos Rivera',
    avatar: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=60&h=60&fit=crop&crop=face',
    lastMsg: 'We won the robotics competition! 🏆',
    time: '3h',
    unread: 0,
    online: false,
  },
  {
    id: 5,
    name: 'Tech Innovators Club',
    avatar: 'https://images.unsplash.com/photo-1531297484001-80022131f5a1?w=60&h=60&fit=crop',
    lastMsg: 'Hackathon registrations are open!',
    time: '5h',
    unread: 5,
    online: false,
    isGroup: true,
  },
];

const DEMO_MESSAGES = {
  1: [
    { id: 1, sender: 'them', content: 'Hey! Are you preparing for the Bio midterm?', time: '10:00 AM' },
    { id: 2, sender: 'me', content: 'Yes! Just started on the cell division chapter. The Pomodoro technique is actually helping 😅', time: '10:02 AM' },
    { id: 3, sender: 'them', content: 'Same! I found some great past papers, want me to share them?', time: '10:04 AM' },
    { id: 4, sender: 'me', content: 'That would be awesome, thank you!', time: '10:05 AM' },
    { id: 5, sender: 'them', content: 'Are you coming to the study session?', time: '10:08 AM' },
  ],
  2: [
    { id: 1, sender: 'them', content: 'Dude that hackathon was INSANE. Our project actually works!', time: 'Yesterday' },
    { id: 2, sender: 'me', content: 'Right?! The judges loved the sustainability angle. We should definitely team up again.', time: 'Yesterday' },
    { id: 3, sender: 'them', content: 'The hackathon was amazing! We should team up.', time: '11:30 AM' },
  ],
};

export default function ChatPage() {
  const [activeConvId, setActiveConvId] = useState(1);
  const [messages, setMessages] = useState(DEMO_MESSAGES);
  const [input, setInput] = useState('');
  const [searchConv, setSearchConv] = useState('');
  const messagesEndRef = useRef(null);

  const activeConv = DEMO_CONVERSATIONS.find(c => c.id === activeConvId);
  const currentMessages = messages[activeConvId] || [];

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [activeConvId, messages]);

  const sendMessage = () => {
    if (!input.trim()) return;
    const newMsg = {
      id: Date.now(),
      sender: 'me',
      content: input.trim(),
      time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
    };
    setMessages(m => ({
      ...m,
      [activeConvId]: [...(m[activeConvId] || []), newMsg],
    }));
    setInput('');

    // Simulate a reply after 1.5s
    setTimeout(() => {
      const replies = [
        'That sounds great! 😊',
        "Definitely! Let's make it happen.",
        'I was just thinking the same thing!',
        'Perfect, see you there!',
        "Awesome! Can't wait 🙌",
      ];
      const reply = {
        id: Date.now() + 1,
        sender: 'them',
        content: replies[Math.floor(Math.random() * replies.length)],
        time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
      };
      setMessages(m => ({ ...m, [activeConvId]: [...(m[activeConvId] || []), reply] }));
    }, 1500);
  };

  const handleKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  const filteredConvs = DEMO_CONVERSATIONS.filter(c =>
    !searchConv || c.name.toLowerCase().includes(searchConv.toLowerCase())
  );

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
            placeholder="Search conversations…"
            className={styles.convSearchInput}
            value={searchConv}
            onChange={e => setSearchConv(e.target.value)}
          />
        </div>

        <div className={styles.convList}>
          {filteredConvs.map(conv => (
            <div
              key={conv.id}
              className={`${styles.convItem} ${activeConvId === conv.id ? styles.convItemActive : ''}`}
              onClick={() => setActiveConvId(conv.id)}
            >
              <div className={styles.convAvatarWrap}>
                <img src={conv.avatar} alt={conv.name} className="avatar avatar-md" />
                {conv.online && <span className={styles.onlineDot} />}
              </div>
              <div className={styles.convInfo}>
                <div className={styles.convInfoTop}>
                  <span className={styles.convName}>{conv.name}</span>
                  <span className={styles.convTime}>{conv.time}</span>
                </div>
                <div className={styles.convInfoBottom}>
                  <span className={styles.convLastMsg}>{conv.lastMsg}</span>
                  {conv.unread > 0 && (
                    <span className={styles.unreadBadge}>{conv.unread}</span>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* ── Chat Area ── */}
      <div className={styles.chatArea}>
        {/* Chat Header */}
        <div className={styles.chatHeader}>
          <div className={styles.chatHeaderLeft}>
            <div className={styles.chatAvatarWrap}>
              <img src={activeConv?.avatar} alt={activeConv?.name} className="avatar avatar-md" />
              {activeConv?.online && <span className={styles.onlineDot} />}
            </div>
            <div>
              <span className={styles.chatName}>{activeConv?.name}</span>
              <span className={styles.chatStatus}>{activeConv?.online ? '🟢 Online' : 'Last seen recently'}</span>
            </div>
          </div>
          <div className={styles.chatHeaderActions}>
            <button className={styles.chatActionBtn}><Phone size={17} /></button>
            <button className={styles.chatActionBtn}><Video size={17} /></button>
            <button className={styles.chatActionBtn}><MoreHorizontal size={17} /></button>
          </div>
        </div>

        {/* Messages */}
        <div className={styles.messagesArea}>
          <div className={styles.dateLabel}>Today</div>
          {currentMessages.map(msg => (
            <div
              key={msg.id}
              className={`${styles.msgRow} ${msg.sender === 'me' ? styles.msgRowMe : ''}`}
            >
              {msg.sender === 'them' && (
                <img src={activeConv?.avatar} alt="" className="avatar avatar-sm" style={{ flexShrink: 0 }} />
              )}
              <div className={styles.msgBubbleWrap}>
                <div className={`${styles.msgBubble} ${msg.sender === 'me' ? styles.msgBubbleMe : styles.msgBubbleThem}`}>
                  {msg.content}
                </div>
                <span className={styles.msgTime}>{msg.time}</span>
              </div>
            </div>
          ))}
          <div ref={messagesEndRef} />
        </div>

        {/* Input */}
        <div className={styles.inputArea}>
          <button className={styles.inputAction}><Smile size={20} /></button>
          <input
            type="text"
            placeholder={`Message ${activeConv?.name}…`}
            className={styles.msgInput}
            value={input}
            onChange={e => setInput(e.target.value)}
            onKeyDown={handleKey}
          />
          <button
            className={`${styles.sendBtn} ${input.trim() ? styles.sendBtnActive : ''}`}
            onClick={sendMessage}
            disabled={!input.trim()}
          >
            <Send size={18} />
          </button>
        </div>
      </div>
    </div>
  );
}
