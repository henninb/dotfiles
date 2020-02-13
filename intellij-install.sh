#!/bin/sh

if [ $# -eq 1 ]; then
  VER_OVERRIDE=$1
fi

RASPI_IP=$(nmap -sP --host-timeout 10 192.168.100.0/24 | grep raspb | grep -o '[0-9.]\+[0-9]')

find ~/.IntelliJIdea* -type d -exec touch -t $(date +"%Y%m%d%H%M") {} \;
rm -rf $HOME/.IntelliJIdea*/config/eval
rm -rf $HOME/.IntelliJIdea*/config/options/other.xml
rm -rf ~/.java/.userPrefs/jetbrains

VER=$(curl 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=&_=1581558835218' | jq '.IIU[0] .version' | cut -d \" -f2)
#VER=$(curl https://www.jetbrains.com/updates/updates.xml | grep "[0-9]\{4\}\.[0-9]\.[0-9]" | head -1 | grep -o '[0-9]\{4\}\.[0-9]\.[0-9]')

if  [ ! -z "$VER_OVERRIDE" ]; then
  VER=${VER_OVERRIDE}
fi

echo $VER

if [ ! -f "ideaIU-${VER}.tar.gz" ]; then
  rm -rf ideaIU-*.tar.gz
  scp pi@${RASPI_IP}:/home/pi/downloads/ideaIU-${VER}.tar.gz .
  if [ $? -ne 0 ]; then
    wget https://download-cf.jetbrains.com/idea/ideaIU-${VER}.tar.gz
    if [ $? -ne 0 ]; then
      echo download failed.
      exit 1
    fi
    scp ideaIU-${VER}.tar.gz pi@${RASPI_IP}:/home/pi/downloads
  fi
fi

sudo groupadd intellij
sudo useradd -g intellij intellij

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S net-tools psmisc wget curl
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo zypper install curl wget
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "FreeBSD" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/intellij-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Gentoo" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  sudo apt install -y net-tools psmisc wget curl
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  #sudo ln -sfn $(ls -1d /opt/idea-IU-*.????.*/) /opt/intellij
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  #sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "Fedora" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod -R 775 /opt/idea-IU-*/
elif [ "$OS" = "CentOS Linux" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IU-*/
  sudo yum install -y net-tools wget curl java-1.8.0-openjdk
  sudo tar -xvf ideaIU-${VER}.tar.gz -C /opt
  sudo ln -sfn /opt/idea-IU-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IU-*/
  sudo chmod 775 /opt/idea-IU-*/
else
  echo $OS is not yet implemented.
  exit 1
fi

sudo usermod  -a -G intellij $(whoami)

exit 0
