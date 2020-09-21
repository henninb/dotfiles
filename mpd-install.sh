#!/bin/sh

cat > mpd.conf <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"

user "mpd"
#bind_to_address "::1"
bind_to_address "127.0.0.1"
# bind_to_address "any"
port "6600"

auto_update "yes"

pid_file "/run/mpd/pid"
state_file "/var/lib/mpd/state"
sticker_file "/var/lib/mpd/sticker.sql"
log_file "/var/log/mpd/mpd.log"

input {
  enabled "no"
  plugin "qobuz"
}

input {
  enabled "no"
  plugin "tidal"
}

decoder {
  plugin "wildmidi"
  enabled "no"
}

# aplay --list-device
audio_output {
    type "alsa"
    name "BT600"
    device "hw:2,0"
}
EOF


sudo mv -v mpd.conf /etc/mpd.conf
sudo mkdir -p /var/log/mpd
sudo mkdir -p /var/lib/mpd/playlists
sudo chown -R mpd:mpd /var/log/mpd /var/lib/mpd

sudo pacman --noconfirm --needed -S mpd
sudo pacman --noconfirm --needed -S mpc

sudo systemctl enable mpd.socket

sudo mv -v ~/media/*.mp3 /var/lib/mpd/music/

#cd ~/media && find . -name '.mp3' -o -name '.flac'|sed -e 's%^./%%g' &gt; all.m3u;mpd ~/.config/mpd/mpd.conf && mpc clear;mpc load all.m3u;mpc update

exit 0
