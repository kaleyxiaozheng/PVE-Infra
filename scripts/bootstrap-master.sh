#!/bin/bash
# Start Agent
apt-get update && apt-get install -y qemu-guest-agent curl git helm
systemctl enable --now qemu-guest-agent

# install and configure Tailscale (before K3s to ensure network identity is ready)
curl -fsSL https://tailscale.com/install.sh | sh
# Using Auth Key to auto authenticate injected by Terraform
tailscale up --authkey=${tailscale_auth_key} --hostname=${hostname}
# install K3s
curl -sfL https://get.k3s.io | sh -

# ensure all are ready and then install Helm/Prometheus 
[ -f /usr/local/bin/post-install.sh ] && /usr/local/bin/post-install.sh