# variable "debug" {
#   type = string
# }

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "location" {
  description = "(Required) Specifies the location of the log analytics workspace"
  type        = string
  default     = "westeurope"
}

variable "rg_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with name of the resource group."
}

variable "rg_basename" {
  description = "Name of the basename of the resource group name for log-analytics-workspace"
  type        = string
}

variable "workspace_prefix" {
  type        = string
  default     = "workspace"
  description = "Prefix of the log analytics workspace prefix resource."
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "log-analytics-workspace"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}

variable "workspace_name" {
  description = "(Required) Specifies the name of the log analytics workspace"
  type        = string
  default     = "workspace1"
}

variable "workspace_sku" {
  description = "(Optional) Specifies the sku of the log analytics workspace"
  type        = string
  default     = "PerGB2018"

  validation {
    condition     = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.workspace_sku)
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

variable "retention_days" {
  description = " (Optional) Specifies the workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type        = number
  default     = 30
}

variable "tags" {
  description = "(Optional) Specifies the tags of the log analytics"
  type        = map(any)
  default     = {}
}
