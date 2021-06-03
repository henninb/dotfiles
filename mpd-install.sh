#!/bin/sh

cat > mpd.conf <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"

# user "mpd"
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
  type "pulse"
  name "pulse audio"
  server "127.0.0.1"
#  type "alsa"
#  name "BT600"
#  device "hw:2,0"
}
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y mpd
  sudo apt install -y mpc
  sudo apt install -y ncmpcpp
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S ncmpcpp
elif [ "$OS" = "FreeBSD" ]; then
  echo
else
  echo "OS is not configured"
fi

sudo useradd mpd -s /sbin/nologin

sudo mv -v mpd.conf /etc/mpd.conf
sudo mkdir -p /var/log/mpd
sudo mkdir -p /var/lib/mpd/playlists
sudo mkdir -p /var/lib/mpd/music
sudo chown -R mpd:audio /var/log/mpd /var/lib/mpd
sudo chown -R mpd:mpd /var/log/mpd /var/lib/mpd
sudo chmod g+wx /var/lib/mpd/music/

sudo usermod -a -G mpd "$(id -un)"
sudo usermod -a -G audio "$(id -un)"
sudo usermod -a -G pulse "$(id -un)"
sudo usermod -a -G pulse-access "$(id -un)"

[ -f "*.mp3" ] && sudo mv -v ~/media/*.mp3 /var/lib/mpd/music/

sudo systemctl disable mpd.socket
sudo systemctl stop mpd.socket
sudo systemctl enable mpd.service
sudo systemctl start mpd.service

echo cp /usr/share/gdm/default.pa ~/.config/pulse/
nowplaying=$(mpc -f "%track%. %artist% - %title%" | sed -n '1p')
playing=$(mpc | grep playing)
nowstatus=$(mpc | sed -n '2p' | cut -d ' ' -f1)
echo "$nowplaying $playing $nowstatus"

sudo ln -s "$HOME/media" /var/lib/mpd/music/media

find ~/media -type f -name "*.mp3" > all.m3u

mpc update
mpc load all.m3u

exit 0
