sudo apt install mdadm
mdadm --examine --scan >> /etc/mdadm/mdadm.conf

sudo modprobe raid0
sudo modprobe raid1
sudo modprobe raid456
sudo modprobe raid10
sudo modprobe linear

henninb@henninb-Z87H3-M:~$ ls /dev/mapper/*
/dev/mapper/control  /dev/mapper/isw_chjhfhadce_volume1  /dev/mapper/isw_chjhfhadce_volume1p1
henninb@henninb-Z87H3-M:~$ cat /proc/mdstat
Personalities : 
unused devices: <none>
henninb@henninb-Z87H3-M:~$ 

henninb@henninb-Z87H3-M:~$ sudo dmraid -ay
RAID set "isw_chjhfhadce_volume1" already active
RAID set "isw_chjhfhadce_volume1p1" already active

henninb@henninb-Z87H3-M:~$ sudo blkid | grep sdc
/dev/sdc: TYPE="isw_raid_member"
henninb@henninb-Z87H3-M:~$ sudo blkid | grep sda
henninb@henninb-Z87H3-M:~$ 

sudo mdadm --assemble --scan

henninb@henninb-Z87H3-M:~$ sudo mdadm --examine /dev/sdc 
