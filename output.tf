# output worker node name and IP
output "worker_nodes_details" {
  description = "All Worker node names and IP addresses"
  value = {
    for vm in proxmox_virtual_environment_vm.worker_nodes : 
    vm.name => vm.ipv4_addresses[0][0] # Note: This depends on your network configuration, if it's dhcp, usually read here
  }
}

# Output K3s Master node information (if you have a master_node resource)
# If you create a master_node in the future, you can add it similarly