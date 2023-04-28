#!/bin/sh

# Get the local IP address
#ip_addr="$(ip -o addr show up primary scope global | awk '{print $4}')"
#ip_addr="$(ip -o addr show up primary scope global | awk '{print $4}' | cut -d'/' -f1)"
#ip_addr="$(ip -o addr show up primary scope global | awk '/inet /{print $4}' | cut -d'/' -f1 | grep -v '^[[:space:]]*127\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')"
#ip_addr="$(ip -o addr show up primary scope global | awk '/inet /{print $4}' | cut -d'/' -f1 | grep -vE '^(127\.|[[:space:]]*172\.18\.0\.1)')"
#ip_addr="$(ip -o addr show up primary scope global | awk '/inet /{print $4}' | cut -d'/' -f1 | grep -vE '^(127\.|172\.(1[6-9]|2[0-9]|3[01])\.)')"
#ip_addr="$(ip -o addr show up primary scope global | awk '/inet /{print $4}' | cut -d'/' -f1 | grep -vE '^(127\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.122\.1)')"
ip_addr="$(ip -o addr show up primary scope global | awk '/inet /{print $4}' | cut -d'/' -f1 | grep -vE '^(127\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.122\.)')"





# Print the local IP address
echo "Local IP address: ${ip_addr}"

exit 0
# vim: set ft=sh:
