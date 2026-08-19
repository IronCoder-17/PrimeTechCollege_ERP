// ============================================================
// AdmissionPage.jsx — PrimeTech College Student Admission
// Full redesign with course selection, dynamic fee display,
// Razorpay payment simulation, and auto account creation
// ============================================================

import { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import {
  User, Mail, Phone, MapPin, Calendar, BookOpen,
  GraduationCap, CreditCard, CheckCircle, ChevronRight,
  ChevronLeft, Upload, AlertCircle, Eye, EyeOff,
  FileText, Shield, ArrowRight, Loader, Receipt
} from 'lucide-react';
import logoImg from '../assets/primetech-logo.png';
import styles from './AdmissionPage.module.css';
import { saveAdmissionAccount, generateEnrollmentNumber } from '../contexts/AuthContext';
import { admissionApi, feesApi, transportationApi } from '../utils/api';
import { createReceipt } from '../utils/feeReceipts';
import { downloadReceiptPDF } from '../utils/receiptPdf';
import ReceiptModal from '../components/ReceiptModal';
import RazorpayButton from '../components/widgets/RazorpayButton';
import { RAZORPAY_BUTTON_IDS } from '../config/razorpay';

// ── Static course data (mirrors DB) ───────────────────────
const COURSES = [
  { id:1,  name:'B.Tech Computer Engineering',        code:'BTCE',  semesters:8,  dept:'Engineering' },
  { id:2,  name:'B.Tech Information Technology',      code:'BTIT',  semesters:8,  dept:'Engineering' },
  { id:3,  name:'B.Tech Mechanical Engineering',      code:'BTME',  semesters:8,  dept:'Engineering' },
  { id:4,  name:'B.Tech Civil Engineering',           code:'BTCV',  semesters:8,  dept:'Engineering' },
  { id:5,  name:'B.Tech Electronics & Communication', code:'BTEC',  semesters:8,  dept:'Engineering' },
  { id:6,  name:'M.Tech Computer Engineering',        code:'MTCE',  semesters:4,  dept:'Engineering' },
  { id:7,  name:'M.Tech Structural Engineering',      code:'MTSE',  semesters:4,  dept:'Engineering' },
  { id:8,  name:'BCA',                               code:'BCA',   semesters:6,  dept:'Computer & IT' },
  { id:9,  name:'MCA',                               code:'MCA',   semesters:4,  dept:'Computer & IT' },
  { id:10, name:'B.Sc Information Technology',        code:'BSCIT', semesters:6,  dept:'Computer & IT' },
  { id:11, name:'BBA',                               code:'BBA',   semesters:6,  dept:'Management' },
  { id:12, name:'MBA',                               code:'MBA',   semesters:4,  dept:'Management' },
  { id:13, name:'B.Com Business Analytics',           code:'BCBA',  semesters:6,  dept:'Management' },
  { id:14, name:'B.Sc Mathematics',                  code:'BSCMA', semesters:6,  dept:'Science' },
  { id:15, name:'B.Sc Physics',                      code:'BSCPH', semesters:6,  dept:'Science' },
  { id:16, name:'M.Sc Data Science',                 code:'MSCDS', semesters:4,  dept:'Science' },
  { id:17, name:'B.Com',                             code:'BCOM',  semesters:6,  dept:'Commerce' },
  { id:18, name:'M.Com',                             code:'MCOM',  semesters:4,  dept:'Commerce' },
  { id:19, name:'BA English',                        code:'BAEN',  semesters:6,  dept:'Arts' },
  { id:20, name:'Bachelor of Multimedia & Animation',code:'BMMA',  semesters:6,  dept:'Design' },
];

// Fee table matching seed_admission.sql — used as a FALLBACK while the
// live fee structure is being fetched from the database, or if the
// fee API is unreachable. Once /api/admission.php/fee-structure responds,
// FEE_TABLE_LIVE (built from the DB) takes precedence everywhere.
const FEE_TABLE_FALLBACK = {
  1:  [75000,75000,80000,80000,85000,85000,90000,90000],
  2:  [72000,72000,77000,77000,82000,82000,87000,87000],
  3:  [68000,68000,72000,72000,76000,76000,80000,80000],
  4:  [65000,65000,69000,69000,73000,73000,77000,77000],
  5:  [70000,70000,75000,75000,80000,80000,85000,85000],
  6:  [85000,85000,90000,90000],
  7:  [80000,80000,85000,85000],
  8:  [40000,40000,44000,44000,48000,48000],
  9:  [55000,55000,60000,60000],
  10: [35000,35000,38000,38000,42000,42000],
  11: [38000,38000,42000,42000,46000,46000],
  12: [65000,65000,72000,72000],
  13: [42000,42000,46000,46000,50000,50000],
  14: [30000,30000,33000,33000,36000,36000],
  15: [32000,32000,35000,35000,38000,38000],
  16: [60000,60000,65000,65000],
  17: [28000,28000,31000,31000,34000,34000],
  18: [40000,40000,45000,45000],
  19: [25000,25000,28000,28000,31000,31000],
  20: [50000,50000,55000,55000,60000,60000],
};
const EXAM_FEE_FALLBACK = 2500;

// ── Hostel fee structure (fallback) ────────────────────────────
const HOSTEL_FEES_FALLBACK = {
  boys: {
    'Non-AC (3 Sharing)': { admission: 5000, deposit: 10000, hostel: 35000, mess: 25000, maintenance: 3000 },
    'Non-AC (2 Sharing)': { admission: 5000, deposit: 10000, hostel: 45000, mess: 25000, maintenance: 3000 },
    'AC (2 Sharing)':     { admission: 5000, deposit: 10000, hostel: 60000, mess: 25000, maintenance: 5000 },
  },
  girls: {
    'Non-AC (3 Sharing)': { admission: 5000, deposit: 10000, hostel: 38000, mess: 25000, maintenance: 3000 },
    'Non-AC (2 Sharing)': { admission: 5000, deposit: 10000, hostel: 48000, mess: 25000, maintenance: 3000 },
    'AC (2 Sharing)':     { admission: 5000, deposit: 10000, hostel: 65000, mess: 25000, maintenance: 5000 },
  },
};

function calcHostelFee(hostelType, roomType, hostelFees) {
  if (!hostelType || !roomType) return 0;
  const key = hostelType === 'Boys Hostel' ? 'boys' : 'girls';
  const f = hostelFees?.[key]?.[roomType];
  if (!f) return 0;
  return f.admission + f.deposit + f.hostel + f.mess + f.maintenance;
}

function getHostelFeeBreakdown(hostelType, roomType, hostelFees) {
  if (!hostelType || !roomType) return null;
  const key = hostelType === 'Boys Hostel' ? 'boys' : 'girls';
  return hostelFees?.[key]?.[roomType] || null;
}

// ── Transportation coverage areas + fee structure (fallback) ───
const TRANSPORT_LOCATIONS = [
  'Rajkot', 'Wankaner', 'Gondal', 'Porbandar', 'Morbi',
  'Jetpur', 'Jamnagar', 'Dhrol', 'Surendranagar', 'Maliya-Miyana',
];

const TRANSPORT_ROUTES_FALLBACK = [
  { id:1,  location:'Rajkot',          bus_number:'BUS-01', transport_fee:2000, status:'active' },
  { id:2,  location:'Wankaner',        bus_number:'BUS-02', transport_fee:1500, status:'active' },
  { id:3,  location:'Gondal',          bus_number:'BUS-03', transport_fee:1800, status:'active' },
  { id:4,  location:'Porbandar',       bus_number:'BUS-04', transport_fee:2200, status:'active' },
  { id:5,  location:'Morbi',           bus_number:'BUS-05', transport_fee:2500, status:'active' },
  { id:6,  location:'Jetpur',          bus_number:'BUS-06', transport_fee:1700, status:'active' },
  { id:7,  location:'Jamnagar',        bus_number:'BUS-07', transport_fee:2100, status:'active' },
  { id:8,  location:'Dhrol',           bus_number:'BUS-08', transport_fee:1600, status:'active' },
  { id:9,  location:'Surendranagar',   bus_number:'BUS-09', transport_fee:1900, status:'active' },
  { id:10, location:'Maliya-Miyana',   bus_number:'BUS-10', transport_fee:1400, status:'active' },
];

// Looks up the ACTIVE route for a given location. Returns null if the
// location is empty, unknown, or the matching route has been deactivated
// by the Admin (in which case it must not be usable for registration).
function getTransportRoute(location, routes) {
  if (!location) return null;
  return (routes || []).find(r => r.location === location && r.status === 'active') || null;
}

const fmt = (n) => '₹' + Number(n).toLocaleString('en-IN');

// ── Step labels ───────────────────────────────────────────
const STEPS = ['Personal Info','Academic','Hostel','Transportation','Documents','Fee & Pay','Confirmation'];

export default function AdmissionPage() {
  const navigate = useNavigate();
  const [step, setStep] = useState(0);

  // form state
  const [form, setForm] = useState({
    first_name:'', middle_name:'', last_name:'',
    dob:'', gender:'', phone:'', email:'', address:'',
    course_id:'', semester:'',
    tenth:'', twelfth:'', photo:'',
    // Hostel fields
    hostel_required: 'no',
    hostel_type: '',
    room_type: '',
    // Transportation fields
    transport_required: 'no',
    transport_location: '',
  });
  const [files, setFiles] = useState({ tenth:null, twelfth:null, photo:null });
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);
  const [payLoading, setPayLoading] = useState(false);

  // ── Live fee data — fetched directly from the centralized Fee
  //    Structure database via the backend APIs (admission.php,
  //    fees.php, transportation.php). Every value an Admin edits in
  //    "Fee Structure Management" is read live here — nothing is
  //    hard-coded or cached in localStorage. ─────────────────────
  const [feeTableLive,   setFeeTableLive]   = useState(null);
  const [examFeeLive,    setExamFeeLive]     = useState(null);
  const [hostelFeesLive, setHostelFeesLive] = useState(null);
  const [transportRoutesLive, setTransportRoutesLive] = useState(null);

  const loadLiveFees = async () => {
    // Course-wise / semester-wise tuition fees — source of truth: fee_structure table
    try {
      const { data } = await admissionApi.getFeeStructure();
      const table = {};
      (data?.courses || []).forEach(c => {
        const arr = [];
        (c.fees || []).forEach(f => { arr[f.semester - 1] = Number(f.tuition_fee) || 0; });
        table[c.course_id] = arr;
      });
      if (Object.keys(table).length) setFeeTableLive(table);
    } catch (e) { /* keep previous/fallback value on transient errors */ }

    // Global one-time / per-semester charges (registration, exam, ID card, etc.)
    try {
      const { data } = await feesApi.getSettings();
      const map = data?.map || {};
      if (typeof map.exam_fee === 'number') setExamFeeLive(map.exam_fee);
    } catch (e) {}

    // Hostel fee plans — convert flat array → { boys: { roomType: {...} }, girls: {...} }
    try {
      const { data } = await feesApi.getHostelPlans();
      const plans = data?.plans || [];
      if (plans.length) {
        const map = { boys: {}, girls: {} };
        plans.forEach(p => {
          const key = p.hostel_type === 'Boys Hostel' ? 'boys' : 'girls';
          map[key][p.room_type] = {
            admission:   Number(p.hostel_admission_fee),
            deposit:     Number(p.security_deposit),
            hostel:      Number(p.hostel_fee),
            mess:        Number(p.mess_fee),
            maintenance: Number(p.maintenance_fee),
          };
        });
        setHostelFeesLive(map);
      }
    } catch (e) {}

    // Transportation routes — only active routes are returned (public endpoint)
    try {
      const { data } = await transportationApi.getRoutes();
      const routes = data?.routes || [];
      if (routes.length) setTransportRoutesLive(routes);
    } catch (e) {}
  };

  useEffect(() => {
    loadLiveFees();
    // Re-fetch on window focus so an Admin's change in another tab/device
    // shows up instantly here too, without requiring a manual page reload.
    const onFocus = () => loadLiveFees();
    window.addEventListener('focus', onFocus);
    return () => window.removeEventListener('focus', onFocus);
  }, []);

  // Always use live (Admin-set) values; fall back to hardcoded defaults
  const FEE_TABLE   = feeTableLive   || FEE_TABLE_FALLBACK;
  const EXAM_FEE    = examFeeLive    ?? EXAM_FEE_FALLBACK;
  const HOSTEL_FEES = hostelFeesLive || HOSTEL_FEES_FALLBACK;
  const TRANSPORT_ROUTES = transportRoutesLive || TRANSPORT_ROUTES_FALLBACK;



  // result state (post payment)
  const [result, setResult] = useState(null);
  const [viewReceipt, setViewReceipt] = useState(null);

  const set = (k, v) => {
    setForm(f => ({ ...f, [k]: v }));
    setErrors(e => ({ ...e, [k]: '' }));
  };

  // Derived fee
  const selectedCourse = COURSES.find(c => c.id === Number(form.course_id));
  const tuitionFee = form.course_id && form.semester
    ? (FEE_TABLE[Number(form.course_id)]?.[Number(form.semester) - 1] ?? 0)
    : 0;
  const hostelFee = form.hostel_required === 'yes'
    ? calcHostelFee(form.hostel_type, form.room_type, HOSTEL_FEES)
    : 0;
  const hostelBreakdown = form.hostel_required === 'yes'
    ? getHostelFeeBreakdown(form.hostel_type, form.room_type, HOSTEL_FEES)
    : null;
  // Only ACTIVE routes are selectable, so this is always either a valid
  // active route or null (e.g. while no location has been chosen yet).
  const transportRoute = form.transport_required === 'yes'
    ? getTransportRoute(form.transport_location, TRANSPORT_ROUTES)
    : null;
  const transportFee = transportRoute ? Number(transportRoute.transport_fee) : 0;
  const activeTransportRoutes = TRANSPORT_ROUTES.filter(r => r.status === 'active');
  const totalFee = tuitionFee + (tuitionFee ? EXAM_FEE : 0) + hostelFee + transportFee;

  // Semester options for selected course
  const semOptions = selectedCourse
    ? Array.from({ length: selectedCourse.semesters }, (_, i) => i + 1)
    : [];

  // Validation per step
  const validate = () => {
    const e = {};
    if (step === 0) {
      if (!form.first_name.trim())  e.first_name = 'First name is required.';
      if (!form.last_name.trim())   e.last_name  = 'Last name is required.';
      if (!form.dob)                e.dob        = 'Date of birth is required.';
      if (!form.gender)             e.gender     = 'Please select gender.';
      if (!/^\d{10}$/.test(form.phone)) e.phone  = 'Enter valid 10-digit phone number.';
      if (!form.address.trim())     e.address    = 'Address is required.';
    }
    if (step === 1) {
      if (!form.course_id) e.course_id = 'Please select a course.';
      if (!form.semester)  e.semester  = 'Please select a semester.';
    }
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const nextStep = () => { if (validate()) setStep(s => s + 1); };
  const prevStep = () => setStep(s => s - 1);

  // File handler
  const handleFile = (key, file) => {
    if (!file) return;
    if (file.size > 5 * 1024 * 1024) {
      setErrors(e => ({ ...e, [key]: 'File must be under 5 MB.' }));
      return;
    }
    setFiles(f => ({ ...f, [key]: file }));
    set(key, file.name);
  };

  // ── Payment + real account creation ────────────────────────
  // Registers the student and records payment against the ACTUAL
  // backend (admission.php /register + /payment), so every new
  // admission is a real row in `students` + `login_credentials`
  // from the moment payment succeeds — no manual DB fix-up needed
  // afterward. Razorpay checkout itself is still simulated (no live
  // payment gateway wired up), but everything downstream of "payment
  // succeeded" is real.
  const handlePayment = async () => {
    setPayLoading(true);
    try {
      const admissionYear = new Date().getFullYear();
      const courseCode    = selectedCourse?.code ?? 'GEN';

      // ── 1. Register the student in the real database ─────────────────
      let dbStudentId;
      try {
        const registerRes = await admissionApi.register({
          first_name: form.first_name,
          middle_name: form.middle_name,
          last_name: form.last_name,
          dob: form.dob,
          gender: form.gender,
          phone: form.phone,
          email: form.email || null,
          address: form.address,
          course_id: selectedCourse?.id,
          semester: form.semester,
          transport_required: form.transport_required === 'yes' ? 'Yes' : 'No',
          transport_location: form.transport_required === 'yes' ? form.transport_location : undefined,
        });
        dbStudentId = registerRes.data.student_id;
      } catch (err) {
        setErrors({ pay: err.response?.data?.error || 'Registration failed. Please check your details and try again.' });
        setPayLoading(false);
        return;
      }

      // Simulate a short delay (real: open Razorpay checkout here)
      await new Promise(r => setTimeout(r, 1500));
      const orderId   = 'order_' + Math.random().toString(36).slice(2, 12).toUpperCase();
      const paymentId = 'pay_'   + Math.random().toString(36).slice(2, 12).toUpperCase();

      // ── 2. Record payment & create real login credentials ────────────
      // The backend generates the authoritative GR number, login email,
      // and password (and creates the `users` row) — we use exactly
      // what it returns so this account is guaranteed to already work
      // against every backend feature (Timetable, Results, etc.).
      let grNumber, enrollmentNumber, emailId, rawPass;
      try {
        const paymentRes = await admissionApi.payment({
          student_id: dbStudentId,
          razorpay_order_id: orderId,
          razorpay_payment_id: paymentId,
          amount: totalFee,
        });
        grNumber = paymentRes.data.gr_number;
        emailId  = paymentRes.data.email;
        rawPass  = paymentRes.data.password;
      } catch (err) {
        setErrors({ pay: err.response?.data?.error || 'Payment could not be recorded. Please contact admissions.' });
        setPayLoading(false);
        return;
      }

      // Enrollment number isn't stored server-side (no column for it
      // yet) — keep the existing display-only generator for the receipt.
      enrollmentNumber = generateEnrollmentNumber(courseCode, admissionYear);

      // Student ID (display only, cosmetic — the real DB primary key is dbStudentId)
      const studentId = `PT${admissionYear}${String(Date.now()).slice(-6)}`;

      // Convert photo file to base64 dataURL if uploaded
      let photoDataUrl = null;
      if (files.photo) {
        try {
          photoDataUrl = await new Promise((res, rej) => {
            const reader = new FileReader();
            reader.onload = () => res(reader.result);
            reader.onerror = () => rej(new Error('Photo read failed'));
            reader.readAsDataURL(files.photo);
          });
        } catch {
          photoDataUrl = null;
        }
      }

      setResult({ grNumber, enrollmentNumber, studentId, emailId, rawPass, orderId, paymentId, amount: totalFee });

      // ── Auto-generate the official Fee Receipt (Payment Success Workflow) ──
      // Creates a unique receipt number (PTC-{year}-{seq}), a PDF-ready
      // record, and instantly stores it so it's visible in both the
      // Student Dashboard ("Fee Receipts") and the Admin "Fee Receipt
      // Management" panel — no manual intervention required.
      const studentName = [form.first_name, form.middle_name, form.last_name].filter(Boolean).join(' ');
      const feeTypeLabel = [
        'Admission & Registration Fee',
        form.hostel_required === 'yes' ? 'Hostel Fee' : null,
        form.transport_required === 'yes' ? 'Transportation Fee' : null,
      ].filter(Boolean).join(' + ');

      const receipt = createReceipt({
        studentId,
        studentName,
        enrollmentNumber,
        department: selectedCourse?.dept ?? '—',
        course: selectedCourse?.name ?? '—',
        semester: form.semester,
        academicYear: `${admissionYear}-${String((admissionYear + 1) % 100).padStart(2, '0')}`,
        feeType: feeTypeLabel || 'Admission Fee',
        amount: totalFee,
        paymentMethod: 'Razorpay',
        status: 'Paid',
        transactionId: paymentId,
        // Transportation details — shown on the printed/PDF receipt
        // whenever the student opted for transportation.
        transportRoute: form.transport_required === 'yes' ? transportRoute?.location : null,
        busNumber: form.transport_required === 'yes' ? transportRoute?.bus_number : null,
        // This payment covers the student's current (admission) semester
        // tuition — tag it so the Fee Receipt module recognizes the
        // semester as paid and immediately offers Next Semester payment.
        paymentType: 'semester_fee',
      });

      setResult(r => ({ ...r, receipt }));

      // ── Persist COMPLETE student record ──────────────────────────────────
      const now = new Date().toISOString();
      saveAdmissionAccount({
        id: Date.now(),
        // Personal Information
        firstName: form.first_name,
        middleName: form.middle_name,
        lastName: form.last_name,
        name: [form.first_name, form.middle_name, form.last_name].filter(Boolean).join(' '),
        dob: form.dob,
        gender: form.gender,
        phone: form.phone,
        address: form.address,
        // Academic Information
        courseCode,
        courseId: selectedCourse?.id ?? null,
        course: selectedCourse?.name ?? '',
        courseDept: selectedCourse?.dept ?? '',
        semester: form.semester,
        // Total semesters in this course — needed by the Student
        // Dashboard → Fee Receipt module to know when the student has
        // reached their final semester (no further "Next Semester Fee
        // Payment" option should be offered after that).
        totalSemesters: selectedCourse?.semesters ?? null,
        admissionYear,
        // Generated Credentials
        email: emailId,
        password: rawPass,        // plain-text for client-side mock; real backend stores bcrypt hash
        grNumber,
        enrollmentNumber,
        studentId,
        // Documents
        photoDataUrl,             // base64 image or null
        tenthDocument: form.tenth || null,
        twelfthDocument: form.twelfth || null,
        // Hostel Information
        hostelRequired: form.hostel_required === 'yes',
        hostelType: form.hostel_required === 'yes' ? form.hostel_type : null,
        roomType: form.hostel_required === 'yes' ? form.room_type : null,
        hostelFee: hostelFee,
        hostelStatus: form.hostel_required === 'yes' ? 'Active' : null,
        hostelAllocationStatus: form.hostel_required === 'yes' ? 'Pending' : null,
        hostelRoomNumber: form.hostel_required === 'yes' ? 'Pending Allocation' : null,
        hostelAdmissionDate: form.hostel_required === 'yes' ? now.split('T')[0] : null,
        hostelPaymentStatus: form.hostel_required === 'yes' ? 'Paid' : null,
        // Transportation Information
        transportRequired: form.transport_required === 'yes',
        transportLocation: form.transport_required === 'yes' ? transportRoute?.location : null,
        busNumber: form.transport_required === 'yes' ? transportRoute?.bus_number : null,
        transportFee: transportFee,
        transportPaymentStatus: form.transport_required === 'yes' ? 'Paid' : null,
        // Financial Information
        academicFee: tuitionFee + EXAM_FEE,
        totalFee,
        paidFee: totalFee,
        pendingFee: 0,
        paymentHistory: [
          {
            date: now,
            amount: totalFee,
            orderId,
            paymentId,
            mode: 'Razorpay',
            status: 'Success',
          },
        ],
        // Activity Tracking
        registrationDate: now,
        accountStatus: 'Active',
      });

      setStep(6);
    } catch {
      setErrors({ pay: 'Payment failed. Please try again.' });
    } finally {
      setPayLoading(false);
    }
  };

  const dept2color = {
    'Engineering':'#2563eb','Computer & IT':'#7c3aed',
    'Management':'#16a34a','Science':'#0891b2',
    'Commerce':'#d97706','Arts':'#db2777','Design':'#ea580c',
  };

  return (
    <div className={styles.page}>
      {/* ── Navbar ── */}
      <nav className={styles.navbar}>
        <Link to="/" className={styles.navLogo}>
          <img src={logoImg} alt="PrimeTech College" className={styles.navLogoImg} />
        </Link>
        <div className={styles.navTitle}>Student Admission Portal</div>
        <Link to="/login" className={styles.navLogin}>Login →</Link>
      </nav>

      {/* ── Hero banner ── */}
      <div className={styles.hero}>
        <h1 className={styles.heroTitle}>New Student Admission</h1>
        <p className={styles.heroSub}>PrimeTech College · Academic Year {new Date().getFullYear()}–{new Date().getFullYear()+1}</p>
      </div>

      {/* ── Stepper ── */}
      {step < 6 && (
        <div className={styles.stepperWrap}>
          <div className={styles.stepper}>
            {STEPS.slice(0,6).map((label, i) => (
              <div key={i} className={`${styles.stepItem} ${i === step ? styles.stepActive : ''} ${i < step ? styles.stepDone : ''}`}>
                <div className={styles.stepCircle}>
                  {i < step ? <CheckCircle size={14}/> : <span>{i+1}</span>}
                </div>
                <span className={styles.stepLabel}>{label}</span>
                {i < 5 && <div className={styles.stepLine} />}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* ── Card ── */}
      <div className={styles.container}>
        <div className={styles.card}>

          {/* ─────── STEP 0: Personal Info ─────── */}
          {step === 0 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><User size={18}/> Personal Information</h2>

              {/* Name row */}
              <div className={styles.row3}>
                <div className={styles.field}>
                  <label className={styles.label}>First Name <span className={styles.req}>*</span></label>
                  <input className={`${styles.input} ${errors.first_name?styles.inputErr:''}`}
                    placeholder="Rahul" value={form.first_name}
                    onChange={e=>set('first_name',e.target.value)} />
                  {errors.first_name && <span className={styles.err}>{errors.first_name}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Middle Name</label>
                  <input className={styles.input} placeholder="Kumar"
                    value={form.middle_name} onChange={e=>set('middle_name',e.target.value)} />
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Last Name <span className={styles.req}>*</span></label>
                  <input className={`${styles.input} ${errors.last_name?styles.inputErr:''}`}
                    placeholder="Patel" value={form.last_name}
                    onChange={e=>set('last_name',e.target.value)} />
                  {errors.last_name && <span className={styles.err}>{errors.last_name}</span>}
                </div>
              </div>

              {/* DOB + Gender */}
              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}><Calendar size={13}/> Date of Birth <span className={styles.req}>*</span></label>
                  <input type="date" className={`${styles.input} ${errors.dob?styles.inputErr:''}`}
                    value={form.dob} onChange={e=>set('dob',e.target.value)}
                    max={new Date().toISOString().split('T')[0]} />
                  {errors.dob && <span className={styles.err}>{errors.dob}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Gender <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.gender?styles.inputErr:''}`}
                    value={form.gender} onChange={e=>set('gender',e.target.value)}>
                    <option value="">Select gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                  </select>
                  {errors.gender && <span className={styles.err}>{errors.gender}</span>}
                </div>
              </div>

              {/* Phone + Email */}
              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}><Phone size={13}/> Phone Number <span className={styles.req}>*</span></label>
                  <input type="tel" className={`${styles.input} ${errors.phone?styles.inputErr:''}`}
                    placeholder="9876543210" value={form.phone}
                    onChange={e=>set('phone',e.target.value.replace(/\D/,''))} maxLength={10} />
                  {errors.phone && <span className={styles.err}>{errors.phone}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}><Mail size={13}/> Email Address <span className={styles.optional}>(optional)</span></label>
                  <input type="email" className={styles.input}
                    placeholder="rahul@gmail.com" value={form.email}
                    onChange={e=>set('email',e.target.value)} />
                </div>
              </div>

              {/* Address */}
              <div className={styles.field}>
                <label className={styles.label}><MapPin size={13}/> Residential Address <span className={styles.req}>*</span></label>
                <textarea className={`${styles.input} ${styles.textarea} ${errors.address?styles.inputErr:''}`}
                  placeholder="Full address including city, state, pincode"
                  value={form.address} onChange={e=>set('address',e.target.value)} rows={3} />
                {errors.address && <span className={styles.err}>{errors.address}</span>}
              </div>

              <div className={styles.btnRow}>
                <span />
                <button className={styles.btnPrimary} onClick={nextStep}>
                  Next: Academic Info <ChevronRight size={16}/>
                </button>
              </div>
            </div>
          )}

          {/* ─────── STEP 1: Academic Info ─────── */}
          {step === 1 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><BookOpen size={18}/> Academic Information</h2>

              {/* Course dropdown */}
              <div className={styles.field}>
                <label className={styles.label}>Select Course <span className={styles.req}>*</span></label>
                <select
                  className={`${styles.input} ${errors.course_id?styles.inputErr:''}`}
                  value={form.course_id}
                  onChange={e=>{ set('course_id',e.target.value); set('semester',''); }}
                >
                  <option value="">— Choose a program —</option>
                  {['Engineering','Computer & IT','Management','Science','Commerce','Arts','Design'].map(dept=>(
                    <optgroup key={dept} label={dept}>
                      {COURSES.filter(c=>c.dept===dept).map(c=>(
                        <option key={c.id} value={c.id}>{c.name}</option>
                      ))}
                    </optgroup>
                  ))}
                </select>
                {errors.course_id && <span className={styles.err}>{errors.course_id}</span>}
              </div>

              {/* Course badge */}
              {selectedCourse && (
                <div className={styles.courseBadge} style={{ borderColor: dept2color[selectedCourse.dept] }}>
                  <div className={styles.courseBadgeIcon} style={{ background: dept2color[selectedCourse.dept] }}>
                    <GraduationCap size={16} color="white"/>
                  </div>
                  <div>
                    <div className={styles.courseBadgeName}>{selectedCourse.name}</div>
                    <div className={styles.courseBadgeMeta}>
                      {selectedCourse.dept} · {selectedCourse.semesters/2} Years · {selectedCourse.semesters} Semesters
                    </div>
                  </div>
                </div>
              )}

              {/* Semester dropdown */}
              {selectedCourse && (
                <div className={styles.field}>
                  <label className={styles.label}>Select Semester <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.semester?styles.inputErr:''}`}
                    value={form.semester} onChange={e=>set('semester',e.target.value)}>
                    <option value="">— Choose semester —</option>
                    {semOptions.map(s=>(
                      <option key={s} value={s}>Semester {s}</option>
                    ))}
                  </select>
                  {errors.semester && <span className={styles.err}>{errors.semester}</span>}
                </div>
              )}

              {/* Dynamic fee preview */}
              {tuitionFee > 0 && (
                <div className={styles.feePreview}>
                  <div className={styles.feePreviewTitle}>
                    <Receipt size={16}/> Fee Summary
                  </div>
                  <div className={styles.feePreviewBody}>
                    <div className={styles.feeRow}>
                      <span>Selected Course</span>
                      <span className={styles.feeCourseName}>{selectedCourse?.name}</span>
                    </div>
                    <div className={styles.feeRow}>
                      <span>Semester</span>
                      <span>Semester {form.semester}</span>
                    </div>
                    <div className={styles.feeDivider}/>
                    <div className={styles.feeRow}>
                      <span>Tuition Fee</span>
                      <span className={styles.feeAmt}>{fmt(tuitionFee)}</span>
                    </div>
                    <div className={styles.feeRow}>
                      <span>Examination Fee</span>
                      <span className={styles.feeAmt}>{fmt(EXAM_FEE)}</span>
                    </div>
                    <div className={styles.feeDivider}/>
                    <div className={`${styles.feeRow} ${styles.feeTotal}`}>
                      <span>Total Payable</span>
                      <span>{fmt(totalFee)}</span>
                    </div>
                  </div>
                </div>
              )}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}>
                  <ChevronLeft size={16}/> Back
                </button>
                <button className={styles.btnPrimary} onClick={nextStep}>
                  Next: Documents <ChevronRight size={16}/>
                </button>
              </div>
            </div>
          )}

          {/* ─────── STEP 2: Hostel Accommodation ─────── */}
          {step === 2 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><span style={{fontSize:20}}>🏠</span> Hostel Accommodation</h2>

              {/* Hostel required radio */}
              <div className={styles.field}>
                <label className={styles.label}>Do you require hostel accommodation? <span className={styles.req}>*</span></label>
                <div style={{display:'flex',gap:20,marginTop:4}}>
                  {['yes','no'].map(val=>(
                    <label key={val} style={{display:'flex',alignItems:'center',gap:8,cursor:'pointer',fontSize:14,fontWeight:val===form.hostel_required?700:500,color:val===form.hostel_required?'#2563eb':'#374151'}}>
                      <input type="radio" name="hostel_required" value={val}
                        checked={form.hostel_required===val}
                        onChange={()=>{ set('hostel_required',val); if(val==='no'){set('hostel_type','');set('room_type','');} }}
                        style={{accentColor:'#2563eb'}}
                      />
                      {val==='yes'?'Yes':'No'}
                    </label>
                  ))}
                </div>
              </div>

              {form.hostel_required === 'yes' && (
                <>
                  <div className={styles.row2}>
                    <div className={styles.field}>
                      <label className={styles.label}>Hostel Type <span className={styles.req}>*</span></label>
                      <select
                        className={`${styles.input} ${errors.hostel_type ? styles.inputErr : ''}`}
                        value={form.hostel_type}
                        onChange={e => { set('hostel_type', e.target.value); set('room_type', ''); }}
                      >
                        <option value="">— Select hostel type —</option>
                        <option value="Boys Hostel">Boys Hostel</option>
                        <option value="Girls Hostel">Girls Hostel</option>
                      </select>
                      {errors.hostel_type && <span className={styles.err}>{errors.hostel_type}</span>}
                    </div>
                    <div className={styles.field}>
                      <label className={styles.label}>Room Type <span className={styles.req}>*</span></label>
                      <select className={`${styles.input} ${errors.room_type?styles.inputErr:''}`}
                        value={form.room_type} onChange={e=>set('room_type',e.target.value)}
                        disabled={!form.hostel_type}>
                        <option value="">— Select room type —</option>
                        <option value="Non-AC (3 Sharing)">Non-AC (3 Sharing)</option>
                        <option value="Non-AC (2 Sharing)">Non-AC (2 Sharing)</option>
                        <option value="AC (2 Sharing)">AC (2 Sharing)</option>
                      </select>
                      {errors.room_type && <span className={styles.err}>{errors.room_type}</span>}
                    </div>
                  </div>

                  {/* Hostel fee preview */}
                  {hostelBreakdown && (
                    <div className={styles.feePreview} style={{borderColor:'#2563eb'}}>
                      <div className={styles.feePreviewTitle} style={{color:'#1d4ed8'}}>
                        🏠 Hostel Fee Breakdown — {form.hostel_type} · {form.room_type}
                      </div>
                      <div className={styles.feePreviewBody}>
                        {[
                          ['Hostel Admission Fee (One Time)', hostelBreakdown.admission],
                          ['Security Deposit (Refundable)', hostelBreakdown.deposit],
                          ['Hostel Fee (Per Semester)', hostelBreakdown.hostel],
                          ['Mess Fee (Per Semester)', hostelBreakdown.mess],
                          ['Maintenance Fee (Per Semester)', hostelBreakdown.maintenance],
                        ].map(([label, amt])=>(
                          <div key={label} className={styles.feeRow}>
                            <span>{label}</span><span className={styles.feeAmt}>{fmt(amt)}</span>
                          </div>
                        ))}
                        <div className={styles.feeDivider}/>
                        <div className={`${styles.feeRow} ${styles.feeTotal}`}>
                          <span>Total Hostel Fee</span>
                          <span>{fmt(hostelFee)}</span>
                        </div>
                      </div>
                    </div>
                  )}
                </>
              )}

              {form.hostel_required === 'no' && (
                <div style={{padding:'16px',background:'#f0fdf4',borderRadius:10,border:'1px solid #bbf7d0',color:'#15803d',fontSize:13,marginTop:8}}>
                  ✓ No hostel accommodation selected. You can apply later if needed.
                </div>
              )}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}><ChevronLeft size={16}/> Back</button>
                <button className={styles.btnPrimary} onClick={()=>{
                  const e={};
                  if(form.hostel_required==='yes'){
                    if(!form.hostel_type) e.hostel_type='Please select hostel type.';
                    if(!form.room_type)   e.room_type='Please select room type.';
                  }
                  setErrors(e);
                  if(Object.keys(e).length===0) setStep(s=>s+1);
                }}>
                  Next: Transportation <ChevronRight size={16}/>
                </button>
              </div>
            </div>
          )}

          {/* ─────── STEP 3: Transportation Details ─────── */}
          {step === 3 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><span style={{fontSize:20}}>🚌</span> Transportation Details</h2>

              {/* Transportation required radio */}
              <div className={styles.field}>
                <label className={styles.label}>Transportation Required <span className={styles.req}>*</span></label>
                <div style={{display:'flex',gap:20,marginTop:4}}>
                  {['yes','no'].map(val=>(
                    <label key={val} style={{display:'flex',alignItems:'center',gap:8,cursor:'pointer',fontSize:14,fontWeight:val===form.transport_required?700:500,color:val===form.transport_required?'#2563eb':'#374151'}}>
                      <input type="radio" name="transport_required" value={val}
                        checked={form.transport_required===val}
                        onChange={()=>{ set('transport_required',val); if(val==='no'){ set('transport_location',''); } }}
                        style={{accentColor:'#2563eb'}}
                      />
                      {val==='yes'?'Yes':'No'}
                    </label>
                  ))}
                </div>
              </div>

              {form.transport_required === 'yes' && (
                <>
                  <div className={styles.field}>
                    <label className={styles.label}>Location <span className={styles.req}>*</span></label>
                    <select
                      className={`${styles.input} ${errors.transport_location ? styles.inputErr : ''}`}
                      value={form.transport_location}
                      onChange={e => set('transport_location', e.target.value)}
                    >
                      <option value="">— Select your location —</option>
                      {activeTransportRoutes.map(r => (
                        <option key={r.id} value={r.location}>{r.location}</option>
                      ))}
                    </select>
                    {errors.transport_location && <span className={styles.err}>{errors.transport_location}</span>}
                  </div>

                  {/* Auto-fetched fee + bus number preview */}
                  {transportRoute && (
                    <div className={styles.feePreview} style={{borderColor:'#2563eb'}}>
                      <div className={styles.feePreviewTitle} style={{color:'#1d4ed8'}}>
                        🚌 Transportation Fee — {transportRoute.location}
                      </div>
                      <div className={styles.feePreviewBody}>
                        <div className={styles.feeRow}>
                          <span>Bus Number</span><span className={styles.feeAmt}>{transportRoute.bus_number}</span>
                        </div>
                        <div className={styles.feeDivider}/>
                        <div className={`${styles.feeRow} ${styles.feeTotal}`}>
                          <span>Transportation Fee</span>
                          <span>{fmt(transportFee)}</span>
                        </div>
                      </div>
                    </div>
                  )}
                </>
              )}

              {form.transport_required === 'no' && (
                <div style={{padding:'16px',background:'#f0fdf4',borderRadius:10,border:'1px solid #bbf7d0',color:'#15803d',fontSize:13,marginTop:8}}>
                  ✓ No transportation selected. You can apply later if needed.
                </div>
              )}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}><ChevronLeft size={16}/> Back</button>
                <button className={styles.btnPrimary} onClick={()=>{
                  const e={};
                  if(form.transport_required==='yes' && !form.transport_location){
                    e.transport_location='Please select your location.';
                  }
                  setErrors(e);
                  if(Object.keys(e).length===0) setStep(s=>s+1);
                }}>
                  Next: Documents <ChevronRight size={16}/>
                </button>
              </div>
            </div>
          )}

          {/* ─────── STEP 4: Documents ─────── */}
          {step === 4 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><FileText size={18}/> Document Upload <span className={styles.optional}>(Optional)</span></h2>
              <p className={styles.docNote}>Accepted: PDF, JPG, PNG · Max size: 5 MB per file</p>

              {[
                { key:'tenth',   label:'10th Marksheet',      icon:'📄' },
                { key:'twelfth', label:'12th Marksheet',      icon:'📄' },
                { key:'photo',   label:'Passport Size Photo', icon:'🖼️' },
              ].map(({ key, label, icon }) => (
                <div key={key} className={styles.field}>
                  <label className={styles.label}>{icon} {label}</label>
                  <div className={styles.fileWrap}>
                    <label className={styles.fileLabel}>
                      <input type="file" accept=".pdf,.jpg,.jpeg,.png" style={{display:'none'}}
                        onChange={e=>handleFile(key, e.target.files[0])} />
                      <Upload size={16}/> {files[key] ? files[key].name : 'Choose file…'}
                    </label>
                    {files[key] && (
                      <span className={styles.fileOk}><CheckCircle size={14}/> Uploaded</span>
                    )}
                  </div>
                  {errors[key] && <span className={styles.err}>{errors[key]}</span>}
                </div>
              ))}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}>
                  <ChevronLeft size={16}/> Back
                </button>
                <button className={styles.btnPrimary} onClick={nextStep}>
                  Next: Pay Fee <ChevronRight size={16}/>
                </button>
              </div>
            </div>
          )}

          {/* ─────── STEP 5: Fee & Payment ─────── */}
          {step === 5 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><CreditCard size={18}/> Fee Payment</h2>

              {/* Summary */}
              <div className={styles.summaryBox}>
                <h3 className={styles.summaryTitle}>Admission Summary</h3>
                <div className={styles.summaryGrid}>
                  <div className={styles.summaryItem}>
                    <span className={styles.summaryKey}>Student Name</span>
                    <span className={styles.summaryVal}>
                      {[form.first_name, form.middle_name, form.last_name].filter(Boolean).join(' ')}
                    </span>
                  </div>
                  <div className={styles.summaryItem}>
                    <span className={styles.summaryKey}>Phone</span>
                    <span className={styles.summaryVal}>{form.phone}</span>
                  </div>
                  <div className={styles.summaryItem}>
                    <span className={styles.summaryKey}>Course</span>
                    <span className={styles.summaryVal}>{selectedCourse?.name}</span>
                  </div>
                  <div className={styles.summaryItem}>
                    <span className={styles.summaryKey}>Semester</span>
                    <span className={styles.summaryVal}>Semester {form.semester}</span>
                  </div>
                </div>

                <div className={styles.feeBreakdown}>
                  <div className={styles.feeRow}>
                    <span>Tuition Fee</span>
                    <span>{fmt(tuitionFee)}</span>
                  </div>
                  <div className={styles.feeRow}>
                    <span>Examination Fee</span>
                    <span>{fmt(EXAM_FEE)}</span>
                  </div>
                  {form.hostel_required === 'yes' && hostelFee > 0 && (
                    <div className={styles.feeRow}>
                      <span>🏠 Hostel Fee ({form.hostel_type} · {form.room_type})</span>
                      <span>{fmt(hostelFee)}</span>
                    </div>
                  )}
                  {form.transport_required === 'yes' && transportFee > 0 && (
                    <div className={styles.feeRow}>
                      <span>🚌 Transportation Fee ({transportRoute?.location} · {transportRoute?.bus_number})</span>
                      <span>{fmt(transportFee)}</span>
                    </div>
                  )}
                  <div className={styles.feeDivider}/>
                  <div className={`${styles.feeRow} ${styles.feeTotal}`}>
                    <span>Total Payable</span>
                    <span>{fmt(totalFee)}</span>
                  </div>
                </div>
              </div>

              {/* Payment options */}
              <div className={styles.payOptions}>
                <div className={styles.payOptionsTitle}>Accepted Payment Methods</div>
                <div className={styles.payChips}>
                  {['UPI','Credit Card','Debit Card','Net Banking','Wallet'].map(m=>(
                    <span key={m} className={styles.payChip}>{m}</span>
                  ))}
                </div>
              </div>

              {errors.pay && (
                <div className={styles.errBox}>
                  <AlertCircle size={14}/> {errors.pay}
                </div>
              )}

              <div className={styles.rzpNote}>
                <Shield size={13}/> Secured by <strong>Razorpay</strong> — 256-bit SSL encryption
              </div>

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep} disabled={payLoading}>
                  <ChevronLeft size={16}/> Back
                </button>
                <div className={styles.payBtnGroup}>
                  <button className={styles.btnPay} onClick={handlePayment} disabled={payLoading}>
                    {payLoading
                      ? <><Loader size={16} className={styles.spin}/> Processing…</>
                      : <><CreditCard size={16}/> Pay {fmt(totalFee)}</>
                    }
                  </button>
                  {/* Real Razorpay gateway button — "Pay Enroll Fee", additive, existing Pay button above is untouched */}
                  <RazorpayButton paymentButtonId={RAZORPAY_BUTTON_IDS.admissionEnrollFee} className={styles.rzpBtnWrap} />
                </div>
              </div>
            </div>
          )}

          {/* ─────── STEP 6: Confirmation ─────── */}
          {step === 6 && result && (
            <div className={styles.successSection}>
              <div className={styles.successIcon}><CheckCircle size={48} color="#16a34a"/></div>
              <h2 className={styles.successTitle}>Admission Successful! 🎓</h2>
              <p className={styles.successSub}>Welcome to PrimeTech College. Your account has been created.</p>

              <div className={styles.credBox}>
                <div className={styles.credTitle}>Your Login Credentials</div>
                <div className={styles.credRow}>
                  <span className={styles.credKey}>GR Number</span>
                  <span className={styles.credVal}>{result.grNumber}</span>
                </div>
                <div className={styles.credRow}>
                  <span className={styles.credKey}>Enrollment Number</span>
                  <span className={styles.credVal}>{result.enrollmentNumber}</span>
                </div>
                <div className={styles.credRow}>
                  <span className={styles.credKey}>Student ID</span>
                  <span className={styles.credVal}>{result.studentId}</span>
                </div>
                <div className={styles.credRow}>
                  <span className={styles.credKey}>Student Email</span>
                  <span className={styles.credVal}>{result.emailId}</span>
                </div>
                <div className={styles.credRow}>
                  <span className={styles.credKey}>Password</span>
                  <span className={styles.credVal}>{result.rawPass}</span>
                </div>
                <p className={styles.credNote}>⚠️ Save these credentials. Change your password on first login.</p>
              </div>

              <div className={styles.receiptBox}>
                <div className={styles.receiptTitle}><Receipt size={15}/> Payment Receipt</div>
                {result.receipt && (
                  <div className={styles.receiptRow}>
                    <span>Receipt No</span><span style={{color:'#A67C52',fontWeight:700}}>{result.receipt.receiptNumber}</span>
                  </div>
                )}
                <div className={styles.receiptRow}>
                  <span>Order ID</span><span>{result.orderId}</span>
                </div>
                <div className={styles.receiptRow}>
                  <span>Payment ID</span><span>{result.paymentId}</span>
                </div>
                <div className={styles.receiptRow}>
                  <span>Amount Paid</span><span style={{color:'#16a34a',fontWeight:700}}>{fmt(result.amount)}</span>
                </div>
                <div className={styles.receiptRow}>
                  <span>Status</span><span style={{color:'#16a34a'}}>✓ Paid</span>
                </div>
              </div>

              {result.receipt && (
                <div className={styles.successBtns} style={{ marginBottom: 16 }}>
                  <button className={styles.btnSecondary} onClick={() => setViewReceipt(result.receipt)}>
                    <Receipt size={16}/> View Fee Receipt
                  </button>
                  <button className={styles.btnPay} onClick={() => downloadReceiptPDF(result.receipt)}>
                    <FileText size={16}/> Download Receipt PDF
                  </button>
                </div>
              )}

              <div className={styles.successBtns}>
                <button className={styles.btnPrimary} onClick={()=>navigate('/login')}>
                  Login Now <ArrowRight size={16}/>
                </button>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Fee receipt view / download modal */}
      <ReceiptModal receipt={viewReceipt} onClose={() => setViewReceipt(null)} />

      {/* One-time fees footer note */}
      {step < 6 && (
        <div className={styles.oneTimeFees}>
          <strong>One-Time Fees (at admission):</strong> Admission ₹5,000 · Registration ₹2,000 · ID Card ₹500 · Library Deposit ₹3,000 · Convocation ₹5,000
        </div>
      )}
    </div>
  );
}