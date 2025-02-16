terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tf-dev"
    storage_account_name = "tfbco"
    container_name       = "state"
    key                  = "project1-state-"
  }
}
