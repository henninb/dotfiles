'use strict'
const express = require('express')
const https = require('https')
const bodyParser = require('body-parser')
const cors = require('cors')
const fs = require('fs')
const path = require('path')
const app = express()
const port = process.env.PORT || 3000

const httpOptions = {
  cert: fs.readFileSync(path.join(__dirname, 'server.crt')),
  key: fs.readFileSync(path.join(__dirname, 'server.key'))
}

app.use((request, response, next) => {
  console.log("set header");
  response.header("x-powered-by", "ExpressServer");
  response.setHeader("Content-Security-Policy", "script-src 'self' https://apis.google.com");
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
