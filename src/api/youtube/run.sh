#!/bin/sh

touch apikey
apikey="$(cat apikey)"
channel="UCVls1GmFKf6WlTraIb_IaJg"

upload=$(curl -s "https://www.googleapis.com/youtube/v3/channels?id=${channel}&key=${apikey}&part=contentDetails" | jq -r '.items[].contentDetails.relatedPlaylists.uploads')

curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=20&order=date" | jq -r '.items[].snippet.title'

exit 0
