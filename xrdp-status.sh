#!/bin/sh

if [ "$OS" = "Gentoo" ]; then
  rc-service xrdp status
else
  sudo systemctl status xrdp
  sudo systemctl status xrdp-sesman
fi

netstat -na | grep 3389 | grep LIST
if [ $? -ne 0 ]; then
  echo 3389 port is not running.
fi

netstat -na | grep 3350 | grep LIST
if [ $? -ne 0 ]; then
  echo 3350 port is not running - xrdp-sesman
fi

sudo fuser 3389/tcp
if [ $? -ne 0 ]; then
  echo 3389 port is not running.
fi

sudo fuser 3350/tcp
if [ $? -ne 0 ]; then
  echo 3350 port is not running - xrdp-sesman
fi

sudo lsof -Pi | grep LISTEN | grep xrdp
echo "xfreerdp /u:henninb /p:'changeit' /cert-ignore /v:127.0.0.1"

setpriv --no-new-privs Xorg :10 -auth .Xauthority -config xrdp/xorg.conf -noreset -nolisten tcp -logfile .xorgxrdp.%s.log

exit 0
