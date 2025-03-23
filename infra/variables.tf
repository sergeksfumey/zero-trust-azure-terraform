variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-deny-public-ip-demo"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureadmin" # or choose your own default
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}