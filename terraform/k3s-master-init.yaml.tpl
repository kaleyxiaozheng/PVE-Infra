# k3s-master-init.yaml.tpl

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

# import local scripts to VM using write_files
# install a post-installation script to deal with Helm and Prometheus installation after K3s is ready
  # Waiting Mechanism (until):
  #  The script continuously checks for the existence of /etc/rancher/k3s/k3s.yaml until K3s has successfully configured the cluster.
  #  •	Robustness: It ensures that no Helm operations are initiated before the Kubernetes API is truly responsive.
write_files:
  - path: /usr/local/bin/post-install.sh
    permissions: '0755'
    content: |
      ${indent(6, file("scripts/post-install.sh"))}

runcmd:
  # install K3s
  - curl -sfL https://get.k3s.io | sh -

  # run asynchronously
  # Asynchronous Execution: nohup ... & allows the Cloud-Init process to complete (preventing your VM boot process from hanging) while the installation logic continues to run silently in the background
  - nohup /usr/local/bin/post-install.sh > /var/log/post-install.log 2>&1 &