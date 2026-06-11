terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.50.100:8006/api2/json"
  pm_api_token_id     = "root@pam!terraform-token"
  pm_api_token_secret = "d6ba2358-e8dc-4c77-b198-60637dc01075" # 使用你之前创建的那个 Secret
  pm_tls_insecure     = true
}