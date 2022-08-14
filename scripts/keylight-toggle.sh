#!/bin/sh

# read -p "Temperature: " temp
# read -p "Brightness: " bright
# read -p "State: " state

generate_post_data() {

cat <<EOF

{

"lights": [
{
"brightness": $bright,
"temperature": $temp,
"on": 1
}
],

"numberOfLights": 1
}
EOF

}

curl --location --request PUT 'http://your-keylights-ip:9123/elgato/lights' \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"
