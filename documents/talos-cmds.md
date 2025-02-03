talosctl gen config <cluster-name> <cluster-endpoint>

talosctl gen config mycluster https://192.168.10.176:6443

talosctl -n 192.168.10.176 get disks --insecure
talosctl -n 192.168.10.177 get disks --insecure

talosctl apply-config --insecure  --nodes 192.168.10.176 --file controlplane.yaml
talosctl apply-config --insecure  --nodes 192.168.10.177 --file worker.yaml


talosctl --talosconfig=./talosconfig --nodes 192.168.10.176 -e 192.168.10.176 version

talosctl bootstrap --nodes 192.168.10.176 --endpoints 192.168.10.176 --talosconfig=./talosconfig


talosctl kubeconfig --nodes 192.168.10.176 --endpoints 192.168.10.176 --talosconfig=./talosconfig

talosctl kubeconfig alternative-kubeconfig --nodes 192.168.10.176 --endpoints 192.168.10.176  --talosconfig=./talosconfig

kubectl label node talos-ln1-e09 node-role.kubernetes.io/worker=worker


kubectl create namespace test-ns
kubectl label namespace test-ns pod-security.kubernetes.io/enforce=privileged
kubectl run test-pod --image=nginx --restart=Never --namespace=test-ns


kubectl get pods -n test-ns -o wide