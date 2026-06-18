output "master_node_details" {
  description = "Master node name and IP address"
  value = {
    name       = module.master_node.node_name
    vm_id      = module.master_node.vm_id
    ipv4       = module.master_node.ipv4_addresses
  }
}

output "worker_nodes_details" {
  description = "All Worker node names and IP addresses"
  value = {
    for i in range(3) : 
    module.worker_node[i].node_name => module.worker_node[i].ipv4_addresses
  }
}