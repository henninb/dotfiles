#!/bin/sh

PROJECTS="sauce-code-pro-nerd-fonts.zip monofur-fonts.zip mononoki-fonts.zip inconsolata-fonts.zip"
for i in $(echo $PROJECTS); do
  cd ~/.fonts
  unzip -o ../$i
done
fc-cache -vf ~/.fonts/

exit 0
