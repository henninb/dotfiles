import * as jwt from '@tsndr/cloudflare-worker-jwt'

async function handleRequest(request: Request) {
  console.log('calling handleRequest()');

  const token = request.headers.get('authorization')?.split(" ")[1] || '';
  console.log(token);

  const url = new URL('https://api.weather.com/v2/pws/observations/current')

  const params = {
    apiKey: "e1f10a1e78da46f5b10a1e78da96f525",
    units: "e",
    stationId:"KMNCOONR65",
    format:"json"
  };

  url.search = new URLSearchParams(params).toString();

  const response = await fetch(url.toString(), {
        method: 'GET',
        redirect: 'follow',
        headers: {
          "Content-Type": "application/json",
        },
  });
  console.log('call to api.weather.com was made.');
  const json = await response.json();
  // console.log(json);
  return new Response(JSON.stringify(json), {
    headers: { 'content-type': 'application/json' },
  })
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
