const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');

const app = express();
app.use(express.json());
app.use(cookieParser());

// Configure the PostgreSQL connection
const pool = new Pool({
  user: 'henninb',       // change this to your database user if different
  host: '192.168.10.10',
  database: 'finance_db',
  password: 'monday1',  // update with your actual database password
  port: 5432,             // default PostgreSQL port
});

// Secret for JWT signing – ensure this is stored securely in production!
const JWT_SECRET = 'your_jwt_secret';
const BCRYPT_SALT_ROUNDS = 10;

// POST /api/register
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;

  // Validate required fields
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  // Normalize username to lowercase per the table constraint
  const normalizedUsername = username.toLowerCase();

  try {
    // Hash the password before storing
    const hashedPassword = await bcrypt.hash(password, BCRYPT_SALT_ROUNDS);

    // Insert the new user into the t_user table
    const queryText = `
      INSERT INTO public.t_user (username, password, date_updated, date_added)
      VALUES ($1, $2, NOW(), NOW())
      RETURNING user_id
    `;
    const { rows } = await pool.query(queryText, [normalizedUsername, hashedPassword]);

    // Return 201 with the new user's ID (optional)
    res.status(201).json({ userId: rows[0].user_id });
  } catch (error) {
    // Handle duplicate username error (unique violation code 23505)
    if (error.code === '23505') {
      return res.status(409).json({ error: 'Username already exists.' });
    }
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// POST /api/login
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;

  // Validate required fields
  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required.' });
  }

  const normalizedUsername = username.toLowerCase();

  try {
    // Retrieve the user from the database
    const queryText = `SELECT * FROM public.t_user WHERE username = $1`;
    const { rows } = await pool.query(queryText, [normalizedUsername]);

    if (rows.length === 0) {
      return res.status(401).json({ error: 'Invalid credentials.' });
    }

    const user = rows[0];

    // Compare the provided password with the stored hashed password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid credentials.' });
    }

    // Create a JWT containing the user_id and username, valid for 1 hour
    const token = jwt.sign({ userId: user.user_id, username: user.username }, JWT_SECRET, { expiresIn: '1h' });

    // Set the JWT in an httpOnly cookie called "token"
    res.cookie('token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // ensure secure flag in production
      maxAge: 3600000, // 1 hour
    });

    // Respond with a 204 No Content status upon successful login
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
