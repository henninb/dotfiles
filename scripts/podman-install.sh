#!/bin/sh

cat << EOF > "$HOME/tmp/registries.conf"
[registries.search]
registries = ['docker.io', 'quay.io', 'registry.access.redhat.com']
registries = ['docker.io']
EOF

cat << EOF > "$HOME/tmp/policy.json"
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports":
        {
            "docker-daemon":
                {
                    "": [{"type":"insecureAcceptAnything"}]
                }
        }
}
EOF

if command -v pacman; then
  sudo pacman --noconfirm --needed -S podman
  sudo pacman --noconfirm --needed -S slirp4netns
  sudo pacman --noconfirm --needed -S fuse-overlayfs
  sudo pacman --noconfirm --needed -S podman-dnsname
  systemctl --user start podman.socket
  # sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(id -un)"
  echo +cpu +cpuset +io +memory +pids > sudo tee -a /sys/fs/cgroup/cgroup.subtree_control
elif command -v emerge; then
  sudo emerge --update --newuse podman
  sudo emerge --update --newuse slirp4netns
  sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$(id -un)"
  systemctl --user start podman.socket
elif [ -x "$(command -v apt)" ]; then
  echo "debian"
elif [ -x "$(command -v xbps-install)" ]; then
  sudo xbps-install -y podman
elif [ -x "$(command -v eopkg)" ]; then
  echo "solus"
elif [ -x "$(command -v dnf)" ]; then
  echo "fedora"
  sudo dnf install podman-plugins -y
elif [ -x "$(command -v brew)" ]; then
  echo "macoos"
else
  echo "$OS is not yet implemented."
  exit 1
fi

sudo setcap cap_net_bind_service=+ep $(which slirp4netns)
# sudo sh -c "echo 0 > /proc/sys/net/ipv4/ip_unprivileged_port_start"
echo 0 | sudo tee /proc/sys/net/ipv4/ip_unprivileged_port_start
#echo net.ipv4.ip_unprivileged_port_start=0 | sudo tee -a /etc/sysctl.conf
echo net.ipv4.ip_unprivileged_port_start=443 | sudo tee -a /etc/sysctl.conf
pip install podman-compose

sudo cp -v /etc/containers/policy.json.example /etc/containers/policy.json

# sudo touch /etc/subuid /etc/subgid
# cat /etc/sysctl.d/userns.conf
sudo sysctl kernel.unprivileged_userns_clone=1
sysctl kernel.unprivileged_userns_clone

sudo mv -v "$HOME/tmp/registries.conf" /etc/containers/registries.conf
sudo mv -v "$HOME/tmp/policy.json" /etc/containers/policy.json

exit 0

# vim: set ft=sh:
