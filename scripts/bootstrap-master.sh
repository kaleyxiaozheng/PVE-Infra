#!/bin/bash

# create ubuntu user if it doesn't exist
if ! id "ubuntu" &>/dev/null; then
  useradd -m -s /bin/bash ubuntu
fi
echo "ubuntu:${vm_password}" | chpasswd
usermod -aG sudo ubuntu

# set up SSH key for ubuntu user
mkdir -p /home/ubuntu/.ssh
echo "${ssh_pubkey}" > /home/ubuntu/.ssh/authorized_keys
chmod 700 /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh

# enable password authentication for SSH (if needed for cloud-init)
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Install Tailscale
# curl -fsSL https://tailscale.com/install.sh | sh
# tailscale up --authkey=${tailscale_auth_key} --hostname=${hostname}

# Enable password authentication for SSH (if needed for cloud-init)
sed -i 's/^#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication prohibit-password/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh
# Start Agent
apt-get update && apt-get install -y qemu-guest-agent curl git helm
systemctl enable --now qemu-guest-agent

# install K3s
curl -sfL https://get.k3s.io | sh -

# ensure all are ready and then install Helm/Prometheus 
[ -f /usr/local/bin/post-install.sh ] && /usr/local/bin/post-install.sh