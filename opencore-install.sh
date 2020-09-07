#!/bin/sh

cd projects || exit
wget "https://github.com/acidanthera/OpenCorePkg/releases/download/0.6.0/OpenCore-0.6.0-RELEASE.zip"

mkdir opencore
cd opencore || exit

unzip ../OpenCore-0.6.0-RELEASE.zip

git clone git@github.com:corpnewt/ProperTree.git
git clone git@github.com:corpnewt/gibMacOS.git
git clone git@github.com:corpnewt/SSDTTime.git
git clone git@github.com:corpnewt/GenSMBIOS.git

exit 0
