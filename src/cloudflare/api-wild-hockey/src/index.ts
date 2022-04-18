// import jwt from '@tsndr/cloudflare-worker-jwt'

async function handleRequest(request: Request) {
  console.log('calling method');

  const token = request.headers.get('authorization')?.split(" ")[1] || '';
  console.log(token);
  // let response = await fetch('/api/auth', {
  //       method: 'GET',
  //       redirect: 'follow',
  //       headers: {
  //         "Content-Type": "application/text",
  //         "Authorization": "Bearer " + token
  //       },
  // });
  // const verified = await response.text();
  // console.log("verified: " + verified);
  const response = await fetch('https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild', {
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
