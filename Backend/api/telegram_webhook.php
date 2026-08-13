<?php
// ============================================================
// Telegram Bot Webhook
// POST /api/telegram_webhook.php?secret=YOUR_TELEGRAM_WEBHOOK_SECRET
//
// SETUP — after deploying, register this URL with Telegram once:
//   https://api.telegram.org/bot<TOKEN>/setWebhook?url=https://yourdomain.com/api/telegram_webhook.php?secret=YOUR_SECRET
//
// FLOW
//   1. User sends /start                → bot asks them to share their
//                                          registered mobile number, via a
//                                          "Share phone number" button.
//   2. User taps the button (or types    → bot verifies the number exists
//      the number manually)                in students or faculty, then
//                                          saves chat_id against that
//                                          record (or into
//                                          telegram_chat_links if the
//                                          number isn't found yet, e.g.
//                                          messaged before admission).
//   3. Admin completes admission         → admission.php / admin.php look
//                                          up the saved chat_id and call
//                                          sendTelegramMessage().
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';
require_once __DIR__ . '/../config/telegram.php';
require_once __DIR__ . '/../helpers/telegram_helper.php';

header('Content-Type: application/json; charset=utf-8');

// ── Verify the shared-secret so random traffic can't fake Telegram updates ──
if (TELEGRAM_WEBHOOK_SECRET !== '' && ($_GET['secret'] ?? '') !== TELEGRAM_WEBHOOK_SECRET) {
    http_response_code(403);
    echo json_encode(['error' => 'Invalid webhook secret.']);
    exit();
}

$update = json_decode(file_get_contents('php://input'), true);
if (!$update) {
    http_response_code(200); // Telegram retries on non-200, so ack even junk bodies
    echo json_encode(['ok' => true]);
    exit();
}

$message = $update['message'] ?? null;
if (!$message) {
    http_response_code(200);
    echo json_encode(['ok' => true]);
    exit();
}

$chatId = $message['chat']['id'] ?? null;
$text   = trim($message['text'] ?? '');
$contact = $message['contact'] ?? null; // set when user taps "Share phone number"

if (!$chatId) {
    http_response_code(200);
    echo json_encode(['ok' => true]);
    exit();
}

// ── /start ───────────────────────────────────────────────────────────────
if ($text === '/start') {
    $keyboard = [
        'keyboard' => [[
            ['text' => '📱 Share my registered mobile number', 'request_contact' => true],
        ]],
        'resize_keyboard'   => true,
        'one_time_keyboard' => true,
    ];
    sendTelegramMessageWithKeyboard(
        $chatId,
        "👋 Welcome to the " . COLLEGE_NAME . " Bot!\n\n"
        . "To receive your admission/login credentials here, please share the mobile number "
        . "you registered with the college — tap the button below, or simply type it.",
        $keyboard
    );
    exit();
}

// ── Phone number received (as a shared contact OR typed text) ─────────────
$phone = null;
if ($contact && !empty($contact['phone_number'])) {
    $phone = $contact['phone_number'];
} elseif ($text !== '' && preg_match('/^[0-9+\-\s]{7,15}$/', $text)) {
    $phone = $text;
}

if ($phone !== null) {
    linkTelegramChatId($chatId, $phone, $message['from']['username'] ?? null);
    exit();
}

// ── Anything else ───────────────────────────────────────────────────────
sendTelegramMessage($chatId, "Please tap /start to begin, then share your registered mobile number.");
echo json_encode(['ok' => true]);
exit();

// ============================================================
// Local helper functions for this webhook
// ============================================================

/** Send a message with a Telegram reply keyboard attached (e.g. the "share contact" button). */
function sendTelegramMessageWithKeyboard($chatId, string $text, array $replyMarkup): void {
    $url = TELEGRAM_API_BASE . '/sendMessage';
    $payload = [
        'chat_id'      => $chatId,
        'text'         => $text,
        'reply_markup' => json_encode($replyMarkup),
    ];
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => http_build_query($payload),
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 10,
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode !== 200) {
        error_log("[Telegram webhook] failed to send keyboard prompt: HTTP $httpCode / $response");
    }
}

/**
 * Verify the phone number against students / faculty and save the
 * chat_id on whichever record matches. If neither matches (e.g. the
 * person is messaging the bot before their admission is processed),
 * the chat_id is stored in telegram_chat_links so it can be picked up
 * automatically the moment admission completes.
 */
function linkTelegramChatId($chatId, string $phone, ?string $username): void {
    $db = getDB();
    $norm = normalizePhone($phone);

    // Try to match against every students/faculty row by normalized phone
    // (normalization handles +91 / 0091 / spaces / dashes differences).
    $matchedName = null;
    $matchedRole = null;

    foreach ($db->query("SELECT id, first_name, last_name, phone FROM students")->fetchAll() as $s) {
        if (normalizePhone($s['phone']) === $norm) {
            $db->prepare("UPDATE students SET telegram_chat_id = ? WHERE id = ?")->execute([$chatId, $s['id']]);
            $matchedName = trim($s['first_name'] . ' ' . $s['last_name']);
            $matchedRole = 'student';
            break;
        }
    }

    if (!$matchedRole) {
        foreach ($db->query("SELECT faculty_id, first_name, last_name, phone FROM faculty")->fetchAll() as $f) {
            if (normalizePhone($f['phone']) === $norm) {
                $db->prepare("UPDATE faculty SET telegram_chat_id = ? WHERE faculty_id = ?")->execute([$chatId, $f['faculty_id']]);
                $matchedName = trim($f['first_name'] . ' ' . $f['last_name']);
                $matchedRole = 'faculty';
                break;
            }
        }
    }

    // Always upsert into telegram_chat_links too — this is what admission.php
    // / admin.php fall back to when a person messages the bot BEFORE their
    // student/faculty row (and its phone number) exists yet.
    $stmt = $db->prepare(
        "INSERT INTO telegram_chat_links (phone, chat_id, telegram_username)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE chat_id = VALUES(chat_id), telegram_username = VALUES(telegram_username)"
    );
    $stmt->execute([$phone, $chatId, $username]);

    if ($matchedRole) {
        sendTelegramMessage($chatId, "✅ Thanks {$matchedName}! Your Telegram is now linked to your {$matchedRole} account.");
    } else {
        sendTelegramMessage($chatId, "✅ Got it — we've saved this number. As soon as your admission is completed, your login credentials will be sent here automatically.");
    }

    // If credentials were generated before this phone was linked (student/
    // faculty admitted first, messaged the bot afterwards), deliver them
    // right now instead of leaving the person waiting.
    $pending = consumePendingCredentials($phone);
    if ($pending) {
        $msg = $pending['type'] === 'student'
            ? buildStudentWelcomeMessage($pending['payload'])
            : buildFacultyWelcomeMessage($pending['payload']);
        sendTelegramMessage($chatId, $msg);
    }

    echo json_encode(['ok' => true]);
}
