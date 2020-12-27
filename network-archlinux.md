[  148.302025] r8169 0000:09:00.0 enp9s0: rtl_rxtx_empty_cond == 0 (loop: 42, delay: 100).

[    0.144869] ACPI BIOS Error (bug): Failure creating named object [\_SB.SMIC], AE_ALREADY_EXISTS (20200717/dswload2-326)
[    0.144873] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20200717/psobject-220)
[    0.144877] ACPI BIOS Error (bug): Failure creating named object [\_SB.SMIB], AE_ALREADY_EXISTS (20200717/dsfield-637)


sudo pacman -S r8168
sudo rmmod r8169
sudo modprobe r8168
sudo netctl restart wired

sudo date -s "27 DEC 2020 12:24:00"

sudo ethtool -s eth0 speed 100 duplex full autoneg off

sudo pacman -Ss r8168

sudo -i
echo "blacklist r8169"  >>  /etc/modprobe.d/blacklist.conf
exit
