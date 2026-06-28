# local.tf

locals {
  common_tags = {
    Project     = local.project_prefix
    Environment = local.env
    ManagedBy   = "terraform"
  }

  project_prefix = "aegis-logic"
  env            = "dev"
}