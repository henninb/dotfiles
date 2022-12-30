#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install jq
fi

# scp pi@raspi:/home/pi/json_in.zip .

mkdir -p json_in
cd json_in || exit
curl -s http://hornsup:8443/transaction/account/select/chase_kari > chase_kari.json
# unzip -o ../json_in.zip
cd - || exit

cat json_in/chase_kari.json | jq '. | map([.guid, .transactionDate, .description, .category, .amount, .reoccurring, .cleared, .notes, .dateUpdated, .dateAdded, .accountType, .accountNameOwner]|join("||"))'
#cat json_in/chase_kari.json| jq '. | map(.guid, .description, .amount|join(","))'

exit 0
