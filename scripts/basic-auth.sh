#!/bin/sh

printf "basic auth Username: "
read -r username

echo

stty -echo
printf "basic auth Password: "
read -r password
stty echo


echo -n "$username:$password" | base64
