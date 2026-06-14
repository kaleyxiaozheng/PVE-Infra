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
  endpoint      = "https://100.85.222.115:8006/api2/json"
  api_token = "root@pam!terraform-token=1c50f781-99db-48fa-92d4-3feef9af6e6f"
  insecure  = true
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}