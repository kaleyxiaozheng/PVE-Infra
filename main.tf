resource "proxmox_virtual_environment_vm" "worker_nodes" {
  count     = 3
  name      = "worker-node-${count.index + 1}"
  node_name = "pve" 
  vm_id     = 102 + count.index 

  # 基础信息
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
    vm_id = 101 # same ID as the template used for master node in PVE
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
}

resource "aws_s3_bucket" "aegis_logic_terraform_state_bucket" {
  bucket = "${local.project_prefix}-${local.common_tags.ManagedBy}-state-bucket"
}