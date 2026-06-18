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

runcmd:
  # 1. waiting for Master node avaialble
  - until curl -s -k https://${master_ip}:6443/readyz; do sleep 5; done

  # 2. install K3s Agent and join to Master
  # injecting the K3S_URL and K3S_TOKEN variables using Terraform
  - curl -sfL https://get.k3s.io | K3S_URL=https://${master_ip}:6443 K3S_TOKEN=${k3s_token} sh -