#!/bin/sh

export SPOTIPY_CLIENT_ID='2679872f57204f0683315b72a9b9a62e'
export SPOTIPY_CLIENT_SECRET='a14d69ba49624dbbada94987c172391e'
# export SPOTIPY_REDIRECT_URI='https://accounts.spotify.com'
export SPOTIPY_REDIRECT_URI='https://www.google.com'

pip install -r requirements.txt
python spotify.py

exit 0
