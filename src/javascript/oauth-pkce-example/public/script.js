// Generate Code Verifier
function generateRandomString(length) {
    let text = '';
    const possible =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    for (let i = 0; i < length; i++) {
      text += possible.charAt(Math.floor(Math.random() * possible.length));
    }

    const codeVerifier = document.getElementById('code-verifier');
    codeVerifier.innerText = text;

    // await new Promise(r => setTimeout(r, 2000));
    return text;
  }

// Hash the verifier.
async function generateCodeChallenge(codeVerifier) {
    const digest = await crypto.subtle.digest(
      'SHA-256',
      new TextEncoder().encode(codeVerifier),
    );

    return btoa(String.fromCharCode(...new Uint8Array(digest)))
      .replace(/=/g, '')
      .replace(/\+/g, '-')
      .replace(/\//g, '_');
}


// User is sent to this URL
function generateUrlWithSearchParams(url, params) {
    const urlObject = new URL(url);
    urlObject.search = new URLSearchParams(params).toString();

    return urlObject.toString();
}


// Send user to the auth url.
// If they accept the below scope, then then they will
// be sent to the redirect URL with a code in the query params.
// this code is then exchanged for an access token.
const scope = 'user-read-currently-playing'

function redirectToSpotifyAuthorizeEndpoint() {
    const codeVerifier = generateRandomString(64);

    generateCodeChallenge(codeVerifier).then((code_challenge) => {
      window.localStorage.setItem('code_verifier', codeVerifier);

      window.location = generateUrlWithSearchParams(
        'https://accounts.spotify.com/authorize',
        {
          response_type: 'code',
          client_id,
          scope: scope,
          code_challenge_method: 'S256',
          code_challenge,
          redirect_uri,
        },
      )
    });
  }


// now that we have an auth code, we must provide the verifier along with
// the redirect uri, and client id
function exchangeToken(code) {
  console.log("Getting code_verifier, getting access token. Auth code: " + code);
  const code_verifier = localStorage.getItem('code_verifier');

  fetch('https://accounts.spotify.com/api/token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
    },
    body: new URLSearchParams({
      client_id,
      grant_type: 'authorization_code',
      code,
      redirect_uri,
      code_verifier,
    }),
  }).then(addThrowErrorToFetch)
    .then((data) => {
      processTokenResponse(data);

    // clear search query params in the url
    window.history.replaceState({}, document.title, '/');
  })
}



  // can be called to clear local storage and reload window
function logout() {
  localStorage.clear();
  window.location.reload();
}

async function addThrowErrorToFetch(response) {
  if (response.ok) {
    return response.json();
  } else {
    throw { response, error: await response.json() };
  }
}

function show(input){
  if (input === 'login'){
    document.getElementById('login').style.display = 'unset';
    document.getElementById('loggedin').style.display = 'none';
  } else if (input === 'loggedin'){
    document.getElementById('login').style.display = 'none';
    document.getElementById('loggedin').style.display = 'unset';
  }
}


// Process the response upon sending the auth code to the auth server.
// Get the access token.
function processTokenResponse(data) {
  console.log(`Access Token Response ${JSON.stringify(data)}`);
  console.log("Access Token: " + data.access_token)
  access_token = data.access_token;

  const t = new Date();
  expires_at = t.setSeconds(t.getSeconds() + data.expires_in);

  localStorage.setItem('access_token', access_token);

  // Replace login screen with logged in screen
  show('loggedin');

  // load data of logged in user
  // TODO: Call function to get currently playing song
  console.log(`Access_token in local Storage: ${localStorage.getItem('access_token')}`)
}


// Client ID from spotify dashboard
const client_id = 'b189b96c428d420988bc622dbe88ce57';
const redirect_uri = 'https://geromics.github.io/oauth-pkce-example/'; // Your redirect uri
//
  // Restore tokens from localStorage
let access_token = localStorage.getItem('access_token') || null;

// Get auth code from query params after user has been called back to the redirect uri.
const args = new URLSearchParams(window.location.search);
const code = args.get('code');

// This javascript will either be run when the user initially loads the page, or when the user
// is redirected back to the page after they have accepted the scopes.
// If the user is redirected back to the page, then the code will be in the query params.
// If the user is initially loading the page, then the code will be null.


if (code) {
  exchangeToken(code);
} else if (access_token) {
  // we have already been logged in
  show('loggedin');

} else {
  // we are not logged in so show the login button
  show('login');
}

document.getElementById('login-button')
        .addEventListener('click', () => {redirectToSpotifyAuthorizeEndpoint()}, false);

document.getElementById('logout-button').addEventListener('click', () => {logout()}, false);

// And now... The cool stuff :)

const getCurrent = document.getElementById('getCurrent')
const content = document.getElementById('content')
let currentSongData = ''
let user = ''



fetch(`https://api.spotify.com/v1/me?access_token=${access_token}`)
      .then(addThrowErrorToFetch)
      .then(data => {
        console.log("User data: " + JSON.stringify(data))
        user = data
      })


getCurrent.addEventListener('click', () => {

    fetch('https://api.spotify.com/v1/me/player/currently-playing', {
          headers: {
            Authorization: 'Bearer ' + access_token,
          },
        })
        .then(addThrowErrorToFetch)
        .then((data) => {
          console.log("Currently playing: " + JSON.stringify(data))
          console.log("Song: " + data.item.name)
          currentSongData = data
          content.innerHTML = processTrack(data)
          const currentSong = document.createElement("h1")
          currentSong.innerText = `${data.item.name}`
          content.appendChild(currentSong)

          const artists = data.item.artists

          console.log("Artists: " + JSON.stringify(artists))

          artists.forEach((artist,index) => {
            console.log("Artist " + index + ": " + artist.name)
            const artistName = document.createElement("h2")
            artistName.innerText = `${artist.name}`
            content.appendChild(artistName)
            document.getElementById('recommend').style.display = 'unset';
          })
        })
        .catch((error) => {
          if (error === 'no-song'){
            console.log("Nothing playing right now...")
            content.innerHTML = `<p>Our miners couldn't find your current song...</p>`
          }
        })
})


function processTrack(data){
  return `
  <div class="wrapper">
    <img src="${data.item.album.images[1].url}" id="albumArt">
  </div>`
}
