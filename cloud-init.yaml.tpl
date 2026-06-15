#cloud-config
hostname: ${hostname}
fqdn: ${hostname}.local
manage_etc_hosts: true
users:
  - name: kz
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrHIPmpf0vaS+fFvrN5SeJ26hFVXmJ0Wi5yLnPvxP7Z zheng.kaley.x@gmail.com
    sudo: ALL=(ALL) NOPASSWD:ALL