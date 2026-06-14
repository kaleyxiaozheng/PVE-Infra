terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 2.9.14"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://100.85.222.115:8006/api2/json"
      pm_api_token_id = "root@pam!terraform-token"
      pm_api_token_secret = "1c50f781-99db-48fa-92d4-3feef9af6e6f"
      pm_tls_insecure = true
}

provider "aws" {
  alias  = "sydney"
  region = "ap-southeast-2"
}