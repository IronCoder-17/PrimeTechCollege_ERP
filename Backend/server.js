// ============================================
// College Campus Connect - Node.js Server
// Handles: Real-time chat via Socket.io
//          Notifications, Presence
// ============================================

const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const cors = require('cors');
const mysql = require('mysql2/promise');
require('dotenv').config();

const app = express();
const server = http.createServer(app);

// Socket.io with CORS
const io = new Server(server, {
  cors: {
    origin: process.env.CLIENT_URL || 'http://localhost:5173',
    methods: ['GET', 'POST'],
    credentials: true,
  },
});

app.use(cors({ origin: process.env.CLIENT_URL || 'http://localhost:5173', credentials: true }));
app.use(express.json());

// MySQL Pool
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASS || '',
  database: process.env.DB_NAME || 'college_campus',
  waitForConnections: true,
  connectionLimit: 10,
});

// ── REST: Get messages for a conversation ──
app.get('/api/messages/:convId', async (req, res) => {
  const { convId } = req.params;
  const [rows] = await pool.query(
    `SELECT m.*, u.name AS sender_name, u.avatar AS sender_avatar
     FROM messages m JOIN users u ON m.sender_id = u.id
     WHERE m.conversation_id = ?
     ORDER BY m.created_at ASC LIMIT 100`,
    [convId]
  );
  res.json({ messages: rows });
});

// ── REST: Get conversations for a user ──
app.get('/api/conversations/:userId', async (req, res) => {
  const { userId } = req.params;
  const [rows] = await pool.query(
    `SELECT cv.*, 
       u1.name AS user1_name, u1.avatar AS user1_avatar,
       u2.name AS user2_name, u2.avatar AS user2_avatar
     FROM conversations cv
     JOIN users u1 ON cv.user1_id = u1.id
     JOIN users u2 ON cv.user2_id = u2.id
     WHERE cv.user1_id = ? OR cv.user2_id = ?
     ORDER BY cv.last_message_at DESC`,
    [userId, userId]
  );
  res.json({ conversations: rows });
});

// ── REST: Get notifications ──
app.get('/api/notifications/:userId', async (req, res) => {
  const { userId } = req.params;
  const [rows] = await pool.query(
    `SELECT n.*, u.name AS from_name, u.avatar AS from_avatar
     FROM notifications n LEFT JOIN users u ON n.from_user_id = u.id
     WHERE n.user_id = ?
     ORDER BY n.created_at DESC LIMIT 30`,
    [userId]
  );
  res.json({ notifications: rows });
});

// ── REST: Mark notifications read ──
app.put('/api/notifications/:userId/read', async (req, res) => {
  const { userId } = req.params;
  await pool.query("UPDATE notifications SET is_read = 1 WHERE user_id = ?", [userId]);
  res.json({ message: 'Notifications cleared.' });
});

// ── Socket.io Real-Time ──
const onlineUsers = new Map(); // userId → socketId

io.on('connection', (socket) => {
  console.log(`🔌 Socket connected: ${socket.id}`);

  // User comes online
  socket.on('user:online', (userId) => {
    onlineUsers.set(userId, socket.id);
    socket.userId = userId;
    io.emit('online:update', Array.from(onlineUsers.keys()));
    console.log(`👤 User ${userId} online`);
  });

  // Join a conversation room
  socket.on('room:join', (convId) => {
    socket.join(`conv:${convId}`);
  });

  // Send message
  socket.on('message:send', async ({ convId, senderId, content }) => {
    try {
      const [result] = await pool.query(
        "INSERT INTO messages (conversation_id, sender_id, content) VALUES (?, ?, ?)",
        [convId, senderId, content]
      );
      await pool.query(
        "UPDATE conversations SET last_message = ?, last_message_at = NOW() WHERE id = ?",
        [content, convId]
      );

      const [msg] = await pool.query(
        `SELECT m.*, u.name AS sender_name, u.avatar AS sender_avatar
         FROM messages m JOIN users u ON m.sender_id = u.id WHERE m.id = ?`,
        [result.insertId]
      );

      // Emit to everyone in the conversation room
      io.to(`conv:${convId}`).emit('message:new', msg[0]);
    } catch (err) {
      console.error('Message error:', err);
      socket.emit('error', { message: 'Failed to send message.' });
    }
  });

  // Typing indicator
  socket.on('typing:start', ({ convId, userId, name }) => {
    socket.to(`conv:${convId}`).emit('typing:show', { userId, name });
  });
  socket.on('typing:stop', ({ convId, userId }) => {
    socket.to(`conv:${convId}`).emit('typing:hide', { userId });
  });

  // Notification push
  socket.on('notification:send', async ({ toUserId, fromUserId, type, message, refId }) => {
    try {
      await pool.query(
        "INSERT INTO notifications (user_id, from_user_id, type, message, reference_id) VALUES (?, ?, ?, ?, ?)",
        [toUserId, fromUserId, type, message, refId]
      );
      const targetSocket = onlineUsers.get(String(toUserId));
      if (targetSocket) {
        io.to(targetSocket).emit('notification:new', { type, message, fromUserId });
      }
    } catch (err) {
      console.error('Notification error:', err);
    }
  });

  // Disconnect
  socket.on('disconnect', () => {
    if (socket.userId) {
      onlineUsers.delete(socket.userId);
      io.emit('online:update', Array.from(onlineUsers.keys()));
    }
    console.log(`🔌 Socket disconnected: ${socket.id}`);
  });
});

// Health check
app.get('/health', (req, res) => res.json({ status: 'ok', uptime: process.uptime() }));

const PORT = process.env.PORT || 3001;
server.listen(PORT, () => {
  console.log(`🚀 Campus Connect server running on http://localhost:${PORT}`);
});
