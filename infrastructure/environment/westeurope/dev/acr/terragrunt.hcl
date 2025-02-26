terraform {
  source = "${find_in_parent_folders("modules")}/acr"
}

include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  environment = include.root.locals.environment # "dev"
  location    = include.root.locals.az_region   # e.g. "westeurope"
  log_analytics_workspace_id           = dependency.log-analytics.outputs.log_analytics_workspace_id
  rg_basename                          = "acr"

  acr_rg_name                         = "acr"
  acr_name                            = "bcacr1dev"
  acr_sku                             = "Basic"
  acr_admin_enabled                   = true
  data_endpoint_enabled               = false
}

dependency "log-analytics" {
  config_path = "${get_terragrunt_dir()}/../log-analytics"
}