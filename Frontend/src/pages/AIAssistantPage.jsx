// ============================================
// AIAssistantPage — Student AI Academic Assistant
// Talks to backend/api/ai-assistant.php, which forwards to
// OpenRouter.ai. The OpenRouter API key never touches this file
// or any other frontend code.
// ============================================

import { useState, useRef, useEffect } from 'react';
import { Sparkles, Send, Trash2, AlertCircle } from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import { aiAssistantApi } from '../utils/api';
import styles from './AIAssistantPage.module.css';

const SUGGESTED_PROMPTS = [
  'Explain database normalization with an example',
  'Help me make a study plan for my upcoming exams',
  'What is the difference between stack and queue?',
  'How do I write a good assignment introduction?',
];

export default function AIAssistantPage() {
  const [messages, setMessages] = useState([]); // { role, content, error? }
  const [input, setInput] = useState('');
  const [sending, setSending] = useState(false);
  const textareaRef = useRef(null);
  const endRef = useRef(null);

  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, sending]);

  const autoGrow = () => {
    const el = textareaRef.current;
    if (!el) return;
    el.style.height = 'auto';
    el.style.height = Math.min(el.scrollHeight, 140) + 'px';
  };

  const sendPrompt = async (text) => {
    const trimmed = (text ?? input).trim();
    if (!trimmed || sending) return;

    const nextMessages = [...messages, { role: 'user', content: trimmed }];
    setMessages(nextMessages);
    setInput('');
    setSending(true);
    requestAnimationFrame(autoGrow);

    try {
      const conversationPayload = nextMessages
        .filter(m => !m.error)
        .map(m => ({ role: m.role, content: m.content }));

      const { data } = await aiAssistantApi.chat(conversationPayload);
      setMessages(prev => [...prev, { role: 'assistant', content: data.message.content }]);
    } catch (err) {
      const errText = err.response?.data?.error || 'Something went wrong while reaching the AI Assistant. Please try again.';
      setMessages(prev => [...prev, { role: 'assistant', content: errText, error: true }]);
    } finally {
      setSending(false);
    }
  };

  const handleKey = (e) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendPrompt();
    }
  };

  const clearConversation = () => {
    if (sending) return;
    setMessages([]);
  };

  return (
    <div className={styles.wrap}>
      {/* Header */}
      <div className={styles.header}>
        <div className={styles.headerLeft}>
          <div className={styles.aiAvatar}><Sparkles size={20} /></div>
          <div>
            <span className={styles.title}>AI Assistant</span>
            <span className={styles.subtitle}>Your academic study companion</span>
          </div>
        </div>
        <button className={styles.clearBtn} onClick={clearConversation} disabled={messages.length === 0 || sending}>
          <Trash2 size={14} /> Clear
        </button>
      </div>

      {/* Messages */}
      <div className={styles.messagesArea}>
        {messages.length === 0 ? (
          <div className={styles.emptyState}>
            <div className={styles.emptyIcon}><Sparkles size={26} /></div>
            <div className={styles.emptyTitle}>Hi, I'm your campus AI Assistant 👋</div>
            <p className={styles.emptyText}>
              Ask me about course concepts, programming, exam prep, assignments, or study planning.
              I can't see your actual marks, attendance, fees, or timetable — for that, check the
              relevant page or ask your faculty.
            </p>
            <div className={styles.suggestionChips}>
              {SUGGESTED_PROMPTS.map((p) => (
                <button key={p} className={styles.chip} onClick={() => sendPrompt(p)}>{p}</button>
              ))}
            </div>
          </div>
        ) : (
          messages.map((m, i) => (
            <div key={i} className={`${styles.msgRow} ${m.role === 'user' ? styles.msgRowMe : ''}`}>
              {m.role === 'assistant' && (
                <div className={styles.msgAvatar}>
                  {m.error ? <AlertCircle size={15} /> : <Sparkles size={15} />}
                </div>
              )}
              <div className={styles.msgBubbleWrap}>
                <div
                  className={`${styles.msgBubble} ${
                    m.role === 'user' ? styles.msgBubbleMe : m.error ? styles.msgBubbleError : styles.msgBubbleThem
                  }`}
                >
                  {m.role === 'assistant' && !m.error ? (
                    <div className={styles.markdown}>
                      <ReactMarkdown>{m.content}</ReactMarkdown>
                    </div>
                  ) : (
                    m.content
                  )}
                </div>
              </div>
            </div>
          ))
        )}

        {sending && (
          <div className={styles.msgRow}>
            <div className={styles.msgAvatar}><Sparkles size={15} /></div>
            <div className={styles.msgBubbleWrap}>
              <div className={`${styles.msgBubble} ${styles.msgBubbleThem}`}>
                <div className={styles.typingRow}>
                  <span className={styles.typingDot} />
                  <span className={styles.typingDot} />
                  <span className={styles.typingDot} />
                </div>
              </div>
            </div>
          </div>
        )}
        <div ref={endRef} />
      </div>

      {/* Input */}
      <div className={styles.inputArea}>
        <textarea
          ref={textareaRef}
          rows={1}
          placeholder="Ask the AI Assistant anything about your studies…"
          className={styles.msgInput}
          value={input}
          onChange={(e) => { setInput(e.target.value); autoGrow(); }}
          onKeyDown={handleKey}
          disabled={sending}
        />
        <button
          className={`${styles.sendBtn} ${input.trim() ? styles.sendBtnActive : ''}`}
          onClick={() => sendPrompt()}
          disabled={!input.trim() || sending}
        >
          <Send size={18} />
        </button>
      </div>
      <div className={styles.hint}>Enter to send · Shift+Enter for a new line</div>
    </div>
  );
}