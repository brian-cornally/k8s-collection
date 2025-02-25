variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "location" {
  description = "(Required) Specifies the location of the vnet"
  type        = string
  default     = "westeurope"
}

variable "rg_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with name of the resource group."
}

variable "rg_basename" {
  description = "Name of the resource group name for virtual network"
  type        = string
  default     = "rg-vnet1-dev"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "vnet"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}

// =========

variable "vnet_prefix" {
  type        = string
  default     = "vnet"
  description = "Prefix of the vnet name."
}
variable "subnet_prefix" {
  type        = string
  default     = "snet"
  description = "Prefix of the Subnet name."
}

// ========================== virtual networking ==========================

variable "hub_vnet_name" {
  description = "Specifies the name of the hub virtual virtual network"
  default     = "vnet-hub-dev"
  type        = string
}

variable "hub_vnet_address_space" {
  description = "Specifies the address space of the hub virtual virtual network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}


variable "hub_gateway_subnet_name" {
  description = "Specifies the name of the gateway subnet"
  default     = "gateway"
  type        = string
}

variable "hub_gateway_subnet_address_prefixes" {
  description = "Specifies the address prefix of the hub gateway subnet"
  type        = list(string)
}

variable "hub_bastion_subnet_name" {
  description = "Specifies the name of the hub vnet AzureBastion subnet"
  default     = "AzureBastionSubnet"
  type        = string
}
variable "hub_bastion_subnet_address_prefixes" {
  description = "Specifies the address prefix of the hub bastion host subnet"
  type        = list(string)
}

variable "hub_firewall_subnet_name" {
  description = "Specifies the name of the azure firewall subnet"
  type        = string
  default     = "AzureFirewallSubnet"
}

variable "hub_firewall_subnet_address_prefixes" {
  description = "Specifies the address prefix of the azure firewall subnet"
  type        = list(string)
}

variable "spoke_vnet_name" {
  description = "Specifies the name of the spoke virtual virtual network"
  type        = string
  default     = "vnet-spoke-dev"
}

variable "spoke_vnet_address_space" {
  description = "Specifies the address space of the spoke virtual virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "jumpbox_subnet_name" {
  description = "Specifies the name of the jumpbox subnet"
  default     = "snet-jumpbox"
  type        = string
}

variable "jumpbox_subnet_address_prefix" {
  description = "Specifies the address prefix of the jumbox subnet"
  type        = list(string)
}


variable "aks_subnet_name" {}
variable "aks_address_prefixes" {}
variable "appgtw_subnet_name" {}
variable "appgtw_address_prefixes" {}
variable "psql_subnet_name" {}
variable "psql_address_prefixes" {}

variable "vnet_log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}

variable "vnet_tags" {
  description = "(Optional) Specifies the tags of the virtual network"
  type        = map(any)
  default     = {}
}
variable "gateway_address_prefixes" {
  type    = string
  default = "10.64.0.0/26"
}
variable "gatewaysubnet_address_prefixes" {
  type    = string
  default = "10.64.0.128/28"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "log analytics workspace id"
  # default     = "efcaf726-00eb-4ce9-85b8-f57ddbdc8623"
}
