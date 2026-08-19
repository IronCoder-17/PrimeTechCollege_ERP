// ============================================================
// receiptPdf — Premium PDF Receipt Generator
// PrimeTech College — Fee Receipt Generation Module
//
// Builds a print-ready, single-page HTML receipt styled with the
// "Premium Beige & White" theme and PrimeTech College branding.
// Used both for the in-app receipt preview (rendered inside an
// <iframe srcDoc={...}>) and for "Download PDF" — opening the same
// markup in a new tab and triggering the browser's print dialog so
// the user can save it as a real PDF (works on desktop, tablet and
// mobile, and is print-friendly).
// ============================================================

import logoUrl from '../assets/primetech-logo.png';

// ── Premium Beige & White Theme ─────────────────────────────
const THEME = {
  bgPrimary:   '#FAF7F2',
  bgSecondary: '#F5EFE6',
  border:      '#D6C7B0',
  textPrimary: '#3E3228',
  textMuted:   '#6B5B4D',
  accent:      '#A67C52',
  success:     '#4F7942',
  white:       '#FFFFFF',
};

const STATUS_STYLES = {
  Paid:           { bg: '#E8F1E4', color: THEME.success, label: 'PAID SUCCESSFULLY' },
  'Partial Paid': { bg: '#F3E6D6', color: THEME.accent,  label: 'PARTIAL PAID' },
  Pending:        { bg: '#FBEAEA', color: '#B3261E',     label: 'PENDING' },
};

// ── College contact details shown in the receipt header ─────
const COLLEGE = {
  name: 'PRIMETECH COLLEGE',
  tagline: 'Excellence in Education',
  address: 'Ahmedabad, Gujarat, India',
  phone: '+91 79 1234 5678',
  website: 'www.primetechcollege.edu.in',
};

// ── Helpers ──────────────────────────────────────────────────
function esc(value) {
  return String(value ?? '').replace(/[&<>"']/g, (ch) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;',
  }[ch]));
}

export function formatCurrency(amount) {
  const n = Number(amount) || 0;
  return `₹ ${n.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

export function formatReceiptDate(value) {
  const d = value ? new Date(value) : new Date();
  if (Number.isNaN(d.getTime())) return String(value);
  return d.toLocaleDateString('en-IN', { day: '2-digit', month: 'long', year: 'numeric' });
}

// Fetches the bundled PrimeTech logo and returns it as a base64
// data URI so it renders correctly inside print windows / iframes
// regardless of document origin.
export async function getLogoDataUrl() {
  try {
    const res = await fetch(logoUrl);
    const blob = await res.blob();
    return await new Promise((resolve) => {
      const reader = new FileReader();
      reader.onloadend = () => resolve(reader.result);
      reader.onerror = () => resolve(null);
      reader.readAsDataURL(blob);
    });
  } catch {
    return null;
  }
}

// ── Receipt HTML builder ────────────────────────────────────
// receipt: { receiptNumber, transactionId, feeType, amount,
//            paymentMethod, paymentDate, status, studentName,
//            enrollmentNumber, department, semester, academicYear }
export function buildReceiptHTML(receipt, { logo = null, autoPrint = false } = {}) {
  const r = receipt || {};
  const statusStyle = STATUS_STYLES[r.status] || STATUS_STYLES.Paid;
  const amountFormatted = formatCurrency(r.amount);
  const dateFormatted = formatReceiptDate(r.paymentDate);

  const logoMarkup = logo
    ? `<img src="${logo}" alt="PrimeTech College logo" />`
    : `<div class="logo-fallback">PT</div>`;

  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>${esc(r.receiptNumber)} — PrimeTech College Fee Receipt</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&amp;family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet">
<style>
  :root {
    --bg-primary: ${THEME.bgPrimary};
    --bg-secondary: ${THEME.bgSecondary};
    --border-color: ${THEME.border};
    --text-primary: ${THEME.textPrimary};
    --text-secondary: ${THEME.textMuted};
    --accent: ${THEME.accent};
    --success: ${THEME.success};
    --white: ${THEME.white};
  }
  * { box-sizing: border-box; }
  html, body { margin: 0; }
  body {
    font-family: 'Inter', 'Plus Jakarta Sans', -apple-system, sans-serif;
    background: var(--bg-primary);
    color: var(--text-primary);
    padding: 28px 16px;
    display: flex;
    justify-content: center;
  }
  .receipt {
    width: 100%;
    max-width: 680px;
    background: var(--white);
    border: 1px solid var(--border-color);
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(166,124,82,0.14);
    overflow: hidden;
  }
  .header {
    background: linear-gradient(135deg, var(--bg-secondary), var(--bg-primary));
    border-bottom: 1px solid var(--border-color);
    padding: 24px 28px;
    display: flex;
    align-items: center;
    gap: 16px;
  }
  .header img {
    width: 56px; height: 56px; object-fit: contain; border-radius: 12px;
    background: var(--white); padding: 4px; border: 1px solid var(--border-color);
    flex-shrink: 0;
  }
  .logo-fallback {
    width: 56px; height: 56px; border-radius: 12px; flex-shrink: 0;
    background: var(--accent); color: var(--white);
    display: flex; align-items: center; justify-content: center;
    font-family: 'Playfair Display', serif; font-weight: 700; font-size: 20px;
  }
  .college-name { text-align: center; flex: 1; min-width: 0; }
  .college-name h1 {
    font-family: 'Playfair Display', serif;
    font-size: 22px; font-weight: 700; letter-spacing: 0.06em;
    margin: 0 0 4px; color: var(--text-primary);
  }
  .college-name .tagline {
    font-size: 11px; color: var(--text-secondary); letter-spacing: 0.12em;
    text-transform: uppercase; margin-bottom: 6px; font-weight: 600;
  }
  .college-name .address { font-size: 12px; color: var(--text-secondary); line-height: 1.6; }
  .header .spacer { width: 56px; flex-shrink: 0; }

  .titlebar {
    text-align: center; padding: 18px 0 4px;
    font-family: 'Playfair Display', serif; font-size: 17px; font-weight: 700;
    letter-spacing: 0.22em; color: var(--text-primary);
  }

  .meta-row {
    display: flex; justify-content: space-between; gap: 16px;
    padding: 10px 28px 4px; font-size: 12px; color: var(--text-secondary);
    text-transform: uppercase; letter-spacing: 0.06em;
  }
  .meta-row .value { display: block; margin-top: 4px; font-size: 14px; font-weight: 700;
    color: var(--text-primary); text-transform: none; letter-spacing: normal; font-family: 'Playfair Display', serif; }
  .meta-row .right { text-align: right; }

  .body { padding: 8px 28px 24px; }

  .divider { border-top: 1px dashed var(--border-color); margin: 18px 0; }

  .section-title {
    font-size: 11px; font-weight: 700; letter-spacing: 0.14em; color: var(--accent);
    text-transform: uppercase; margin-bottom: 10px;
  }
  .info-card {
    background: var(--bg-primary);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 16px 18px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px 24px;
  }
  .info-card .field-label {
    font-size: 11px; color: var(--text-secondary); text-transform: uppercase;
    letter-spacing: 0.05em; margin-bottom: 3px;
  }
  .info-card .field-value { font-size: 14px; font-weight: 600; color: var(--text-primary); word-break: break-word; }

  .amount-card {
    background: var(--bg-secondary);
    border: 2px solid var(--accent);
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    margin-top: 18px;
  }
  .amount-card .label {
    font-size: 11px; letter-spacing: 0.16em; color: var(--text-secondary);
    text-transform: uppercase; margin-bottom: 8px; font-weight: 600;
  }
  .amount-card .value {
    font-family: 'Playfair Display', serif; font-size: 32px; font-weight: 700; color: var(--accent);
  }
  .status-pill {
    display: inline-block; margin-top: 12px; padding: 5px 18px; border-radius: 999px;
    font-size: 12px; font-weight: 700; letter-spacing: 0.1em;
  }

  .footer { text-align: center; padding: 22px 28px 28px; }
  .footer .sign { font-family: 'Playfair Display', serif; font-size: 14px; font-weight: 700; margin-bottom: 2px; }
  .footer .sign-sub { font-size: 11px; color: var(--text-secondary); margin-bottom: 16px; }
  .footer .note { font-size: 11px; color: var(--text-secondary); border-top: 1px dashed var(--border-color); padding-top: 14px; }

  @media print {
    body { padding: 0; background: var(--white); }
    .receipt { box-shadow: none; border: none; border-radius: 0; max-width: 100%; }
  }
  @page { size: A4; margin: 14mm; }
</style>
</head>
<body>
  <div class="receipt">
    <div class="header">
      ${logoMarkup}
      <div class="college-name">
        <h1>${esc(COLLEGE.name)}</h1>
        <div class="tagline">${esc(COLLEGE.tagline)}</div>
        <div class="address">
          ${esc(COLLEGE.address)}<br/>
          ${esc(COLLEGE.phone)} &nbsp;·&nbsp; ${esc(COLLEGE.website)}
        </div>
      </div>
      <div class="spacer"></div>
    </div>

    <div class="titlebar">FEE RECEIPT</div>

    <div class="meta-row">
      <div>Receipt No<span class="value">${esc(r.receiptNumber)}</span></div>
      <div class="right">Date<span class="value">${esc(dateFormatted)}</span></div>
    </div>

    <div class="body">
      <div class="section-title">Student Information</div>
      <div class="info-card">
        <div><div class="field-label">Student Name</div><div class="field-value">${esc(r.studentName)}</div></div>
        <div><div class="field-label">Enrollment Number</div><div class="field-value">${esc(r.enrollmentNumber)}</div></div>
        <div><div class="field-label">Course</div><div class="field-value">${esc(r.course)}</div></div>
        <div><div class="field-label">Department</div><div class="field-value">${esc(r.department)}</div></div>
        <div><div class="field-label">Semester</div><div class="field-value">${esc(r.semester)}</div></div>
        <div><div class="field-label">Academic Year</div><div class="field-value">${esc(r.academicYear)}</div></div>
      </div>

      <div class="divider"></div>

      <div class="section-title">Payment Information</div>
      <div class="info-card">
        <div><div class="field-label">Fee Type</div><div class="field-value">${esc(r.feeType)}</div></div>
        <div><div class="field-label">Transaction ID</div><div class="field-value">${esc(r.transactionId)}</div></div>
        <div><div class="field-label">Payment Method</div><div class="field-value">${esc(r.paymentMethod)}</div></div>
        <div><div class="field-label">Payment Date</div><div class="field-value">${esc(dateFormatted)}</div></div>
        <div><div class="field-label">Amount Paid</div><div class="field-value">${esc(amountFormatted)}</div></div>
        ${r.transportRoute ? `<div><div class="field-label">Transport Route</div><div class="field-value">${esc(r.transportRoute)}</div></div>` : ''}
        ${r.busNumber ? `<div><div class="field-label">Bus Number</div><div class="field-value">${esc(r.busNumber)}</div></div>` : ''}
      </div>

      <div class="amount-card">
        <div class="label">Total Amount Paid</div>
        <div class="value">${esc(amountFormatted)}</div>
        <div class="status-pill" style="background:${statusStyle.bg}; color:${statusStyle.color};">STATUS: ${esc(statusStyle.label)}</div>
      </div>
    </div>

    <div class="footer">
      <div class="sign">Authorized Signature</div>
      <div class="sign-sub">PrimeTech College</div>
      <div class="note">This is a computer-generated receipt and does not require a physical signature.</div>
    </div>
  </div>
  ${autoPrint ? '<script>window.onload = function () { window.focus(); window.print(); };</script>' : ''}
</body>
</html>`;
}

// Simple placeholder shown the instant a print tab opens, before
// the logo has finished loading.
function buildLoadingHTML() {
  return `<!DOCTYPE html><html><head><meta charset="utf-8"><title>Preparing receipt…</title></head>
  <body style="font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;background:${THEME.bgPrimary};color:${THEME.textMuted};">
    Preparing your receipt…
  </body></html>`;
}

// Opens the receipt in a new tab, styled for print/"Save as PDF".
// Real PDF output via the browser's print dialog — works on
// desktop, tablet and mobile, and downloads on any device.
export function downloadReceiptPDF(receipt) {
  const win = window.open('', '_blank');
  if (!win) {
    window.alert('Please allow pop-ups for this site to download the receipt.');
    return;
  }
  win.document.write(buildLoadingHTML());

  getLogoDataUrl()
    .then((logo) => {
      const html = buildReceiptHTML(receipt, { logo, autoPrint: true });
      win.document.open();
      win.document.write(html);
      win.document.close();
    })
    .catch(() => {
      const html = buildReceiptHTML(receipt, { logo: null, autoPrint: true });
      win.document.open();
      win.document.write(html);
      win.document.close();
    });
}
