// ============================================
// SuggestedPeople Widget
// ============================================

import { useState } from 'react';
import { UserPlus, Check } from 'lucide-react';
import styles from './Widgets.module.css';

const PEOPLE = [
  {
    id: 2,
    name: 'Maya Patel',
    major: 'Biology · Sophomore',
    avatar: 'https://images.unsplash.com/photo-1494790108755-2616b332c36a?w=60&h=60&fit=crop&crop=face',
    mutual: 12,
  },
  {
    id: 3,
    name: 'Jordan Lee',
    major: 'Business · Senior',
    avatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=60&h=60&fit=crop&crop=face',
    mutual: 8,
  },
  {
    id: 4,
    name: 'Priya Sharma',
    major: 'Design · Junior',
    avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=60&h=60&fit=crop&crop=face',
    mutual: 5,
  },
  {
    id: 5,
    name: 'Carlos Rivera',
    major: 'Engineering · Senior',
    avatar: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=60&h=60&fit=crop&crop=face',
    mutual: 3,
  },
];

export default function SuggestedPeople() {
  const [followed, setFollowed] = useState(new Set());

  const toggle = (id) => {
    setFollowed(s => {
      const n = new Set(s);
      n.has(id) ? n.delete(id) : n.add(id);
      return n;
    });
  };

  return (
    <div className={`${styles.widget} card`}>
      <div className={styles.widgetHeader}>
        <UserPlus size={16} color="var(--blue-600)" />
        <span className={styles.widgetTitle}>People You May Know</span>
      </div>
      <div className={styles.peopleList}>
        {PEOPLE.map(p => (
          <div key={p.id} className={styles.personItem}>
            <img src={p.avatar} alt={p.name} className="avatar avatar-sm" style={{ flexShrink: 0 }} />
            <div className={styles.personInfo}>
              <span className={styles.personName}>{p.name}</span>
              <span className={styles.personMeta}>{p.major}</span>
              <span className={styles.personMutual}>{p.mutual} mutual friends</span>
            </div>
            <button
              className={`${styles.followBtn} ${followed.has(p.id) ? styles.followBtnActive : ''}`}
              onClick={() => toggle(p.id)}
            >
              {followed.has(p.id)
                ? <><Check size={13} /> Following</>
                : <><UserPlus size={13} /> Follow</>}
            </button>
          </div>
        ))}
      </div>
    </div>
  );
}
