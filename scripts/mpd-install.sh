#!/bin/sh

cat > "$HOME/tmp/mpd.conf" <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"
bind_to_address "127.0.0.1"
# bind_to_address "any"
# bind_to_address "localhost"
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

# audio_output {
#   type "pulse"
#   name "pulse server"
# }

audio_output {
  type "pipewire"
  name "pipewire server"
}
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
  sudo zypper install -y mpd
  sudo zypper install -y mpclient
  sudo zypper install -y ncmpcpp
elif [ "$OS" = "Fedora Linux" ]; then
  sudo dnf install -y mpd
  sudo dnf install -y mpc
  sudo dnf install -y ncmpcpp
elif [ "$OS" = "Clear Linux OS" ]; then
  "sudo swupd bundle-add"
elif [ "$OS" = "Darwin" ]; then
  echo "brew install"
else
  echo "$OS is not yet implemented."
  exit 1
fi

ln -sfn /mnt/external/mp3 "$HOME/.config/mpd/music"
touch "$HOME/.config/mpd/database"
touch "$HOME/.config/mpd/state"

# if [ "${OS}" = "FreeBSD" ]; then
#   sudo mv -v "$HOME/tmp/musicpd.conf" /usr/local/etc/musicpd.conf
#   sudo touch /var/lib/mpd/tag_cache
# else
#   sudo mv -v "$HOME/tmp/mpd.conf" /etc/mpd.conf
#   sudo touch /var/lib/mpd/tag_cache
# fi

cd /mnt/external/mp3 || exit
find . -type f -name "*.mp3" | sort > "$HOME/tmp/all.m3u"
# sudo cp -v "$HOME/tmp/all.m3u" /var/lib/mpd/playlists/
cp -v "$HOME/tmp/all.m3u" "$HOME/.config/mpd/playlists/all.m3u"
cd - || exit

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

echo aplay --list-device
mpc update
echo mpc load all
mpc load all
echo ncmpcpp
echo mpc play
echo mpc pause
echo "mpc listall | shuf -n 1 | mpc add && mpc play"

exit 0

# vim: set ft=sh
