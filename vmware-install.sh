#!/bin/sh

wget https://download3.vmware.com/software/player/file/VMware-VIX-1.15.8-5528349.x86_64.bundle?HashKey=87e27ebfcdd6b468babc788abf70e5fc&params=%7B%22sourcefilesize%22%3A%2221.05+MB%22%2C%22dlgcode%22%3A%22PLAYER-1256-VIX1158%22%2C%22languagecode%22%3A%22en%22%2C%22source%22%3A%22DOWNLOADS%22%2C%22downloadtype%22%3A%22manual%22%2C%22eula%22%3A%22N%22%2C%22downloaduuid%22%3A%2205e75b8f-8369-420a-b40a-377342d55ac7%22%2C%22purchased%22%3A%22N%22%2C%22dlgtype%22%3A%22Drivers+%26+Tools%22%2C%22productversion%22%3A%221.15.8%22%2C%22productfamily%22%3A%22VMware+Player%22%7D&AuthKey=1560088103_03df8cf51f7c0ec669faf547601a850b

echo VMware-Player-15.1.0
echo cat /usr/lib/vmware-vix/vixwrapper-config.txt
echo player    19  vmdb  15.1.0 Workstation-12.0.0

echo vmrun -T player list
echo /etc/vmware/license-ws-150-e1-201804

exit 0
