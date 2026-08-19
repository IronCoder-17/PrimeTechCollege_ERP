import { useState } from 'react';
import { Briefcase, ArrowUpRight, Search } from 'lucide-react';
import styles from './PlacementsPage.module.css';

const placements = [
  { company:'Google',     role:'SDE Intern',          ctc:'₹80k/mo',  deadline:'Jun 15',  tags:['FAANG','Remote'],       logo:'G', color:'#4285F4', type:'intern' },
  { company:'Microsoft',  role:'SWE Intern',          ctc:'₹75k/mo',  deadline:'Jun 18',  tags:['FAANG','Hybrid'],       logo:'M', color:'#00a1f1', type:'intern' },
  { company:'Infosys',    role:'Systems Engineer',    ctc:'₹4.5 LPA', deadline:'Jun 20',  tags:['On-campus','Full-time'],logo:'I', color:'#007cc3', type:'fulltime' },
  { company:'Razorpay',   role:'Backend Engineer',    ctc:'₹18 LPA',  deadline:'Jun 18',  tags:['Fintech','Full-time'],  logo:'R', color:'#2D9CDB', type:'fulltime' },
  { company:'Adobe',      role:'Product Intern',      ctc:'₹60k/mo',  deadline:'Jun 25',  tags:['Design','Tech'],        logo:'A', color:'#FF0000', type:'intern' },
  { company:'Wipro',      role:'Project Engineer',    ctc:'₹3.5 LPA', deadline:'Jun 28',  tags:['On-campus','Service'],  logo:'W', color:'#8B4513', type:'fulltime' },
  { company:'Zepto',      role:'SDE-1',               ctc:'₹22 LPA',  deadline:'Jul 2',   tags:['Startup','Full-time'],  logo:'Z', color:'#9333ea', type:'fulltime' },
  { company:'Deloitte',   role:'Analyst',             ctc:'₹7 LPA',   deadline:'Jul 5',   tags:['Consulting','On-site'], logo:'D', color:'#86BC25', type:'fulltime' },
];

export default function PlacementsPage() {
  const [filter, setFilter] = useState('all');
  const [search, setSearch] = useState('');
  const shown = placements.filter(p =>
    (filter==='all'||p.type===filter) &&
    (p.company.toLowerCase().includes(search.toLowerCase())||p.role.toLowerCase().includes(search.toLowerCase()))
  );
  return (
    <div className={styles.page}>
      <div className={styles.pageHeader}>
        <Briefcase size={22} color="var(--dark-beige)" />
        <h1 className={styles.pageTitle}>Placements & Internships</h1>
      </div>
      <div className={styles.controls}>
        <div className={styles.searchWrap}>
          <Search size={15} className={styles.searchIcon} />
          <input className={styles.searchInput} placeholder="Search company or role..." value={search} onChange={e=>setSearch(e.target.value)} />
        </div>
        <div className={styles.filters}>
          {['all','intern','fulltime'].map(f=>(
            <button key={f} className={`${styles.filterBtn} ${filter===f?styles.filterActive:''}`} onClick={()=>setFilter(f)}>
              {f==='all'?'All':f==='intern'?'Internships':'Full-time'}
            </button>
          ))}
        </div>
      </div>
      <div className={styles.grid}>
        {shown.map((p,i)=>(
          <div key={i} className={`${styles.placementCard} card`}>
            <div className={styles.cardTop}>
              <div className={styles.compLogo} style={{background:p.color+'22',color:p.color}}>{p.logo}</div>
              <div className={styles.compInfo}>
                <span className={styles.compName}>{p.company}</span>
                <span className={styles.compRole}>{p.role}</span>
              </div>
              <div className={styles.ctcBadge}>{p.ctc}</div>
            </div>
            <div className={styles.tagRow}>
              {p.tags.map(t=><span key={t} className={styles.tag}>{t}</span>)}
            </div>
            <div className={styles.cardBottom}>
              <span className={styles.deadline}>📅 Deadline: {p.deadline}</span>
              <button className={styles.applyBtn}><ArrowUpRight size={14} /> Apply Now</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
