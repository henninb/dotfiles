## stoped working - noticed on 5/27/2022
yay -S  rtl8821au-dkms-git

## built the following on archlinux and the device shows up
git clone https://github.com/brektrou/rtl8821CU.git


## may need to create this file with this setting
echo "options 8821cu rtw_RFE_type=0x26" | sudo tee /etc/modprobe.d/8821cu.conf


## result of `ip a show`
wlp0s20u1

## once driver is loaded the led will blink blue

## look for this in the lsusb
Bus 003 Device 017: ID 0bda:c811 Realtek Semiconductor Corp. 802.11ac NIC

## this may function on debian based systems
sudo apt update
sudo apt install build-essential git dkms
git clone https://github.com/brektrou/rtl8821CU.git
cd rtl8821CU
chmod +x dkms-install.sh
sudo ./dkms-install.sh
sudo modprobe 8821cu






rtl8811cu/rtl8821cu
rtl8821cu-dkms-git AUR provides a kernel module for the Realtek 8811cu and 8821cu chipset.

This requires DKMS, so make sure you have your proper kernel headers installed.

If no wireless interface shows up even though the 8821cu module is loaded, you may need to manually specify the rtw_RFE_type option [8][9]. Try e.g. rtw_RFE_type=0x26, other values might also work. See Kernel module#Setting module options for details.

rtl8821ce
rtl8821ce-dkms-gitAUR provides a kernel module for the Realtek 8821ce chipset found in the Asus X543UA.

This requires DKMS, so make sure you have your proper kernel headers installed.

Note: It has been reported [10] that the default rtl8821ce module provided by Realtek is broken for Linux kernel ≥ 5.9, which may lead to low connectivity. The AUR version above should be preferred. See the statement on GitHub.
