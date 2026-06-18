# output worker node name and IP
output "worker_nodes_details" {
  description = "All Worker node names and IP addresses"
  value = {
    # access via module output
    for i in range(3) : 
    module.k3s_workers[i].node_name => module.k3s_workers[i].ipv4_addresses
  }
}