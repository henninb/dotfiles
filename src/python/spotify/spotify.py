import os
# import sys
# import json
import spotipy
# import webbrowser
import spotipy.util as util
# from json.decoder import JSONDecodeError
# import random
import re
import uuid

username=uuid.uuid1()
redirect_uri='https://www.google.com/'
scope = 'playlist-read-collaborative playlist-modify-private playlist-modify-public playlist-read-private user-modify-playback-state user-read-currently-playing user-read-playback-state user-read-private user-read-email user-library-modify user-library-read user-follow-modify user-follow-read user-read-recently-played user-top-read streaming app-remote-control'
# scope = 'playlist-read-collaborative playlist-modify-private playlist-modify-public playlist-read-private'


try:
    # token = util.prompt_for_user_token(username, scope, client_id=client_id, client_secret=client_secret, redirect_uri='https://www.google.com/')
    token = util.prompt_for_user_token(username, scope, redirect_uri='https://www.google.com/')

except:

    os.remove(f".cache-{username}")
    # token = util.prompt_for_user_token(username,scope,client_id=client_id,client_secret=client_secret,redirect_uri='https://www.google.com/')
    token = util.prompt_for_user_token(username, scope, redirect_uri='https://www.google.com/')
    # token = util.prompt_for_user_token(username, scope, client_id=client_id, client_secret=client_secret, redirect_uri='https://www.google.com/')

spotifyObject = spotipy.Spotify(auth=token)

def display_tracks(tracks):
  for track in tracks:
      # spotify likes to use dashes instead of parentheses for remixes
      title = re.sub('\s-\s([\w\.\?\&\s]+?\sremix)$', ' (\g<1>)', track['track']['name'], flags=re.I)
      artists = ', '.join(a['name'] for a in track['track']['artists'])
      print('{} - {}'.format(artists, title))

def get_playlist(playlist_id):
    print("playlist_id: " + playlist_id)
    results = spotifyObject.user_playlist(username, playlist_id)
    tracks = results['tracks']['items']
    print(len(tracks))
    display_tracks(tracks)

# user = spotifyObject.current_user()
# displayname = user['display_name']
# followers = user['followers']['total']
# userId = user['id']

# print("displayname:" + displayname)
# print("userId:" + userId)
# print(user)

playlistsNew = spotifyObject.current_user_playlists()
pls = playlistsNew['items']
print(len(pls))
# [print(playlist['uri']) for playlist in pls]
[print(playlist['id']) for playlist in pls]
[print(playlist['name']) for playlist in pls]
[get_playlist(playlist['id']) for playlist in pls]
