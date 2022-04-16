interface Celsius {
  celsius: number;
  fahrenheit: number;
}

interface Fahrenheit {
  fahrenheit: number;
  celsius: number;
}
function toCelsius(x: number) : number {
  return ((5.0/9.0) * (x - 32.0));
}

function toFahrenheit(x: number) {
  return  x * (9.0/5.0) + 32.0;
}

async function handleRequest(request: Request) {
  console.log(request.method);
  console.log(request.url);
  let json = "{}";

  if( request.url.includes('celsius') ) {
    const to_celsius: Celsius = await request.json();
    console.log(JSON.stringify(to_celsius));
    console.log(toCelsius(to_celsius.fahrenheit));
    to_celsius.celsius = toCelsius(to_celsius.fahrenheit);
    json = JSON.stringify(to_celsius);
  } else if ( request.url.includes('fahrenheit') ) {
    const to_fahrenheit: Fahrenheit = await request.json();
    console.log(JSON.stringify(to_fahrenheit));
    console.log(toCelsius(to_fahrenheit.celsius));
    to_fahrenheit.fahrenheit = toFahrenheit(to_fahrenheit.celsius);
    json = JSON.stringify(to_fahrenheit);
  } else {
    console.log('none');
  }

  return new Response(json, {
    headers: { 'content-type': 'application/json' },
  })
};

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
});
