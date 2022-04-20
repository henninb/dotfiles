import * as jwt from '@tsndr/cloudflare-worker-jwt'

async function handleRequest(request: Request) {
  const { headers } = request;
  const contentType = headers.get('content-type') || '';
  const token = request.headers.get('authorization')?.split(" ")[1] || '';

  if( request.method !== 'GET' ) {
    return new Response("failure on method", {
      status: 400,
      statusText: 'must be a GET',
    })
  }
  console.log("method: " + request.method);
  console.log("contentType: " + contentType);
  console.log(request.url);

  const decoded = await jwt.verify(token, JWT_KEY);

    return new Response(decoded.toString(), {
      status: 200,
      statusText: 'success',
      headers: { 'content-type': 'application/text' },
    })

};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
