docker network create -d macvlan --subnet=192.168.10.0/24 --gateway=192.168.10.1  -o parent=enp3s0 macvlan-net


sudo ip link add mac0 link enp3s0 type macvlan mode bridge
sudo ip addr add 192.168.10.26/24 dev mac0
sudo ip link set mac0 up
sudo ip route add 192.168.10.0/24 dev mac0
gentoo ~/documents  main [!+] ♜ ping 192.168.10.26
