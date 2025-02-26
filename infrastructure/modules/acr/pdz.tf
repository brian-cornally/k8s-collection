# Create private DNS zone for Azure container registry - requires Premium
resource "azurerm_private_dns_zone" "pdz_acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.vnet_rg
  tags                = merge(local.default_tags)

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create private virtual network link to Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "acr_pdz_vnet_link" {
  name                  = "privatelink_to_${var.vnet_name}"
  resource_group_name   = var.vnet_rg
  virtual_network_id    = var.vnet_id
  private_dns_zone_name = azurerm_private_dns_zone.pdz_acr.name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_resource_group.rg_acr,
    azurerm_private_dns_zone.pdz_acr
  ]
}

# Create private endpoint for Azure container registry
resource "azurerm_private_endpoint" "pe_acr" {
  name                = lower("${var.private_endpoint_prefix}-${azurerm_container_registry.acr.name}")
  location            = azurerm_container_registry.acr.location
  resource_group_name = azurerm_container_registry.acr.resource_group_name
  subnet_id           = var.subnet_jumpbox_id
  tags                = merge(local.default_tags, var.acr_tags)

  private_service_connection {
    name                           = "pe-${azurerm_container_registry.acr.name}"
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = var.pe_sc_is_manual_connection
    subresource_names              = var.pe_acr_subresource_names
    request_message                = var.pe_sc_is_manual_connection == true ? var.pe_sc_request_message : null
  }

  private_dns_zone_group {
    name                 = "default" //var.pe_acr_private_dns_zone_group_name
    private_dns_zone_ids = [azurerm_private_dns_zone.pdz_acr.id]
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
  depends_on = [
    azurerm_container_registry.acr,
    azurerm_private_dns_zone.pdz_acr
  ]
}
