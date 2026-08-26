// ── Razorpay Payment Button IDs — centralized config ──────────
// To switch from Test Mode to Live Mode after Razorpay verifies your
// account, update the 4 values below (get new Live Mode IDs from your
// Razorpay Dashboard → Payment Button → Live Mode). No other file
// needs to change.

export const RAZORPAY_BUTTON_IDS = {
  feeReceiptsCurrentSemester: 'your Razorpay key API',
  feeReceiptsNextSemester: 'your Razorpay key API',
  feeReceiptsPayOtherFees: 'your Razorpay key API',
  admissionEnrollFee: 'your Razorpay key API',
};
