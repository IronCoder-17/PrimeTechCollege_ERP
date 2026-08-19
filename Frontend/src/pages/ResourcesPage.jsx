import { useState } from 'react';
import { BookOpen, Download, Search } from 'lucide-react';
import styles from './ResourcesPage.module.css';

const resources = [
  { title:'DSA Complete Notes (Unit 1-5)',   type:'PDF',   subject:'DSA',  size:'4.2 MB', icon:'📄', uploaded:'Dr. Priya Shah',    date:'Jun 1' },
  { title:'DBMS Previous Year Questions',   type:'PDF',   subject:'DBMS', size:'2.1 MB', icon:'📝', uploaded:'Prof. Amit Patel',  date:'May 28' },
  { title:'OS Lecture Recordings — Unit 3', type:'Video', subject:'OS',   size:'1.8 GB', icon:'🎬', uploaded:'Prof. Meera Joshi', date:'May 25' },
  { title:'CN Textbook (Forouzan 7th Ed)',  type:'eBook', subject:'CN',   size:'22 MB',  icon:'📚', uploaded:'Library',           date:'Jan 1' },
  { title:'Software Engineering Notes',     type:'PDF',   subject:'SE',   size:'3.5 MB', icon:'📄', uploaded:'Dr. Suresh Nair',   date:'May 30' },
  { title:'DSA Quiz Questions Bank',        type:'PDF',   subject:'DSA',  size:'1.2 MB', icon:'📝', uploaded:'Dr. Priya Shah',    date:'Jun 3' },
  { title:'DBMS Lab Manual',               type:'PDF',   subject:'DBMS', size:'856 KB', icon:'📄', uploaded:'Prof. Amit Patel',  date:'Apr 15' },
  { title:'OS PYQ 2023-2024',              type:'PDF',   subject:'OS',   size:'2.3 MB', icon:'📝', uploaded:'Dept. Office',      date:'Mar 10' },
  { title:'CN Lab Experiments',            type:'PDF',   subject:'CN',   size:'1.4 MB', icon:'📄', uploaded:'Dr. Ravi Kumar',    date:'May 5' },
  { title:'SE Case Study Materials',       type:'ZIP',   subject:'SE',   size:'15 MB',  icon:'📦', uploaded:'Dr. Suresh Nair',   date:'May 20' },
];
const subjects = ['All','DSA','DBMS','OS','CN','SE'];
const typeColor = { PDF:'#e05a5a', Video:'#7c3aed', eBook:'#10b981', ZIP:'#C9963C' };

export default function ResourcesPage() {
  const [subj, setSubj] = useState('All');
  const [search, setSearch] = useState('');
  const shown = resources.filter(r =>
    (subj==='All'||r.subject===subj) &&
    r.title.toLowerCase().includes(search.toLowerCase())
  );
  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <BookOpen size={22} color="var(--dark-beige)" />
        <h1 className={styles.pageTitle}>Study Resources</h1>
      </div>
      <div className={styles.controls}>
        <div className={styles.searchWrap}>
          <Search size={15} className={styles.searchIcon} />
          <input className={styles.searchInput} placeholder="Search resources..." value={search} onChange={e=>setSearch(e.target.value)} />
        </div>
        <div className={styles.subjectTabs}>
          {subjects.map(s=><button key={s} className={`${styles.subjectBtn} ${s===subj?styles.subjectActive:''}`} onClick={()=>setSubj(s)}>{s}</button>)}
        </div>
      </div>
      <div className={styles.resourceGrid}>
        {shown.map((r,i)=>(
          <div key={i} className={`${styles.resourceCard} card`}>
            <div className={styles.cardLeft}>
              <span className={styles.resIcon}>{r.icon}</span>
              <div className={styles.resInfo}>
                <span className={styles.resTitle}>{r.title}</span>
                <span className={styles.resMeta}>By {r.uploaded} · {r.date} · {r.size}</span>
                <div className={styles.resTags}>
                  <span className={styles.resSubject}>{r.subject}</span>
                  <span className={styles.resType} style={{color:typeColor[r.type]||'var(--charcoal-400)',background:(typeColor[r.type]||'var(--charcoal-400)')+'18'}}>{r.type}</span>
                </div>
              </div>
            </div>
            <button className={styles.downloadBtn}><Download size={15} /></button>
          </div>
        ))}
      </div>
    </div>
  );
}
