interface Temperature {
  celsius: number;
  fahrenheit: number;
}

function toCelsius(x: number) : number {
  return ((5.0/9.0) * (x - 32.0));
}

function toFahrenheit(x: number) {
  return  x * (9.0/5.0) + 32.0;
}

async function handleRequest(request: Request) {
  const { headers } = request;
  const contentType = headers.get('content-type') || '';
  const token = request.headers.get('authorization')?.split(" ")[1] || '';
  let json = "{}";

  if( request.method !== 'POST' ) {
    return new Response(json, {
      status: 400,
      statusText: 'must be a POST',
    })
  }

  console.log(request.method);
  console.log(contentType);
  console.log(request.url);

  if( contentType === 'application/x-www-form-urlencoded' ) {
    const text = await request.text();
    return new Response(text, {
      status: 400,
      statusText: 'fail',
    })
  }

  const to_temperature: Temperature = await request.json();
  console.log(JSON.stringify(to_temperature));
  // const to_fahrenheit: Temperature = await request.json();

  if( request.url.includes('celsius') ) {
    to_temperature.celsius = toCelsius(to_temperature.fahrenheit);
    json = JSON.stringify(to_temperature);
  } else if ( request.url.includes('fahrenheit') ) {
    to_temperature.fahrenheit = toFahrenheit(to_temperature.celsius);
    json = JSON.stringify(to_temperature);
  } else {
    console.log('none');
    return new Response(json, {
      status: 400,
      statusText: 'failure',
    })
  }

  return new Response(json, {
    status: 200,
    statusText: 'success',
    headers: { 'content-type': 'application/json' },
  })
  // Redirect the user to your website
  //  return Response.redirect(HOMEPAGE_URL, 302);
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
