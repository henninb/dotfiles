'use strict'
const express = require('express')
const https = require('https')
const bodyParser = require('body-parser')
const cors = require('cors')
const fs = require('fs')
const path = require('path')
const app = express()
const port = process.env.PORT || 3000

//app.use(express.cookieParser());
//app.use(cookieParser());

const httpOptions = {
  cert: fs.readFileSync(path.join(__dirname, 'server.crt')),
  key: fs.readFileSync(path.join(__dirname, 'server.key'))
}

app.use((request, response, next) => {
  console.log("set header");
  response.header("x-powered-by", "ExpressServer");
  // response.setHeader("Content-Security-Policy", "script-src 'self' https://apis.google.com");
  
  // response.setHeader('Content-Type', 'text/plain; charset=utf-8');
  response.setHeader('Set-Cookie', 'mutableSessionCookie=initialValue');
  response.setHeader('Set-Cookie', 'sessionCookie=initialValue; HttpOnly');
  // response.end('Setting a session cookie in the browser');
  //
  //response.cookie('cokkieName',randomNumber, { maxAge: 900000, httpOnly: true })

  console.log('cookie have created successfully');

  next();
});
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(cors());

app.get('/', (_req, response) => {
  response.send('Hello World!');
});

app.get('/test', (_req, response) => {
  response.send('testing');
});

// app.listen(port, () => { console.log(`listening on port ${port}`) });

https.createServer(httpOptions, app)
    .listen(port, () => { console.log(`listening on port ${port}`) });
