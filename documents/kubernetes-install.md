## remove swap from /etc/fstab

## Uncomment the following line for packet forwarding
vi /etc/sysctl.conf
net.ipv4.ip_forward=1

## static ip
vi /etc/network/interfaces

## the interface name can vary
```
auto ens18
iface ens18 inet static
address 192.168.10.60
netmask 255.255.255.0
gateway 192.168.10.1
dns-nameservers 8.8.4.4 8.8.8.8
```

## docker install
apt update
apt install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


## load modules
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

containerd config default | tee /etc/containerd/config.toml >/dev/null 2>&1

SystemdCgroup = true


echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

apt update
apt install kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
