import { useState } from 'react';
import { Bell, CheckCheck } from 'lucide-react';
import styles from './NotificationsPage.module.css';

const ALL_NOTIFS = [
  { type:'college', title:'Annual Sports Day registration open', body:'Register for various events by June 12. Prizes worth ₹50,000.', time:'2h ago', read:false },
  { type:'faculty',  title:'DBMS assignment deadline extended', body:'Assignment 3 deadline moved from Jun 12 to Jun 14. Please note.', time:'5h ago', read:false },
  { type:'event',    title:'TechFest 2026 — Team registration closes today', body:'Last day to register your team for TechFest. Hurry!', time:'1d ago', read:true },
  { type:'club',     title:'Coding Club: Hackathon this weekend', body:'24-hour hackathon at CB Hall. Food provided. Register at codingclub.primetech.edu', time:'2d ago', read:true },
  { type:'college',  title:'New E-library resources added', body:'50+ new textbooks and reference materials uploaded for Sem 5.', time:'3d ago', read:true },
  { type:'faculty',  title:'Quiz scheduled for OS on Jun 10', body:'Unit 3 & 4 syllabus. Bring your ID cards.', time:'3d ago', read:true },
];

const typeIcon = { college:'🏫', faculty:'👨‍🏫', event:'🎉', club:'🎯' };
const typeLabel = { college:'College', faculty:'Faculty', event:'Events', club:'Clubs' };

export default function NotificationsPage() {
  const [filter, setFilter] = useState('all');
  const [notifs, setNotifs] = useState(ALL_NOTIFS);
  const filters = ['all','college','faculty','event','club'];
  const shown = filter === 'all' ? notifs : notifs.filter(n => n.type === filter);
  const markAll = () => setNotifs(notifs.map(n=>({...n,read:true})));
  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <Bell size={22} color="var(--dark-beige)" />
        <h1 className={styles.pageTitle}>Notifications</h1>
        <button className={styles.markAllBtn} onClick={markAll}><CheckCheck size={14} /> Mark all read</button>
      </div>
      <div className={styles.filterRow}>
        {filters.map(f=>(
          <button key={f} className={`${styles.filterBtn} ${filter===f?styles.filterActive:''}`} onClick={()=>setFilter(f)}>
            {f==='all'?'All':typeLabel[f]}
          </button>
        ))}
      </div>
      <div className={styles.notifList}>
        {shown.map((n,i)=>(
          <div key={i} className={`${styles.notifCard} card ${!n.read?styles.unread:''}`} onClick={()=>setNotifs(notifs.map((x,xi)=>xi===notifs.indexOf(n)?{...x,read:true}:x))}>
            <span className={styles.notifEmoji}>{typeIcon[n.type]}</span>
            <div className={styles.notifContent}>
              <span className={styles.notifTitle}>{n.title}</span>
              <span className={styles.notifBody}>{n.body}</span>
              <div className={styles.notifMeta}>
                <span className={styles.notifType}>{typeLabel[n.type]}</span>
                <span className={styles.notifTime}>{n.time}</span>
              </div>
            </div>
            {!n.read && <div className={styles.unreadDot} />}
          </div>
        ))}
      </div>
    </div>
  );
}
