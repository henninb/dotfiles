#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Please provide a domain name as a parameter."
    exit 1
fi

domain=$1

echo "Performing DNS lookup for $domain..."
dig_output=$(dig $domain +short)

response=$(curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" -vlskI -X GET -w "%{http_code}" -o /dev/null -L "https://$domain")

if [ $response -ge 400 ]; then
    echo "Error: HTTP response code $response"
    exit 1
fi

if [ $response -ge 300 ]; then
    echo "Redirect detected, following..."
    redirect_url=$(curl -s -L -o /dev/null -w %{url_effective} "https://$domain")
    echo "Redirect path: $redirect_url"
fi

curl -i -s -o /dev/null -w "Response code: %{http_code}\n" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" -X GET "https://$domain"

curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" -s -I "https://$domain" | grep -i "Content-Security-Policy"

if [ -z "$dig_output" ]; then
    echo "No results found for $domain."
else
    echo "Results for $domain:"
    echo "$dig_output"

    # Check if there are any indications of a CDN
    if echo "$dig_output" | grep -q 'cdn'; then
        echo "There are indications of a CDN for $domain."
    else
        echo "No indications of a CDN for $domain."
    fi

    # Get more information about the IP addresses
    for ip in $(echo "$dig_output"); do
        echo "Additional information for IP address $ip:"
        whois_output=$(whois $ip | awk -F ':' '/^OrgName/ {print $2}')
        echo "OrgName: $whois_output"
        echo ""
    done
fi

exit 0
