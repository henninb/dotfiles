#!/bin/sh

PROJECTS="sauce-code-pro-nerd-fonts.zip monofur-fonts.zip mononoki-fonts.zip inconsolata-fonts.zip dejavu-sans-mono-fonts.zip jetbrains-fonts.zip"
for i in $(echo $PROJECTS); do
  cd ~/.fonts || exit
  unzip -o "../$i"
done
fc-cache -vf ~/.fonts/

fc-list | grep -i jet

exit 0
