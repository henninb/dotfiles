# nvidia install
sudo telinit 3

sudo bash NVIDIA-Linux-x86_64-440.44.run


## archolinux install
sudo pacman -S nvidia

## steam requires 32bit libs
sudo pacman -S nvidia nvidia-libgl lib32-nvidia-libgl
