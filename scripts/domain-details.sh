#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Please provide a domain name."
    exit 1
fi

domain=$1
# user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"
user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36"

echo "Performing DNS lookup for $domain..."
dig_output=$(dig $domain +short)

# response=$(curl -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36" -vlskI -X GET -w "%{http_code}" -o /dev/null -L "https://$domain")
response=$(curl -H "User-Agent: $user_agent" -s -I -w "%{http_code}" -o /dev/null "https://$domain")

if [ $response -ge 400 ]; then
    echo "Error: HTTP response code $response"
    exit 1
fi

if [ $response -ge 300 ]; then
    redirect_url=$(curl -s -L -o /dev/null -w %{url_effective} "https://$domain")
    echo "Redirect path: $redirect_url"
    response=$(curl -H "User-Agent: $user_agent" -s -I -L -X GET -w "%{http_code}" -o /dev/null "https://$domain")
    if [ $response -ne 200 ]; then
      echo "cannont access $redirect_url"
      exit 1
    fi
fi

curl -H "User-Agent: $user_agent" -s -I -L -o /dev/null -v -X GET "https://$domain" > "/tmp/domain-$$.log" 2>&1
curl -H "User-Agent: $user_agent" -s -I -L "https://$domain"  | grep -i "Content-Security-Policy" || echo "no CSP header response"
curl -H "User-Agent: $user_agent" -s -I -L "https://$domain" | grep -i -w '^server:' || echo "no server header response"
curl -H "User-Agent: $user_agent" -s -I -L "https://$domain" | grep -i -w '^cf-cache-status:' || echo "no cf-cache-status header response"
curl -H "User-Agent: $user_agent" -s -I -L "https://$domain" | grep -i -w '^x-yottaa-os:' || echo "no x-yottaa-os header response"
# curl -H "User-Agent: $user_agent" -s -I -L "https://$domain" | awk '/^cf-cache-status:/ {print $2; found=1} END {if (!found) print "cf-cache-status Header not found"}'

if [ -z "$dig_output" ]; then
    echo "No results found for $domain."
else
    echo "Results for $domain:"
    echo "$dig_output"

    # Get more information about the IP addresses
    for ip in $(echo "$dig_output"); do
      if printf "%s\n" "$ip" | grep -E -q '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'; then
        echo "Additional information for IP address $ip:"
        whois_output=$(whois $ip | awk -F ':' '/^OrgName/ {print $2}')
        echo "OrgName: $whois_output"
        echo ""
      fi
    done
fi

exit 0
