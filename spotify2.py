import os
import sys
import json
import spotipy
import webbrowser
import spotipy.util as util
from json.decoder import JSONDecodeError
import random


username = '22kpgi2vtrlebcei6eu37db7y'
scope = 'playlist-read-collaborative playlist-modify-private playlist-modify-public playlist-read-private user-modify-playback-state user-read-currently-playing user-read-playback-state user-read-private user-read-email user-library-modify user-library-read user-follow-modify user-follow-read user-read-recently-played user-top-read streaming app-remote-control'

#22kpgi2vtrlebcei6eu37db7y

try:

    token = util.prompt_for_user_token(username,scope,client_id='8ff0ccc6f1fb460e8fabbe33e0e42112',client_secret='03d0e4de0957434abcc60660045d7cfc',redirect_uri='https://www.google.com/')

except:

    os.remove(f".cache-{username}")
    token = util.prompt_for_user_token(username,scope,client_id='8ff0ccc6f1fb460e8fabbe33e0e42112',client_secret='03d0e4de0957434abcc60660045d7cfc',redirect_uri='https://www.google.com/')

spotifyObject = spotipy.Spotify(auth=token)

playlist_name = 'International Playlist'  # for the post-creation page

user = spotifyObject.current_user()
displayname = user['display_name']
followers = user['followers']['total']
userId = user['id']

print("displayname:" + displayname)
print("userId:" + userId)


# internationalPlaylistClass.showPlaylist


class internationalPlaylistClass():

    def internationalPlaylist(self):
        # setting up variables
        spotifyObject.user_playlist_create(user['id'], 'International Playlist')
        newPlaylist = spotifyObject.current_user_playlists()['items'][0]['id']
        newPlaylistUri = spotifyObject.current_user_playlists()['items'][0]['uri']

        songs = []
        randsongs = []

        # functionality
        searchResults = spotifyObject.search('Indian Chill', 1, 0, 'playlist')  # Indian Music

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name'] # Get playlists and playlist owners from search results

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        for x in range(0,len(playlist['items'])):
            songs.append(playlist['items'][x]['track']['uri'])  #fill playlist list with all songs from search results

        searchResults = spotifyObject.search('Arab Mood Booster', 1, 0, 'playlist')       #Do another search for additional songs and veriety

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name']

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        for x in range(0,len(playlist['items'])):
            songs.append(playlist['items'][x]['track']['uri'])  # add to playlist

        searchResults = spotifyObject.search('Arab Mood Booster', 1, 0, 'playlist')   # Arabic Music

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name']

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        for x in range(0,len(playlist['items'])):
            songs.append(playlist['items'][x]['track']['uri'])  # add to playlist

            searchResults = spotifyObject.search('songs that get europeans turnt', 1, 0, 'playlist')   # European Music

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name']

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        for x in range(0,len(playlist['items'])):
            songs.append(playlist['items'][x]['track']['uri'])  # add to playlist

        searchResults = spotifyObject.search('Korean Chill', 1, 0, 'playlist')       # Korean music

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name']

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        for x in range(0,len(playlist['items'])):
            songs.append(playlist['items'][x]['track']['uri'])  # add to playlist

        searchResults = spotifyObject.search('African Heat', 1, 0, 'playlist')       # African music

        playlistResult = searchResults['playlists']['items'][0]['id']
        playlistUser = searchResults['playlists']['items'][0]['owner']['display_name']

        playlist = spotifyObject.user_playlist_tracks(user=playlistUser,playlist_id=playlistResult)

        # for x in range(0,len(playlist['items'])):
        #     songs.append(playlist['items'][x]['track']['uri'])  # add to playlist

        for x in range(0,29):
            randsongs.append(songs[random.randint(0,(len(songs) - 1))])     #Fill randsongs list with  30 randomly selected songs from playlist list

        spotifyObject.user_playlist_add_tracks(user=userId, playlist_id=newPlaylist, tracks=randsongs)  #Fill playlist with songs from randsongs list

        Playlists = spotifyObject.current_user_playlists()['items'][0]['uri']
        playlistId = newPlaylist
        return playlistId

    def showPlaylist(self, passedId):
        playlistUrl = 'https://open.spotify.com/embed/playlist/%s' % (passedId)
        return playlistUrl


def international():
    # playlistDisplay = SpotipyFunctions.presentPlaylists()
    intObject = internationalPlaylistClass()
    passId = intObject.internationalPlaylist()
    url = intObject.showPlaylist(passId)
    print(url)
    print(passId)
    # playlistDisplay = SpotipyFunctions.presentPlaylists()
    # profile_pic = SpotipyFunctions.getProfilePic()
    # return render(
    #     request,
    #     'hello/playlist_view.html',
    #     {
    #         'playlistUrl': url,
    #         'name': SpotipyFunctions.displayname,
    #         'playlist': playlistDisplay,
    #         'picture': profile_pic,
    #     }
    # )
international()
