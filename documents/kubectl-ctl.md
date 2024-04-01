# kubectl

## add a context called gce
kubectl config set-context gce --user=cluster-admin
kubectl config set-context minikube --user=cluster-admin

## view the config
kubectl config view

## set the context
kubectl config use-context minikube

## unset the current context
kubectl config unset current-context

## get contexts
kubectl config get-contexts

## current context
kubectl config current-context


## get nodes
kubectl get nodes

## initialize k8
kubeadm init --control-plane-endpoint=192.168.10.60 --node-name k8-controller --pod-network-cidr=10.244.0.0/16
