#!/bin/sh

sudo mkdir -p /usr/local/share/fonts/

# if [ ! -f "symbola.zip" ]; then
#   wget -q 'https://fontlibrary.org/assets/downloads/symbola/cf81aeb303c13ce765877d31571dc5c7/symbola.zip'
# fi

# if [ ! -f "FiraCode_2.zip" ]; then
#   wget -q 'https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip'
# fi


#otf is a newer standard based on ttf, when given the option you should generally choose otf.
      # mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.otf

PROJECTS="monofur-fonts.zip symbola-fonts.zip fira-code-nerd-fonts.zip font-awesome5-regular.zip"
for i in $PROJECTS; do
  cd "$HOME/.fonts" || exit
  unzip -o "$HOME/$i"
  cd /usr/local/share/fonts || exit
  sudo unzip -o "$HOME/$i"
done
fc-cache -vf ~/.fonts/

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

exit 0
