#!/bin/bash
# Start Agent
apt-get update && apt-get install -y qemu-guest-agent curl git helm
systemctl enable --now qemu-guest-agent

# install K3s
curl -sfL https://get.k3s.io | sh -

# ensure all are ready and then install Helm/Prometheus 
[ -f /usr/local/bin/post-install.sh ] && /usr/local/bin/post-install.sh