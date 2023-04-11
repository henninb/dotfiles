#!/bin/sh

cat > "$HOME/tmp/mpd.conf" <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"
bind_to_address "127.0.0.1"
# bind_to_address "any"
port "6600"

auto_update "yes"

pid_file "/var/mpd/pid"
# pid_file "/run/mpd/pid"
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

aplay --list-device
audio_output {
  type "pulse"
  name "pulse output"
  server "127.0.0.1"
}

# audio_output {
#   type "pipe"
#   name "pipewire output"
#   command "audiounitary-sink"
#   server "127.0.0.1"
# }
EOF

cat > "$HOME/tmp/musicpd.conf" <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"

# user "mpd"
#bind_to_address "::1"
bind_to_address "127.0.0.1"
# bind_to_address "any"
port "6600"

auto_update "yes"

pid_file "/var/mpd/pid"
# pid_file "/run/mpd/pid"
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
EOF

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S ncmpcpp
elif [ "$OS" = "Gentoo" ]; then
  if ! command -v mpd; then
    sudo emerge --update --newuse media-sound/mpd
  fi
  if ! command -v mpc; then
    sudo emerge --update --newuse media-sound/mpc
  fi
  if ! command -v ncmpcpp; then
    sudo emerge --update --newuse ncmpcpp
  fi
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y mpd
  sudo apt install -y mpc
  sudo apt install -y ncmpcpp
elif [ "$OS" = "Void" ]; then
  echo "sudo xbps-install -y"
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y musicpd
  sudo pkg install -y musicpc
  sudo pkg install -y ncmpcpp
  sudo pw usermod "$(whoami)" -G mpd
elif [ "$OS" = "OpenBSD" ]; then
  echo "OpenBSD"
elif [ "$OS" = "Solus" ]; then
  "sudo eopkg install -y"
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo "sudo zypper install -y"
elif [ "$OS" = "Fedora Linux" ]; then
  echo "sudo dnf install -y"
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo ln -sfn /mnt/external/mp3 /var/lib/mpd/music

sudo useradd mpd -s /sbin/nologin

if [ "${OS}" = "FreeBSD" ]; then
  sudo mv -v "$HOME/tmp/musicpd.conf" /usr/local/etc/musicpd.conf
  sudo touch /var/lib/mpd/tag_cache
else
  sudo mv -v "$HOME/tmp/mpd.conf" /etc/mpd.conf
  sudo touch /var/lib/mpd/tag_cache
fi

cd /mnt/external/mp3 || exit
find . -type f -name "*.mp3" > "$HOME/tmp/all.m3u"
sudo cp -v "$HOME/tmp/all.m3u" /var/lib/mpd/playlists/
cd - || exit

sudo mkdir -p /var/log/mpd
sudo mkdir -p /var/lib/mpd/playlists
#sudo mkdir -p /var/lib/mpd/music
sudo chmod g+w /var/lib/mpd/playlists
sudo chmod g+wx /var/lib/mpd/music/
sudo chown -R mpd:audio /var/log/mpd /var/lib/mpd
sudo chown -R mpd:mpd /var/log/mpd /var/lib/mpd

if [ ! "${OS}" = "FreeBSD" ]; then
  sudo usermod -a -G mpd "$(id -un)"
  sudo usermod -a -G audio "$(id -un)"
  sudo usermod -a -G pulse "$(id -un)"
  sudo usermod -a -G pulse-access "$(id -un)"
fi

#[ -f "*.mp3" ] && sudo mv -v ~/media/*.mp3 /var/lib/mpd/music/

if [ "${OS}" = "FreeBSD" ]; then
  sudo service musicpd start
else
  if [ -x "$(command -v systemctl)" ]; then
    sudo systemctl disable mpd.socket
    sudo systemctl stop mpd.socket
    sudo systemctl enable mpd.service
    sudo systemctl start mpd.service
  else
    echo "not running systemd"
  fi
fi

# cd ~/projects || exit
# git clone git@github.com:joshkunz/ashuffle.git
# git submodule update --init --recursive
# meson -Dbuildtype=release build
# ninja -C build install
# cd - || exit

# echo cp -v /usr/share/gdm/default.pa ~/.config/pulse/
nowplaying=$(mpc -f "%track%. %artist% - %title%" | sed -n '1p')
playing=$(mpc | grep playing)
nowstatus=$(mpc | sed -n '2p' | cut -d ' ' -f1)
echo "$nowplaying $playing $nowstatus"

#export MPD_HOST=localhost:6600
# export MPD_HOST=127.0.0.1:6600

echo mpc update
echo mpc load all
mpc load all
echo ncmpcpp

exit 0

# vim: set ft=sh
