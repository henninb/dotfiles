const fs = require('fs');
const https = require('https');
const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs'); // switched to bcryptjs
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
  user: 'henninb',       // update if needed
  host: 'postgresql-server',  // change to 'postgresql-server' if using Docker network
  database: 'finance_db',
  password: 'monday1',   // update with your actual database password
  port: 5432,            // default PostgreSQL port
});

// Global error handler for idle clients—log error without exiting
pool.on('error', (err) => {
  console.error('Unexpected error on idle client:', err);
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

app.get('/', (req, res) => {
  res.send('Server is up!');
});

// POST /api/register
app.post('/api/register', async (req, res) => {
  console.log('/api/register called');
  const { username, password } = req.body;
  console.log('Received username:', username);
  console.log('Received password:', password ? 'provided' : 'not provided');

  if (!username || !password) {
    console.log('Missing username or password');
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  const normalizedUsername = username.toLowerCase();

  try {
    console.log('Hashing password...');
    const hashedPassword = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);
    console.log('Password hashed');
    const queryText = `
      INSERT INTO public.t_user (username, password, date_updated, date_added)
      VALUES ($1, $2, NOW(), NOW())
      RETURNING user_id
    `;
    console.log('Executing query to insert user...');
    const { rows } = await pool.query(queryText, [normalizedUsername, hashedPassword]);
    console.log('User inserted with user_id:', rows[0].user_id);
    return res.sendStatus(201);
  } catch (error) {
    console.error('Error in /api/register:', error);
    if (error.code === '23505') {
      console.log('Username already exists');
      return res.status(409).json({ error: 'Username already exists.' });
    }
    return res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/login with rate limiter applied
app.post('/api/login', loginLimiter, async (req, res) => {
  console.log('POST /api/login called');
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  const normalizedUsername = username.toLowerCase();

  try {
    const queryText = `SELECT * FROM public.t_user WHERE username = $1`;
    console.log('Querying database for user:', normalizedUsername);
    const { rows } = await pool.query(queryText, [normalizedUsername]);

    if (rows.length === 0) {
      console.log('User not found');
      return res.status(401).json({ error: 'Invalid credentials.' });
    }

    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      console.log('Password does not match');
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
      sameSite: 'lax',
      maxAge: 3600000, // 1 hour
    });

    console.log('Login successful, sending 204');
    return res.status(204).send();
  } catch (error) {
    console.error('Error in /api/login:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
});

// SSL options - replace with the path to your certificate and key files
const sslOptions = {
  key: fs.readFileSync('./bhenning.privkey.pem'),
  cert: fs.readFileSync('./bhenning.fullchain.pem'),
};

const PORT = process.env.PORT || 3000;

// Create HTTPS server using the SSL options
https.createServer(sslOptions, app).listen(PORT, '0.0.0.0', () => {
  console.log(`HTTPS server running on port ${PORT}`);
});

