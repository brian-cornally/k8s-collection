# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = lower("${var.rg_prefix}-${var.appgtw_rg_name}-${var.environment}")
  location = var.location
  tags     = merge(local.default_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create public ip address for Application Gateway
resource "azurerm_public_ip" "appgtw_pip" {
  name                = lower("${var.public_ip_prefix}-${var.appgtw_pip_name}-${var.environment}")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku

  tags = merge(local.default_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.rg,
  ]
}
