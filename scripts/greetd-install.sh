#!/bin/sh

set -e

if [ -f "/etc/gentoo-release" ]; then
    OS="gentoo"
elif [ -f "/etc/arch-release" ]; then
    OS="arch"
else
    echo "Unsupported OS. This script supports Gentoo and Arch Linux."
    exit 1
fi

# Install greetd and tuigreet
install_greetd() {
    if [ "$OS" = "gentoo" ]; then
        emerge -av greetd greetd-tuigreet
         doas emerge --update --newuse greetd
         doas emerge --update --newuse gtkgreet
    elif [ "$OS" = "arch" ]; then
        sudo pacman -S --noconfirm greetd greetd-tuigreet
        sudo pacman -S --noconfirm gtkgreert
    fi
}

# Configure greetd to launch Hyprland
generate_greetd_config() {
    CONFIG_PATH="/etc/greetd/config.toml"
    USERNAME="$(id -un)"

    sudo mkdir -p /etc/greetd
    echo "Creating greetd configuration..."
    echo "" | sudo tee "$CONFIG_PATH" > /dev/null
    sudo tee "$CONFIG_PATH" <<EOF
[default_session]
command = "wlgreet"
user = "$USERNAME"
EOF
}

# Enable and start greetd service
enable_greetd() {
  sudo usermod -aG video,input "$(id -un)"
  sudo systemctl enable greetd.service
  sudo systemctl start greetd.service
}

# Execute functions
install_greetd
#generate_greetd_config
enable_greetd

echo "Greetd is now set up to launch Hyprland on login."
exit 0
