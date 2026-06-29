# ubuntu_template.tf

resource "proxmox_virtual_environment_vm" "ubuntu_template" {
  name      = var.vm_name
  node_name = var.pve_node
  vm_id     = var.vm_id
  # template  = true # mark it as template

  # hardware configuration
  memory {
    dedicated = 4096
  }
  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }
  machine = "q35"
  bios    = "ovmf" # UEFI

  # disk configuration
  scsi_hardware = "virtio-scsi-pci"

  disk {
    datastore_id = var.datastore
    file_id      = "local:iso/jammy-server-cloudimg-amd64.img" 
    interface    = "scsi0"
    size         = 32
    iothread     = true
    discard      = "on"
  }

  # network configuration
  network_device {
    bridge  = "vmbr0"
    model   = "virtio"
    firewall = true
  }

  # Options configuration
  agent {
    enabled = true # QEMU Guest Agent
  }

  # Cloud-Init configuration
  initialization {
    datastore_id = var.datastore

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    user_account {
      username = "ubuntu"
      keys     = [file(var.ssh_public_key_path)]
      }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.pve_node

  source_raw {
    data      = file("${path.module}/ubuntu_template.yaml")
    file_name = "ubuntu_template.yaml"
  }
}