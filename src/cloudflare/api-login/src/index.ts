import * as jwt from '@tsndr/cloudflare-worker-jwt'

interface Login {
  email: string
  password: string
}

async function handleRequest(request: Request) {
  const { headers } = request
  const contentType = headers.get('content-type') || ''
  // const token = request.headers.get('authorization') || '';

  // setTimeout(async function(){
  //   const decoded = await jwt.verify(token, JWT_KEY);
  //   console.log(decoded);
  // }, 2000);

  if (request.method !== 'POST') {
    return new Response('failure', {
      status: 400,
      statusText: 'login failure use a POST method.',
    })
  }

  console.log('method: ' + request.method)
  console.log('contentType: ' + contentType)
  console.log(request.url)

  if (contentType === 'application/x-www-form-urlencoded') {
    const text = await request.text()
    return new Response(text, {
      status: 400,
      statusText: 'failure to pass data as JSON',
    })
  }

  const login: Login = await request.json()
  if (login.email === EMAIL && login.password === PASSWORD) {
    const token = await jwt.sign(
      {
        email: login.email,
        password: login.password,
        nbf: Math.floor(Date.now() / 1000),
        exp: Math.floor(Date.now() / 1000) + 1 * (60 * 60), // Expires: Now + 1h
      },
      JWT_KEY,
    )

    console.log('token: ' + token)

    return new Response(token, {
      status: 200,
      statusText: 'success',
      headers: { 'content-type': 'application/text' },
    })
  } else {
    return new Response('user authorization failure', {
      status: 403,
      statusText: 'authorization failure',
      headers: { 'content-type': 'application/text' },
    })
  }
}

addEventListener('fetch', (event) => {
  event.respondWith(handleRequest(event.request))
})
