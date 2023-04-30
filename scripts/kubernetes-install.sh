#!/bin/sh

#mkdir -p "$HOME/.docker"
#touch "$HOME/.docker/config.json"

sudo emerge --update --newuse sys-cluster/kubectl
sudo emerge --update --newuse sys-cluster/minikube

minikube start --vm-driver kvm2

echo "temp early exit"
exit 1

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  doas pacman --noconfirm --needed -S ethtool socat
  echo "https://computingforgeeks.com/how-to-run-minikube-on-kvm/"
  echo "minikube logs"

  if [ ! -f /usr/local/bin/minikube ]; then
    #curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    if ! wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube; then
      echo failure 1
      exit 1
    fi
    chmod +x minikube
    sudo mv -v minikube /usr/local/bin
  fi

  if [ ! -f /usr/local/bin/kubectl ]; then
    if ! curl -Lo kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"; then
      echo failure 2
      exit 2
    fi
    chmod +x kubectl
    sudo mv -v kubectl /usr/local/bin
  fi
  kubectl version -o json

  if [ ! -f /usr/local/bin/docker-machine-driver-kvm2 ]; then
    if ! curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2; then
      echo failure 3
      exit 3
    fi
    chmod +x docker-machine-driver-kvm2
    sudo mv -v docker-machine-driver-kvm2 /usr/local/bin/
  fi

  if ! minikube start --vm-driver kvm2; then
    echo failure 4
    exit 4
  fi
  minikube status
  kubectl cluster-info
  kubectl get nodes
  kubectl get pod
  echo "kubectl get nodes"
  echo "minikube stop"
  echo "minikube delete"
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  if [ ! -f /usr/local/bin/minikube ]; then
#    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    if ! wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube; then
      echo failure 1
      exit 1
    fi
    chmod +x minikube
    sudo mv -v minikube /usr/local/bin
  fi

  rm -rf stable.txt
  if [ ! -f /usr/local/bin/kubectl ]; then
    VER=$(wget -q https://storage.googleapis.com/kubernetes-release/release/stable.txt -O stable.txt && cat stable.txt)
    if [ $? -ne 0 ]; then
      echo failure 6
      exit 6
    fi
    echo "$VER"
    echo "https://storage.googleapis.com/kubernetes-release/release/$VER/bin/linux/amd64/kubectl"
    if ! wget -q "https://storage.googleapis.com/kubernetes-release/release/$VER/bin/linux/amd64/kubectl" -O kubectl; then
      echo failure 2
      exit 2
    fi
    chmod +x kubectl
    sudo mv -v kubectl /usr/local/bin
  fi

  if [ ! -f /usr/local/bin/docker-machine-driver-kvm2 ]; then
    #curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
    if ! wget -q https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 -o docker-machine-driver-kvm2; then
      echo failure 3
      exit 3
    fi
    chmod +x docker-machine-driver-kvm2
    sudo mv -v docker-machine-driver-kvm2 /usr/local/bin/
  fi

  kubectl version -o json
  if ! minikube start --vm-driver kvm2; then
    echo failure 101
    exit 101
  fi
  minikube status
  kubectl cluster-info
  kubectl get nodes
  kubectl get pod
  echo "kubectl get nodes"
  echo "minikube stop"
  echo "minikube delete"
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

# vim: set ft=sh:
