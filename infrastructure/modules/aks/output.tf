// ========================== Azure Kubernetes services (AKS) ==========================
output "aks_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "Specifies the name of the AKS cluster."
}

output "aks_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "Specifies the resource id of the AKS cluster."
}


# output "aks_identity_principal_id" {
#   value       = azurerm_user_assigned_identity.aks_identity.principal_id
#   description = "Specifies the principal id of the managed identity of the AKS cluster."
# }

output "kubelet_identity_object_id" {
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  description = "Specifies the object id of the kubelet identity of the AKS cluster."
}

output "kube_config_raw" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "Contains the Kubernetes config to be used by kubectl and other compatible tools."
}

output "aks_private_fqdn" {
  value       = azurerm_kubernetes_cluster.aks.private_fqdn
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
}

output "aks_node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "Specifies the resource id of the auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
}
