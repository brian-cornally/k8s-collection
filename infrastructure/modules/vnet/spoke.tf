# Create spoke virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = lower("${var.vnet_prefix}-${var.spoke_vnet_name}-${var.environment}")
  address_space       = var.spoke_vnet_address_space
  resource_group_name = azurerm_resource_group.vnet.name
  location            = azurerm_resource_group.vnet.location
  depends_on = [
    azurerm_resource_group.vnet,
  ]
}

// gateway subnet
resource "azurerm_subnet" "gateway" {
  name                 = "gateway"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.gateway_address_prefixes]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

// VPN gateway subnet
resource "azurerm_subnet" "vpn_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.gatewaysubnet_address_prefixes]
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

// postgreSQL subnet
resource "azurerm_subnet" "psql" {
  name                                          = lower("${var.subnet_prefix}-${var.psql_subnet_name}")
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = [var.psql_address_prefixes]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

// aks subnet
resource "azurerm_subnet" "aks" {
  name                                          = lower("${var.subnet_prefix}-${var.aks_subnet_name}")
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = [var.aks_address_prefixes]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

// jumpm VM server subnet
resource "azurerm_subnet" "jumpbox" {
  name                                          = lower("${var.subnet_prefix}-${var.jumpbox_subnet_name}")
  resource_group_name                           = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.jumpbox_subnet_address_prefix
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
