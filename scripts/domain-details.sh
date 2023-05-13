#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Please provide a domain name."
    exit 1
fi

domain=$1
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"

echo "Performing DNS lookup for $domain..."
dig_output=$(dig $domain +short)

# response=$(curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" -vlskI -X GET -w "%{http_code}" -o /dev/null -L "https://$domain")
response=$(curl -H "User-Agent: $user_agent" -lskI -X GET -w "%{http_code}" -o /dev/null -L "https://$domain")

if [ $response -ge 400 ]; then
    echo "Error: HTTP response code $response"
    exit 1
fi

if [ $response -ge 300 ]; then
    echo "Redirect detected, following..."
    redirect_url=$(curl -s -L -o /dev/null -w %{url_effective} "https://$domain")
    echo "Redirect path: $redirect_url"
fi

curl -H "User-Agent: $user_agent" -s -I -vl -X GET -o /dev/null -L "https://$domain" > "/tmp/domain-$$.log" 2>&1
curl -H "User-Agent: $user_agent" -s -i -o /dev/null -w "Response: %{http_code}\n" -X GET "https://$domain"
curl -H "User-Agent: $user_agent" -s -I "https://$domain" | grep -i "Content-Security-Policy"
curl -H "User-Agent: $user_agent" -s -I "https://$domain" | grep -i -w '^server:'

if [ -z "$dig_output" ]; then
    echo "No results found for $domain."
else
    echo "Results for $domain:"
    echo "$dig_output"

    # Get more information about the IP addresses
    for ip in $(echo "$dig_output"); do
        echo "Additional information for IP address $ip:"
        whois_output=$(whois $ip | awk -F ':' '/^OrgName/ {print $2}')
        echo "OrgName: $whois_output"
        echo ""
    done
fi

exit 0
