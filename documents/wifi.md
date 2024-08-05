sudo nmcli --ask dev wifi connect dd-wrt-2.4

mmcli device wifi connect WiFi
nmcli connection delete WiFi

mmcli device wifi connect henninb-wifi
sudo nmcli --ask dev wifi connect henninb-wifi
nmcli connection delete henninb-wifi
