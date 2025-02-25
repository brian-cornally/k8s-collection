# Create the resource group
resource "azurerm_resource_group" "this" {
  name     = lower("${var.rg_prefix}-${var.rg_basename}-${var.environment}")
  location = var.location
  tags     = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = lower("${var.workspace_prefix}-${var.workspace_name}-${var.environment}")
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  sku                 = var.workspace_sku
  retention_in_days   = var.retention_days != "" ? var.retention_days : null
  tags                = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.this,
  ]
}

# Create log analytics workspace solution
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution
resource "azurerm_log_analytics_solution" "workspace_solution" {
  for_each              = var.solution_plan_map
  solution_name         = each.key
  resource_group_name   = azurerm_resource_group.this.name
  location              = var.location
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name
  plan {
    # product   = "OMSGallery/ContainerInsights"
    # publisher = "Microsoft"
    product   = each.value.product
    publisher = each.value.publisher
  }
  tags = merge(local.default_tags, var.tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_log_analytics_workspace.this,
  ]
}

# Lock the resource group
# resource "azurerm_management_lock" "rg_workspace_lock" {
#   name       = "CanNotDelete"
#   scope      = azurerm_resource_group.this.id
#   lock_level = "CanNotDelete"
#   notes      = "This resource group can not be deleted - lock set by Terraform"
#   depends_on = [
#     azurerm_resource_group.this,
#     azurerm_log_analytics_workspace.this,
#     azurerm_log_analytics_solution.workspace_solution,
#   ]
# }
