#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Please provide a domain name."
    exit 1
fi

domain=$1
rootdomain=$(echo $domain | awk -F '.' '{ print $(NF-1)"."$NF }')

if [ "$domain" = "$rootdomain" ]; then
 domain="www.$rootdomain"
fi
# user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"
user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36"

echo "Performing DNS lookup for $domain..."
dig_output=$(dig $domain +short +time=15)

touch /tmp/mycookies.txt

response=$(curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar /tmp/mycookies.txt -s -I -w "%{http_code}" -o /dev/null "https://$domain")

if [ $response -ge 400 ]; then
    echo "Error: HTTP response code $response"
    exit 1
fi

if [ $response -ge 300 ]; then
    redirect_url=$(curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar /tmp/mycookies.txt -s -L -o /dev/null -w %{url_effective} "https://$domain")
    echo "Redirect path: $redirect_url"
    response=$(curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar /tmp/mycookies.txt -s -I -L -X GET -w "%{http_code}" -o /dev/null "https://$domain")
    if [ $response -ne 200 ]; then
      echo "cannont access $redirect_url"
      exit 1
    fi
fi

run_curl() {
  local arg1=$1
  dig_arg1=$(dig $arg1 +short +time=15)
  echo $arg1
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I -o /dev/null -v -X GET "https://$arg1" > "/tmp/$arg1-$$.log" 2>&1
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I "https://$arg1"  | grep -i "Content-Security-Policy" || echo "no CSP header response"
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I "https://$arg1" | grep -i -w '^server:' || echo "no server header response"
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I "https://$arg1" | grep -i -w '^cf-cache-status:' || echo "no cf-cache-status header response"
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I "https://$arg1" | grep -i -w '^x-yottaa-os:' || echo "no x-yottaa-os header response"
  curl --max-time 15 -H "User-Agent: $user_agent" --cookie-jar "/tmp/cookies.$arg1.dat" -s -I "https://$arg1" | awk '/^HTTP/{print $1}'
  # curl -H "User-Agent: $user_agent" -s -I -L "https://$arg1" | awk '/^cf-cache-status:/ {print $2; found=1} END {if (!found) print "cf-cache-status Header not found"}'

  if [ -z "$dig_arg1" ]; then
      echo "No results found for $arg1."
  else
      echo "Results for $arg1:"
      echo "$dig_arg1"

      # Get more information about the IP addresses
      for ip in $(echo "$dig_arg1"); do
        if printf "%s\n" "$ip" | grep -E -q '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'; then
          echo "Additional information for IP address $ip:"
          whois_output=$(whois $ip | awk -F ':' '/^OrgName/ {print $2}')
          echo "OrgName: $whois_output"
        fi
      done
      echo "-----------"
  fi
}

run_curl $rootdomain
run_curl login.$rootdomain
run_curl $domain

exit 0
