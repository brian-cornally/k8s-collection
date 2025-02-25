terraform {
  source = "${find_in_parent_folders("modules")}/log-analytics"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
  merge_strategy = "deep"
}

inputs = {
  environment = include.root.locals.environment # "dev"
  location = include.root.locals.az_region # "westeurope"
  rg_basename  = "workspace"
  workspace_name     = "workspace1"
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
