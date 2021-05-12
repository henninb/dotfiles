#!/usr/bin/env sh

temp=0

if curl -s "wttr.in/Minneapolis?format=j1" > /tmp/.weather-minneapolis; then
  if jq < /tmp/.weather-minneapolis >/dev/null 2>&1; then
    temp=$(jq -r '.current_condition | .[] | .temp_F' < /tmp/.weather-minneapolis 2> /dev/null)
  else
    exit 1
  fi
else
  exit 2
fi

echo "${temp}"

# vim: set ft=sh:
