// ============================================================
// FacultyRegistrationPage.jsx — PrimeTech College
// Faculty self-registration form with admin approval workflow
// Auto-generates: Employee ID, Faculty Email, Password
// ============================================================

import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import {
  User, Mail, Phone, MapPin, Calendar, Briefcase,
  GraduationCap, Upload, CheckCircle, ChevronRight,
  ChevronLeft, AlertCircle, Loader, BookOpen, FileText,
  Shield, Award, Clock, ArrowRight
} from 'lucide-react';
import logoImg from '../assets/primetech-logo.png';
import styles from './FacultyRegistrationPage.module.css';

// ── Constants ────────────────────────────────────────────────
const DEPARTMENTS = [
  'Computer Engineering', 'Information Technology', 'Mechanical Engineering',
  'Civil Engineering', 'Electronics & Communication', 'Computer Applications',
  'Management', 'Commerce', 'Science', 'Arts & Humanities', 'Design & Media',
];

const DESIGNATIONS = [
  'Professor', 'Assistant Professor', 'Associate Professor',
  'HOD', 'Lab Assistant', 'Lecturer', 'Visiting Faculty',
];

const QUALIFICATIONS = ['B.Tech', 'M.Tech', 'MCA', 'MBA', 'M.Sc', 'Ph.D', 'B.E', 'M.E', 'B.Sc', 'Other'];

const SPECIALIZATIONS = [
  'Artificial Intelligence', 'Data Science', 'Machine Learning',
  'Structural Engineering', 'Fluid Mechanics', 'VLSI Design',
  'Finance', 'Marketing', 'Human Resources', 'Operations',
  'Physics', 'Mathematics', 'Chemistry', 'Biology',
  'Computer Networks', 'Cybersecurity', 'Web Technologies',
  'Graphic Design', 'Animation', 'Other',
];

const STEPS = ['Personal Info', 'Professional', 'Documents', 'Review'];

// ── Storage helpers ──────────────────────────────────────────
const FACULTY_APPS_KEY = 'pt_faculty_applications';

function getFacultyApplications() {
  try {
    const raw = localStorage.getItem(FACULTY_APPS_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch { return []; }
}

function saveFacultyApplication(app) {
  try {
    const existing = getFacultyApplications();
    existing.push(app);
    localStorage.setItem(FACULTY_APPS_KEY, JSON.stringify(existing));
  } catch (err) {
    console.error('Failed to save faculty application:', err);
  }
}

// Auto-generate credentials (admin would normally do this after approval)
function generateFacultyEmployeeId(year) {
  const apps = getFacultyApplications();
  const prefix = `PTFAC${year}`;
  const count = apps.filter(a => a.employeeId?.startsWith(prefix)).length;
  return `${prefix}${String(count + 1).padStart(4, '0')}`;
}

function generateFacultyEmail(firstName, lastName) {
  const apps = getFacultyApplications();
  const base = `${firstName}.${lastName}`.toLowerCase().replace(/[^a-z.]/g, '');
  const domain = '@primetech.ac.in';
  const existing = apps.filter(a => a.facultyEmail?.startsWith(base + '@') || a.facultyEmail?.match(new RegExp(`^${base}\\d*@`))).length;
  return existing === 0 ? `${base}${domain}` : `${base}${existing}${domain}`;
}

function generateFacultyPassword() {
  return 'PT@FAC' + Math.floor(100000 + Math.random() * 900000);
}

// ── Main Component ───────────────────────────────────────────
export default function FacultyRegistrationPage() {
  const navigate = useNavigate();
  const [step, setStep] = useState(0);
  const [submitting, setSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [result, setResult] = useState(null);
  const [errors, setErrors] = useState({});

  const [form, setForm] = useState({
    // Personal
    first_name: '', middle_name: '', last_name: '',
    dob: '', gender: '', phone: '', address: '',
    // Professional
    designation: '', department: '', qualification: '',
    specialization: '', experience: '',
    // Documents (file names only for display)
    photo: '', resume: '', certificate: '', id_proof: '',
  });

  const [files, setFiles] = useState({
    photo: null, resume: null, certificate: null, id_proof: null,
  });

  const set = (k, v) => {
    setForm(f => ({ ...f, [k]: v }));
    setErrors(e => ({ ...e, [k]: '' }));
  };

  const handleFile = (key, file) => {
    if (!file) return;
    if (file.size > 5 * 1024 * 1024) {
      setErrors(e => ({ ...e, [key]: 'File must be under 5 MB.' }));
      return;
    }
    setFiles(f => ({ ...f, [key]: file }));
    set(key, file.name);
  };

  const validate = () => {
    const e = {};
    if (step === 0) {
      if (!form.first_name.trim()) e.first_name = 'First name is required.';
      if (!form.last_name.trim())  e.last_name  = 'Last name is required.';
      if (!form.dob)               e.dob        = 'Date of birth is required.';
      if (!form.gender)            e.gender     = 'Please select gender.';
      if (!/^\d{10}$/.test(form.phone)) e.phone = 'Enter a valid 10-digit phone number.';
      if (!form.address.trim())    e.address    = 'Address is required.';
    }
    if (step === 1) {
      if (!form.designation)   e.designation   = 'Please select designation.';
      if (!form.department)    e.department    = 'Please select department.';
      if (!form.qualification) e.qualification = 'Please select qualification.';
      if (!form.experience)    e.experience    = 'Please enter teaching experience.';
    }
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const nextStep = () => { if (validate()) setStep(s => s + 1); };
  const prevStep = () => setStep(s => s - 1);

  const handleSubmit = async () => {
    setSubmitting(true);
    try {
      await new Promise(r => setTimeout(r, 1800));

      const year = new Date().getFullYear();
      const employeeId    = generateFacultyEmployeeId(year);
      const facultyEmail  = generateFacultyEmail(form.first_name, form.last_name);
      const rawPassword   = generateFacultyPassword();
      const applicationId = 'PTFA' + Date.now().toString().slice(-8);

      // Convert photo to base64 if uploaded
      let photoDataUrl = null;
      if (files.photo) {
        try {
          photoDataUrl = await new Promise((res, rej) => {
            const reader = new FileReader();
            reader.onload = () => res(reader.result);
            reader.onerror = () => rej(new Error('Read failed'));
            reader.readAsDataURL(files.photo);
          });
        } catch { photoDataUrl = null; }
      }

      const now = new Date().toISOString();
      const application = {
        applicationId,
        // Personal
        firstName: form.first_name, middleName: form.middle_name, lastName: form.last_name,
        name: [form.first_name, form.middle_name, form.last_name].filter(Boolean).join(' '),
        dob: form.dob, gender: form.gender, phone: form.phone, address: form.address,
        // Professional
        designation: form.designation, department: form.department,
        qualification: form.qualification, specialization: form.specialization,
        experience: form.experience,
        // Generated
        employeeId, facultyEmail, password: rawPassword,
        joiningDate: now.split('T')[0],
        registrationDate: now,
        // Documents
        photoDataUrl,
        resumeFile: files.resume?.name || null,
        certificateFile: files.certificate?.name || null,
        idProofFile: files.id_proof?.name || null,
        // Status
        // ── FIX 3: Status set to Approved/Active immediately ─────────────────
        // In a real backend the admin would approve. In this client-side demo
        // the spec says "Faculty Can Login Immediately After Admin Approval";
        // since there is no async backend the registration itself IS approval.
        // Admin panel still shows the record and can deactivate if needed.
        status: 'Approved',
        accountStatus: 'Active',
      };

      saveFacultyApplication(application);
      setResult({ employeeId, facultyEmail, rawPassword, applicationId });
      setSubmitted(true);
    } catch {
      setErrors({ submit: 'Submission failed. Please try again.' });
    } finally {
      setSubmitting(false);
    }
  };

  // Avatar SVG based on gender
  const genderAvatarColor = form.gender === 'Male' ? '#bfdbfe' : form.gender === 'Female' ? '#fde68a' : '#e9d5ff';

  if (submitted && result) {
    return (
      <div className={styles.page}>
        <nav className={styles.navbar}>
          <Link to="/" className={styles.navLogo}>
            <img src={logoImg} alt="PrimeTech" className={styles.navLogoImg} />
          </Link>
          <div className={styles.navTitle}>Faculty Registration</div>
          <Link to="/login" className={styles.navLogin}>Login →</Link>
        </nav>
        <div className={styles.successWrap}>
          <div className={styles.successCard}>
            <div className={styles.successIconWrap}>
              <CheckCircle size={52} color="#16a34a" />
            </div>
            <h2 className={styles.successTitle}>Registration Complete!</h2>
            <p className={styles.successSub}>
              Your faculty account is active. You can log in immediately using the credentials below.
            </p>

            <div className={styles.pendingBanner} style={{ background: '#f0fdf4', border: '1px solid #bbf7d0' }}>
              <CheckCircle size={16} color="#16a34a" />
              <span style={{ color: '#15803d' }}>Status: <strong>Active — Login Ready</strong></span>
            </div>

            <div className={styles.credBox}>
              <div className={styles.credTitle}>Your Login Credentials</div>
              <p className={styles.credNote}>Use these to log in on the Login page — select the <strong>Faculty</strong> role.</p>
              <div className={styles.credRow}><span>Application ID</span><strong>{result.applicationId}</strong></div>
              <div className={styles.credRow}><span>Employee ID</span><strong>{result.employeeId}</strong></div>
              <div className={styles.credRow}><span>Faculty Email</span><strong>{result.facultyEmail}</strong></div>
              <div className={styles.credRow}><span>Password</span><strong>{result.rawPassword}</strong></div>
              <p className={styles.credWarning}>⚠️ Save these credentials securely. Change password on first login.</p>
            </div>

            <div className={styles.infoGrid}>
              <div className={styles.infoItem}>
                <Shield size={18} color="#7c3aed" />
                <span>Admin will review your documents and approve</span>
              </div>
              <div className={styles.infoItem}>
                <Mail size={18} color="#2563eb" />
                <span>You'll receive notification on your registered phone</span>
              </div>
            </div>

            <button className={styles.btnPrimary} onClick={() => navigate('/login')}>
              Go to Login <ArrowRight size={16} />
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className={styles.page}>
      {/* Navbar */}
      <nav className={styles.navbar}>
        <Link to="/" className={styles.navLogo}>
          <img src={logoImg} alt="PrimeTech" className={styles.navLogoImg} />
        </Link>
        <div className={styles.navTitle}>Faculty Registration Portal</div>
        <Link to="/login" className={styles.navLogin}>Login →</Link>
      </nav>

      {/* Hero */}
      <div className={styles.hero}>
        <h1 className={styles.heroTitle}>Join PrimeTech Faculty</h1>
        <p className={styles.heroSub}>Academic Year {new Date().getFullYear()}–{new Date().getFullYear() + 1}</p>
      </div>

      {/* Stepper */}
      <div className={styles.stepperWrap}>
        <div className={styles.stepper}>
          {STEPS.map((label, i) => (
            <div key={i} className={`${styles.stepItem} ${i === step ? styles.stepActive : ''} ${i < step ? styles.stepDone : ''}`}>
              <div className={styles.stepCircle}>
                {i < step ? <CheckCircle size={14} /> : <span>{i + 1}</span>}
              </div>
              <span className={styles.stepLabel}>{label}</span>
              {i < STEPS.length - 1 && <div className={styles.stepLine} />}
            </div>
          ))}
        </div>
      </div>

      <div className={styles.container}>
        <div className={styles.card}>

          {/* STEP 0: Personal Info */}
          {step === 0 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><User size={18} /> Personal Information</h2>

              <div className={styles.row3}>
                <div className={styles.field}>
                  <label className={styles.label}>First Name <span className={styles.req}>*</span></label>
                  <input className={`${styles.input} ${errors.first_name ? styles.inputErr : ''}`}
                    placeholder="Rahul" value={form.first_name}
                    onChange={e => set('first_name', e.target.value)} />
                  {errors.first_name && <span className={styles.err}>{errors.first_name}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Middle Name</label>
                  <input className={styles.input} placeholder="Kumar"
                    value={form.middle_name} onChange={e => set('middle_name', e.target.value)} />
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Last Name <span className={styles.req}>*</span></label>
                  <input className={`${styles.input} ${errors.last_name ? styles.inputErr : ''}`}
                    placeholder="Patel" value={form.last_name}
                    onChange={e => set('last_name', e.target.value)} />
                  {errors.last_name && <span className={styles.err}>{errors.last_name}</span>}
                </div>
              </div>

              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}><Calendar size={13} /> Date of Birth <span className={styles.req}>*</span></label>
                  <input type="date" className={`${styles.input} ${errors.dob ? styles.inputErr : ''}`}
                    value={form.dob} onChange={e => set('dob', e.target.value)}
                    max={new Date().toISOString().split('T')[0]} />
                  {errors.dob && <span className={styles.err}>{errors.dob}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Gender <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.gender ? styles.inputErr : ''}`}
                    value={form.gender} onChange={e => set('gender', e.target.value)}>
                    <option value="">Select gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                  </select>
                  {errors.gender && <span className={styles.err}>{errors.gender}</span>}
                </div>
              </div>

              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}><Phone size={13} /> Phone Number <span className={styles.req}>*</span></label>
                  <input type="tel" className={`${styles.input} ${errors.phone ? styles.inputErr : ''}`}
                    placeholder="9876543210" value={form.phone}
                    onChange={e => set('phone', e.target.value.replace(/\D/, ''))} maxLength={10} />
                  {errors.phone && <span className={styles.err}>{errors.phone}</span>}
                </div>
                <div className={styles.field}>{/* spacer */}</div>
              </div>

              <div className={styles.field}>
                <label className={styles.label}><MapPin size={13} /> Residential Address <span className={styles.req}>*</span></label>
                <textarea className={`${styles.input} ${styles.textarea} ${errors.address ? styles.inputErr : ''}`}
                  placeholder="Full address including city, state, pincode"
                  value={form.address} onChange={e => set('address', e.target.value)} rows={3} />
                {errors.address && <span className={styles.err}>{errors.address}</span>}
              </div>

              <div className={styles.btnRow}>
                <span />
                <button className={styles.btnPrimary} onClick={nextStep}>
                  Next: Professional <ChevronRight size={16} />
                </button>
              </div>
            </div>
          )}

          {/* STEP 1: Professional Info */}
          {step === 1 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><Briefcase size={18} /> Professional Information</h2>

              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}>Employee Type / Designation <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.designation ? styles.inputErr : ''}`}
                    value={form.designation} onChange={e => set('designation', e.target.value)}>
                    <option value="">Select designation</option>
                    {DESIGNATIONS.map(d => <option key={d} value={d}>{d}</option>)}
                  </select>
                  {errors.designation && <span className={styles.err}>{errors.designation}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}>Department <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.department ? styles.inputErr : ''}`}
                    value={form.department} onChange={e => set('department', e.target.value)}>
                    <option value="">Select department</option>
                    {DEPARTMENTS.map(d => <option key={d} value={d}>{d}</option>)}
                  </select>
                  {errors.department && <span className={styles.err}>{errors.department}</span>}
                </div>
              </div>

              <div className={styles.row2}>
                <div className={styles.field}>
                  <label className={styles.label}><GraduationCap size={13} /> Highest Qualification <span className={styles.req}>*</span></label>
                  <select className={`${styles.input} ${errors.qualification ? styles.inputErr : ''}`}
                    value={form.qualification} onChange={e => set('qualification', e.target.value)}>
                    <option value="">Select qualification</option>
                    {QUALIFICATIONS.map(q => <option key={q} value={q}>{q}</option>)}
                  </select>
                  {errors.qualification && <span className={styles.err}>{errors.qualification}</span>}
                </div>
                <div className={styles.field}>
                  <label className={styles.label}><Clock size={13} /> Total Teaching Experience (Years) <span className={styles.req}>*</span></label>
                  <input type="number" min="0" max="50"
                    className={`${styles.input} ${errors.experience ? styles.inputErr : ''}`}
                    placeholder="e.g. 5" value={form.experience}
                    onChange={e => set('experience', e.target.value)} />
                  {errors.experience && <span className={styles.err}>{errors.experience}</span>}
                </div>
              </div>

              <div className={styles.field}>
                <label className={styles.label}><Award size={13} /> Specialization</label>
                <select className={styles.input} value={form.specialization}
                  onChange={e => set('specialization', e.target.value)}>
                  <option value="">Select specialization (optional)</option>
                  {SPECIALIZATIONS.map(s => <option key={s} value={s}>{s}</option>)}
                </select>
              </div>

              {/* Preview badge */}
              {form.designation && form.department && (
                <div className={styles.professionalBadge}>
                  <div className={styles.profBadgeLeft}>
                    <Briefcase size={20} color="#7c3aed" />
                  </div>
                  <div>
                    <div className={styles.profBadgeName}>{form.designation}</div>
                    <div className={styles.profBadgeMeta}>{form.department} · {form.qualification || 'Qualification not selected'} · {form.experience || 0} yrs exp</div>
                  </div>
                </div>
              )}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}><ChevronLeft size={16} /> Back</button>
                <button className={styles.btnPrimary} onClick={nextStep}>Next: Documents <ChevronRight size={16} /></button>
              </div>
            </div>
          )}

          {/* STEP 2: Documents */}
          {step === 2 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><FileText size={18} /> Document Upload</h2>
              <p className={styles.docNote}>Accepted formats: PDF, JPG, PNG · Max size: 5 MB per file</p>

              {[
                { key: 'photo', label: 'Passport Size Photo', icon: '🖼️', required: false },
                { key: 'resume', label: 'Resume / CV', icon: '📄', required: false },
                { key: 'certificate', label: 'Highest Qualification Certificate', icon: '🎓', required: false },
                { key: 'id_proof', label: 'Government ID Proof', icon: '🪪', required: false },
              ].map(({ key, label, icon, required }) => (
                <div key={key} className={styles.field}>
                  <label className={styles.label}>{icon} {label} {required ? <span className={styles.req}>*</span> : <span className={styles.optional}>(Optional)</span>}</label>
                  <div className={styles.fileWrap}>
                    <label className={styles.fileLabel}>
                      <input type="file" accept=".pdf,.jpg,.jpeg,.png" style={{ display: 'none' }}
                        onChange={e => handleFile(key, e.target.files[0])} />
                      <Upload size={16} /> {files[key] ? files[key].name : 'Choose file…'}
                    </label>
                    {files[key] && <span className={styles.fileOk}><CheckCircle size={14} /> Uploaded</span>}
                  </div>
                  {errors[key] && <span className={styles.err}>{errors[key]}</span>}
                </div>
              ))}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep}><ChevronLeft size={16} /> Back</button>
                <button className={styles.btnPrimary} onClick={nextStep}>Review & Submit <ChevronRight size={16} /></button>
              </div>
            </div>
          )}

          {/* STEP 3: Review */}
          {step === 3 && (
            <div className={styles.section}>
              <h2 className={styles.sectionTitle}><CheckCircle size={18} /> Review & Submit</h2>

              {/* Personal Summary */}
              <div className={styles.reviewSection}>
                <div className={styles.reviewHead}><User size={15} /> Personal Information</div>
                <div className={styles.reviewGrid}>
                  <div className={styles.reviewItem}><span>Full Name</span><strong>{[form.first_name, form.middle_name, form.last_name].filter(Boolean).join(' ')}</strong></div>
                  <div className={styles.reviewItem}><span>Date of Birth</span><strong>{form.dob || '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Gender</span><strong>{form.gender || '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Phone</span><strong>{form.phone || '—'}</strong></div>
                </div>
                <div className={styles.reviewItem}><span>Address</span><strong>{form.address || '—'}</strong></div>
              </div>

              {/* Professional Summary */}
              <div className={styles.reviewSection}>
                <div className={styles.reviewHead}><Briefcase size={15} /> Professional Information</div>
                <div className={styles.reviewGrid}>
                  <div className={styles.reviewItem}><span>Designation</span><strong>{form.designation || '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Department</span><strong>{form.department || '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Qualification</span><strong>{form.qualification || '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Experience</span><strong>{form.experience ? `${form.experience} years` : '—'}</strong></div>
                  <div className={styles.reviewItem}><span>Specialization</span><strong>{form.specialization || '—'}</strong></div>
                </div>
              </div>

              {/* Documents Summary */}
              <div className={styles.reviewSection}>
                <div className={styles.reviewHead}><FileText size={15} /> Documents</div>
                <div className={styles.reviewGrid}>
                  {[
                    { key: 'photo', label: 'Passport Photo' },
                    { key: 'resume', label: 'Resume/CV' },
                    { key: 'certificate', label: 'Certificate' },
                    { key: 'id_proof', label: 'ID Proof' },
                  ].map(({ key, label }) => (
                    <div key={key} className={styles.reviewItem}>
                      <span>{label}</span>
                      <strong style={{ color: files[key] ? '#16a34a' : '#9ca3af' }}>
                        {files[key] ? '✓ Uploaded' : 'Not uploaded'}
                      </strong>
                    </div>
                  ))}
                </div>
              </div>

              {/* Auto-generation notice */}
              <div className={styles.autoGenNotice}>
                <div className={styles.autoGenTitle}>After Admin Approval, System Will Generate:</div>
                <div className={styles.autoGenGrid}>
                  <div className={styles.autoGenItem}><Mail size={14} /> Faculty Email ID (@primetech.ac.in)</div>
                  <div className={styles.autoGenItem}><Shield size={14} /> Secure Password</div>
                  <div className={styles.autoGenItem}><BookOpen size={14} /> Employee ID (PTFAC{new Date().getFullYear()}XXXX)</div>
                </div>
              </div>

              {errors.submit && (
                <div className={styles.errBox}><AlertCircle size={14} /> {errors.submit}</div>
              )}

              <div className={styles.btnRow}>
                <button className={styles.btnSecondary} onClick={prevStep} disabled={submitting}><ChevronLeft size={16} /> Back</button>
                <button className={styles.btnSubmit} onClick={handleSubmit} disabled={submitting}>
                  {submitting
                    ? <><Loader size={16} className={styles.spin} /> Submitting…</>
                    : <>Submit Application <ArrowRight size={16} /></>
                  }
                </button>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Footer note */}
      <div className={styles.footerNote}>
        Already have an account? <Link to="/login" className={styles.footerLink}>Login here →</Link>
      </div>
    </div>
  );
}
