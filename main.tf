resource "proxmox_virtual_environment_vm" "worker_nodes" {
  count     = 3
  name      = "worker-node-${count.index + 1}"
  node_name = "pve"
  vm_id     = 101 + count.index

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 3072
  }

  clone {
    vm_id = 100 # same ID as the template used for master node in PVE
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 30
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.cloud_config[count.index].id

    user_account {
      username = "kz"
    }
    
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
}

resource "local_file" "cloud_init_config" {
  count    = 3
  filename = "${path.module}/cloud-configs/worker-${count.index + 1}.yaml"
  content  = templatefile("cloud-init.yaml.tpl", {
    hostname = "worker-node-${count.index + 1}"
  })
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  count        = 3
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "pve"

  source_file {
    path = local_file.cloud_init_config[count.index].filename
  }
}

resource "aws_s3_bucket" "aegis_logic_terraform_state_bucket" {
  bucket = "${local.project_prefix}-${local.common_tags.ManagedBy}-state-bucket"
}