# Service Principal
variable "sp-subscription-id" {
  description = "Id of the azure subscription where all resources will be created"
  type        = string
}
variable "sp-client-id" {
  description = "Client Id of A Service Principal or Azure Active Directory application registration used for provisioning azure resources."
  type        = string
}
variable "sp-client-secret" {
  description = "Secret of A Service Principal or Azure Active Directory application registration used for provisioning azure resources."
  type        = string
}
variable "sp-tenant-id" {
  description = "Tenant Id of the azure account."
  type        = string
}

# Azure resources
variable "rg_name" {
  description = "Name of the main resource group name for log-analytics-workspace"
  type        = string
}

variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  type        = string
  default     = "westeurope"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "log-analytics-workspace"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}

variable "log_analytics_workspace_rg_name" {
  description = "(Required) Specifies the resource group name of the log analytics workspace"
  type        = string
  default     = "rg-workspace-dev"
}

variable "log_analytics_workspace_name" {
  description = "(Required) Specifies the name of the log analytics workspace"
  type        = string
  default     = "workspace-workspace1-dev"
}

variable "log_analytics_workspace_location" {
  description = "(Required) Specifies the location of the log analytics workspace"
  type        = string
  default     = "westeurope"
}

variable "log_analytics_workspace_sku" {
  description = "(Optional) Specifies the sku of the log analytics workspace"
  type        = string
  default     = "PerGB2018"

  validation {
    condition     = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.log_analytics_workspace_sku)
    error_message = "The log analytics sku is incorrect."
  }
}

variable "solution_plan_map" {
  description = "(Required) Specifies solutions to deploy to log analytics workspace"
  type        = map(any)
  default = {
    ContainerInsights = {
      product = "OMSGallery/ContainerInsights"
      # product   = "OMSGallery/Containers"
      publisher = "Microsoft"
    }
  }
}


variable "log_analytics_retention_days" {
  description = " (Optional) Specifies the workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type        = number
  default     = 30
}

variable "log_analytics_tags" {
  description = "(Optional) Specifies the tags of the log analytics"
  type        = map(any)
  default     = {}
}
