function toCelsius(x) {
  return (5.0/9.0) * (x - 32.0);
}

function toFahrenheit(x) {
  return  x * (9.0/5.0) + 32.0;
}

const redirectMap = new Map([
  ['/test1', 'https://mysite.com/newlocation1'],
  ['/test2', 'https://mysite.com/newlocation2'],
  ['/test3', 'https://mysite.com/newlocation3'],
  ['/test4', 'https://mysite.com/newlocation4'],
])

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})
/**
 * Respond with hello worker text
 * @param {Request} request
 */
async function handleRequest(request) {
  return new Response('10 degress Celsius to Fahrenheit is ' + toFahrenheit(10), {
    headers: { 'content-type': 'text/plain' },
  })
}




// addEventListener('fetch', async event => {
//   event.respondWith(handleRequest(event.request))
// })

// async function handleRequest(request) {
//   let requestURL = new URL(request.url)
//   let path       = requestURL.pathname.split('/redirect')[1]
//   let location   = redirectMap.get(path)

//   if (location) {
//     return Response.redirect(location, 301)
//   }

//   return fetch(request)
// }
