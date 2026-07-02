# output.tf

# output "template_id" {
#   value       = proxmox_virtual_environment_vm.ubuntu_template.vm_id
#   description = "The ubuntu template ID of the created template"
# }

# output "template_name" {
#   value       = proxmox_virtual_environment_vm.ubuntu_template.name
#   description = "The name of the created template"
# }

# output "master_node_details" {
#   description = "Master node name and IP address"
#   value = {
#     name       = module.master_node.node_name
#     vm_id      = module.master_node.vm_id
#     ipv4       = module.master_node.ipv4_addresses
#   }
# }

# output "worker_nodes_details" {
#   description = "All Worker node names and IP addresses"
#   value = {
#     for i in range(3) : 
#       "${module.worker_node[i].node_name}" => {
#         vm_id = module.worker_node[i].vm_id
#         ipv4 = module.worker_node[i].ipv4_addresses
#       }
#   }
# }

# output "ssh_instructions" {
#   description = "Run these commands to SSH into your nodes"
#   value = {
#     master_ssh = "ssh ubuntu@{module.master_node.ipv4_addresses[0]}"
#     worker_ssh = [for i in range(3) : "ssh ubuntu@{module.worker_node[i].ipv4_addresses[0]}"]
#   }
# }