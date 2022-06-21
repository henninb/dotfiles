#!/bin/sh

touch apikey
apikey="$(cat apikey)"
count=7

ifname=audio/how-to-check-ssltls-configuration-ciphers-and-protocols.mp3
dur=$(ffprobe -i $ifname -show_entries format=duration -v quiet -of csv="p=0")
trim=$(perl -le "print($dur-27.0)")
echo ffmpeg -ss 7 -t $trim -i $ifname output.mp3

generic()
{
  fname=$1
  videoid=$2
  shift; shift;

  if [ ! -f "audio/$fname.mp3" ]; then
  youtube-dl -f bestaudio --extract-audio "https://www.youtube.com/watch?v=$videoid" --output "$fname.opus"
    if ffmpeg -i "$fname.opus" "audio/$fname.mp3"; then
      rm -rf "$fname.opus"
    else
      if ffmpeg -i "$fname.m4a" "audio/$fname.mp3"; then
        rm -rf "$fname.m4a"
      fi
    fi
  fi
}


techhut()
{
  fname=$1
  videoid=$2
  shift; shift;

  duration=$(ffprobe -i "${fname}" -show_entries format=duration -v quiet -of csv="p=0")
  trim=$(perl -le "print($duration-27.0)")
  echo ffmpeg -ss 7 -t "${trim}" -i $ifname output.mp3

  if [ ! -f "audio/$fname.mp3" ]; then
  youtube-dl -f bestaudio --extract-audio "https://www.youtube.com/watch?v=$videoid" --output "$fname.opus"
    if ffmpeg -ss 7 -t "${trim}" -i "$fname.opus" "audio/$fname.mp3"; then
      rm -rf "$fname.opus"
    else
      if ffmpeg -ss 7 -t "${trim}" -i "$fname.m4a" "audio/$fname.mp3"; then
        rm -rf "$fname.m4a"
      fi
    fi
  fi
}

for channel in $(cat channels.txt); do
  channelId=$(echo "$channel" | awk -F, '{print $1}')
  channelName=$(echo "$channel" | awk -F, '{print $2}')
  echo "$channelName"
  echo "$channelId"
  upload=$(curl -s "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails" | jq -r '.items[].contentDetails.relatedPlaylists.uploads')
  # echo "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails"

  if [ "${channelName}" = "techhut" ]; then
    count=10
    payload=$(curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date")
    echo "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date"
  else
    payload=$(curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date")
    echo "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date"
  fi

  rm -rf "*.csv"
  echo "${payload}" | jq -r '.items[].snippet.title' | sed 's/[[:punct:]]//g' | tr 'ᴴᴰ' ' ' | tr " " "-" | tr '[:upper:]' '[:lower:]' > title.csv
  echo "${payload}" | jq -r '.items[].snippet.publishedAt' > published.csv
  echo "${payload}" | jq -r '.items[].snippet.resourceId.videoId' > videoid.csv

  paste -d ',' published.csv title.csv videoid.csv > output.csv

  for row in $(cat output.csv); do
    # date=$(echo "$row" | awk -F, '{print $1}')
    fname=$(echo "$row" | awk -F, '{print $2}')
    videoid=$(echo "$row" | awk -F, '{print $3}')

    if [ "${channelName}" = "techhut" ]; then
      techhut "${fname}" "${videoid}"
    else
      generic "${fname}" "${videoid}"
    fi


    # if [ ! -f "audio/$fname.mp3" ]; then
    # youtube-dl -f bestaudio --extract-audio "https://www.youtube.com/watch?v=$videoid" --output "$fname.opus"
    #   if ffmpeg -i "$fname.opus" "audio/$fname.mp3"; then
    #     rm -rf "$fname.opus"
    #   else
    #     if ffmpeg -i "$fname.m4a" "audio/$fname.mp3"; then
    #       rm -rf "$fname.m4a"
    #     fi
    #   fi
    # fi
  done
done

exit 0
