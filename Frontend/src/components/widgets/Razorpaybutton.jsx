import { useEffect, useRef } from 'react';

// ── Razorpay Payment Button (real gateway) ──────────────────
// React doesn't execute <script> tags placed directly in JSX, so the
// Razorpay embed script is injected manually into a <form> ref via
// useEffect. This renders the actual hosted Razorpay "Pay Now" button
// for the given paymentButtonId. Purely additive — never replaces any
// existing simulated Pay Now / Pay Fee button, just sits alongside it.
export default function RazorpayButton({ paymentButtonId, className = '' }) {
  const formRef = useRef(null);

  useEffect(() => {
    const form = formRef.current;
    if (!form || !paymentButtonId) return;
    form.innerHTML = ''; // clear before (re-)injecting, avoids duplicate buttons
    const script = document.createElement('script');
    script.src = 'https://checkout.razorpay.com/v1/payment-button.js';
    script.async = true;
    script.setAttribute('data-payment_button_id', paymentButtonId);
    form.appendChild(script);
  }, [paymentButtonId]);

  return <form ref={formRef} className={className} />;
}