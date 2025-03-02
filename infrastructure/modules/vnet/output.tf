// ========================== virtual networking ==========================
output "vnet_rg" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.resource_group_name
}

output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_gateway_id" {
  description = "Specifies the resource id of the gateway subnet"
  value       = azurerm_subnet.gateway.id
}

output "subnet_appgtw_id" {
  description = "Specifies the resource id of the appgtw subnet"
  value       = azurerm_subnet.appgtw.id
}

output "subnet_psql_id" {
  description = "Specifies the resource id of the psql subnet"
  value       = azurerm_subnet.psql.id
}

output "subnet_aks_id" {
  description = "Specifies the resource id of the tenantmgmt subnet"
  value       = azurerm_subnet.aks.id
}

output "subnet_jumpbox_id" {
  description = "Specifies the resource id of the jumpbox subnet"
  value       = azurerm_subnet.jumpbox.id
}
