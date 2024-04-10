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
