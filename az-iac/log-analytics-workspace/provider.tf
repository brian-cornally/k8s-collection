terraform {

  required_version = ">=1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.31.0" //"~>2.0"
    }

    azuread = {
      version = ">= 2.26.0" // https://github.com/terraform-providers/terraform-provider-azuread/releases
    }
  }
}

provider "random" {}

provider "azurerm" {
  features {}
  #   skip_provider_registration = true
  subscription_id = var.sp-subscription-id
  client_id       = var.sp-client-id
  client_secret   = var.sp-client-secret
  tenant_id       = var.sp-tenant-id
}
