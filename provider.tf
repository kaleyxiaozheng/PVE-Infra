# provider.tf

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = var.proxmox_api_token
  insecure  = true
  ssh {
    username    = "root"
    private_key = file(var.ssh_private_key_path)
  }
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}