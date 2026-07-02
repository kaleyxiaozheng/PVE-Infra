# # main.tf

# resource "proxmox_virtual_environment_vm" "ubuntu_template" {
#   name      = "ubuntu-template"
#   node_name = "pve"
#   vm_id     = 999
#   template  = true # mark it as template

#   # hardware configuration
#   memory {
#     dedicated = 4096
#   }
#   cpu {
#     cores   = 2
#     sockets = 1
#     type    = "host"
#   }
#   machine = "q35"
#   bios    = "ovmf" # UEFI

#   # disk configuration
#   scsi_hardware = "virtio-scsi-pci"

#   disk {
#     datastore_id = var.datastore
#     file_id      = "local:iso/jammy-server-cloudimg-amd64.img" 
#     interface    = "scsi0"
#     size         = 32
#     iothread     = true
#     discard      = "on"
#   }

#   # network configuration
#   network_device {
#     bridge  = "vmbr0"
#     model   = "virtio"
#     firewall = true
#   }

#   # Options configuration
#   agent {
#     enabled = true # QEMU Guest Agent
#   }

#   # Cloud-Init configuration
#   initialization {
#     datastore_id = var.datastore

#     user_account {
#       username = "ubuntu"
#       keys     = [file(var.ssh_public_key_path)]
#       }
#   }

#   # Automatic Cleanup and Conversion
#   provisioner "local-exec" {
#     command = <<EOT
#       echo "Waiting for template VM to be ready..."
#       sleep 10
      
#       echo "Cleaning up template..."
#       ssh -o StrictHostKeyChecking=no ubuntu@${var.template_ip} "sudo cloud-init clean && sudo truncate -s 0 /etc/machine-id && sudo rm -f /etc/ssh/ssh_host_* && sudo poweroff"
      
#       echo "Converting VM ${self.vm_id} to Template on PVE host..."
#       ssh -o StrictHostKeyChecking=no root@${var.pve_host_ip} "qm template ${self.vm_id}"
      
#       echo "Template conversion complete."
#     EOT
#   }
# }