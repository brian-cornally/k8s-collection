terraform {
  source = "${find_in_parent_folders("modules")}/aks"
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
  rg_name                         = "aks"
  cluster_name                        = "cluster1"
  dns_prefix                          = "cluster1-dns"
  private_cluster_enabled             = false
  aks_sku_tier                        = "Free"
  default_node_pool_node_count        = 2
  default_node_pool_vm_size           = "Standard_B4ms"

  # dependencies
  log_analytics_workspace_id = dependency.log-analytics.outputs.log_analytics_workspace_id
  subnet_aks_id = dependency.vnet.outputs.subnet_aks_id
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

# dependency "app-gateway" {
#   config_path = "${get_terragrunt_dir()}/../app-gateway"
# }