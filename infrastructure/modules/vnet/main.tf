# Create the resource group
resource "azurerm_resource_group" "vnet" {
  name     = lower("${var.rg_prefix}-${var.rg_basename}-${var.environment}")
  location = var.location
  tags     = merge(local.default_tags, var.vnet_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
