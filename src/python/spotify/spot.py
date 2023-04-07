import spotipy
from spotipy.oauth2 import SpotifyOAuth

# export SPOTIPY_CLIENT_ID='2679872f57204f0683315b72a9b9a62e'
# export SPOTIPY_CLIENT_SECRET='a14d69ba49624dbbada94987c172391e'
# # export SPOTIPY_REDIRECT_URI='https://accounts.spotify.com'
# export SPOTIPY_REDIRECT_URI='https://www.google.com'
# Set up authentication with Spotify API
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id="2679872f57204f0683315b72a9b9a62e",
                                               client_secret="a14d69ba49624dbbada94987c172391e",
                                               redirect_uri="https://www.google.com",
                                               scope=["user-library-read"]))
# Ask user to authorize your application by visiting the URL
auth_url = sp.auth_manager.get_authorize_url()
print(f"Please visit this URL to authorize the application: {auth_url}")

# Once the user grants permission, the user will be redirected back to your app with the authorization code in the URL.
# You can access the code from the URL and use it to obtain the access token.
code = input("Enter the authorization code: ")
token_info = sp.auth_manager.get_access_token(code=code)
access_token = token_info['access_token']

# Set the access token on the Spotify client
sp = spotipy.Spotify(auth=access_token)

# Get the user's favorites list
favorites = sp.current_user_saved_tracks()
print(favorites)

# Get the user's favorites list
favorites = sp.current_user_saved_tracks()
print(favorites)
