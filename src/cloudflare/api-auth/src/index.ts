// declare global {
//   const JWT_KEY: string
// }
import jwt from '@tsndr/cloudflare-worker-jwt'


const JWT_KEY="mySecret";
// const test : any = self["JWT_KEY"];

async function handleRequest(request: Request) {
  const { headers } = request;
  const contentType = headers.get('content-type') || '';
  const token = request.headers.get('authorization')?.split(" ")[1] || '';

  if( request.method !== 'GET' ) {
    return new Response("failure", {
      status: 400,
      statusText: 'must be a GET',
    })
  }
  // console.log("token: " + token);
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
