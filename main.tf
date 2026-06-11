resource "proxmox_vm_qemu" "worker_nodes" {
  count       = 3
  name        = "worker-node-${count.index + 1}"
  target_node = "pve"
  clone       = "ubuntu-template" # 确保你在 PVE 里右键创建了一个名为 ubuntu-template 的模板

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