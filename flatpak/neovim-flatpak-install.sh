#!/bin/sh

cat > neovim-flatpak <<EOF
#!/bin/sh

flatpak run io.neovim.nvim

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# neither of these two cammand are working
#sudo flatpak override --env=XDG_CONFIG_HOME=$HOME/.config io.neovim.nvim
flatpak --user override --env=XDG_CONFIG_HOME=$HOME/.config io.neovim.nvim

flatpak --user -y install flathub io.neovim.nvim
ln -sfn $HOME/.config/nvim/ $HOME/.var/app/io.neovim.nvim/config/nvim

chmod 755 neovim-flatpak
mv neovim-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:
