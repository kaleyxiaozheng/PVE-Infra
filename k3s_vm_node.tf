# k3s_nodes.tf

module "master_node" {
  source    = "git@github.com:kaleyxiaozheng/k3s-node-module.git?ref=v1.0.0"
  node_name = "k3s-master-node"
  node_type = "master"
  vm_id     = 101
  memory    = 4096
  static_ip = "192.168.50.101/24"
  gateway   = "192.168.50.1"
  ssh_public_key_content = file(var.ssh_public_key_path) # fetch the content of the SSH public key file and pass it to the module
  vm_password = var.vm_password # pass the VM password variable to the module for cloud-init use  

  user_data = templatefile(local.k3s_templates.master, {
    hostname           = "k3s-master-node"
    ssh_pubkey         = file(var.ssh_public_key_path)
    k3s_token          = var.k3s_token
  })

  depends_on = [proxmox_virtual_machine.ubuntu_template] # Ensure the master node is created after the template
}

module "worker_node" {
  count     = 3
  source    = "git@github.com:kaleyxiaozheng/k3s-node-module.git?ref=v1.0.0"
  node_name = "worker-node-${count.index + 1}"
  node_type = "worker"
  vm_id     = 102 + count.index
  memory    = 3072
  ssh_public_key_content = file(var.ssh_public_key_path) # fetch the content of the SSH public key file and pass it to the module
  vm_password = var.vm_password # pass the VM password variable to the module for cloud-init use  

  # assign unique static IPs to each worker node
  static_ip = "192.168.50.${102 + count.index}/24"
  gateway   = "192.168.50.1"
  
  user_data = templatefile(local.k3s_templates.worker, {
    hostname   = "worker-node-${count.index + 1}"
    ssh_pubkey = file(var.ssh_public_key_path)
    master_ip  = "192.168.50.101"
    k3s_token  = var.k3s_token
  })
}