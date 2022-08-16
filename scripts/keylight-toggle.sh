#!/bin/sh

# read -p "Temperature: " temp
# read -p "Brightness: " bright
# read -p "State: " state

curl -s --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json' | jq

generate_post_data() {

cat <<EOF

{

"lights": [
{
"brightness": 40,
"temperature": 276,
"on": 0
}
],

"numberOfLights": 1
}
EOF

}

curl -s --location --request PUT 'http://192.168.10.110:9123/elgato/lights' \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"
