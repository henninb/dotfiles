#!/bin/bash
# ------------------------------------------------------------------
#
#     bin/chunk_cpu_usage.sh
#     Description: Script for Download/ Upload Speed
#                  feed to dzen.
#
#     Source
#
#     Modified by: Epsi Nurwijayadi <epsi.nurwijayadi@gmail.com)
#
# ------------------------------------------------------------------

interface=$(iw dev | grep Interface | awk '{print $2}')

if [ "$interface" ]; then

  # Read first datapoint
  read TX_prev < /sys/class/net/$interface/statistics/tx_bytes
  read RX_prev < /sys/class/net/$interface/statistics/rx_bytes

  sleep 1

  # Read second datapoint

  read TX_curr < /sys/class/net/$interface/statistics/tx_bytes
  read RX_curr < /sys/class/net/$interface/statistics/rx_bytes

  # compute
  TX_diff=$((TX_curr-TX_prev))
  RX_diff=$((RX_curr-RX_prev))

  # printout var
  TX_text=$(echo "scale=1; $TX_diff/1024" | bc | awk '{printf "%.1f", $0}')
  RX_text=$(echo "scale=1; $RX_diff/1024" | bc | awk '{printf "%.1f", $0}')

  echo -n '^i(.xmonad/assets/monitor/net_down.xbm) '$RX_text
  echo -n '^i(.xmonad/assets/monitor/net_up.xbm) '$TX_text

fi

exit 0
