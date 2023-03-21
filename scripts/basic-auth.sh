#!/bin/sh

printf "basic auth Username: "
read -r username

echo

stty -echo
printf "basic auth Password: "
read -r password
stty echo


printf "%s" "$username:$password" | base64
