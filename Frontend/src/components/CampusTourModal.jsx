// ============================================================
// CampusTourModal — Full-screen campus tour video overlay
// ============================================================
// Usage: <CampusTourModal onClose={() => setShowTour(false)} />
// The modal auto-plays the video and provides a Skip button
// in the bottom-left corner that stops playback and closes.
// ============================================================

import { useEffect, useRef } from 'react';
import styles from './CampusTourModal.module.css';

// ── Campus tour video (local asset) ───────────────────────
import campusTourVideo from '../assets/PrimeTech_College.mp4'; // placeholder

export default function CampusTourModal({ onClose }) {
  const videoRef = useRef(null);

  // Auto-play as soon as the modal mounts
  useEffect(() => {
    if (videoRef.current) {
      videoRef.current.play().catch(() => {
        // Browsers may block autoplay without user gesture — silently ignore
      });
    }
  }, []);

  // Allow closing with the Escape key
  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape') handleSkip();
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, []);

  // Stop video immediately and close the modal
  const handleSkip = () => {
    if (videoRef.current) {
      videoRef.current.pause();
      videoRef.current.src = ''; // Release the media resource
    }
    onClose();
  };

  // Close when clicking the dark backdrop (not the video itself)
  const handleOverlayClick = (e) => {
    if (e.target === e.currentTarget) handleSkip();
  };

  return (
    <div
      className={styles.overlay}
      role="dialog"
      aria-modal="true"
      aria-label="Campus Tour Video"
      onClick={handleOverlayClick}
    >
      {/* ── Video player ── */}
      <div className={styles.playerWrapper}>
        <video
          ref={videoRef}
          className={styles.video}
          controls
          autoPlay
          playsInline
          /* Muted is required by most browsers to allow autoplay.
             Remove 'muted' if autoplay is triggered by a user gesture
             and you need audio from the very start. */
          muted={false}
          preload="auto"
        >
          <source src={campusTourVideo} type="video/mp4" />
          Your browser does not support the video tag.
        </video>

        {/* ── Skip button — bottom-left, always visible ── */}
        <button
          className={styles.skipBtn}
          onClick={handleSkip}
          aria-label="Skip campus tour and return to homepage"
        >
          <span className={styles.skipIcon}>✕</span>
          Skip Tour
        </button>
      </div>
    </div>
  );
}

/*
 * ── Using a YouTube / Vimeo embed instead of a raw video file ──
 *
 * Replace the <video> block above with an <iframe>:
 *
 * <iframe
 *   className={styles.video}
 *   src="https://www.youtube.com/embed/YOUR_VIDEO_ID?autoplay=1&rel=0"
 *   title="Campus Tour"
 *   allow="autoplay; fullscreen"
 *   allowFullScreen
 * />
 *
 * For YouTube, append ?autoplay=1 to the embed URL.
 * The skip handler remains identical — just remove the videoRef logic.
 */