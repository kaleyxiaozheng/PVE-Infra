#!/bin/bash

USER="ubuntu"
HOME_DIR="/home/$USER"

# create ubuntu user if it doesn't exist
if ! id "$USER" &>/dev/null; then
  useradd -m -s /bin/bash $USER
  usermod -aG sudo $USER
fi
echo "$USER:${vm_password}" | chpasswd
usermod -aG sudo $USER

# set up SSH key for ubuntu user
mkdir -p $HOME_DIR/.ssh
echo "${ssh_pubkey}" > $HOME_DIR/.ssh/authorized_keys
chmod 700 $HOME_DIR/.ssh
chmod 600 $HOME_DIR/.ssh/authorized_keys
chown -R $USER:$USER $HOME_DIR/.ssh

# enable password authentication for SSH (if needed for cloud-init)
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

# install Tailscale
# curl -fsSL https://tailscale.com/install.sh | sh
# tailscale up --authkey=${tailscale_auth_key} --hostname=${hostname} 

# Enable password authentication for SSH (if needed for cloud-init)
sed -i 's/^#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication prohibit-password/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart ssh

apt-get update && apt-get install -y qemu-guest-agent curl git
systemctl enable --now qemu-guest-agent

# waiting for Master API port
until nc -zv ${master_ip} 6443; do sleep 5; done

# join K3s cluster
curl -sfL https://get.k3s.io | K3S_URL=https://${master_ip}:6443 K3S_TOKEN=${k3s_token} sh -