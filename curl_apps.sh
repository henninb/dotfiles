#!/bin/sh

curl cheat.sh
echo GET THE LOCAL WEATHER
curl wttr.in
echo GET THE WEATHER in Berlin
curl wttr.in/Berlin

echo GET YOUR External IP ADDRESS
curl ifconfig.co

echo GET YOUR LOCATION
curl ifconfig.co/country
curl ifconfig.co/city

echo TINYURL URL SHORTENER
echo curl -s http://tinyurl.com/api-create.php?url...

echo GETNEWS.TECH
curl getnews.tech
curl getnews.tech/trump
curl getnews.tech/nba+finals

#CHEAT SHEETS
curl cheat.sh/btrfs

#CRYPTOCURRENCY EXCHANGE RATES
curl rate.sx

#DICTIONARY
curl 'dict://dict.org/d:operating system'

#FUN WITH PARROTS
curl parrot.live
echo "also checkout parrotsay: https://github.com/matheuss/parrotsay"

#FUN WITH RICK ASTLEY
curl -s -L https://raw.githubusercontent.com/ker... | bash

echo IRC: irc://freenode #distrotube

echo GitLab: https://gitlab.com/dwt1

curl -X POST localhost:3000

exit 0
