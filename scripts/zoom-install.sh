#!/bin/sh
# This script downloads, extracts, and installs Zoom to /opt/zoom.
# It downloads the tarball into $HOME/.tmp, extracts it, then moves the 'zoom'
# directory into /opt. Root privileges are required for installation.

# Define variables
TMP_DIR="$HOME/.tmp"
DOWNLOAD_URL="https://cdn.zoom.us/prod/6.4.3.827/zoom_x86_64.tar.xz"
ARCHIVE_NAME="zoom_x86_64.tar.xz"
ARCHIVE_PATH="$TMP_DIR/$ARCHIVE_NAME"
EXTRACT_DIR="$TMP_DIR/zoom_extracted"

# Create temporary directories if needed
[ -d "$TMP_DIR" ] || mkdir -p "$TMP_DIR"
[ -d "$EXTRACT_DIR" ] || mkdir -p "$EXTRACT_DIR"

# Download Zoom using wget
echo "Downloading Zoom from $DOWNLOAD_URL..."
wget -O "$ARCHIVE_PATH" "$DOWNLOAD_URL" || {
    echo "Error: Failed to download Zoom."
    exit 1
}

# Extract the archive
echo "Extracting Zoom..."
tar -xf "$ARCHIVE_PATH" -C "$EXTRACT_DIR" || {
    echo "Error: Failed to extract Zoom archive."
    exit 1
}

# Verify that the expected 'zoom' directory exists in the extracted files.
if [ -d "$EXTRACT_DIR/zoom" ]; then
    echo "Installing Zoom to /opt/zoom..."
    # Remove any previous installation if present.
    if [ -d "/opt/zoom" ]; then
        echo "Existing Zoom installation found at /opt/zoom. Removing..."
        sudo rm -rf "/opt/zoom" || {
            echo "Error: Failed to remove existing installation."
            exit 1
        }
    fi
    # Move the extracted zoom directory to /opt.
    sudo mv "$EXTRACT_DIR/zoom" /opt/ || {
        echo "Error: Failed to move Zoom to /opt."
        exit 1
    }
    echo "Zoom has been installed successfully at /opt/zoom."
else
    echo "Error: The extracted files do not contain a 'zoom' directory."
    exit 1
fi

# Optional cleanup: remove the temporary extraction directory and archive
rm -rf "$EXTRACT_DIR" "$ARCHIVE_PATH"
echo "Temporary files cleaned up."

exit 0
