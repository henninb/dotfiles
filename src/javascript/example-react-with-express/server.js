const express = require('express')
const axios = require('axios')
const bodyParser = require('body-parser');

const port = 3001
const app = express()

app.use((request, response, next) => {
  console.log("set header");
  response.header("x-powered-by", "ExpressServer");
  next();
});

app.listen(port, () => { console.log(`listening on port ${port}`) });
app.use(bodyParser.urlencoded({ extended: true }));

app.post('/api/login', (req, res) => {
  console.log('Got body:', req.body);
  res.send('test');
});

