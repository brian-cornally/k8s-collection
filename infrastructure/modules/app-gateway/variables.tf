variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "location" {
  description = "(Required) Specifies the location of the acr"
  type        = string
  default     = "westeurope"
}

variable "rg_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with name of the resource group."
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "acr"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}

###############
# dependencies
###############

variable "acr_name" {
  description = "Name of the Container Registry"
  type        = string
}

variable "acr_rg_name" {
  description = "Specifies the name of the resource group."
  type        = string
}

variable "subnet_appgtw_id" {
  description = "Specifies the appgtw subnet id"
  type        = string
}

###############
# app gateway
###############

// Public IP
variable "public_ip_prefix" {
  type        = string
  default     = "pip"
  description = "Prefix of the public ip prefix resource."
}

variable "appgtw_pip_name" {
  description = "(Required) Specifies the name of the Public IP."
  type        = string
}

variable "pip_allocation_method" {
  description = " (Required) Defines the allocation method for this IP address."
  type        = string
  default     = "Static"
  validation {
    condition     = contains(["Static", "Dynamic"], var.pip_allocation_method)
    error_message = "The allocation method is invalid."
  }
}

variable "pip_sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "basic"
  validation {
    condition     = contains(["basic", "Standard"], var.pip_sku)
    error_message = "The sku is invalid."
  }
}
// Application Gateway
variable "appgtw_prefix" {
  type        = string
  default     = "appgtw"
  description = "Prefix of the Application Gateway prefix resource."
}

variable "appgtw_name" {
  description = "(Required) Specifies the name of the Application Gateway."
  type        = string
}

variable "appgtw_rg_name" {
  description = "(Required) The name of the resource group in which to the Application Gateway should exist."
  type        = string
  default     = ""
}

variable "appgtw_location" {
  description = "(Required) The Azure region where the Application Gateway should exist."
  type        = string
  default     = "North Central US"
}

variable "appgtw_sku_size" {
  description = "(Required) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2."
  type        = string
  default     = "Standard_v2"
  validation {
    condition     = contains(["Standard_Small", "Standard_Medium", "Standard_Large", "Standard_v2", "WAF_Medium", "WAF_Large", "WAF_v2"], var.appgtw_sku_size)
    error_message = "The sku size is invalid."
  }
}

variable "appgtw_sku_tier" {
  description = "(Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2."
  type        = string
  default     = "Standard_v2"
  validation {
    condition     = contains(["Standard", "Standard_v2", "WAF", "WAF_v2"], var.appgtw_sku_tier)
    error_message = "The sku tier is invalid."
  }
}

variable "appgtw_sku_capacity" {
  description = "(Required) The Capacity  of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if autoscale_configuration is set."
  type        = string
  default     = "1"
}

variable "waf_config_firewall_mode" {
  description = "(Required) The Web Application Firewall Mode. Possible values are Detection and Prevention."
  type        = string
  default     = "Detection"
  validation {
    condition     = contains(["Detection", "Prevention"], var.waf_config_firewall_mode)
    error_message = "The Web Application Firewall Mode is invalid."
  }
}

variable "waf_config_enable" {
  description = "(Required) Is the Web Application Firewall enabled?"
  type        = bool
  default     = true
}
