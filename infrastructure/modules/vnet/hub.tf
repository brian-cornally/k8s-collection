# Create hub virtual network (Management vnet)
resource "azurerm_virtual_network" "hub_vnet" {
  name                = lower("${var.vnet_prefix}-${var.hub_vnet_name}-${var.environment}")
  address_space       = var.hub_vnet_address_space
  resource_group_name = azurerm_resource_group.vnet.name
  location            = azurerm_resource_group.vnet.location
  depends_on = [
    azurerm_resource_group.vnet,
  ]
}

//Create hub vnet gateway subnet
resource "azurerm_subnet" "hub_gateway" {
  name                 = var.hub_gateway_subnet_name
  resource_group_name  = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = var.hub_gateway_subnet_address_prefixes
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

// Create hub bastion host subnet
resource "azurerm_subnet" "hub_bastion" {
  name                                          = var.hub_bastion_subnet_name
  resource_group_name                           = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.hub_vnet.name
  address_prefixes                              = var.hub_bastion_subnet_address_prefixes
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

// Create hub application gateway subnet
resource "azurerm_subnet" "appgtw" {
  name                                          = lower("${var.subnet_prefix}-${var.appgtw_subnet_name}")
  resource_group_name                           = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.hub_vnet.name
  address_prefixes                              = [var.appgtw_address_prefixes]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}

// Create hub azure firewall subnet
resource "azurerm_subnet" "firewall" {
  name                                          = var.hub_firewall_subnet_name
  resource_group_name                           = azurerm_virtual_network.hub_vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.hub_vnet.name
  address_prefixes                              = var.hub_firewall_subnet_address_prefixes
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}
