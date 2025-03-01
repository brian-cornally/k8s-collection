terraform {
  source = "${find_in_parent_folders("modules")}/app-gateway"
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
  appgtw_name           = "appgtw1"
  appgtw_sku_size       = "WAF_v2"
  appgtw_sku_tier       = "WAF_v2"
  appgtw_sku_capacity   = 2
  appgtw_pip_name       = "appgtw"
  pip_allocation_method = "Static"
  pip_sku               = "Standard"

  # dependencies
  acr_name                   = dependency.acr.outputs.acr_name
  acr_rg_name                = dependency.acr.outputs.acr_rg_name
  subnet_appgtw_id= dependency.vnet.outputs.subnet_appgtw_id
}

dependency "acr" {
  config_path = "${get_terragrunt_dir()}/../acr"
}

dependency "log-analytics" {
  config_path = "${get_terragrunt_dir()}/../log-analytics"
}

dependency "vnet" {
  config_path = "${get_terragrunt_dir()}/../vnet"
}