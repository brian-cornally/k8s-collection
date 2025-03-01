terraform {
  source = "${find_in_parent_folders("modules")}/log-analytics"
}

include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = true
  merge_strategy = "deep"
}

inputs = {
  # general
  environment    = include.root.locals.environment # "dev"
  location       = include.root.locals.az_region   # "westeurope"

  # direct
  rg_basename    = "workspace"
  workspace_name = "workspace1"
}
