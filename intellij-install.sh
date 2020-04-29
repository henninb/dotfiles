#!/bin/sh

if [ $# -eq 1 ]; then
  VER_OVERRIDE="$1"
fi

cat > '_@user_Darcula.icls' <<EOF
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

sudo dnf install -y jq
sudo emerge --update --newuse jq
sudo pacman --noconfirm --needed -S jq
sudo apt install -y jq

find ~/.config/JetBrains/IntelliJIdea2020.1 -type d -exec touch -t $(date +"%Y%m%d%H%M") {} \;
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.1/config/eval"
rm -rf "$HOME/.config/JetBrains/IntelliJIdea2020.1/config/options/other.xml"
rm -rf ~/.java/.userPrefs/jetbrains

VER=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=&_=1581558835218' | jq '.IIU[0] .version' | cut -d \" -f2)

# if  [ ! -z "$VER_OVERRIDE" ]; then
#   VER=${VER_OVERRIDE}
# fi

if [ ! -f "ideaIU-${VER}.tar.gz" ]; then
  rm -rf ideaIU-*.tar.gz
  if ! scp "pi@pi:/home/pi/downloads/ideaIU-${VER}.tar.gz" .; then
    if ! wget "https://download-cf.jetbrains.com/idea/ideaIU-${VER}.tar.gz"; then
      echo download failed.
      exit 1
    fi
    scp "ideaIU-${VER}.tar.gz" "pi@pi:/home/pi/downloads"
  fi
fi

sudo groupadd intellij
sudo useradd -g intellij intellij

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S net-tools psmisc wget curl jq
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo zypper install curl wget
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "void" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Solus" ]; then
  sudo mkdir -p /opt
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "FreeBSD" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/intellij-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Gentoo" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Linux Mint" ] || [  "$OS" = "Ubuntu" ]; then
  sudo apt install -y net-tools psmisc wget curl
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Fedora" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "CentOS Linux" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo yum install -y net-tools wget curl java-1.8.0-openjdk
  sudo tar -xvf "ideaIU-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod 775 /opt/idea-IU-*/
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo usermod -a -G intellij "$(whoami)"
echo "$VER"

# ls -ld "$HOME/.IntelliJIdea2020.1/config/eval"
# ls -ld "$HOME/.IntelliJIdea2020.1/config/options/other.xml"
# ls -ld "$HOME/.java/.userPrefs/jetbrains"

exit 0
