git clone https://github.com/foxlet/macOS-Simple-KVM.git
sudo apt install qemu-system qemu-utils

qemu-img create -f qcow2 MyDisk.qcow2 20G

./basic.sh
