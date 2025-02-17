#!/bin/sh

# Define the service file path
SERVICE_PATH="/etc/systemd/system/lid-close.service"
LOGIND_CONF="/etc/systemd/logind.conf"

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Create the systemd service to handle lid-close event
echo "Creating systemd service to lock screen and turn off monitor on lid close..."

sudo cat <<EOF > "$SERVICE_PATH"
[Unit]
Description=Lock screen and turn off monitor on lid close
After=logind.service

[Service]
Type=oneshot
ExecStart=/usr/bin/hyprlock && /usr/bin/hyprctl dispatch dpms off
Environment=DISPLAY=:0

[Install]
WantedBy=multi-user.target
EOF

# Ensure the systemd service file is correct
if [ ! -f "$SERVICE_PATH" ]; then
  echo "Error creating systemd service file." >&2
  exit 1
fi

# Enable and start the systemd service
echo "Enabling and starting the lid-close service..."
sudo systemctl enable lid-close.service
sudo systemctl start lid-close.service

# Configure logind to ignore lid close (so we can handle it with the service)
echo "Configuring logind to ignore lid close..."

if ! grep -q "HandleLidSwitch=ignore" "$LOGIND_CONF"; then
  # Add HandleLidSwitch=ignore if it's not already set
  echo "HandleLidSwitch=ignore" | tee -a "$LOGIND_CONF"
else
  echo "Lid switch handling is already set to ignore."
fi

# Reload systemd and logind configuration
echo "Reloading systemd and logind settings..."
sudo systemctl restart systemd-logind.service

# Confirm the setup
echo "Lid close action setup complete! Lid close will now lock the screen and turn off the monitor."

exit 0
