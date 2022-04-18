// declare global {
//   const JWT_KEY: string
// }
// import jsonwebtoken from 'jsonwebtoken'
// jsonwebtoken
// const jwt = require('jsonwebtoken');
// import jwt from 'jsonwebtoken'
import jwt from '@tsndr/cloudflare-worker-jwt'

// const jwt = require('@tsndr/cloudflare-worker-jwt')
// import axios from 'axios'

interface Login {
  email: string;
  password: string;
}

const JWT_KEY="mySecret";
const EMAIL="henninb@gmail.com"
const PASSWORD="monday1"
//
// const test : any = self["JWT_KEY"];

 // console.log(JWT_KEY);

async function handleRequest(request: Request) {
  const { headers } = request;
  const contentType = headers.get('content-type') || '';
  // const token = request.headers.get('authorization') || '';


    // setTimeout(async function(){
    //   const decoded = await jwt.verify(token, JWT_KEY);
    //   console.log(decoded);
    // }, 2000);


  if( request.method !== 'POST' ) {
    return new Response("failure", {
      status: 400,
      statusText: 'must be a POST',
    })
  }

  console.log("method: " + request.method);
  console.log("contentType: " + contentType);
  console.log(request.url);

  if( contentType === 'application/x-www-form-urlencoded' ) {
    const text = await request.text();
    return new Response(text, {
      status: 400,
      statusText: 'fail',
    })
  }

  const login: Login = await request.json();
  if( login.email === EMAIL && login.password === PASSWORD ) {
    const token = await jwt.sign({
          email: login.email,
          password: login.password,
          nbf: Math.floor(Date.now() / 1000),
          exp: Math.floor(Date.now() / 1000) + (1 * (60 * 60)) // Expires: Now + 1h
      }, JWT_KEY)

      console.log("token: " + token);

    return new Response(token, {
      status: 200,
      statusText: 'success',
      headers: { 'content-type': 'application/text' },
    })
  } else {
    return new Response('authorization failure', {
      status: 401,
      statusText: 'failure',
      headers: { 'content-type': 'application/text' },
    })

  }
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
