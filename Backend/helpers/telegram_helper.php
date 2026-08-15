<?php
// ============================================================
// Telegram Helper — reusable send/lookup functions
// Include wherever Telegram messages need to be sent from:
//   require_once __DIR__ . '/../config/telegram.php';
//   require_once __DIR__ . '/../helpers/telegram_helper.php';
// ============================================================

require_once __DIR__ . '/../config/telegram.php';

/**
 * Send a plain-text message to a Telegram chat via the official Bot API.
 *
 * @param string|int $chatId  Telegram chat id (numeric, as a string is fine)
 * @param string     $message Message text (HTML parse mode is used, so
 *                             <b>, <i>, <code> etc. are safe to include)
 * @return array{ok: bool, http_code: int, response: array|null, error: string|null}
 */
function sendTelegramMessage($chatId, string $message): array {
    if (!TELEGRAM_BOT_TOKEN) {
        $result = ['ok' => false, 'http_code' => 0, 'response' => null, 'error' => 'TELEGRAM_BOT_TOKEN is not configured in backend/.env'];
        logTelegramMessage($chatId, $message, $result);
        return $result;
    }

    if (!$chatId) {
        $result = ['ok' => false, 'http_code' => 0, 'response' => null, 'error' => 'No chat_id supplied'];
        logTelegramMessage($chatId, $message, $result);
        return $result;
    }

    $url = TELEGRAM_API_BASE . '/sendMessage';

    $payload = [
        'chat_id'                  => $chatId,
        'text'                     => $message,
        'parse_mode'               => 'HTML',
        'disable_web_page_preview' => true,
    ];

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => http_build_query($payload),
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 10,
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_SSL_VERIFYPEER => true,
    ]);

    $responseBody = curl_exec($ch);
    $httpCode     = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlErr      = curl_error($ch);
    curl_close($ch);

    if ($responseBody === false) {
        // Network-level failure (DNS, timeout, TLS, etc.) — cURL itself failed.
        $result = ['ok' => false, 'http_code' => 0, 'response' => null, 'error' => "cURL error: $curlErr"];
        logTelegramMessage($chatId, $message, $result);
        return $result;
    }

    $decoded = json_decode($responseBody, true);
    $ok = $httpCode === 200 && is_array($decoded) && !empty($decoded['ok']);

    $result = [
        'ok'        => $ok,
        'http_code' => $httpCode,
        'response'  => $decoded,
        'error'     => $ok ? null : ($decoded['description'] ?? "HTTP $httpCode from Telegram"),
    ];

    logTelegramMessage($chatId, $message, $result);
    return $result;
}

/**
 * Log every Telegram send attempt (success AND failure) to the
 * telegram_message_log table, and additionally append failures to a
 * flat file so they're visible even if the DB write itself is what
 * failed. Never throws — logging must never break the admission flow.
 */
function logTelegramMessage($chatId, string $message, array $result): void {
    try {
        require_once __DIR__ . '/../config/db.php';
        $db = getDB();
        $stmt = $db->prepare(
            "INSERT INTO telegram_message_log (chat_id, recipient_type, recipient_ref, message, status, http_code, response_body)
             VALUES (?, 'unlinked', NULL, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $chatId !== null ? (string)$chatId : null,
            $message,
            $result['ok'] ? 'sent' : 'failed',
            $result['http_code'],
            json_encode($result['response'] ?? ['error' => $result['error']]),
        ]);
    } catch (\Throwable $e) {
        // DB logging failed too — fall back to a plain file so nothing is lost silently.
        $line = sprintf(
            "[%s] chat_id=%s status=%s error=%s\n",
            date('Y-m-d H:i:s'),
            $chatId ?? 'null',
            $result['ok'] ? 'sent' : 'failed',
            $result['error'] ?? 'unknown'
        );
        @file_put_contents(__DIR__ . '/../logs/telegram_errors.log', $line, FILE_APPEND);
    }

    if (!$result['ok']) {
        error_log('[Telegram] send failed: ' . ($result['error'] ?? 'unknown error'));
    }
}

/**
 * Normalize a phone number for matching purposes: keep only digits
 * and, if longer than 10 digits, keep the last 10 (strips country
 * codes like +91 / 0091 so "9876543210" and "+919876543210" match).
 */
function normalizePhone(string $phone): string {
    $digits = preg_replace('/\D+/', '', $phone);
    return strlen($digits) > 10 ? substr($digits, -10) : $digits;
}

/**
 * Look up a chat_id previously linked via the bot (telegram_chat_links)
 * for a given phone number. Returns null if the person hasn't started
 * the bot / shared their number yet.
 */
function findTelegramChatIdByPhone(string $phone): ?string {
    require_once __DIR__ . '/../config/db.php';
    $db = getDB();
    $norm = normalizePhone($phone);

    $stmt = $db->prepare("SELECT chat_id, phone FROM telegram_chat_links");
    $stmt->execute();
    foreach ($stmt->fetchAll() as $row) {
        if (normalizePhone($row['phone']) === $norm) {
            return $row['chat_id'];
        }
    }
    return null;
}

/**
 * Save a student/faculty's plaintext credentials briefly, for the case
 * where they haven't linked Telegram yet at admission time. Consumed
 * (and deleted) the moment they link — see consumePendingCredentials().
 */
function savePendingCredentials(string $phone, string $recipientType, array $payload): void {
    try {
        require_once __DIR__ . '/../config/db.php';
        $db = getDB();
        $db->prepare(
            "INSERT INTO telegram_pending_credentials (phone, recipient_type, payload) VALUES (?, ?, ?)"
        )->execute([$phone, $recipientType, json_encode($payload)]);
    } catch (\Throwable $e) {
        error_log('[Telegram] Failed to save pending credentials: ' . $e->getMessage());
    }
}

/**
 * Look up and delete any pending credentials saved for this phone
 * (normalized match, same as findTelegramChatIdByPhone). Returns
 * ['type' => 'student'|'faculty', 'payload' => array] or null.
 */
function consumePendingCredentials(string $phone): ?array {
    require_once __DIR__ . '/../config/db.php';
    $db = getDB();
    $norm = normalizePhone($phone);

    $rows = $db->query("SELECT id, phone, recipient_type, payload FROM telegram_pending_credentials")->fetchAll();
    foreach ($rows as $row) {
        if (normalizePhone($row['phone']) === $norm) {
            $db->prepare("DELETE FROM telegram_pending_credentials WHERE id = ?")->execute([$row['id']]);
            return ['type' => $row['recipient_type'], 'payload' => json_decode($row['payload'], true)];
        }
    }
    return null;
}

// ── Message templates ─────────────────────────────────────────────────────

function buildStudentWelcomeMessage(array $s): string {
    $college = COLLEGE_NAME;
    $name    = htmlspecialchars($s['name'], ENT_QUOTES, 'UTF-8');
    return "🎓 <b>Welcome to {$college}</b>\n\n"
         . "Dear {$name},\n\n"
         . "Your admission has been completed successfully.\n\n"
         . "Enrollment No : {$s['enroll_no']}\n"
         . "GR No : {$s['gr_no']}\n"
         . "Course : {$s['course']}\n"
         . "Department : {$s['department']}\n"
         . "Email : {$s['email']}\n"
         . "Password : {$s['password']}\n\n"
         . "Please change your password after your first login.\n\n"
         . "Thank You\n{$college}";
}

function buildFacultyWelcomeMessage(array $f): string {
    $college = COLLEGE_NAME;
    $name    = htmlspecialchars($f['name'], ENT_QUOTES, 'UTF-8');
    return "👨‍🏫 <b>Welcome to {$college}</b>\n\n"
         . "Dear {$name},\n\n"
         . "Your faculty account has been created successfully.\n\n"
         . "Employee ID : {$f['employee_id']}\n"
         . "Department : {$f['department']}\n"
         . "Email : {$f['email']}\n"
         . "Password : {$f['password']}\n\n"
         . "Please change your password after your first login.\n\n"
         . "Thank You\n{$college}";
}
