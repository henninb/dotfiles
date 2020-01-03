#!/bin/sh

if [ "$(uname -s)" = "Linux" ]; then
  find /sys/class/net -mindepth 1 -maxdepth 1 ! -name lo -printf "%P: " -execdir cat {}/address \;
  echo cat /sys/class/net/enp0s3/address
  echo cat /sys/class/net/eth0/address
  ip -o link | awk '$2 != "lo:" {print $2, $(NF-2)}'
  ip -br link | grep -v LOOPBACK | awk '{ print $1 " : " $3 }'
  ip route show default | awk '/default/ {print $5}'
  ip a | grep ether | cut -d " " -f6
  ls /sys/class/net/

  D='/sys/class/net'
  for nic in $( ls $D )
  do
      echo $nic
      if  grep -q up $D/$nic/operstate
      then
          echo -n '   '
          cat $D/$nic/address
      fi
  done
else
  echo $OS is not yet implemented.
  exit 1
fi

exit 0
