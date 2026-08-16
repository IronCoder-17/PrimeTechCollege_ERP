// ============================================================
// EditProfilePage — Full Student Profile Editor
// PrimeTech College Campus Connect
// Fetches all student data from context (backed by localStorage)
// Read-only: GR Number, Enrollment, Email, Course, Admission Year
// Editable: Phone, Address, Profile Photo, Password
// ============================================================

import { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  User, Mail, Phone, MapPin, Calendar, BookOpen,
  GraduationCap, Shield, Lock, Eye, EyeOff,
  Camera, Save, CheckCircle, AlertCircle,
  FileText, CreditCard, Clock, Hash, BadgeCheck,
  ChevronRight, RotateCcw, Upload
} from 'lucide-react';
import { useAuth } from '../contexts/AuthContext';
import styles from './EditProfilePage.module.css';

// ── Helpers ───────────────────────────────────────────────────────────────────
const fmt = (n) => n ? '₹' + Number(n).toLocaleString('en-IN') : '₹0';
const fmtDate = (d) => {
  if (!d) return '—';
  try { return new Date(d).toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' }); }
  catch { return d; }
};

function ReadOnlyField({ label, value, icon: Icon, badge }) {
  return (
    <div className={styles.field}>
      <label className={styles.fieldLabel}>
        {Icon && <Icon size={13} className={styles.fieldIcon} />}
        {label}
        <span className={styles.readOnlyTag}>Read-only</span>
      </label>
      <div className={styles.readOnlyVal}>
        {value || '—'}
        {badge && <span className={`badge badge-blue`} style={{ marginLeft: 8, fontSize: 11 }}>{badge}</span>}
      </div>
    </div>
  );
}

function EditField({ label, icon: Icon, error, children }) {
  return (
    <div className={styles.field}>
      <label className={styles.fieldLabel}>
        {Icon && <Icon size={13} className={styles.fieldIcon} />}
        {label}
      </label>
      {children}
      {error && <p className={styles.fieldError}><AlertCircle size={12}/> {error}</p>}
    </div>
  );
}

// ── Section header ────────────────────────────────────────────────────────────
function SectionCard({ title, icon: Icon, color = '#8B7355', children }) {
  return (
    <div className={`${styles.sectionCard} card`}>
      <div className={styles.sectionHeader}>
        <div className={styles.sectionIconWrap} style={{ background: `${color}18` }}>
          <Icon size={16} color={color} />
        </div>
        <h2 className={styles.sectionTitle}>{title}</h2>
      </div>
      <div className={styles.sectionBody}>{children}</div>
    </div>
  );
}

// ── Main Component ────────────────────────────────────────────────────────────
export default function EditProfilePage() {
  const { user, updateUser } = useAuth();
  const navigate = useNavigate();

  // Editable fields
  const [phone, setPhone] = useState(user?.phone || '');
  const [address, setAddress] = useState(user?.address || '');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPass, setShowPass] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  // Photo
  const [photoPreview, setPhotoPreview] = useState(user?.photoDataUrl || user?.avatar || null);
  const [photoFile, setPhotoFile] = useState(null);
  const fileRef = useRef();

  // UI state
  const [errors, setErrors] = useState({});
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  // Reset saved indicator after 3s
  useEffect(() => {
    if (saved) {
      const t = setTimeout(() => setSaved(false), 3000);
      return () => clearTimeout(t);
    }
  }, [saved]);

  const handlePhotoChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (file.size > 5 * 1024 * 1024) {
      setErrors(prev => ({ ...prev, photo: 'Photo must be under 5 MB.' }));
      return;
    }
    setErrors(prev => ({ ...prev, photo: '' }));
    setPhotoFile(file);
    const reader = new FileReader();
    reader.onload = () => setPhotoPreview(reader.result);
    reader.readAsDataURL(file);
  };

  const validate = () => {
    const e = {};
    if (phone && !/^\d{10}$/.test(phone.trim())) {
      e.phone = 'Enter a valid 10-digit phone number.';
    }
    if (newPassword) {
      if (newPassword.length < 6) e.newPassword = 'Password must be at least 6 characters.';
      if (newPassword !== confirmPassword) e.confirmPassword = 'Passwords do not match.';
    }
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSave = async () => {
    if (!validate()) return;
    setSaving(true);
    try {
      await new Promise(r => setTimeout(r, 800));

      const updates = {};

      if (phone.trim()) updates.phone = phone.trim();
      if (address.trim()) updates.address = address.trim();
      if (newPassword) updates.password = newPassword;

      if (photoFile) {
        const dataUrl = await new Promise((res, rej) => {
          const reader = new FileReader();
          reader.onload = () => res(reader.result);
          reader.onerror = () => rej(new Error('Read failed'));
          reader.readAsDataURL(photoFile);
        });
        updates.avatar = dataUrl;
        updates.photoDataUrl = dataUrl;
      }

      updateUser(updates);

      // Also update admission account in localStorage (for student accounts)
      try {
        const key = 'ccc_admission_accounts';
        const raw = localStorage.getItem(key);
        if (raw) {
          const accounts = JSON.parse(raw);
          const idx = accounts.findIndex(a => a.email?.toLowerCase() === user?.email?.toLowerCase());
          if (idx !== -1) {
            if (updates.phone)       accounts[idx].phone       = updates.phone;
            if (updates.address)     accounts[idx].address     = updates.address;
            if (updates.password)    accounts[idx].password    = updates.password;
            if (updates.photoDataUrl) accounts[idx].photoDataUrl = updates.photoDataUrl;
            localStorage.setItem(key, JSON.stringify(accounts));
          }
        }
      } catch { /* silent */ }

      // Also update faculty application in localStorage (for faculty accounts)
      try {
        if (user?.role === 'faculty') {
          const fkey = 'pt_faculty_applications';
          const fraw = localStorage.getItem(fkey);
          if (fraw) {
            const apps = JSON.parse(fraw);
            const idx = apps.findIndex(a =>
              a.employeeId?.toLowerCase() === user?.employeeId?.toLowerCase() ||
              a.facultyEmail?.toLowerCase() === user?.email?.toLowerCase()
            );
            if (idx !== -1) {
              if (updates.phone)        apps[idx].phone        = updates.phone;
              if (updates.address)      apps[idx].address      = updates.address;
              if (updates.password)     apps[idx].password     = updates.password;
              if (updates.photoDataUrl) apps[idx].photoDataUrl = updates.photoDataUrl;
              localStorage.setItem(fkey, JSON.stringify(apps));
            }
          }
        }
      } catch { /* silent */ }

      setSaved(true);
      setNewPassword('');
      setConfirmPassword('');
      setPhotoFile(null);
    } finally {
      setSaving(false);
    }
  };

  // Gender avatar fallback
  const avatarSrc = photoPreview || (
    user?.gender === 'female'
      ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=ffdfba&topType=LongHairStraight&facialHairType=Blank&clotheType=BlazerShirt`
      : user?.gender === 'male'
      ? `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=b6e3f4&topType=ShortHairShortRound&facialHairType=Blank&clotheType=BlazerShirt`
      : `https://api.dicebear.com/7.x/avataaars/svg?seed=${user?.name}&backgroundColor=c0aede`
  );

  // Payment history
  const payHistory = user?.paymentHistory || [];

  return (
    <div className={styles.page}>
      {/* ── Page header ── */}
      <div className={styles.pageHeader}>
        <div>
          <h1 className={styles.pageTitle}>Edit Profile</h1>
          <p className={styles.pageSubtitle}>View your academic details and update allowed information</p>
        </div>
        <div className={styles.pageActions}>
          {saved && (
            <span className={styles.savedMsg}>
              <CheckCircle size={15} color="#16a34a" /> Saved successfully
            </span>
          )}
          <button className="btn btn-secondary" onClick={() => navigate(-1)}>
            Cancel
          </button>
          <button
            className="btn btn-primary"
            onClick={handleSave}
            disabled={saving}
          >
            {saving ? <><span className="spinner" style={{ width: 14, height: 14 }} /> Saving…</> : <><Save size={15} /> Save Changes</>}
          </button>
        </div>
      </div>

      <div className={styles.grid}>
        {/* ── LEFT COLUMN ── */}
        <div className={styles.leftCol}>

          {/* Profile Photo Card */}
          <div className={`${styles.photoCard} card`}>
            <div className={styles.photoWrap}>
              <img src={avatarSrc} alt={user?.name} className={styles.profilePhoto} />
              <button
                className={styles.photoEditBtn}
                onClick={() => fileRef.current?.click()}
                title="Change photo"
              >
                <Camera size={14} />
              </button>
              <input
                ref={fileRef}
                type="file"
                accept="image/*"
                style={{ display: 'none' }}
                onChange={handlePhotoChange}
              />
            </div>
            <h2 className={styles.photoName}>{user?.name || 'Student'}</h2>
            <p className={styles.photoEnroll}>{user?.enrollmentNumber || user?.grNumber || ''}</p>
            <span className={`badge badge-green`} style={{ fontSize: 11 }}>
              ● {user?.accountStatus || 'Active'}
            </span>
            {errors.photo && (
              <p className={styles.fieldError} style={{ marginTop: 8 }}>
                <AlertCircle size={12}/> {errors.photo}
              </p>
            )}
            <button
              className={`btn btn-secondary ${styles.photoUploadBtn}`}
              onClick={() => fileRef.current?.click()}
            >
              <Upload size={14} /> Change Photo
            </button>
            <p className={styles.photoHint}>JPG, PNG or GIF · Max 5 MB</p>
          </div>

          {/* Account Information */}
          <SectionCard title="Account Information" icon={Shield} color="#e05a5a">
            <ReadOnlyField label={user?.role === 'faculty' ? 'Faculty Email' : 'Student Email'} value={user?.email} icon={Mail} />
            <ReadOnlyField label="Account Status" value={user?.accountStatus || 'Active'} icon={Shield} badge="Active" />
            <ReadOnlyField label="Registration Date" value={fmtDate(user?.registrationDate)} icon={Clock} />
            {user?.role === 'faculty' && (
              <>
                <ReadOnlyField label="Employee ID"   value={user?.employeeId}   icon={Hash} />
                <ReadOnlyField label="Joining Date"  value={fmtDate(user?.joiningDate)} icon={Calendar} />
              </>
            )}
          </SectionCard>

        </div>

        {/* ── RIGHT COLUMN ── */}
        <div className={styles.rightCol}>

          {/* Personal Information */}
          <SectionCard title="Personal Information" icon={User} color="#2563eb">
            <div className={styles.fieldsGrid}>
              <ReadOnlyField label="First Name" value={user?.firstName || user?.name?.split(' ')[0]} icon={User} />
              <ReadOnlyField label="Middle Name" value={user?.middleName || '—'} icon={User} />
              <ReadOnlyField label="Last Name" value={user?.lastName || user?.name?.split(' ').slice(-1)[0]} icon={User} />
              <ReadOnlyField label="Date of Birth" value={fmtDate(user?.dob)} icon={Calendar} />
              <ReadOnlyField label="Gender" value={user?.gender ? user.gender.charAt(0).toUpperCase() + user.gender.slice(1) : '—'} icon={User} />
            </div>

            {/* Editable: Phone */}
            <EditField label="Phone Number" icon={Phone} error={errors.phone}>
              <input
                type="tel"
                className={`${styles.input} ${errors.phone ? styles.inputError : ''}`}
                value={phone}
                onChange={e => { setPhone(e.target.value); setErrors(p => ({ ...p, phone: '' })); }}
                placeholder="10-digit mobile number"
                maxLength={10}
              />
            </EditField>

            {/* Editable: Address */}
            <EditField label="Residential Address" icon={MapPin} error={errors.address}>
              <textarea
                className={`${styles.textarea} ${errors.address ? styles.inputError : ''}`}
                value={address}
                onChange={e => { setAddress(e.target.value); setErrors(p => ({ ...p, address: '' })); }}
                placeholder="Enter your residential address"
                rows={3}
              />
            </EditField>
          </SectionCard>

          {/* Faculty Professional Information (only for faculty) */}
          {user?.role === 'faculty' && (
            <SectionCard title="Professional Information" icon={GraduationCap} color="#7c3aed">
              <div className={styles.fieldsGrid}>
                <ReadOnlyField label="Designation"    value={user?.designation}    icon={GraduationCap} />
                <ReadOnlyField label="Department"     value={user?.department}     icon={BookOpen} />
                <ReadOnlyField label="Qualification"  value={user?.qualification}  icon={GraduationCap} />
                <ReadOnlyField label="Specialization" value={user?.specialization} icon={BookOpen} />
                <ReadOnlyField label="Experience"     value={user?.experience ? `${user.experience} years` : '—'} icon={Clock} />
              </div>
            </SectionCard>
          )}

          {/* Academic Information (only for students) */}
          {user?.role !== 'faculty' && (
            <SectionCard title="Academic Information" icon={GraduationCap} color="#7c3aed">
              <div className={styles.fieldsGrid}>
                <ReadOnlyField label="GR Number" value={user?.grNumber} icon={Hash} />
                <ReadOnlyField label="Enrollment Number" value={user?.enrollmentNumber} icon={BadgeCheck} />
                <ReadOnlyField label="Student ID" value={user?.studentId} icon={Hash} />
                <ReadOnlyField label="Course" value={user?.course || user?.major} icon={BookOpen} />
                <ReadOnlyField label="Current Semester" value={user?.semester ? `Semester ${user.semester}` : user?.year} icon={BookOpen} />
                <ReadOnlyField label="Admission Year" value={user?.admissionYear} icon={Calendar} />
              </div>
            </SectionCard>
          )}

          {/* Documents */}
          <SectionCard title="Documents" icon={FileText} color="#059669">
            <div className={styles.docsList}>
              <div className={styles.docItem}>
                <div className={styles.docInfo}>
                  <FileText size={15} color="#2563eb" />
                  <span className={styles.docName}>Passport Size Photo</span>
                </div>
                <span className={`badge ${user?.photoDataUrl ? 'badge-green' : 'badge-amber'}`}>
                  {user?.photoDataUrl ? '✓ Uploaded' : 'Not Uploaded'}
                </span>
              </div>
              <div className={styles.docItem}>
                <div className={styles.docInfo}>
                  <FileText size={15} color="#7c3aed" />
                  <span className={styles.docName}>10th Marksheet</span>
                </div>
                <span className={`badge ${user?.tenthDocument ? 'badge-green' : 'badge-amber'}`}>
                  {user?.tenthDocument ? '✓ Uploaded' : 'Not Uploaded'}
                </span>
              </div>
              <div className={styles.docItem}>
                <div className={styles.docInfo}>
                  <FileText size={15} color="#d97706" />
                  <span className={styles.docName}>12th Marksheet</span>
                </div>
                <span className={`badge ${user?.twelfthDocument ? 'badge-green' : 'badge-amber'}`}>
                  {user?.twelfthDocument ? '✓ Uploaded' : 'Not Uploaded'}
                </span>
              </div>
            </div>

            {/* Change Profile Photo section */}
            <div className={styles.docUploadSection}>
              <p className={styles.docUploadLabel}>Update Profile Photo</p>
              <button
                className="btn btn-secondary"
                style={{ width: '100%', justifyContent: 'center' }}
                onClick={() => fileRef.current?.click()}
              >
                <Camera size={14} /> Choose New Photo
              </button>
            </div>
          </SectionCard>

          {/* Fee Information */}
          <SectionCard title="Fee Information" icon={CreditCard} color="#d97706">
            <div className={styles.feeGrid}>
              <div className={styles.feeItem}>
                <span className={styles.feeLabel}>Total Fee</span>
                <span className={styles.feeVal} style={{ color: '#1f2937' }}>{fmt(user?.totalFee)}</span>
              </div>
              <div className={styles.feeItem}>
                <span className={styles.feeLabel}>Paid Fee</span>
                <span className={styles.feeVal} style={{ color: '#16a34a' }}>{fmt(user?.paidFee)}</span>
              </div>
              <div className={styles.feeItem}>
                <span className={styles.feeLabel}>Pending Fee</span>
                <span className={styles.feeVal} style={{ color: user?.pendingFee > 0 ? '#e05a5a' : '#16a34a' }}>
                  {fmt(user?.pendingFee)}
                </span>
              </div>
            </div>

            {payHistory.length > 0 && (
              <div className={styles.payHistory}>
                <p className={styles.payHistoryTitle}>Payment History</p>
                {payHistory.map((p, i) => (
                  <div key={i} className={styles.payRow}>
                    <div>
                      <div className={styles.payMode}>{p.mode}</div>
                      <div className={styles.payDate}>{fmtDate(p.date)}</div>
                      <div className={styles.payId}>ID: {p.paymentId}</div>
                    </div>
                    <div style={{ textAlign: 'right' }}>
                      <div className={styles.payAmount}>{fmt(p.amount)}</div>
                      <span className="badge badge-green" style={{ fontSize: 10 }}>✓ {p.status}</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </SectionCard>

          {/* Hostel Information — only for hostel students */}
          {user?.hostelRequired && (
            <SectionCard title="Hostel Information" icon={MapPin} color="#2563eb">
              <div className={styles.fieldsGrid}>
                <ReadOnlyField label="Hostel Required" value="Yes" icon={MapPin} />
                <ReadOnlyField label="Hostel Status"   value={user?.hostelStatus || 'Active'} icon={Shield} badge="Active" />
                <ReadOnlyField label="Hostel Type"     value={user?.hostelType || '—'} icon={MapPin} />
                <ReadOnlyField label="Room Type"       value={user?.roomType   || '—'} icon={MapPin} />
                <ReadOnlyField label="Room Number"     value={user?.hostelRoomNumber || 'Pending Allocation'} icon={MapPin} />
                <ReadOnlyField label="Allocation Status" value={user?.hostelAllocationStatus || 'Pending'} icon={Clock} />
                <ReadOnlyField label="Hostel Fee"      value={user?.hostelFee ? fmt(user.hostelFee) : '—'} icon={CreditCard} />
                <ReadOnlyField label="Payment Status"  value={user?.hostelPaymentStatus || 'Paid'} icon={Shield} badge="Paid" />
                <ReadOnlyField label="Admission Date"  value={user?.hostelAdmissionDate ? new Date(user.hostelAdmissionDate).toLocaleDateString('en-IN') : '—'} icon={Calendar} />
              </div>
            </SectionCard>
          )}

          {/* Transportation Information — only for students who opted in */}
          {user?.transportRequired && (
            <SectionCard title="Transportation Information" icon={MapPin} color="#16a34a">
              <div className={styles.fieldsGrid}>
                <ReadOnlyField label="Transportation Required" value="Yes" icon={MapPin} />
                <ReadOnlyField label="Location"          value={user?.transportLocation || '—'} icon={MapPin} />
                <ReadOnlyField label="Bus Number"         value={user?.busNumber || '—'} icon={Hash} />
                <ReadOnlyField label="Transportation Fee" value={user?.transportFee ? fmt(user.transportFee) : '—'} icon={CreditCard} />
                <ReadOnlyField label="Payment Status"     value={user?.transportPaymentStatus || 'Paid'} icon={Shield} badge="Paid" />
              </div>
            </SectionCard>
          )}

          {/* Change Password */}
          <SectionCard title="Change Password" icon={Lock} color="#e05a5a">
            <p className={styles.passHint}>Leave blank if you don't want to change your password.</p>
            <div className={styles.fieldsGrid}>
              <EditField label="New Password" icon={Lock} error={errors.newPassword}>
                <div className={styles.passWrap}>
                  <input
                    type={showPass ? 'text' : 'password'}
                    className={`${styles.input} ${errors.newPassword ? styles.inputError : ''}`}
                    value={newPassword}
                    onChange={e => { setNewPassword(e.target.value); setErrors(p => ({ ...p, newPassword: '' })); }}
                    placeholder="Min. 6 characters"
                  />
                  <button
                    type="button"
                    className={styles.eyeBtn}
                    onClick={() => setShowPass(s => !s)}
                  >
                    {showPass ? <EyeOff size={15} /> : <Eye size={15} />}
                  </button>
                </div>
              </EditField>

              <EditField label="Confirm New Password" icon={Lock} error={errors.confirmPassword}>
                <div className={styles.passWrap}>
                  <input
                    type={showConfirm ? 'text' : 'password'}
                    className={`${styles.input} ${errors.confirmPassword ? styles.inputError : ''}`}
                    value={confirmPassword}
                    onChange={e => { setConfirmPassword(e.target.value); setErrors(p => ({ ...p, confirmPassword: '' })); }}
                    placeholder="Re-enter new password"
                  />
                  <button
                    type="button"
                    className={styles.eyeBtn}
                    onClick={() => setShowConfirm(s => !s)}
                  >
                    {showConfirm ? <EyeOff size={15} /> : <Eye size={15} />}
                  </button>
                </div>
              </EditField>
            </div>
          </SectionCard>

          {/* Save / Cancel bottom buttons */}
          <div className={styles.bottomActions}>
            <button className="btn btn-secondary" onClick={() => navigate(-1)}>
              <RotateCcw size={14} /> Cancel
            </button>
            <button
              className="btn btn-primary"
              onClick={handleSave}
              disabled={saving}
              style={{ minWidth: 140 }}
            >
              {saving
                ? <><span className="spinner" style={{ width: 14, height: 14 }} /> Saving…</>
                : <><Save size={15} /> Save Changes</>
              }
            </button>
          </div>

        </div>
      </div>
    </div>
  );
}
