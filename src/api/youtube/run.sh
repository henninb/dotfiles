#!/bin/sh

touch apikey
apikey="$(cat apikey)"
 # coffee="UCcUf33cEPky2GiWBgOP-jQA"
 #   jack="UCMIqrmh2lMdzhlCPK5ahsAg"
# distrotube="UCVls1GmFKf6WlTraIb_IaJg"
# venture="UCt3JiNkefsfbA2N4SgEkoiQ"
 #   stok="UCQN2DsjnYH60SFBIA6IkNwg"
# phillip="UC3xdLFFsqG701QAyGJIPT1g"

# channel="UC3xdLFFsqG701QAyGJIPT1g"
count=7

for channel in $(cat channels.txt); do
  upload=$(curl -s "https://www.googleapis.com/youtube/v3/channels?id=${channel}&key=${apikey}&part=contentDetails" | jq -r '.items[].contentDetails.relatedPlaylists.uploads')

  payload=$(curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date")

  rm -rf "*.csv"
  echo "${payload}" | jq -r '.items[].snippet.title' | sed 's/[[:punct:]]//g' | tr " " "-" | tr '[:upper:]' '[:lower:]' > title.csv
  echo "${payload}" | jq -r '.items[].snippet.publishedAt' > published.csv
  echo "${payload}" | jq -r '.items[].snippet.resourceId.videoId' > videoid.csv

  paste -d ',' published.csv title.csv videoid.csv > output.csv
  # cat output.csv

  for row in $(cat output.csv); do
    # date=$(echo "$row" | awk -F, '{print $1}')
    fname=$(echo "$row" | awk -F, '{print $2}')
    videoid=$(echo "$row" | awk -F, '{print $3}')

    # put content in video and check if it exists
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
  done
done

exit 0
