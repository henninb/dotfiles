const express = require('express')
const app = express()
const port = 3001

app.use((request, response, next) => {
  console.log("set header");
  response.header("x-powered-by", "ExpressServer");
  next();
});

app.get('/', (_req, response) => {
  response.send('Hello World!');
});

app.get('/test', (_req, response) => {
  response.send('testing');
});

app.listen(port, () => { console.log(`Example app listening on port ${port}`) });
