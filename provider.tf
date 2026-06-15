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
  endpoint  = "https://192.168.50.100:8006/"
  api_token = "root@pam!terraform-token=1c50f781-99db-48fa-92d4-3feef9af6e6f"
  insecure  = true

  ssh {
    username   = "root"
    private_key = file("/Users/kaleyzheng/.ssh/id_ed25519") 
  }
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}