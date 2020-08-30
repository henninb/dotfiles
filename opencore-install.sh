#!/bin/sh

cd projects
wget "https://github.com/acidanthera/OpenCorePkg/releases/download/0.6.0/OpenCore-0.6.0-RELEASE.zip"

mkdir opencore
cd opencore

unzip ../OpenCore-0.6.0-RELEASE.zip

git clone git@github.com:corpnewt/ProperTree.git
git clone git@github.com:corpnewt/gibMacOS.git
git clone git@github.com:corpnewt/SSDTTime.git
git clone git@github.com:corpnewt/GenSMBIOS.git
# if [ ! -x "$(command -v go)" ]; then
#   echo go not installed.
#   exit 1
# else
#   sudo pacman -S go
#   # sudo apt install -y golang
#   brew install golang
# fi

# go get github.com/gokcehan/lf

exit 0
