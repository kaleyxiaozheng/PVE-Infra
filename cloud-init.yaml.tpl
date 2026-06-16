#cloud-config
hostname: ${hostname}
fqdn: ${hostname}.local
manage_etc_hosts: true
users:
  - name: kz
    ssh_authorized_keys:
      - ${ssh_pubkey}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']

packages:
  - curl
  - git
  - helm

runcmd:
  # install K3s
  - curl -sfL https://get.k3s.io | sh -
  # add Helm Repo and install Prometheus/Grafana
  - helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  - helm install prometheus prometheus-community/kube-prometheus-stack