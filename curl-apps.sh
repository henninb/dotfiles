#!/bin/sh

mkdir curl-data

echo CHEAT
curl cheat.sh > curl-data/cheat.txt

echo APPL
curl -s 'http://download.finance.yahoo.com/d/quotes.csv?s=aapl&f=l1' > curl-data/appl.txt

echo GET THE LOCAL WEATHER
curl wttr.in > curl-data/local-weather.txt

echo GET THE WEATHER in Minneapolis
curl wttr.in/Minneapolis > curl-data/weather-minneapolis.txt

echo WEATHER JSON Minneapolis
curl 'wttr.in/Minneapolis?format=j1' > curl-data/weather-minneapolis-json.txt

echo GET YOUR External IP ADDRESS
#curl ifconfig.co > curl-data/external-ip.txt
curl ifconfig.me > curl-data/external-ip.txt
#curl icanhazip.com
#curl ipecho.net/plain
#curl ifconfig.co

echo GET YOUR LOCATION Country
curl ifconfig.co/country > curl-data/location.txt

echo GET YOUR LOCATION City
curl ifconfig.co/city > curl-data/city.txt

echo TINYURL URL SHORTENER
echo curl -s http://tinyurl.com/api-create.php?url...
sleep 3

echo GETNEWS.TECH
curl getnews.tech > curl-data/news-tech.txt

echo NBA Finals
curl 'getnews.tech/nba+finals' > curl-data/news-nba-news.txt

echo CRYPTOCURRENCY EXCHANGE RATES
curl rate.sx > curl-data/crypto-currency.txt

echo DICTIONARY
curl 'dict://dict.org/d:operating system' > curl-data/dictionary-os.txt
sleep 3

echo FUN WITH PARROTS
curl parrot.live
echo "curl https://github.com/matheuss/parrotsay"

#FUN WITH RICK ASTLEY
curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash

exit 0

# vim: set ft=sh:

