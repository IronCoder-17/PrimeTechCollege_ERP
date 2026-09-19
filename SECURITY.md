# Security Policy

## Supported Versions

College Campus Connect is deployed as a single running instance rather than
distributed as a versioned package, so security fixes are applied to the
active deployment branch rather than backported across release lines.

| Branch / Deployment       | Supported          |
| -------------------------- | ------------------ |
| `main` (production)        | :white_check_mark: |
| Active feature branches    | :white_check_mark: |
| Archived / superseded forks | :x:                |

If you are running a fork or an older snapshot of this codebase, you are
responsible for pulling in fixes yourself — please don't expect patches to be
backported to it.

## Reporting a Vulnerability

**Please do not open a public GitHub issue for security vulnerabilities.**
Given the modules involved (authentication, admissions, fee payments via
Razorpay, and the AI assistant proxy), even a minimal repro can be enough for
misuse if it's public before a fix ships.

Instead, report privately using one of the following:

- **GitHub Private Vulnerability Reporting** — open the repository's
  **Security** tab → **Report a vulnerability**, if enabled for this repo.
- **Email** — send details to the maintainer's contact email listed on the
  repository's GitHub profile / organization page.

When reporting, please include:

- A description of the vulnerability and its potential impact.
- Steps to reproduce (a minimal example is ideal).
- Which component is affected — frontend, the PHP API (`backend/api/`), the
  Node/Socket.IO realtime server (`backend/server.js`), or the database
  schema.
- Whether the issue requires authentication, and if so, which role
  (admin / faculty / student).

### What to expect

- **Acknowledgement** within 3 business days of your report.
- **Initial assessment** (severity and affected components) within 7 days.
- **Status updates** at least every 7 days until the issue is resolved,
  more frequently for high-severity reports.
- **Resolution or mitigation** timeline depends on severity:
  - Critical (e.g. auth bypass, payment tampering, remote code execution,
    SQL injection): fix targeted within 7 days.
  - High (e.g. privilege escalation between roles, data exposure): fix
    targeted within 14 days.
  - Medium/Low (e.g. missing hardening, non-exploitable misconfiguration):
    fix scheduled into the normal development cycle.

If a report is **accepted**, you'll be credited in the fix's changelog entry
unless you ask to remain anonymous, and notified when the fix is deployed.
If a report is **declined** (not reproducible, out of scope, or judged not to
be a vulnerability), you'll get an explanation of the reasoning and are
welcome to provide additional evidence for reconsideration.

### Scope

In scope:
- Authentication and session handling (`backend/api/auth.php`,
  `frontend/src/contexts/AuthContext.jsx`, `frontend/src/utils/rbac.js`)
- Authorization / role boundaries between admin, faculty, and student
- The PHP REST API (`backend/api/*.php`) and its database access
- The Node/Socket.IO realtime server (`backend/server.js`)
- Payment flows involving Razorpay Payment Buttons
- The AI assistant proxy (`backend/api/ai-assistant.php`) — e.g. prompt
  injection that leaks other students' data, key exposure, injection into the
  OpenRouter request
- The Telegram webhook handler (`backend/api/telegram_webhook.php`)
- SQL injection, XSS, CSRF, IDOR, and insecure direct file access

Out of scope:
- Findings that require access to `backend/.env` or database credentials you
  should not already have
- Denial-of-service via raw traffic volume (report application-logic DoS,
  e.g. unbounded queries, separately)
- Social engineering against maintainers or users
- Issues in third-party dependencies — please report those to the upstream
  project, though a link here is still appreciated so we can track exposure

### A note on this project's current security posture

This is an actively developed student/college project, and a few known gaps
are documented in the [README](README.md#security-notes) rather than hidden:
static admin credentials defined in `backend/config/helpers.php`, and a
client-managed (non-server-signed) session model for student/faculty users.
These are known, tracked issues, not undisclosed vulnerabilities — you're
welcome to report hardening suggestions for them, but please reference the
README section so reports aren't duplicated.

Thank you for helping keep College Campus Connect and its users' data safe.
