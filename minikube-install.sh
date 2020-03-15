#!/bin/sh

mkdir -p "$HOME/.docker"
touch "$HOME/.docker/config.json"

if [ "$OS" = "Arch Linux" ]; then
  sudo pacman --noconfirm --needed -S ethtool socat
  echo "https://computingforgeeks.com/how-to-run-minikube-on-kvm/"
  echo "minikube logs"

  if [ ! -f /usr/local/bin/minikube ]; then
    #curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
    if [ $? -ne 0 ]; then
      echo failure 1
      exit 1
    fi
    chmod +x minikube
    sudo mv -v minikube /usr/local/bin
  fi

  if [ ! -f /usr/local/bin/kubectl ]; then
    curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    if [ $? -ne 0 ]; then
      echo failure 2
      exit 2
    fi
    chmod +x kubectl
    sudo mv -v kubectl /usr/local/bin
  fi
  kubectl version -o json

  if [ ! -f /usr/local/bin/docker-machine-driver-kvm2 ]; then
    curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
    if [ $? -ne 0 ]; then
      echo failure 3
      exit 3
    fi
    chmod +x docker-machine-driver-kvm2
    sudo mv -v docker-machine-driver-kvm2 /usr/local/bin/
  fi

  minikube start --vm-driver kvm2
  if [ $? -ne 0 ]; then
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
    wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube
    if [ $? -ne 0 ]; then
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
    echo $VER
    echo "https://storage.googleapis.com/kubernetes-release/release/$VER/bin/linux/amd64/kubectl"
    wget -q "https://storage.googleapis.com/kubernetes-release/release/$VER/bin/linux/amd64/kubectl" -O kubectl
    if [ $? -ne 0 ]; then
      echo failure 2
      exit 2
    fi
    chmod +x kubectl
    sudo mv -v kubectl /usr/local/bin
  fi

  if [ ! -f /usr/local/bin/docker-machine-driver-kvm2 ]; then
    #curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
    wget -q https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 -o docker-machine-driver-kvm2
    if [ $? -ne 0 ]; then
      echo failure 3
      exit 3
    fi
    chmod +x docker-machine-driver-kvm2
    sudo mv -v docker-machine-driver-kvm2 /usr/local/bin/
  fi

  kubectl version -o json
  minikube start --vm-driver kvm2
  #minikube start --vm-driver none
  if [ $? -ne 0 ]; then
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

mkdir -p $HOME/projects
cd $HOME/projects
rm -rf kubernetes-bin
rm -rf kubernetes
git clone https://aur.archlinux.org/kubernetes-bin.git
git clone https://aur.archlinux.org/kubernetes.git
git clone https://aur.archlinux.org/minikube.git
cd minikube
#cd kubernetes-bin
makepkg -si
#sudo kubeadm init

exit 0
