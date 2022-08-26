## openwrt on proxmox

# install with 512M of ram

# step 1 - on proxmox
```
wget https://downloads.openwrt.org/releases/21.02.3/targets/x86/64/openwrt-21.02.3-x86-64-generic-squashfs-combined.img.gz
gunzip openwrt-21.02.3-x86-64-generic-squashfs-combined.img.gz
mv openwrt-21.02.3-x86-64-generic-squashfs-combined.img openwrt.img
qm importdisk 110 openwrt.img local-500
```

# check the boot order and then click start

# step 2 - on openwrt
```
passwd
uci set network.lan.ipaddr='192.168.10.6'
uci commit network
/etc/init.d/network restart
```
