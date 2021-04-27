#!/bin/sh

mkdir -p "$HOME/.fonts/"
mkdir -p "$HOME/.config/fontconfig/conf.d"
mkdir -p "$HOME/.fontconfig"

for family in serif sans-serif monospace Arial Helvetica Verdana "Times New Roman" "Courier New"; do
  echo -n "$family: "
  fc-match "$family"
done

fc-list -f 'Fontpath "%{file|dirname}"\n' : | sort -u

echo -e "\uE0A0"
echo -e "\uE0B0"
echo -e "SKULL AND CROSSBONES (U+2620) \U02620"

echo /etc/fonts/conf.d

echo sudo apt remove -y fonts-font-awesome

echo https://powerline.readthedocs.io/en/latest/installation/linux.html#patched-font-installation
if [ ! -f "$HOME/.fonts/PowerlineSymbols.otf" ]; then
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  mv PowerlineSymbols.otf ~/.fonts/
fi

if [ ! -f "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf" ]; then
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi

#echo for putty
# echo "https://codeload.github.com/powerline/fonts/zip/master"
# echo "https://github.com/powerline/fonts/tree/master/DejaVuSansMono"
# wget "https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu Sans Mono Bold Oblique for Powerline.ttf" -O "DejaVu_Sans_Mono_Bold_Oblique_for_Powerline.ttf"
# wget "https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu Sans Mono Bold for Powerline.ttf" -O "DejaVu_Sans_Mono_Bold_for_Powerline.ttf"
# wget "https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu Sans Mono Oblique for Powerline.ttf" -O "DejaVu_Sans_Mono_Oblique_for_Powerline.ttf"
# wget "https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu Sans Mono for Powerline.ttf" -O "DejaVu_Sans_Mono_for_Powerline.ttf"
# zip DejaVu_Sans_Mono.zip *.ttf
# rm *.ttf

cd "$HOME/projects" || exit
git clone git@github.com:powerline/powerline.git powerline

echo Powerline fonts
cd "$HOME/projects" || exit
git clone git@github.com:powerline/fonts.git powerline-fonts
cd powerline-fonts || exit
echo for the linux console
sudo cp -r Terminus/PSF/*.psf.gz /usr/share/consolefonts
echo for putty on windows and iterm2 on OSX
zip "$HOME/DejaVuSansMono.zip DejaVuSansMono/*.ttf"

cd "$HOME/projects" || exit
git clone git@github.com:gabrielelana/awesome-terminal-fonts.git
cd awesome-terminal-fonts || exit
cp fonts/* ~/.fonts/

fc-cache -vf ~/.fonts/
exit 1

cd "$HOME/projects" || exit
echo git clone git@github.com:ryanoasis/nerd-fonts.git

cd "$HOME/projects" || exit
mkdir sauce-code-pro-nerd-font
cd sauce-code-pro-nerd-font || exit
git init
git remote add -f origin git@github.com:ryanoasis/nerd-fonts.git
git config core.sparseCheckout true
echo "patched-fonts/SourceCodePro/Regular/complete/" >> .git/info/sparse-checkout
echo git pull origin master

echo for linux console
echo setfont ter-powerline-v16b
echo xrdp-genkeymap file
echo terminfo rxvt-unicode 'Co#256:AB=\E[48;5;%dm:AF=\E[38;5;%dm'

echo Awesome-Terminal Fonts
echo https://github.com/gabrielelana/awesome-terminal-fonts
echo git@github.com:gabrielelana/awesome-terminal-fonts.git
echo https://www.nerdfonts.com/
echo sudo pacman -Syu awesome-terminal-fonts
echo glyphs
echo /etc/default/console-setup
echo Font-Awesome-5-free
echo https://fontawesome.com/cheatsheet?from=io
echo "internet explorer symbol"

echo "fc-list -v | less"

echo fc-match Monospace
fc-match Monospace

echo fc-match FontAwesome
fc-match FontAwesome

echo fc-match Courier New:slant=0:weight=100:pixelsize=24:antialias=False:autohint=True:minspace=True
fc-match 'Courier New:slant=0:weight=100:pixelsize=24:antialias=False:autohint=True:minspace=True'

exit 0

#Open PuTTY and make changes to the settings:
#click on default
#click on load

#Under appearance section
#select the DejaVu_Sans_Mono font
##Select font quality Clear Type
##  Under Translation select character set UTF-8
##  Apply settings and restart the PuTTY session


#echo Linux Console
#https://phoikoi.io/2016/11/09/powerline-console.html
#/etc/default/console-setup
#Before
## CONFIGURATION FILE FOR SETUPCON

## Consult the console-setup(5) manual page.

#ACTIVE_CONSOLES="/dev/tty[1-6]"

#CHARMAP="UTF-8"

#CODESET="Lat15"
#FONTFACE="TerminusBold"
#FONTSIZE="14x28"

#VIDEOMODE=
#After
## CONFIGURATION FILE FOR SETUPCON

## Consult the console-setup(5) manual page.

#ACTIVE_CONSOLES="/dev/tty[1-6]"

#CHARMAP="UTF-8"

#VIDEOMODE=
#FONT="ter-powerline-v32b.psf.gz"
