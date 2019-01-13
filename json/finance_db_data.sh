#!/bin/sh

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) -o \(  "$OS" = "Raspbian GNU/Linux" \) ]; then
  sudo apt install jq
fi

scp pi@192.168.100.25:/home/pi/json_in.zip .

mkdir -p json_in
cd json_in
unzip -o ../json_in.zip
cd -

cat json_in/chase_kari.json| jq '. | map([.guid, .transactionDate, .description, .category, .amount, .reoccurring, .cleared, .notes, .dateUpdated, .dateAdded, .accountType, .accountNameOwner]|join("||"))'
#cat json_in/chase_kari.json| jq '. | map(.guid, .description, .amount|join(","))'

exit 0
