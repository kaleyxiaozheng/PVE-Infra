# local.tf
locals {
  common_tags = {
    Project     = local.project_prefix
    Environment = local.env
    ManagedBy   = "terraform"
  }

  project_prefix = "aegis-logic"
  env            = "dev"

  k3s_templates = {
    master = "${path.module}/templates/k3s-master-init.yaml.tpl"
    worker = "${path.module}/templates/k3s-worker-init.yaml.tpl"
  }
}