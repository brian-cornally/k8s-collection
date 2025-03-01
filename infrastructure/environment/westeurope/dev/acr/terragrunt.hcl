terraform {
  source = "${find_in_parent_folders("modules")}/acr"
}

include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  # general
  environment = include.root.locals.environment # "dev"
  location    = include.root.locals.az_region   # e.g. "westeurope"

  # direct
  acr_rg_name           = "acr"
  acr_name              = "bcacr1dev"
  acr_sku               = "Basic" # "Premium" #
  acr_admin_enabled     = true
  data_endpoint_enabled = false

  # dependencies
  log_analytics_workspace_id = dependency.log-analytics.outputs.log_analytics_workspace_id
  vnet_rg                    = dependency.vnet.outputs.vnet_rg
  vnet_id                    = dependency.vnet.outputs.vnet_id
  vnet_name                  = dependency.vnet.outputs.vnet_name
  subnet_jumpbox_id          = dependency.vnet.outputs.subnet_jumpbox_id
}

dependency "log-analytics" {
  config_path = "${get_terragrunt_dir()}/../log-analytics"
}

dependency "vnet" {
  config_path = "${get_terragrunt_dir()}/../vnet"
}