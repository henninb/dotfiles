#!/bin/sh

# Check if /etc/os-release exists
if [ -f /etc/os-release ]; then
  echo Read the contents of /etc/os-release into variables
  . /etc/os-release
  OS=$ID
elif command -v sw_vers >/dev/null 2>&1; then
  echo  Use sw_vers command to get distribution information
  OS=$(sw_vers -productName)
elif command -v lsb_release >/dev/null 2>&1; then
  echo Use lsb_release command to get distribution information
  OS=$(lsb_release -si)
# Check if /etc/lsb-release exists
elif [ -f /etc/lsb-release ]; then
  echo Read the contents of /etc/lsb-release into variables
  . /etc/lsb-release

  # Set the OS variable to the value of the DISTRIB_ID field, which contains the distribution name
  OS=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
  echo Set the OS variable to "Debian"
  OS="Debian"

# Check if /etc/slackware-version exists
elif [ -f /etc/slackware-version ]; then
  echo Read the contents of /etc/slackware-version into variables
  . /etc/slackware-version

  # Set the OS variable to "Slackware"
  OS="Slackware"

# Check if /etc/gentoo-release exists
elif [ -f /etc/void-release ]; then
  # Read the contents of /etc/void-release into variables
  . /etc/void-release

  # Set the OS variable to "Void Linux"
  OS="Void Linux"

# If none of the above conditions are true, exit with an error message
else
  echo "Unable to detect operating system distribution"
  exit 1
fi

# Export the OS variable as an environment variable
export OS

# Print the detected distribution name for verification
echo "Detected operating system distribution: $OS"
