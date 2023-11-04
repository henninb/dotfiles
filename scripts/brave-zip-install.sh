#!/usr/bin/env sh

#https://github.com/brave/brave-browser/releases/latest
#https://github.com/brave/brave-browser/releases/download/v1.60.110/brave-browser-1.60.110-linux-amd64.zip
#
BRAVE_VER=$(curl -sfI 'https://github.com/brave/brave-browser/releases/latest' | grep -o 'v1.[0-9.]\+[0-9]' | sed 's/Release//' | sed 's/v//')

echo "ver=$BRAVE_VER"
# echo "act=$ACTUAL_VER"
#
# if [ -f "/opt/firefox/firefox" ]; then
#   ACTUAL_VER=$(/opt/firefox/firefox --version | grep -o '[0-9.]\+[0-9]')
#
#   if [ "$ACTUAL_VER" = "$BRAVE_VER" ]; then
#     echo "already at the latest version $BRAVE_VER."
#   fi
# fi

doas groupadd brave
doas useradd -s /sbin/nologin -g brave brave > /dev/null
echo "Press enter to continue"
read -r x
echo "$x" > /dev/null

#exit 1

if [ ! -f "$HOME/tmp/brave-browser-${BRAVE_VER}-linux-amd64.zip" ]; then
  wget "https://github.com/brave/brave-browser/releases/download/v${BRAVE_VER}/brave-browser-${BRAVE_VER}-linux-amd64.zip" -O "$HOME/tmp/brave-browser-${BRAVE_VER}-linux-amd64.zip"
fi

doas rm -rf /opt/brave-browser
doas mkdir -p /opt/brave-browser

cd /opt/brave-browser || exit
doas unzip -o "$HOME/tmp/brave-browser-${BRAVE_VER}-linux-amd64.zip"
doas chown -R brave:brave /opt/brave-browser

echo "Installed version: $(/opt/brave-browser/brave-browser --version)"

exit 0

# vim: set ft=sh:
