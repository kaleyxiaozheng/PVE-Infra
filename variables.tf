# variables.tf

# ubuntu-template configuration
variable "pve_node" {
  type    = string
  default = "pve"
}

variable "vm_id" {
  type    = number
  default = 998
}

variable "datastore" {
  type    = string
  default = "local-lvm"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-template-tf"
}

variable "proxmox_api_url" {
  description = "Proxmox API address"
  type        = string
  default     = "https://192.168.50.100:8006/"
}

variable "proxmox_api_token" {
  description = "Proxmox API Token (format: user@realm!tokenid=tokenvalue)"
  type        = string
  sensitive   = true  # Terraform will not display it in plain text in the logs
}

variable "ssh_private_key_path" {
  description = "SSH private key path for connecting to Proxmox nodes"
  type        = string
  default     = "/Users/kaleyzheng/.ssh/id_ed25519"
}

variable "k3s_token" {
  description = "The token used for K3s node joining"
  type        = string
  sensitive   = true  # true to prevent it from being displayed in logs, as it's a sensitive value
}

variable "ssh_public_key_path" { 
  description = "Path to the SSH public key for node access"
  type = string 
  default = "/Users/kaleyzheng/.ssh/id_ed25519.pub"
  sensitive   = true  # true to prevent it from being displayed in logs, as it's a sensitive value
}

variable "vm_password" { 
  type = string
  sensitive = true 
  description = "Password for user ubuntu on the VMs (if needed for cloud-init)"
}

variable "node_type" {
  type        = string
  description = "Node type: master or worker"
  default     = "worker" 
}