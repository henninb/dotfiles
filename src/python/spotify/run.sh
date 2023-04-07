#!/bin/sh

export SPOTIPY_CLIENT_ID='2679872f57204f0683315b72a9b9a62e'
export SPOTIPY_CLIENT_SECRET='a14d69ba49624dbbada94987c172391e'
# export SPOTIPY_REDIRECT_URI='https://accounts.spotify.com'
export SPOTIPY_REDIRECT_URI='https://www.google.com'
export BROWSER=firefox

pip install -r requirements.txt
#python spotify.py
# python spotify-favorites.py
python spot.py

exit 0
