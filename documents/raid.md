# raid setup
sudo apt install -y mdadm
sudo xbps-install -y mdadm
sudo dnf install -y dmraid
sudo mkdir -p /etc/mdadm/
echo sudo mdadm --examine --scan
sudo mdadm --examine --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo xbps-install -y dmraid

sudo modprobe raid0
sudo modprobe raid1
sudo modprobe raid456
sudo modprobe raid10
sudo modprobe linear

ls /dev/mapper/*
```
/dev/mapper/control  /dev/mapper/isw_chjhfhadce_volume1  /dev/mapper/isw_chjhfhadce_volume1p1
henninb@henninb-Z87H3-M:~$ cat /proc/mdstat
Personalities :
unused devices: <none>
```

sudo dmraid -ay
```
RAID set "isw_chjhfhadce_volume1" already active
RAID set "isw_chjhfhadce_volume1p1" already active
```

sudo blkid | grep sdc
```
/dev/sdc: TYPE="isw_raid_member"
```

sudo blkid | grep sda

sudo mdadm --assemble --scan

sudo mdadm --examine /dev/sdc
