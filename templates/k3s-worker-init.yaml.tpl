hostname: ${hostname}
fqdn: ${hostname}.local
manage_etc_hosts: true
package_update: true

users:
  - name: kz
    ssh_authorized_keys:
      - ${ssh_pubkey}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']

packages:
  - curl
  - git
  - qemu-guest-agent

runcmd:
  # 1. install and start Agent
  - apt-get update
  - apt-get install -y qemu-guest-agent
  - systemctl daemon-reload
  - systemctl enable --now qemu-guest-agent
  - systemctl restart qemu-guest-agent
  
  # 2. waiting for Master node avaialble
  - until ping -c 1 google.com; do sleep 2; done

  # 3. install K3s Agent and join to Master
  # injecting the K3S_URL and K3S_TOKEN variables using Terraform
  - curl -sfL https://get.k3s.io | K3S_URL=https://${master_ip}:6443 K3S_TOKEN=${k3s_token} sh -