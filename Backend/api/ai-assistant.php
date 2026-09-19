<?php
// ============================================================
// College Campus Connect — Student AI Assistant (OpenRouter.ai)
//
//   Student React UI → this endpoint → OpenRouter API → this
//   endpoint → JSON response → UI.
//
// The OpenRouter API key lives ONLY in backend/.env and is read
// here with getenv(). It is never sent to, or readable by, the
// frontend.
//
// Endpoints:
//   POST /api/ai-assistant.php/chat
//        Body: { messages: [{ role: 'user'|'assistant', content: '...' }, ...] }
// ============================================================

require_once __DIR__ . '/../config/db.php';
require_once __DIR__ . '/../config/helpers.php';

setCORSHeaders();

$method   = $_SERVER['REQUEST_METHOD'];
$path     = explode('/', trim($_SERVER['PATH_INFO'] ?? '', '/'));
$resource = $path[0] ?? '';

const AI_MAX_MESSAGES     = 40;   // cap conversation length sent per request
const AI_MAX_MSG_CHARS    = 4000; // per-message length limit
const AI_MAX_TOTAL_CHARS  = 24000; // total conversation size limit
const AI_TIMEOUT_SECONDS  = 30;

function aiGetStudentContext($db, $user) {
    // Best-effort — the assistant should still work even if course/semester
    // aren't on file yet, so failures here are swallowed, not fatal.
    try {
        $stmt = $db->prepare(
            "SELECT c.course_name, s.semester
             FROM students s
             JOIN login_credentials lc ON lc.student_id = s.id
             LEFT JOIN courses c ON c.id = s.course_id
             WHERE lc.email = ?"
        );
        $stmt->execute([$user['email']]);
        $row = $stmt->fetch();
        return $row ?: null;
    } catch (Throwable $e) {
        return null;
    }
}

function aiBuildSystemPrompt($studentCtx) {
    $prompt = "You are PrimeTech College's official academic assistant on Campus Connect, built to help students. "
        . "Help students understand academic concepts clearly (course-related questions, study "
        . "explanations, programming concepts, exam preparation, assignment guidance, study "
        . "planning) and help them navigate the college platform (timetable, results, resources) "
        . "in general terms. "
        . "Do NOT fabricate college policies, marks, attendance, fees, timetable entries, deadlines, "
        . "or any personal student data — you do not have live access to the college database. "
        . "If asked about information you do not actually have, say so clearly and suggest where "
        . "the student can check (e.g. their Results, Timetable, or Fees page, or their faculty). "
        . "Keep answers clear, concise, and encouraging. Use simple formatting (short paragraphs, "
        . "numbered/bulleted steps) when it helps.";

    if ($studentCtx) {
        $extra = [];
        if (!empty($studentCtx['course_name'])) $extra[] = "course: {$studentCtx['course_name']}";
        if (!empty($studentCtx['semester']))    $extra[] = "semester: {$studentCtx['semester']}";
        if ($extra) {
            $prompt .= " Context about the student you are talking to (for tailoring examples only, "
                . "do not restate it unprompted): " . implode(', ', $extra) . ".";
        }
    }

    return $prompt;
}

// ============================================================
// POST /ai-assistant.php/chat
// ============================================================
if ($resource === 'chat' && $method === 'POST') {
    $user = requireRole(['student']);

    $apiKey = getenv('OPENROUTER_API_KEY');
    $model  = getenv('OPENROUTER_MODEL') ?: 'openai/gpt-4o-mini';

    if (!$apiKey) {
        error_log('AI Assistant: OPENROUTER_API_KEY is not configured.');
        jsonError('The AI Assistant is not configured yet. Please contact the college admin.', 503);
    }

    $data = json_decode(file_get_contents('php://input'), true);
    if (!is_array($data) || !isset($data['messages']) || !is_array($data['messages'])) {
        jsonError('Request must include a "messages" array.');
    }

    $incoming = $data['messages'];
    if (count($incoming) === 0) {
        jsonError('Conversation cannot be empty.');
    }
    if (count($incoming) > AI_MAX_MESSAGES) {
        jsonError('Conversation is too long. Please clear the chat and start again.');
    }

    $cleanMessages = [];
    $totalChars = 0;
    foreach ($incoming as $m) {
        if (!is_array($m) || !isset($m['role']) || !isset($m['content'])) {
            jsonError('Each message must have a role and content.');
        }
        $role = $m['role'];
        if (!in_array($role, ['user', 'assistant'], true)) {
            jsonError('Message role must be "user" or "assistant".');
        }
        $content = trim((string)$m['content']);
        if ($content === '') {
            jsonError('Messages cannot be empty.');
        }
        $len = function_exists('mb_strlen') ? mb_strlen($content) : strlen($content);
        if ($len > AI_MAX_MSG_CHARS) {
            jsonError('One of your messages is too long (max ' . AI_MAX_MSG_CHARS . ' characters).');
        }
        $totalChars += $len;
        if ($totalChars > AI_MAX_TOTAL_CHARS) {
            jsonError('Conversation is too long overall. Please clear the chat and start again.');
        }
        $cleanMessages[] = ['role' => $role, 'content' => $content];
    }

    // The last message must be from the student — never trust the client
    // to have sent a well-formed turn order, but this is the minimum
    // sanity check before forwarding to the model.
    if (end($cleanMessages)['role'] !== 'user') {
        jsonError('The last message must be from the student.');
    }

    $db = getDB();
    $studentCtx = aiGetStudentContext($db, $user);
    $systemPrompt = aiBuildSystemPrompt($studentCtx);

    $payload = [
        'model' => $model,
        'messages' => array_merge(
            [['role' => 'system', 'content' => $systemPrompt]],
            $cleanMessages
        ),
        'max_tokens' => 1000,
        'temperature' => 0.5,
    ];

    $ch = curl_init('https://openrouter.ai/api/v1/chat/completions');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $apiKey,
            // Optional but recommended by OpenRouter for attribution.
            'HTTP-Referer: ' . (getenv('CLIENT_URL') ?: 'http://localhost:5173'),
            'X-Title: PrimeTech College Campus Connect',
        ],
        CURLOPT_TIMEOUT => AI_TIMEOUT_SECONDS,
        CURLOPT_CONNECTTIMEOUT => 10,
    ]);

    $responseBody = curl_exec($ch);
    $curlErrno = curl_errno($ch);
    $curlError = curl_error($ch);
    $httpCode  = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    // Never log full conversation content — just enough to debug outages.
    if ($curlErrno) {
        error_log("AI Assistant: OpenRouter request failed (curl errno {$curlErrno}): {$curlError}");
        if ($curlErrno === CURLE_OPERATION_TIMEDOUT) {
            jsonError('The AI Assistant is taking too long to respond. Please try again.', 504);
        }
        jsonError('Could not reach the AI Assistant right now. Please try again shortly.', 502);
    }

    $decoded = json_decode($responseBody, true);

    if ($httpCode < 200 || $httpCode >= 300 || !is_array($decoded)) {
        error_log("AI Assistant: OpenRouter returned HTTP {$httpCode}.");
        if ($httpCode === 401 || $httpCode === 403) {
            jsonError('The AI Assistant is not configured correctly. Please contact the college admin.', 503);
        }
        if ($httpCode === 429) {
            jsonError('The AI Assistant is busy right now. Please try again in a moment.', 429);
        }
        jsonError('The AI Assistant could not process your request. Please try again.', 502);
    }

    $content = $decoded['choices'][0]['message']['content'] ?? null;
    if (!$content) {
        error_log('AI Assistant: OpenRouter response missing message content.');
        jsonError('The AI Assistant did not return a response. Please try again.', 502);
    }

    jsonResponse([
        'success' => true,
        'message' => [
            'role' => 'assistant',
            'content' => $content,
        ],
    ]);
}

jsonError('Not found.', 404);