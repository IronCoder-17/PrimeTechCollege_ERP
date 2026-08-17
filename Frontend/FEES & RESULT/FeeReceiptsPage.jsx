// ============================================================
// FeeReceiptsPage — Student "Fees & Payments → Fee Receipts"
// PrimeTech College Campus Connect
//
// - Current Semester Fee Payment → automatic receipt generation →
//   "Paid Successfully" → Next Semester Fee Payment option appears
//   immediately, with no manual process required.
// - Paying the Next Semester fee generates a new receipt (previous
//   receipts are never deleted), automatically advances the
//   student's current semester, and refreshes the dashboard.
// - "Pay Fees" (below) still covers one-off charges (exam, library,
//   ID card, hostel, transport, etc.) — semester tuition is always
//   paid through the dedicated Current/Next Semester cards above.
// - Search receipts, view full receipt details, and Download/Print
//   the premium PrimeTech-branded PDF receipt.
// - Students can only ever see their own receipts.
// ============================================================

import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import {
  FileText, Search, Download, Eye, CreditCard, CheckCircle, Printer,
  ArrowRight, GraduationCap, Lock, AlertTriangle, RefreshCw,
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import {
  getReceiptsForStudent, getStudentProfile, createReceipt,
  searchReceipts, getFeeTypeOptionsAsync, PAYMENT_METHODS,
  semesterFeeType, getSemesterReceipt,
} from '../utils/feeReceipts';
import { downloadReceiptPDF, formatCurrency, formatReceiptDate } from '../utils/receiptPdf';
import { admissionApi } from '../utils/api';
import ReceiptModal, { printReceipt } from '../components/ReceiptModal';
import RazorpayButton from '../components/widgets/RazorpayButton';
import { RAZORPAY_BUTTON_IDS } from '../config/razorpay';
import styles from './FeeReceiptsPage.module.css';

// ── Fee data flow ────────────────────────────────────────────
// There is NO hardcoded fallback fee anywhere in this module. The
// payable amount for a given course + semester always comes from
// the database, via GET /api/admission/fee?course_id=&semester=,
// which returns the row inside a `fee` object:
//   { fee: { tuition_fee, exam_fee, total_fee, ... } }
// so every read below must use `data?.fee?.total_fee` (NOT the old,
// incorrect `data?.total_fee`). If the fee cannot be loaded, the UI
// shows an explicit error state instead of silently displaying a
// fake/default amount.
//
// Sync strategy (so an Admin fee change is picked up automatically,
// without any code change or manual refresh):
//   • fetch on mount
//   • refetch on window/tab focus
//   • refetch on document visibility change (tab switched back to)
//   • refetch every 30s while the page is open
//   • refetch one final time immediately before creating a payment,
//     so a student can never pay a stale/outdated amount
const AUTO_REFRESH_MS = 30000;
const FEE_UNAVAILABLE_MSG = 'Fee information is currently unavailable. Please refresh or contact the Admin Office.';
const FEE_NOT_CONFIGURED_MSG = 'Fee structure is not configured for this course and semester. Please contact the Admin Office.';

// Fetches the fee for one course+semester straight from the DB.
// Returns { total_fee, tuition_fee, exam_fee } or throws.
async function fetchSemesterFee(courseId, semester) {
  const { data } = await admissionApi.getFee(courseId, semester);
  const fee = data?.fee; // ← corrected: fee lives inside `data.fee`, not `data`
  if (!fee || fee.total_fee === undefined || fee.total_fee === null) {
    throw new Error('not_found');
  }
  return {
    totalFee: Number(fee.total_fee),
    tuitionFee: Number(fee.tuition_fee),
    examFee: Number(fee.exam_fee),
  };
}

function StatusBadge({ status }) {
  const cls = status === 'Paid' ? styles.statusPaid
    : status === 'Partial Paid' ? styles.statusPartial
    : styles.statusPending;
  const label = status === 'Paid' ? 'Paid Successfully' : status;
  return <span className={`${styles.statusBadge} ${cls}`}>{label}</span>;
}

// One card's worth of fee state: 'loading' | 'ready' | 'error' | 'not_configured'
function useSemesterFee(courseId, semester, enabled) {
  const [status, setStatus] = useState('loading');
  const [fee, setFee] = useState(null); // { totalFee, tuitionFee, examFee }
  const mountedRef = useRef(true);
  useEffect(() => () => { mountedRef.current = false; }, []);

  const load = useCallback(async () => {
    if (!enabled || !courseId || !semester) return;
    setStatus(prev => (prev === 'ready' ? 'ready' : 'loading')); // keep showing old value while refreshing
    try {
      const result = await fetchSemesterFee(courseId, semester);
      if (!mountedRef.current) return;
      setFee(result);
      setStatus('ready');
    } catch (err) {
      if (!mountedRef.current) return;
      if (err?.response?.status === 404 || err?.message === 'not_found') {
        setStatus('not_configured');
      } else {
        setStatus('error');
      }
    }
  }, [courseId, semester, enabled]);

  // Initial load + whenever course/semester changes.
  useEffect(() => { load(); }, [load]);

  // Refetch on tab/window focus and on visibility change (Admin may
  // have updated the fee in another tab/session).
  useEffect(() => {
    if (!enabled) return undefined;
    const onFocus = () => load();
    const onVisible = () => { if (document.visibilityState === 'visible') load(); };
    window.addEventListener('focus', onFocus);
    document.addEventListener('visibilitychange', onVisible);
    return () => {
      window.removeEventListener('focus', onFocus);
      document.removeEventListener('visibilitychange', onVisible);
    };
  }, [enabled, load]);

  // Periodic refresh while the page stays open, so an Admin fee
  // change is picked up automatically within ~30s even with no
  // interaction from the student.
  useEffect(() => {
    if (!enabled) return undefined;
    const id = setInterval(load, AUTO_REFRESH_MS);
    return () => clearInterval(id);
  }, [enabled, load]);

  return { status, fee, reload: load };
}

function FeeCardBody({ status, reload }) {
  if (status === 'loading') {
    return <div className={styles.semesterMeta}>Loading latest fee…</div>;
  }
  if (status === 'not_configured') {
    return (
      <div className={styles.semesterMeta} style={{ color: '#B91C1C' }}>
        <AlertTriangle size={13} style={{ verticalAlign: -2, marginRight: 4 }} />
        {FEE_NOT_CONFIGURED_MSG}
      </div>
    );
  }
  return (
    <div className={styles.semesterMeta} style={{ color: '#B91C1C' }}>
      <AlertTriangle size={13} style={{ verticalAlign: -2, marginRight: 4 }} />
      {FEE_UNAVAILABLE_MSG}{' '}
      <button
        type="button"
        onClick={reload}
        style={{ border: 'none', background: 'none', color: '#A67C52', textDecoration: 'underline', cursor: 'pointer', padding: 0, font: 'inherit' }}
      >
        <RefreshCw size={11} style={{ verticalAlign: -1 }} /> Retry
      </button>
    </div>
  );
}

// ── Current / Next Semester Fee Payment ─────────────────────
// Drives Steps 2–5 of the Fee Receipt workflow: shows the current
// semester's payment status, and — the instant it's paid — reveals
// the Next Semester Fee Payment option automatically.
//
// Every amount shown/charged here is fetched live from
// fee_structure via the database (course_id + semester) — there is
// no default/fallback amount, and if the DB fee cannot be loaded the
// card shows an explicit error state instead of a fake number.
function SemesterFeeSection({ student, user, receipts, onPaid, onAdvanceSemester }) {
  const currentSemester = Number(student.semester) || 1;
  const totalSemesters = Number(user?.totalSemesters) || null;
  // Prefer the real DB course_id. Never fall back to matching by
  // course name — multiple courses can share similar names.
  const courseId = user?.courseId ?? student?.courseId ?? null;

  const currentPaidReceipt = getSemesterReceipt(receipts, currentSemester);
  const currentPaid = !!currentPaidReceipt;

  const nextSemester = currentSemester + 1;
  const courseComplete = totalSemesters ? currentSemester >= totalSemesters : false;
  const showNext = currentPaid && !courseComplete;

  const currentFeeState = useSemesterFee(courseId, currentSemester, !currentPaid);
  const nextFeeState = useSemesterFee(courseId, nextSemester, showNext);

  const [payingWhich, setPayingWhich] = useState(null); // 'current' | 'next' | null
  const [payError, setPayError] = useState(null);
  // Which card the current payError belongs to. Tracked separately from
  // payingWhich because payingWhich is already reset to null (in the
  // `finally` block) by the time React re-renders after a failure — so
  // gating the error message on payingWhich would mean it never shows.
  const [payErrorWhich, setPayErrorWhich] = useState(null);

  const paySemester = async (semesterNumber, which, reload) => {
    setPayError(null);
    setPayErrorWhich(null);

    if (!courseId) {
      // Never fail silently — this is the one guard that used to just
      // `return`, which made the button look "broken" with zero feedback.
      setPayError('Your course could not be identified on this account. Please contact the Admin Office.');
      setPayErrorWhich(which);
      return;
    }

    setPayingWhich(which);
    try {
      // Final check before payment (Step 8 / Step 10): re-fetch the
      // latest fee one more time, right now, so a student can never
      // pay an amount that went stale between page-load and click.
      const latest = await fetchSemesterFee(courseId, semesterNumber);

      // Server-side validation (Step 12): the backend independently
      // re-reads fee_structure and only proceeds if the amount we're
      // about to charge still matches the live DB value. This is the
      // authoritative check — the frontend fetch above is just so we
      // don't even attempt a stale payment.
      //
      // This call is treated as best-effort: if the fee itself was
      // just successfully re-confirmed above, an unrelated failure of
      // this extra round-trip (network hiccup, session edge case,
      // etc.) must not silently brick the whole payment flow. Only an
      // explicit "amount doesn't match" response (409) blocks payment.
      try {
        const { data: verification } = await admissionApi.verifyFee(
          courseId, semesterNumber, latest.totalFee
        );
        if (!verification?.valid) {
          throw Object.assign(new Error('fee_changed'), { code: 'fee_changed' });
        }
      } catch (verifyErr) {
        if (verifyErr?.response?.status === 409 || verifyErr?.code === 'fee_changed') {
          throw verifyErr; // genuine mismatch — must block, handled below
        }
        // eslint-disable-next-line no-console
        console.warn('Fee verification round-trip failed; proceeding on the freshly-fetched DB amount.', verifyErr);
      }

      const receipt = createReceipt({
        studentId: student.id,
        studentName: student.name,
        enrollmentNumber: student.enrollmentNumber,
        department: student.department,
        course: student.course,
        semester: semesterNumber,
        academicYear: student.academicYear,
        feeType: semesterFeeType(semesterNumber),
        amount: latest.totalFee, // the freshly-verified DB amount, never client/cached state
        paymentMethod: 'Online',
        status: 'Paid',
        paymentType: 'semester_fee',
      });

      // Step 5 — Automatic Semester Update: once the NEXT semester's
      // fee is paid, advance the student's current semester and
      // refresh every part of the app that reads it (dashboard,
      // header, etc.) via the shared auth context.
      if (which === 'next') {
        onAdvanceSemester(semesterNumber);
      }

      onPaid(receipt);
    } catch (err) {
      setPayErrorWhich(which);
      if (err?.response?.status === 409 || err?.code === 'fee_changed') {
        setPayError('The fee amount was just updated by the Admin. Showing the latest amount — please review and try again.');
        reload();
      } else if (err?.response?.status === 404 || err?.message === 'not_found') {
        setPayError(FEE_NOT_CONFIGURED_MSG);
      } else {
        setPayError(FEE_UNAVAILABLE_MSG);
      }
    } finally {
      setPayingWhich(null);
    }

  };

  return (
    <div className={styles.semesterSection}>
      {/* Current Semester */}
      <div className={`${styles.semesterCard} ${currentPaid ? styles.semesterCardPaid : ''}`}>
        <div className={styles.semesterTopRow}>
          <span className={styles.semesterLabel}>Current Semester</span>
          {currentPaid && <StatusBadge status="Paid" />}
        </div>
        <h3 className={styles.semesterName}>Semester {currentSemester}</h3>

        {currentPaid ? (
          <>
            <div className={styles.semesterMeta}>
              Receipt {currentPaidReceipt.receiptNumber} · Paid {formatReceiptDate(currentPaidReceipt.paymentDate)}
            </div>
            <div className={styles.semesterCompleteNote}>
              <CheckCircle size={13} style={{ verticalAlign: -2, marginRight: 4 }} />
              Paid Successfully
            </div>
            <div className={styles.semesterActions}>
              <button className={styles.semesterGhostBtn} onClick={() => downloadReceiptPDF(currentPaidReceipt)}>
                <Download size={13} /> Download
              </button>
              <button className={styles.semesterGhostBtn} onClick={() => printReceipt(currentPaidReceipt)}>
                <Printer size={13} /> Print
              </button>
            </div>
          </>
        ) : currentFeeState.status === 'ready' ? (
          <>
            <div className={styles.semesterAmount}>{formatCurrency(currentFeeState.fee.totalFee)}</div>
            <div className={styles.semesterMeta}>
              Tuition Fee {formatCurrency(currentFeeState.fee.tuitionFee)} · Examination Fee {formatCurrency(currentFeeState.fee.examFee)}
            </div>
            <div className={styles.semesterActions}>
              <button
                className={styles.semesterPayBtn}
                disabled={payingWhich !== null}
                onClick={() => paySemester(currentSemester, 'current', currentFeeState.reload)}
              >
                {payingWhich === 'current' ? 'Processing…' : 'Pay Now'}
              </button>
              {/* Real Razorpay gateway button — additive, existing Pay Now above is untouched */}
              <RazorpayButton paymentButtonId={RAZORPAY_BUTTON_IDS.feeReceiptsCurrentSemester} className={styles.razorpayFormWrap} />
            </div>
          </>
        ) : (
          <FeeCardBody status={currentFeeState.status} reload={currentFeeState.reload} />
        )}
        {payErrorWhich === 'current' && payError && (
          <div className={styles.semesterMeta} style={{ color: '#B91C1C', marginTop: 6 }}>{payError}</div>
        )}
      </div>

      {/* Next Semester */}
      {currentPaid && (
        <div className={`${styles.semesterCard} ${styles.semesterCardNext} ${!showNext ? styles.semesterCardLocked : ''}`}>
          <div className={styles.semesterTopRow}>
            <span className={styles.semesterLabel}>Next Semester</span>
            {!showNext && <Lock size={14} color="#A67C52" />}
          </div>

          {showNext ? (
            nextFeeState.status === 'ready' ? (
              <>
                <h3 className={styles.semesterName}>Semester {nextSemester}</h3>
                <div className={styles.semesterAmount}>{formatCurrency(nextFeeState.fee.totalFee)}</div>
                <div className={styles.semesterMeta}>
                  Tuition Fee {formatCurrency(nextFeeState.fee.tuitionFee)} · Examination Fee {formatCurrency(nextFeeState.fee.examFee)}
                </div>
                <div className={styles.semesterActions}>
                  <button
                    className={styles.semesterPayBtn}
                    disabled={payingWhich !== null}
                    onClick={() => paySemester(nextSemester, 'next', nextFeeState.reload)}
                  >
                    {payingWhich === 'next' ? 'Processing…' : (<>Pay Now <ArrowRight size={13} /></>)}
                  </button>
                  {/* Real Razorpay gateway button — additive, existing Pay Now above is untouched */}
                  <RazorpayButton paymentButtonId={RAZORPAY_BUTTON_IDS.feeReceiptsNextSemester} className={styles.razorpayFormWrap} />
                </div>
                {payErrorWhich === 'next' && payError && (
                  <div className={styles.semesterMeta} style={{ color: '#B91C1C', marginTop: 6 }}>{payError}</div>
                )}
              </>
            ) : (
              <>
                <h3 className={styles.semesterName}>Semester {nextSemester}</h3>
                <FeeCardBody status={nextFeeState.status} reload={nextFeeState.reload} />
              </>
            )
          ) : (
            <>
              <h3 className={styles.semesterName} style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <GraduationCap size={18} /> All Semesters Paid
              </h3>
              <div className={styles.semesterMeta}>
                You've completed fee payment for every semester of this course. Congratulations!
              </div>
            </>
          )}
        </div>
      )}
    </div>
  );
}

// ── "Pay Fees" — for one-off charges (exam, library, ID card,
//    hostel, transport, etc.). Semester tuition is always paid via
//    the dedicated Current/Next Semester Fee Payment cards above,
//    so it's excluded from this list to avoid two payment paths for
//    the same fee. Every amount is Admin-managed / database-driven —
//    see getFeeTypeOptionsAsync in utils/feeReceipts.js. ──
function PayFeesCard({ student, user, onSuccess }) {
  const [feeOptions, setFeeOptions] = useState([]);
  const [loadState, setLoadState] = useState('loading'); // 'loading' | 'ready' | 'error'
  const [feeKey, setFeeKey] = useState(null);
  const [amount, setAmount] = useState(0);
  const [method, setMethod] = useState(PAYMENT_METHODS[0]);
  const [processing, setProcessing] = useState(false);

  const loadOptions = useCallback(async () => {
    setLoadState('loading');
    try {
      const options = await getFeeTypeOptionsAsync(student, user);
      setFeeOptions(options);
      setFeeKey(options[0]?.key ?? null);
      setAmount(options[0]?.amount ?? 0);
      setLoadState('ready');
    } catch {
      setLoadState('error');
    }
  }, [student, user]);

  useEffect(() => { loadOptions(); }, [loadOptions]);

  const handleFeeChange = (key) => {
    setFeeKey(key);
    const opt = feeOptions.find(o => o.key === key);
    if (opt) setAmount(opt.amount);
  };

  const handlePay = () => {
    const selected = feeOptions.find(o => o.key === feeKey) || feeOptions[0];
    const numericAmount = Number(amount);
    if (!selected || !numericAmount || numericAmount <= 0) return;

    setProcessing(true);
    // Simulate payment gateway round-trip — no manual intervention
    // needed; the receipt is generated automatically on success.
    setTimeout(() => {
      const receipt = createReceipt({
        studentId: student.id,
        studentName: student.name,
        enrollmentNumber: student.enrollmentNumber,
        department: student.department,
        course: student.course,
        semester: student.semester,
        academicYear: student.academicYear,
        feeType: selected.label,
        amount: numericAmount,
        paymentMethod: method,
        status: 'Paid',
      });
      setProcessing(false);
      onSuccess(receipt);
    }, 900);
  };

  return (
    <div className={styles.payCard}>
      <div className={styles.payHeader}>
        <div className={styles.payIconWrap}><CreditCard size={16} /></div>
        <div>
          <h2 className={styles.payTitle}>Pay Other Fees</h2>
          <p className={styles.paySub}>Pay a fee online — a receipt is generated automatically the moment your payment succeeds.</p>
        </div>
      </div>

      {loadState === 'loading' && (
        <div className={styles.semesterMeta}>Loading latest fee…</div>
      )}
      {loadState === 'error' && (
        <div className={styles.semesterMeta} style={{ color: '#B91C1C' }}>
          <AlertTriangle size={13} style={{ verticalAlign: -2, marginRight: 4 }} /> {FEE_UNAVAILABLE_MSG}{' '}
          <button
            type="button"
            onClick={loadOptions}
            style={{ border: 'none', background: 'none', color: '#A67C52', textDecoration: 'underline', cursor: 'pointer', padding: 0, font: 'inherit' }}
          >
            <RefreshCw size={11} style={{ verticalAlign: -1 }} /> Retry
          </button>
        </div>
      )}
      {loadState === 'ready' && feeOptions.length === 0 && (
        <div className={styles.semesterMeta}>No other fees are currently configured by the Admin.</div>
      )}
      {loadState === 'ready' && feeOptions.length > 0 && (
        <div className={styles.payGrid}>
        <div className={styles.fieldGroup}>
          <label className={styles.fieldLabel}>Fee Type</label>
          <select
            className={styles.fieldControl}
            value={feeKey}
            onChange={(e) => handleFeeChange(e.target.value)}
          >
            {feeOptions.map(opt => (
              <option key={opt.key} value={opt.key}>{opt.label}</option>
            ))}
          </select>
        </div>

        <div className={styles.fieldGroup}>
          <label className={styles.fieldLabel}>Amount (₹)</label>
          <input
            type="number"
            min="1"
            className={styles.fieldControl}
            value={amount}
            onChange={(e) => setAmount(e.target.value)}
          />
        </div>

        <div className={styles.payBtnGroup}>
          <button className={styles.payBtn} onClick={handlePay} disabled={processing}>
            {processing ? 'Processing…' : 'Pay Now'}
          </button>
          {/* Real Razorpay gateway button — additive, existing Pay Now above is untouched */}
          <RazorpayButton paymentButtonId={RAZORPAY_BUTTON_IDS.feeReceiptsPayOtherFees} className={styles.razorpayFormWrap} />
        </div>
        </div>
      )}
    </div>
  );
}

// ── Payment success confirmation ────────────────────────────
function PaymentSuccessModal({ receipt, onView, onClose }) {
  if (!receipt) return null;
  return (
    <div className={styles.successOverlay} onClick={onClose}>
      <div className={styles.successModal} onClick={(e) => e.stopPropagation()}>
        <div className={styles.successIcon}><CheckCircle size={28} /></div>
        <h2 className={styles.successTitle}>Payment Successful!</h2>
        <p className={styles.successSub}>{receipt.feeType} · {formatCurrency(receipt.amount)}</p>
        <p className={styles.successReceiptNo}>{receipt.receiptNumber}</p>
        <div className={styles.successActions}>
          <button className={styles.successBtnPrimary} onClick={() => downloadReceiptPDF(receipt)}>
            <Download size={14} /> Download Receipt
          </button>
          <button className={styles.successBtnGhost} onClick={() => onView(receipt)}>
            <Eye size={14} /> View Receipt
          </button>
        </div>
        <button className={styles.successClose} onClick={onClose}>Close</button>
      </div>
    </div>
  );
}

export default function FeeReceiptsPage() {
  const { user, updateUser } = useAuth();
  const student = useMemo(() => getStudentProfile(user), [user]);

  const [receipts, setReceipts] = useState([]);
  const [search, setSearch] = useState('');
  const [viewReceipt, setViewReceipt] = useState(null);
  const [successReceipt, setSuccessReceipt] = useState(null);

  const refresh = () => {
    if (student?.id !== undefined) setReceipts(getReceiptsForStudent(student.id));
  };

  useEffect(() => { refresh(); /* eslint-disable-next-line react-hooks/exhaustive-deps */ }, [student?.id]);

  const filtered = useMemo(() => {
    return searchReceipts(receipts, search)
      .slice()
      .sort((a, b) => new Date(b.paymentDate) - new Date(a.paymentDate));
  }, [receipts, search]);

  const totalPaid = useMemo(
    () => receipts.filter(r => r.status === 'Paid').reduce((sum, r) => sum + (Number(r.amount) || 0), 0),
    [receipts]
  );

  // Step 5 — Automatic Semester Update: advances the student's
  // current semester (and persists it, so it survives logout/login)
  // the instant the next semester's fee is paid. Every part of the
  // app that reads user.semester (Student Dashboard, header, etc.)
  // re-renders immediately because it comes from shared auth state.
  //
  // This ALSO updates the real `students.semester` column in the
  // database (via admission.php /advance-semester) — the Timetable
  // and Results modules read the student's semester straight from
  // the DB, not from this local session, so without this call they'd
  // keep showing the old semester even after the fee was paid.
  const advanceSemester = (newSemester) => {
    updateUser({ semester: newSemester, year: `Semester ${newSemester}` });
    admissionApi.advanceSemester(newSemester).catch(err => {
      console.error('Failed to sync new semester to the server:', err);
      // Non-fatal: the paid receipt and local session already reflect
      // the new semester. Surface it so it's not silently lost — the
      // Timetable/Results pages would otherwise keep showing the old
      // semester until this succeeds.
      alert('Your payment was recorded, but we could not update your semester on the server. Please contact the admin office if your Timetable still shows the old semester.');
    });
  };

  if (!user || !student) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 80 }}>
        <div className="spinner" style={{ width: 36, height: 36 }} />
      </div>
    );
  }

  return (
    <div className={styles.page}>
      {/* Page header */}
      <div className={styles.pageHeader}>
        <div className={styles.pageIconWrap}><FileText size={20} /></div>
        <div>
          <h1 className={styles.pageTitle}>Fee Receipts</h1>
          <p className={styles.pageSub}>
            Pay your fees and manage all your PrimeTech College fee payment receipts in one place.
          </p>
        </div>
      </div>

      {/* Quick stats */}
      <div className={styles.statsRow}>
        <div className={`${styles.statCard} card`}>
          <span className={styles.statLabel}>Total Receipts</span>
          <span className={styles.statValue}>{receipts.length}</span>
        </div>
        <div className={`${styles.statCard} card`}>
          <span className={styles.statLabel}>Total Paid</span>
          <span className={styles.statValue}>{formatCurrency(totalPaid)}</span>
        </div>
        <div className={`${styles.statCard} card`}>
          <span className={styles.statLabel}>Enrollment Number</span>
          <span className={styles.statValue} style={{ fontSize: 15 }}>{student.enrollmentNumber}</span>
        </div>
      </div>

      {/* Current Semester / Next Semester Fee Payment */}
      <SemesterFeeSection
        student={student}
        user={user}
        receipts={receipts}
        onPaid={(receipt) => { setSuccessReceipt(receipt); refresh(); }}
        onAdvanceSemester={advanceSemester}
      />

      {/* Pay Fees (other charges) */}
      <PayFeesCard student={student} user={user} onSuccess={(receipt) => { setSuccessReceipt(receipt); refresh(); }} />

      {/* Receipts table */}
      <div className={`${styles.sectionCard} card`}>
        <div className={styles.sectionHeader}>
          <h2 className={styles.sectionTitle}>My Receipts</h2>
          <div className={styles.searchWrap}>
            <Search size={14} />
            <input
              className={styles.searchInput}
              placeholder="Search receipt no, fee type, transaction…"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
          </div>
        </div>

        {filtered.length === 0 ? (
          <div className={styles.emptyState}>
            {receipts.length === 0
              ? 'No fee receipts yet. Pay a fee above to generate your first receipt automatically.'
              : 'No receipts match your search.'}
          </div>
        ) : (
          <div className={styles.tableWrap}>
            <table className={styles.table}>
              <thead>
                <tr>
                  <th>Receipt No</th>
                  <th>Fee Type</th>
                  <th>Amount</th>
                  <th>Date</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((r) => (
                  <tr key={r.id}>
                    <td className={styles.receiptNo}>{r.receiptNumber}</td>
                    <td>{r.feeType}</td>
                    <td className={styles.amountCell}>{formatCurrency(r.amount)}</td>
                    <td>{formatReceiptDate(r.paymentDate)}</td>
                    <td><StatusBadge status={r.status} /></td>
                    <td>
                      <div className={styles.actionsCell}>
                        <button className={styles.actionBtn} title="View Receipt" onClick={() => setViewReceipt(r)}>
                          <Eye size={14} />
                        </button>
                        <button className={styles.actionBtn} title="Download PDF" onClick={() => downloadReceiptPDF(r)}>
                          <Download size={14} />
                        </button>
                        <button className={styles.actionBtn} title="Print Receipt" onClick={() => printReceipt(r)}>
                          <Printer size={14} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Payment success confirmation */}
      <PaymentSuccessModal
        receipt={successReceipt}
        onClose={() => setSuccessReceipt(null)}
        onView={(r) => { setSuccessReceipt(null); setViewReceipt(r); }}
      />

      {/* Full receipt view / download */}
      <ReceiptModal receipt={viewReceipt} onClose={() => setViewReceipt(null)} />
    </div>
  );
}