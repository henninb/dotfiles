# grub info

## fix for screen resolution in the console on nvidia systems in linux mint
```
$ sudo vi /etc/default/grub

# grub changes for Nvidia with respect to screen resolution
# run the following after the updates to this file
# sudo update-grub
GRUB_GFXMODE=1920x1080x24
# Hack to force higher framebuffer resolution
GRUB_GFXPAYLOAD_LINUX=1920x1080
```

## grub visual tool
sudo apt install grub-customizer
