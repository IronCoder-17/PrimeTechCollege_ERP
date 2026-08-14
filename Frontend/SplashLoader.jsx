// ============================================================
// SplashLoader — Premium top/bottom split-reveal splash screen
// Shown once on initial application load (1.5s), then unmounts.
// ============================================================

import { useEffect, useState, useRef } from 'react';
import styles from './SplashLoader.module.css';
import primetechLogo from '../assets/primetech-logo.png';

const DISPLAY_MS = 1500;   // time the panels stay closed
const EXIT_MS = 650;       // panel slide-out + fade duration (must match CSS)

export default function SplashLoader({ onFinished }) {
  // 'enter' -> 'exit' -> unmounted
  const [phase, setPhase] = useState('enter');
  const finishedRef = useRef(false);

  useEffect(() => {
    // Lock scroll while the splash is up — avoids any layout shift/flicker
    const prevOverflow = document.documentElement.style.overflow;
    document.documentElement.style.overflow = 'hidden';

    const exitTimer = setTimeout(() => setPhase('exit'), DISPLAY_MS);

    const removeTimer = setTimeout(() => {
      document.documentElement.style.overflow = prevOverflow;
      if (!finishedRef.current) {
        finishedRef.current = true;
        onFinished?.();
      }
    }, DISPLAY_MS + EXIT_MS);

    return () => {
      clearTimeout(exitTimer);
      clearTimeout(removeTimer);
      document.documentElement.style.overflow = prevOverflow;
    };
  }, [onFinished]);

  return (
    <div
      className={`${styles.splash} ${phase === 'exit' ? styles.splashExit : ''}`}
      role="status"
      aria-label="Loading PrimeTech College"
      aria-live="polite"
    >
      <div className={`${styles.panel} ${styles.panelTop}`} />
      <div className={`${styles.panel} ${styles.panelBottom}`} />

      <div className={styles.logoWrap}>
        <img
          src={primetechLogo}
          alt="PrimeTech College"
          className={styles.logo}
          draggable="false"
        />
        <div className={styles.glowRing} />
      </div>
    </div>
  );
}
