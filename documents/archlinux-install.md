# archlinux install

```
passwd
```

```
ssh root@192.168.122.25
```

```
timedatectl set-ntp true
```


## partition the drive as show below (use dos)
```
cfdisk /dev/sda
cfdisk /dev/vda

parted /dev/sda  mklabel msdos
parted /dev/sda mkpart primary 1 1024
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary 1024 100%
```


## make the partitions
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -T small /dev/sda2
```
