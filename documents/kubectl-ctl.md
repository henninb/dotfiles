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
