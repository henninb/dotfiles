scp /usr/share/terminfo/x/xterm-kitty debian-dockerserver:/home/henninb
ssh debian-dockerserver sudo cp xterm-kitty /usr/share/terminfo/x/xterm-kitty

scp /usr/share/terminfo/x/xterm-kitty proxmox:/root
ssh proxmox sudo cp xterm-kitty /usr/share/terminfo/x/xterm-kitty
scp /usr/share/terminfo/x/xterm-kitty proxmox-backup:/usr/share/terminfo/x/xterm-kitty
