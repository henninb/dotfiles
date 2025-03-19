#!/bin/sh
# Set Android Studio version here:
VER="2024.3.1.13"

# Set temporary directory and output file name:
TMPDIR="$HOME/tmp"
OUTFILE="$TMPDIR/android-studio-linux.tar.gz"

# Create temporary directory if it doesn't exist:
if [ ! -d "$TMPDIR" ]; then
  mkdir -p "$TMPDIR" || { echo "Failed to create directory $TMPDIR" >&2; exit 1; }
fi

# Construct the download URL:
URL="https://r2---sn-jxou0gtapo3-hn2e.gvt1.com/edgedl/android/studio/ide-zips/${VER}/android-studio-${VER}-linux.tar.gz"

echo "Downloading Android Studio version ${VER} from:"
echo "$URL"

# Download the file with curl:
if ! curl -sL --output "$OUTFILE" "$URL"; then
  echo "Download failed" >&2
  exit 1
else
  echo "Download succeeded"
fi

# Remove any existing Android Studio installation:
if doas rm -rf /opt/android-studio/; then
  echo "Removed previous Android Studio installation (if any)"
fi

# Change to the temporary directory:
cd "$TMPDIR" || { echo "Failed to change directory to $TMPDIR" >&2; exit 1; }

# Extract the tarball to /opt:
if doas tar -xvf "android-studio-linux.tar.gz" -C /opt; then
  echo "Extraction succeeded"
else
  echo "Extraction failed" >&2
  exit 1
fi

exit 0
