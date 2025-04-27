#!/bin/sh

# Exit on unset variables and any failing command
set -eu

# Trap errors and report the line number
trap 'echo "Error on line $LINENO. Exiting." >&2' ERR

# --- Dependency check ---
for cmd in curl jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: Required command '$cmd' not found. Please install it." >&2
    exit 1
  fi
done

# --- Configuration ---
# You can override this by exporting KEYLIGHT_IP beforehand
: "${KEYLIGHT_IP:=192.168.7.181}"
keylight_ip=$KEYLIGHT_IP
url="http://${keylight_ip}:9123/elgato/lights"

# --- Fetch current state once ---
if ! json=$(curl -sfL "$url"); then
  echo "Error: Failed to fetch data from $url" >&2
  exit 1
fi

# --- Parse fields, each with its own error check ---
status=$(printf '%s' "$json" | jq '.lights[0].on') \
  || { echo "Error: Unable to parse 'on' status" >&2; exit 1; }
brightness=$(printf '%s' "$json" | jq '.lights[0].brightness') \
  || { echo "Error: Unable to parse brightness" >&2; exit 1; }
temperature=$(printf '%s' "$json" | jq '.lights[0].temperature') \
  || { echo "Error: Unable to parse temperature" >&2; exit 1; }

# --- Report current values ---
echo "brightness=$brightness"
echo "temperature=$temperature"
if [ "$status" -eq 0 ]; then
  echo "currently off"
  status=1
else
  echo "currently on"
  status=0
fi

# --- Build payload ---
generate_post_data() {
  cat <<EOF
{
  "lights": [
    {
      "brightness": $brightness,
      "temperature": $temperature,
      "on": $status
    }
  ],
  "numberOfLights": 1
}
EOF
}

payload=$(generate_post_data)

# --- Push update ---
if ! response=$(curl -sfL -X PUT "$url" \
     -H 'Content-Type: application/json' \
     -d "$payload"); then
  echo "Error: Failed to update lights" >&2
  exit 1
fi

echo "Update successful: $response"
exit 0



#!/bin/sh

# read -p "Temperature: " temp
# read -p "Brightness: " bright
# read -p "State: " state

if ! command -v jq; then
  echo "jq install required"
  exit 1
fi

# keylight_ip=192.168.20.60
keylight_ip=keylight.lan
keylight_ip=192.168.7.181

curl -s --location --request GET "http://${keylight_ip}:9123/elgato/lights" --header 'Accept: application/json' | jq
status=$(curl -s --location --request GET "http://${keylight_ip}:9123/elgato/lights" --header 'Accept: application/json' | jq '.lights | .[].on')
brightness=$(curl -s --location --request GET "http://${keylight_ip}:9123/elgato/lights" --header 'Accept: application/json' | jq '.lights | .[].brightness')
temperature=$(curl -s --location --request GET "http://${keylight_ip}:9123/elgato/lights" --header 'Accept: application/json' | jq '.lights | .[].temperature')


echo "brightness=$brightness"
echo "temperature=$temperature"
if [ "$status" = 0 ]; then
    echo "currently off"
    status=1
else
    echo "currently on"
    status=0
fi

generate_post_data() {

cat <<EOF
{
"lights": [
{
"brightness": $brightness,
"temperature": $temperature,
"on": $status
}
],

"numberOfLights": 1
}
EOF

}

curl -s --location --request PUT "http://${keylight_ip}:9123/elgato/lights" \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"

exit 0

# vim: set ft=sh:
