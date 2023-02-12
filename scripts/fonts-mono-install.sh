#!/bin/sh

sudo mkdir -p /usr/local/share/fonts/
sudo mkdir -p /usr/share/fonts/
# sudo cp -v "$HOME/.local/fonts/ter-powerline-v16b.psf" /usr/share/consolefonts/

fonts="monofur-fonts.zip symbola-fonts.zip fira-code-nerd-fonts.zip font-awesome5-regular.zip"
for font in $fonts; do
  cd "$HOME/.fonts" || exit
  unzip -o "$HOME/.local/fonts/$font"
  cd /usr/local/share/fonts || exit
  sudo unzip -o "$HOME/.local/fonts/$font"
  cd /usr/share/fonts || exit
  sudo unzip -o "$HOME/.local/fonts/$font"
done
fc-cache -vf "$HOME/.fonts"
fc-cache -vf /usr/share/fonts

fc-list | grep -i 'monofur for Powerline'
echo
fc-list | grep -i 'Symbola'
echo
fc-list | grep -i 'FiraCode Nerd Font'
echo
fc-list | grep -i 'Awesome'
echo

echo -e "\uE0A0"
echo -e "\uE0B0"
echo -e "SKULL AND CROSSBONES (U+2620) \U02620"

# echo "fc-list | grep -i jet"
# echo "fc-list | grep -i monofur"
# fc-list | grep -i "symbo"
# fc-list : family | grep -i awesome
# echo https://www.fontsquirrel.com/

if [ "$OS" = "Darwin" ]; then
  open -b com.apple.FontBook ~/.fonts/*.ttf
fi

exit 0

# vim: set ft=sh:
