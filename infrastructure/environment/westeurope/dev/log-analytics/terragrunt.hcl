terraform {
  source = "${find_in_parent_folders("modules")}/log-analytics"
}

include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  environment    = include.root.locals.environment # "dev"
  location       = include.root.locals.az_region   # "westeurope"
  rg_basename    = "workspace"
  workspace_name = "workspace1"
}
