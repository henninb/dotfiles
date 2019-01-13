#!/bin/sh

echo minikube start --vm-driver kvm2
#minikube start --vm-driver kvm2

#minikube docker-env
#kubectl cluster-info

kubectl delete --all pods --namespace=default

# deete all deployments
kubectl delete --all deployments --namespace=default
 
 # delete all services
kubectl delete --all services --namespace=default

echo create pod and deployment
kubectl create -f nginx-deployment.yml
kubectl apply -f nginx-pod.yml

echo kubectl get pods
kubectl get pods

echo kubectl get deployments
kubectl get deployments

#echo create a service
#kubectl expose -f nginx_example.yml
kubectl expose deployment nginx-deployment --type=LoadBalancer --name=nginx-service

echo kubectl get services
kubectl get services

echo kubectl describe service nginx
kubectl describe service nginx

#kubectl apply -f nginx_example.yml
#kubectl get nodes
#echo minikube ssh
minikube ip

echo minikube service nginx-service

exit 0
