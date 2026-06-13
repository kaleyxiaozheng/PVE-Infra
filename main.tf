resource "proxmox_vm_qemu" "worker_nodes" {
  count       = 3
  name        = "worker-node-${count.index + 1}"
  target_node = "pve"
  clone       = "ubuntu-template" # make sure a template named "ubuntu-template" in Proxmox clusteryou has been created

  agent    = 1
  cores    = 2
  memory   = 3072
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "scsi"
    size    = "30G"
  }
}

resource "aws_s3_bucket" "aegis_logic_s3_bucket" {
  bucket = "${local.project_prefix}-${local.common_tags.ManagedBy}-bucket"
}

resource "aws_dynamodb_table" "aegis_logic_dynamodb_table" {
  name = "${local.project_prefix}-${local.common_tags.Environment}-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
}
}