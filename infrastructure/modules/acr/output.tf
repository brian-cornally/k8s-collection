// ========================== Azure Container Registry (ACR) ==========================

output "acr_name" {
  description = "Specifies the name of the container registry."
  value       = azurerm_container_registry.acr.name
}

output "acr_id" {
  description = "Specifies the resource id of the container registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_rg_name" {
  description = "Specifies the name of the resource group."
  value       = azurerm_container_registry.acr.resource_group_name
}

output "acr_login_server" {
  description = "Specifies the login server of the container registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_login_server_url" {
  description = "Specifies the login server url of the container registry."
  value       = "https://${azurerm_container_registry.acr.login_server}"
}

output "acr_admin_username" {
  description = "Specifies the admin username of the container registry."
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_sku" {
  description = "The SKU name of the container registry."
  value       = azurerm_container_registry.acr.sku
}
