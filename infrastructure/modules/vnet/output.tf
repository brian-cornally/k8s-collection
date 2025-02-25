// ========================== virtual netowrking ==========================
output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_gateway_id" {
  description = "Specifies the resource id of the gateway subnets"
  value       = azurerm_subnet.gateway.id
}
output "subnet_appgtw_id" {
  description = "Specifies the resource id of the appgtw subnets"
  value       = azurerm_subnet.appgtw.id
}
output "subnet_psql_id" {
  description = "Specifies the resource id of the psql subnets"
  value       = azurerm_subnet.psql.id
}
output "subnet_aks_id" {
  description = "Specifies the resource id of the tenantmgmt subnets"
  value       = azurerm_subnet.aks.id
}
