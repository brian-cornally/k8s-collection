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
  description = "Name of the main resource rroup name for project-1"
  type        = string
}

variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  type        = string
  default     = "East US"
}

variable "default_tags" {
  type = map(any)
  default = {
    "Project"   = "Project-1"
    "Owner"     = "me"
    "CreatedBy" = "me"
  }
}
