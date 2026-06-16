#!/bin/bash
  
# wait for K3s to start and generate kubeconfig file
until [ -f /etc/rancher/k3s/k3s.yaml ]; do sleep 5; done
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# wait for API Server to be available
until kubectl get nodes; do sleep 5; done

# install Helm and Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack --create-namespace --namespace monitoring

# waiting for installation to complete and then remove the script itself (to keep the environment clean)
rm /usr/local/bin/post-install.sh