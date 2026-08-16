variable "location" {
  description = "Azure region for the AKS platform."
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}

variable "prefix" {
  description = "Short naming prefix."
  type        = string
  default     = "rugo"
}

variable "vnet_address_space" {
  description = "Address space for the AKS virtual network."
  type        = list(string)
  default     = ["10.40.0.0/16"]
}

variable "aks_subnet_prefixes" {
  description = "Address prefixes for the AKS node subnet."
  type        = list(string)
  default     = ["10.40.1.0/24"]
}

variable "system_node_vm_size" {
  description = "VM size for the AKS system node pool."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
