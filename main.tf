# main.tf

module "master_node" {
  source = "git@github.com:kaleyxiaozheng/k3s-node-module.git?ref=V1.0.0"
  node_name = "k3s-master-node"
  vm_id     = 101
  memory    = 4096
  static_ip = "192.168.50.101/24"
  gateway   = "192.168.50.1"
  user_data = templatefile("k3s-master-init.yaml.tpl", {
    hostname   = "k3s-master-node"
    ssh_pubkey = var.ssh_public_key
  })
}

module "worker_node" {
  count  = 3
  source = "git@github.com:kaleyxiaozheng/k3s-node-module.git?ref=V1.0.0"
  node_name = "worker-node-${count.index + 1}"
  vm_id     = 102 + count.index
  memory    = 3072
  
  user_data = templatefile("k3s-worker-init.yaml.tpl", {
    hostname   = "worker-node-${count.index + 1}"
    ssh_pubkey = var.ssh_public_key
    master_ip  = "192.168.50.101"
    k3s_token  = var.k3s_token
  })
}

resource "aws_s3_bucket" "aegis_logic_terraform_state_bucket" {
  bucket = "${local.project_prefix}-${local.common_tags.ManagedBy}-state-bucket"
}