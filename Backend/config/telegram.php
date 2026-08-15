<?php
// ============================================================
// Telegram Bot Configuration
// ------------------------------------------------------------
// The bot token is a secret — it must live in backend/.env
// (never committed to git, never hardcoded here) exactly like
// DB_HOST / DB_PASS already do in config/db.php.
//
// Add to backend/.env:
//   TELEGRAM_BOT_TOKEN=123456789:AAExampleTokenGoesHere
//   TELEGRAM_BOT_USERNAME=YourCollegeBot
//
// backend/.env is already loaded (putenv) by config/db.php, so as
// long as this file is included after db.php the values below
// are available. We repeat the tiny .env loader defensively in
// case telegram.php is ever included on its own.
// ============================================================

if (!getenv('TELEGRAM_BOT_TOKEN') && file_exists(__DIR__ . '/../.env')) {
    foreach (file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        if ($line[0] === '#' || !str_contains($line, '=')) continue;
        [$k, $v] = explode('=', $line, 2);
        putenv(trim($k) . '=' . trim($v));
    }
}

define('TELEGRAM_BOT_TOKEN', getenv('TELEGRAM_BOT_TOKEN') ?: '');
define('TELEGRAM_BOT_USERNAME', getenv('TELEGRAM_BOT_USERNAME') ?: '');
define('TELEGRAM_API_BASE', 'https://api.telegram.org/bot' . TELEGRAM_BOT_TOKEN);

// Shared secret appended to the webhook URL as ?secret=... so random
// internet traffic can't POST fake Telegram updates into your bot
// endpoint. Set TELEGRAM_WEBHOOK_SECRET in .env when you register the
// webhook with Telegram (see backend/api/telegram_webhook.php header).
define('TELEGRAM_WEBHOOK_SECRET', getenv('TELEGRAM_WEBHOOK_SECRET') ?: '');

// College name used only as a fallback if a caller forgets to pass one
// into the message templates in helpers/telegram_helper.php.
define('COLLEGE_NAME', getenv('COLLEGE_NAME') ?: 'ABC College');
