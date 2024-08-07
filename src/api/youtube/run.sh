#!/bin/sh

touch apikey
apikey="$(cat apikey)"
count=7

generic()
{
  fname=$1
  videoid=$2
  channelName=$3
  trackName=$4
  shift; shift; shift; shift;

  if [ ! -f "audio/$fname.mp3" ]; then
    echo youtube-dl -q -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoid" --output "audio/$fname.mp3"
    youtube-dl -q -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoid" --output "audio/$fname.mp3"
    if [ ! -s "audio/$fname.mp3" ]; then
      rm -rf "audio/$fname.mp3"
    else
      if ! ffmpeg -hide_banner -i "audio/$fname.mp3" "audio/new-${fname}.mp3"; then
        echo $?
        echo ffmpeg failed.
      fi
      mv -v "audio/new-${fname}.mp3" "audio/${fname}.mp3"
      echo id3v2 -t "${trackName}" -a "${channelName}" "audio/${fname}.mp3"
      if id3v2 -t "${trackName}" -a "${channelName}" "audio/${fname}.mp3"; then
        echo id3v2 failed.
      fi
    fi
  fi
}

# ffmpeg -hide_banner -loglevel error

mrturvy()
{
  fname=$1
  videoid=$2
  channelName=$3
  trackName=$4
  shift; shift; shift; shift;

  if [ ! -f "audio/$fname.mp3" ]; then
    youtube-dl -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoid" --output "audio/$fname.mp3"
    duration=$(ffprobe -i "audio/${fname}.mp3" -show_entries format=duration -v quiet -of csv="p=0")
    trim=$(perl -le "print($duration-28.0)")
    if ffmpeg -hide_banner -ss 8 -t "${trim}" -i "audio/$fname.mp3" "audio/new-${fname}.mp3"; then
      mv -v "audio/new-${fname}.mp3" "audio/${fname}.mp3"
      echo id3v2 -t "${trackName}" -a "${channelName}" "audio/${fname}.mp3"
      if id3v2 -t "${trackName}" -a "${channelName}" "audio/${fname}.mp3"; then
        echo id3v2 failed.
      fi
    fi
  fi
}

mkdir -p audio

for channel in $(cat channels.txt); do
  channelId=$(echo "$channel" | awk -F, '{print $1}')
  channelName=$(echo "$channel" | awk -F, '{print $2}')
  echo "$channelName"
  echo "$channelId"
  upload=$(curl -s "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails" | jq -r '.items[].contentDetails.relatedPlaylists.uploads')
  # echo "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails"

  if [ "${channelName}" = "techhut" ]; then
    count=20
  elif [ "${channelName}" = "mrturvy" ]; then
    count=20
  elif [ "${channelName}" = "rhysider" ]; then
    count=20
  elif [ "${channelName}" = "coffeehouse" ]; then
    count=20
  else
    count=10
  fi

  payload=$(curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date")
  echo "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date"
  rm -rf "*.csv"

  echo "${payload}" | tr -d '\n' | jq -r '.items[].snippet.title' | tr " " "-" | sed 's/[^a-zA-Z0-9-]//g' | tr '[:upper:]' '[:lower:]' > title.csv
  echo "${payload}" | tr -d '\n'| jq -r '.items[].snippet.publishedAt' > published.csv
  echo "${payload}" | tr -d '\n' | jq -r '.items[].snippet.resourceId.videoId' > videoid.csv

  paste -d ',' published.csv title.csv videoid.csv > output.csv

  for row in $(cat output.csv); do
    # date=$(echo "$row" | awk -F, '{print $1}')
    fname=$(echo "$row" | awk -F, '{print $2}')
    videoid=$(echo "$row" | awk -F, '{print $3}')

    if [ "${channelName}" = "mrturvy" ]; then
      mrturvy "${channelName}-${fname}" "${videoid}" "${channelName}" "${fname}"
      # artist=$(mp3info -p "%a" "audio/${fname}.mp3")
    else
      generic "${channelName}-${fname}" "${videoid}" "${channelName}" "${fname}"
    fi
    # eyeD3 --preserve-file-times --title "${fname}" --artist "${channelName}" "audio/${fname}.mp3"

  done
done
rm -rf "*.csv"

exit 0
