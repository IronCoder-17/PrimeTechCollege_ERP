// ============================================
// TrendingWidget
// ============================================

import { TrendingUp, Hash } from 'lucide-react';
import styles from './Widgets.module.css';

const TRENDS = [
  { tag: 'SpringHackathon', posts: 234 },
  { tag: 'CampusLife', posts: 189 },
  { tag: 'Finals2025', posts: 156 },
  { tag: 'GSoC', posts: 98 },
  { tag: 'CareerFair', posts: 87 },
  { tag: 'StudyGroup', posts: 72 },
];

export default function TrendingWidget() {
  return (
    <div className={`${styles.widget} card`}>
      <div className={styles.widgetHeader}>
        <TrendingUp size={16} color="var(--blue-600)" />
        <span className={styles.widgetTitle}>Trending on Campus</span>
      </div>
      <div className={styles.trendList}>
        {TRENDS.map((t, i) => (
          <div key={t.tag} className={styles.trendItem}>
            <div className={styles.trendRank}>{i + 1}</div>
            <div className={styles.trendInfo}>
              <span className={styles.trendTag}>#{t.tag}</span>
              <span className={styles.trendCount}>{t.posts} posts</span>
            </div>
            <Hash size={14} className={styles.trendIcon} />
          </div>
        ))}
      </div>
    </div>
  );
}
