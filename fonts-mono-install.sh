#!/bin/sh

wget https://fontlibrary.org/assets/downloads/symbola/cf81aeb303c13ce765877d31571dc5c7/symbola.zip

https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip

PROJECTS="sauce-code-pro-nerd-fonts.zip monofur-fonts.zip mononoki-fonts.zip inconsolata-fonts.zip dejavu-sans-mono-fonts.zip jetbrains-fonts.zip symbola.zip FiraCode_2.zip"
for i in $(echo $PROJECTS); do
  cd ~/.fonts || exit
  unzip -o "../$i"
done
fc-cache -vf ~/.fonts/

echo "fc-list | grep -i jet"

exit 0
