# Create the resource group
resource "azurerm_resource_group" "rg_acr" {
  name     = lower("${var.rg_prefix}-${var.acr_rg_name}-${var.environment}")
  location = var.acr_location
  tags     = merge(local.default_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create ACR user assigned identity
resource "azurerm_user_assigned_identity" "acr_identity" {
  resource_group_name = azurerm_resource_group.rg_acr.name
  location            = azurerm_resource_group.rg_acr.location
  tags                = merge(local.default_tags, var.acr_tags)

  name = "${var.acr_name}Identity"
  depends_on = [
    azurerm_resource_group.rg_acr,
  ]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create the Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg_acr.name
  location            = azurerm_resource_group.rg_acr.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
  # zone_redundancy_enabled = true
  data_endpoint_enabled = var.data_endpoint_enabled
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.acr_identity.id
    ]
  }

  # dynamic "georeplications" {
  #   for_each = var.acr_georeplication_locations

  #   content {
  #     location = georeplications.value
  #     tags     = merge(local.default_tags, var.acr_tags)
  #   }
  # }
  tags = merge(local.default_tags, var.acr_tags)
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.rg_acr
  ]
}

# create Diagnostics Settings for ACR
resource "azurerm_monitor_diagnostic_setting" "diag_acr" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
  }

  enabled_log {
    category = "ContainerRegistryLoginEvents"
  }

  metric {
    category = "AllMetrics"
  }
}
