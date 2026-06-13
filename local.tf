locals {
  common_tags = {
    Project     = local.project_prefix
    Environment = local.env
    ManagedBy   = "Terraform"
  }
  
  project_prefix = "aegis-logic"
  env            = "dev"
}