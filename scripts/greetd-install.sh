#!/bin/sh

set -e

# Detect the OS
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
    elif [ "$OS" = "arch" ]; then
        sudo pacman -S --noconfirm greetd greetd-tuigreet
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
command = "Hyprland"
user = "$USERNAME"
EOF
}

# Enable and start greetd service
enable_greetd() {
    if [ "$OS" = "gentoo" ]; then
        sudo rc-update add greetd default
        sudo rc-service greetd start
    elif [ "$OS" = "arch" ]; then
        sudo systemctl enable greetd.service
        sudo systemctl start greetd.service
    fi
}

# Execute functions
install_greetd
generate_greetd_config
enable_greetd

echo "Greetd is now set up to launch Hyprland on login."
exit 0
