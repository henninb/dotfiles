const express = require('express')
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express()
const port = process.env.PORT || 3000

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

app.listen(port, () => { console.log(`Example app listening on port ${port}`) });
