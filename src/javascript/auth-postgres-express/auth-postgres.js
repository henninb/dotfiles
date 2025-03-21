const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');

const app = express();

// Middleware setup
app.use(express.json());
app.use(cookieParser());
app.use(helmet()); // Adds security headers

// Configure PostgreSQL connection
const pool = new Pool({
  user: 'henninb',       // change this to your database user if different
  host: '192.168.10.10',
  database: 'finance_db',
  password: 'monday1',  // update with your actual database password
  port: 5432,             // default PostgreSQL port
});

// Security constants
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret'; // store securely!
const BCRYPT_SALT_ROUNDS = 10;

// Rate limiter for login endpoint
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 10,                   // limit each IP to 10 login requests per window
  message: 'Too many login attempts, please try again later.',
});

// POST /api/register
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  const normalizedUsername = username.toLowerCase();

  try {
    const hashedPassword = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);
    const queryText = `
      INSERT INTO public.t_user (username, password, date_updated, date_added)
      VALUES ($1, $2, NOW(), NOW())
      RETURNING user_id
    `;
    const { rows } = await pool.query(queryText, [normalizedUsername, hashedPassword]);
    // res.status(201).json({ userId: rows[0].user_id });
    res.sendStatus(201);
  } catch (error) {
    if (error.code === '23505') {
      return res.status(409).json({ error: 'Username already exists.' });
    }
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/login with rate limiter applied
app.post('/api/login', loginLimiter, async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  const normalizedUsername = username.toLowerCase();

  try {
    const queryText = `SELECT * FROM public.t_user WHERE username = $1`;
    const { rows } = await pool.query(queryText, [normalizedUsername]);

    if (rows.length === 0) {
      return res.status(401).json({ error: 'Invalid credentials.' });
    }

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid credentials.' });
    }

    const token = jwt.sign(
      { userId: user.user_id, username: user.username },
      JWT_SECRET,
      { expiresIn: '1h' }
    );

    // Set the JWT in an httpOnly cookie with sameSite attribute
    res.cookie('token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax', // Helps mitigate CSRF attacks
      maxAge: 3600000, // 1 hour
    });

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
