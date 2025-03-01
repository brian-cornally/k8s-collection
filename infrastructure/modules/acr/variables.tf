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

variable "log_analytics_workspace_id" {
  type        = string
  description = "log analytics workspace id"
  # default     = "efcaf726-00eb-4ce9-85b8-f57ddbdc8623"
}

variable "vnet_rg" {
  type        = string
  description = "vnet resource group name"
}

variable "vnet_id" {
  type        = string
  description = "vnet id"
}

variable "vnet_name" {
  type        = string
  description = "vnet name"
}

variable "subnet_jumpbox_id" {
  description = "jumpbox subnet id"
  type        = string
}

// ========================== Azure Container Registry (ACR) ==========================

variable "acr_prefix" {
  type        = string
  default     = "acr"
  description = "Prefix of the Azure Container Registry (ACR) name that's combined with name of the ACR"
}

variable "acr_name" {
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
  type        = string
}

variable "acr_rg_name" {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
  type        = string
}

variable "acr_location" {
  description = "Location in which to deploy the Container Registry"
  type        = string
  default     = "West Europe"
}

variable "acr_admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  type        = string
  default     = false
}

variable "acr_sku" {
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "The container registry sku is invalid."
  }
}
variable "acr_georeplication_locations" {
  description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = ["orth Europe", "West Europe"]
}

variable "acr_log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 7
}
variable "acr_tags" {
  description = "(Optional) Specifies the tags of the ACR"
  type        = map(any)
  default     = {}
}

variable "data_endpoint_enabled" {
  description = "(Optional) Whether to enable dedicated data endpoints for this Container Registry? Defaults to false. This is only supported on resources with the Premium SKU."
  default     = true
  type        = bool
}

variable "pe_acr_subresource_names" {
  description = "(Optional) Specifies a subresource names which the Private Endpoint is able to connect to ACR."
  type        = list(string)
  default     = ["registry"]
}

variable "private_endpoint_prefix" {
  description = "(Optional) private endpoint prefix"
  type        = string
  default     = "pe"
}

variable "pe_sc_request_message" {
  description = "(Optional) private endpoint service connection - request message"
  type        = string
  default     = "pe_sc"
}

variable "pe_sc_is_manual_connection" {
  description = "(Optional) private endpoint service connection - is_manual_connection"
  type        = bool
  default     = false
}
