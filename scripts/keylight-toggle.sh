#!/bin/sh

# read -p "Temperature: " temp
# read -p "Brightness: " bright
# read -p "State: " state

curl --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json'

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

curl --location --request PUT 'http://192.168.10.110:9123/elgato/lights' \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"
