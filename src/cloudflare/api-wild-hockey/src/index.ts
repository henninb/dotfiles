import * as jwt from '@tsndr/cloudflare-worker-jwt'

async function handleRequest(request: Request) {
  console.log('calling method');

  const token = request.headers.get('authorization')?.split(" ")[1] || '';
  console.log(token);


  const url = new URL('https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild')

  const params: Record<string,string> = {
  };

  url.search = new URLSearchParams(params).toString();
  const response = await fetch(url.toString(), {
        method: 'GET',
        redirect: 'follow',
        headers: {
          "Content-Type": "application/json",
        },
  });
  console.log('apiCall was made.');
  const json = await response.json();
  console.log(json);
  return new Response(JSON.stringify(json), {
    headers: { 'content-type': 'application/json' },
  })
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
