#!/bin/sh

echo minikube start --vm-driver kvm2
# minikube start --vm-driver kvm2

# minikube docker-env
# kubectl cluster-info

kubectl delete --all pods --namespace=default

# delete all deployments
kubectl delete --all deployments --namespace=default

# delete all services
kubectl delete --all services --namespace=default

echo create pod and deployment
kubectl create -f postgres-deployment.yml

echo kubectl get pods
kubectl get pods

echo kubectl get deployments
kubectl get deployments

#echo create a service
#kubectl expose -f postgres_example.yml
kubectl expose deployment postgres-deployment --type=LoadBalancer --name=postgres-service

echo kubectl get services
kubectl get services

echo kubectl describe service postgres
kubectl describe service postgres

#kubectl apply -f postgres_example.yml
#kubectl get nodes
#echo minikube ssh
minikube ip

echo minikube service postgres-service

exit 0
