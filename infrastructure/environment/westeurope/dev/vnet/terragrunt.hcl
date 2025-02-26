terraform {
  source = "${find_in_parent_folders("modules")}/vnet"
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
  rg_basename                          = "vnet1"
  
  hub_vnet_name                        = "hub"
  hub_vnet_address_space               = ["10.63.0.0/20"]
  hub_gateway_subnet_name              = "gateway"
  hub_gateway_subnet_address_prefixes  = ["10.63.0.0/25"] // HostMin:   10.63.0.1 , HostMax:   10.63.0.126
  hub_bastion_subnet_name              = "AzureBastionSubnet"
  hub_bastion_subnet_address_prefixes  = ["10.63.0.128/28"] //HostMin:   10.63.0.129,HostMax:   10.63.0.142
  appgtw_subnet_name                   = "appgtw"
  appgtw_address_prefixes              = "10.63.1.0/28"
  hub_firewall_subnet_name             = "AzureFirewallSubnet"
  hub_firewall_subnet_address_prefixes = ["10.63.2.0/24"]
  spoke_vnet_name                      = "spoke" //spoke_vnet_name
  spoke_vnet_address_space             = ["10.64.0.0/16"]
  aks_subnet_name                      = "aks1"
  aks_address_prefixes                 = "10.64.4.0/22"
  psql_subnet_name                     = "psql1"
  psql_address_prefixes                = "10.64.2.0/26"
  jumpbox_subnet_name                  = "jumpbox"
  jumpbox_subnet_address_prefix        = ["10.64.3.0/28"]
}

dependency "log-analytics" {
  config_path = "${get_terragrunt_dir()}/../log-analytics"
}

# generate "debug" {
#   path      = "private.debug.txt"
#   if_exists = "overwrite_terragrunt"
#   contents  = jsonencode(include.root)
# }

# resource "null_resource" "terraform-debug" {
#   provisioner "local-exec" {
#     command = "echo $VARIABLE >> private-debug.txt"

#     environment = {
#         VARIABLE = jsonencode(include.root)
#     }
#   }
# }
