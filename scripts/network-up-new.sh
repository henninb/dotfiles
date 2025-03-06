#!/bin/sh
#
# Enhanced network bring-up script with interactive prompts and error handling.
# It clears existing settings and supports both static and DHCP configurations.
#

# Exit with an error message
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check for required commands
command -v ip >/dev/null 2>&1 || error_exit "'ip' command not found. Please install iproute2."
command -v sudo >/dev/null 2>&1 || error_exit "'sudo' command not found. Please install sudo."
command -v dhclient >/dev/null 2>&1 || echo "Warning: 'dhclient' not found. DHCP may not work properly."

# Function to prompt for input interactively
prompt_input() {
    # $1 = prompt message, $2 = default value (optional)
    local input
    printf "%s" "$1"
    read input
    if [ -z "$input" ] && [ -n "$2" ]; then
        input=$2
    fi
    echo "$input"
}

# Get network device and configuration mode
if [ $# -eq 0 ]; then
    echo "Interactive network configuration"

    # Prompt for device name and ensure it exists
    while :; do
        DEVICE=$(prompt_input "Enter network device (e.g., enp3s0): ")
        if [ -z "$DEVICE" ]; then
            echo "Device cannot be empty."
        elif ! ip link show "$DEVICE" >/dev/null 2>&1; then
            echo "Device '$DEVICE' does not exist. Please try again."
        else
            break
        fi
    done

    # Ask whether to use a static IP configuration
    while :; do
        IS_STATIC=$(prompt_input "Use static IP configuration? (y/n): ")
        case "$(echo "$IS_STATIC" | tr '[:upper:]' '[:lower:]')" in
            y|n)
                IS_STATIC=$(echo "$IS_STATIC" | tr '[:upper:]' '[:lower:]')
                break
                ;;
            *) echo "Invalid input. Please enter y or n." ;;
        esac
    done

elif [ $# -eq 2 ]; then
    DEVICE=$1
    IS_STATIC=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    if ! ip link show "$DEVICE" >/dev/null 2>&1; then
        error_exit "Device '$DEVICE' does not exist."
    fi
else
    ip address show
    echo "Usage: $0 <device> <y/n for static>"
    exit 1
fi

echo "Configuring device: $DEVICE"

# Flush existing IP addresses on the device
echo "Flushing existing IP addresses on $DEVICE..."
if ! sudo ip addr flush dev "$DEVICE"; then
    error_exit "Failed to flush IP addresses on $DEVICE"
fi

if [ "$IS_STATIC" = "y" ]; then
    # Ask for static configuration details
    STATIC_IP=$(prompt_input "Enter static IP address with CIDR (default: 192.168.10.40/24): " "192.168.10.40/24")
    GATEWAY=$(prompt_input "Enter default gateway (default: 192.168.10.1): " "192.168.10.1")
    NAMESERVER=$(prompt_input "Enter nameserver (default: 8.8.8.8): " "8.8.8.8")

    # Bring down the interface before applying settings
    echo "Bringing down the interface $DEVICE..."
    if ! sudo ip link set dev "$DEVICE" down; then
        error_exit "Failed to bring down $DEVICE"
    fi

    # Apply static IP
    echo "Setting static IP address $STATIC_IP on $DEVICE..."
    if ! sudo ip addr add dev "$DEVICE" "$STATIC_IP"; then
        error_exit "Failed to set IP address on $DEVICE"
    fi

    # Set default route
    echo "Adding default gateway $GATEWAY..."
    if ! sudo ip route add default via "$GATEWAY"; then
        error_exit "Failed to add default gateway"
    fi

    # Configure nameserver (this will overwrite /etc/resolv.conf)
    echo "Configuring nameserver $NAMESERVER..."
    if ! echo "nameserver $NAMESERVER" | sudo tee /etc/resolv.conf >/dev/null; then
        error_exit "Failed to configure nameserver"
    fi

    # Bring up the interface
    echo "Bringing up the interface $DEVICE..."
    if ! sudo ip link set dev "$DEVICE" up; then
        error_exit "Failed to bring up $DEVICE"
    fi

    echo "Static network configuration applied successfully."

else
    # DHCP configuration
    echo "Configuring DHCP on $DEVICE..."

    # Bring down the interface
    echo "Bringing down the interface $DEVICE..."
    if ! sudo ip link set dev "$DEVICE" down; then
        error_exit "Failed to bring down $DEVICE"
    fi

    # Bring up the interface
    echo "Bringing up the interface $DEVICE..."
    if ! sudo ip link set dev "$DEVICE" up; then
        error_exit "Failed to bring up $DEVICE"
    fi

    # Start the DHCP client
    echo "Starting DHCP client on $DEVICE..."
    if ! sudo dhclient "$DEVICE"; then
        error_exit "DHCP client failed on $DEVICE"
    fi

    echo "DHCP network configuration applied successfully."
fi

exit 0
