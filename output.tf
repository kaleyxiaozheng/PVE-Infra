# output worker node name and IP
output "worker_nodes_details" {
  description = "All Worker node names and IP addresses"
  value = {
    # access via module output
    for i in range(3) : 
    module.k3s-node-module.worker_nodes[i].node_name => module.k3s-node-module.worker_nodes[i].ipv4_addresses
  }
}