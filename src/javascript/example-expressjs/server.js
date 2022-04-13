const express = require('express')
const app = express()
const port = 3001

app.get('/', (_req, res) => {
  res.send('Hello World!');
});

app.get('/test', (_req, res) => {
  res.send('testing');
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
});
