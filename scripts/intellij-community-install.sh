#!/bin/sh

if [ $# -eq 1 ]; then
  VER_OVERRIDE="$1"
  echo "override=$VER_OVERRIDE"
fi

cat > "$HOME/tmp/"'_@user_Darcula.icls' <<EOF
<scheme name="_@user_Darcula" version="142" parent_scheme="Darcula">
  <option name="FONT_SCALE" value="1.0" />
  <metaInfo>
    <property name="created">2020-01-01T13:05:54</property>
    <property name="ide">idea</property>
    <property name="ideVersion">2019.3.1.0.0</property>
    <property name="modified">2020-01-01T13:07:16</property>
    <property name="originalScheme">Darcula</property>
  </metaInfo>
  <option name="CONSOLE_FONT_NAME" value="monofur for Powerline" />
  <option name="CONSOLE_FONT_SIZE" value="16" />
  <option name="CONSOLE_LINE_SPACING" value="1.2" />
</scheme>
EOF

if command -v pacman; then
  sudo pacman --noconfirm --needed -S jq curl
  sudo pacman --noconfirm --needed -S net-tools psmisc
elif command -v emerge; then
  if ! command -v jq; then
    sudo emerge --update --newuse app-misc/jq
  fi
  if ! command -v wget; then
    sudo emerge --update --newuse wget 
  fi
  if ! command -v curl; then
  sudo emerge --update --newuse net-misc/curl
  fi
elif command -v apt; then
  sudo apt install -y jq curl
elif command -v xbps-install; then
  sudo xbps-install -y jq curl
elif command -v zypper; then
  sudo zypper install jq curl
elif command -v dnf; then
  sudo dnf install -y jq curl
elif command -v brew; then
  echo "macos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

pkill -f "intellij.idea.Main"

version="IntelliJIdea2021.2"
find "$HOME/.config/JetBrains/${version}" -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/${version}/eval"
rm -rf "$HOME/.config/JetBrains/${version}/options/other.xml"
rm -rf "$HOME/.java/.userPrefs/jetbrains"

VER=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=&_=1581558835218' | jq '.IIU[0] .version' | cut -d \" -f2)

# if  [ ! -z "$VER_OVERRIDE" ]; then
#   VER=${VER_OVERRIDE}
# fi

if [ ! -f "$HOME/tmp/ideaIC-${VER}.tar.gz" ]; then
  echo "attempting to copy from raspi."
  if ! scp "pi@pi:/home/pi/downloads/ideaIC-${VER}.tar.gz" "$HOME/tmp/"; then
    echo "attempting to copy from the net."
    if ! curl -s --output "$HOME/tmp/ideaIC-${VER}.tar.gz" "https://download-cf.jetbrains.com/idea/ideaIC-${VER}.tar.gz"; then
      echo download failed.
      exit 1
    fi
    scp "$HOME/tmp/ideaIC-${VER}.tar.gz" "pi@pi:/home/pi/downloads"
  else
    echo "found this version on the pi - ideaIC-${VER}.tar.gz"
  fi
fi

# if [ ! -f "$HOME/tmp/ideaIC-${VER}.tar.gz" ]; then
#   rm -rf "$HOME/tmp/ideaIC-*.tar.gz"
#   if ! scp "pi@pi:/home/pi/downloads/ideaIC-${VER}.tar.gz" "$HOME/tmp/"; then
#     if ! curl -s --output "$HOME/tmp/ideaIC-${VER}.tar.gz" "https://download-cf.jetbrains.com/idea/ideaIC-${VER}.tar.gz"; then
#     # if ! wget "https://download.jetbrains.com/idea/ideaIC-${VER}.tar.gz"; then
#       echo download failed.
#       exit 1
#     fi
#     scp "$HOME/tmp/ideaIC-${VER}.tar.gz" "pi@pi:/home/pi/downloads"
#   fi
# fi

sudo mkdir -p /opt
sudo rm -rf /opt/intellij
sudo rm -rf /opt/idea-IC-*/
sudo tar -xvf "$HOME/tmp/ideaIC-${VER}.tar.gz" -C /opt
sudo ln -sfn /opt/idea-IC-* /opt/intellij
sudo chown -R intellij:intellij /opt/idea-IC-*/
sudo chmod -R 775 /opt/idea-IC-*/

if [ "${OS}" = "FreeBSD" ]; then
  sudo pw group add intellij
  sudo pw usermod "$(whoami)" -G intellij
else
  sudo groupadd intellij
  sudo useradd -s /sbin/nologin -g intellij intellij
  sudo usermod -a -G intellij "$(whoami)"
fi
echo "$VER"

exit 0

# vim: set ft=sh:
