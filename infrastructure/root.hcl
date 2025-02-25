locals {
  # account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  az_region   = local.region_vars.locals.az_region
  environment   = local.env_vars.locals.environment
}

remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-tf-dev"
    storage_account_name = "tfbco"
    container_name       = "state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}
EOF
}

# https://github.com/hashicorp/terraform-provider-azuread/releases
# https://github.com/hashicorp/terraform-provider-azurerm/releases
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
generate "provider_version" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.20.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      # version = "~>3.1.0"
    }
  }
}
EOF
}
