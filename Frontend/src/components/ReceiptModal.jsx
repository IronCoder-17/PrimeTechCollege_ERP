// ============================================================
// ReceiptModal — Shared "View Receipt" modal
// PrimeTech College — Fee Receipt Generation Module
//
// Renders the premium beige & white fee receipt (built by
// utils/receiptPdf) inside an iframe so the in-app preview is
// pixel-identical to the downloaded/printed PDF, and provides a
// "Download PDF" action. Used by both the Student "Fee Receipts"
// page and the Admin "Fee Receipt Management" panel.
// ============================================================

import { useEffect, useState } from 'react';
import { X, Download, Printer } from 'lucide-react';
import { buildReceiptHTML, getLogoDataUrl, downloadReceiptPDF } from '../utils/receiptPdf';

// Opens the receipt in a new window with auto-print enabled — used by the
// "Print Receipt" action on both the Student Fee Receipts page and this modal.
export async function printReceipt(receipt) {
  const logo = await getLogoDataUrl();
  const html = buildReceiptHTML(receipt, { logo, autoPrint: true });
  const win = window.open('', '_blank', 'width=850,height=1000');
  if (!win) return;
  win.document.open();
  win.document.write(html);
  win.document.close();
}

export default function ReceiptModal({ receipt, onClose }) {
  const [html, setHtml] = useState('');

  useEffect(() => {
    if (!receipt) return;
    let active = true;
    setHtml('');
    (async () => {
      const logo = await getLogoDataUrl();
      if (active) setHtml(buildReceiptHTML(receipt, { logo, autoPrint: false }));
    })();
    return () => { active = false; };
  }, [receipt]);

  if (!receipt) return null;

  return (
    <div
      style={{
        position: 'fixed', inset: 0, background: 'rgba(62,50,40,0.45)',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        zIndex: 2000, padding: 16,
      }}
      onClick={onClose}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{
          background: '#FAF7F2', borderRadius: 16, width: '100%', maxWidth: 760,
          maxHeight: '92vh', display: 'flex', flexDirection: 'column',
          overflow: 'hidden', border: '1px solid #D6C7B0',
          boxShadow: '0 24px 64px rgba(62,50,40,0.25)',
        }}
      >
        {/* Modal header */}
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
          padding: '14px 20px', borderBottom: '1px solid #D6C7B0', background: '#FFFFFF',
          flexShrink: 0, gap: 12,
        }}>
          <div style={{ minWidth: 0 }}>
            <div style={{ fontWeight: 700, fontSize: 14, color: '#3E3228' }}>{receipt.receiptNumber}</div>
            <div style={{ fontSize: 12, color: '#6B5B4D', marginTop: 2, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
              {receipt.feeType}
            </div>
          </div>
          <div style={{ display: 'flex', gap: 8, flexShrink: 0 }}>
            <button
              onClick={() => downloadReceiptPDF(receipt)}
              style={{
                display: 'flex', alignItems: 'center', gap: 6, padding: '9px 16px',
                background: '#A67C52', color: '#FFFFFF', border: 'none', borderRadius: 10,
                fontSize: 13, fontWeight: 700, cursor: 'pointer',
              }}
            >
              <Download size={14} /> Download PDF
            </button>
            <button
              onClick={() => printReceipt(receipt)}
              style={{
                display: 'flex', alignItems: 'center', gap: 6, padding: '9px 16px',
                background: '#FFFFFF', color: '#3E3228', border: '1px solid #D6C7B0', borderRadius: 10,
                fontSize: 13, fontWeight: 700, cursor: 'pointer',
              }}
            >
              <Printer size={14} /> Print
            </button>
            <button
              onClick={onClose}
              aria-label="Close"
              style={{
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                width: 36, height: 36, background: '#F5EFE6', border: '1px solid #D6C7B0',
                borderRadius: 10, cursor: 'pointer', color: '#3E3228',
              }}
            >
              <X size={16} />
            </button>
          </div>
        </div>

        {/* Receipt preview */}
        <div style={{ flex: 1, overflow: 'auto', background: '#FAF7F2' }}>
          {html ? (
            <iframe
              title={`Receipt ${receipt.receiptNumber}`}
              srcDoc={html}
              style={{ width: '100%', height: '100%', minHeight: 640, border: 'none', display: 'block' }}
            />
          ) : (
            <div style={{ padding: 60, textAlign: 'center', color: '#6B5B4D', fontSize: 13 }}>
              Preparing receipt preview…
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
