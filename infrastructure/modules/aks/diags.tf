# Create Diagnostics Settings for AKS
resource "azurerm_monitor_diagnostic_setting" "diag_aks" {
  name                       = "DiagnosticsSettings"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "guard"
  }

  enabled_log {
    category = "cloud-controller-manager"
  }

  enabled_log {
    category = "csi-azuredisk-controller"
  }

  enabled_log {
    category = "csi-azurefile-controller"
  }

  enabled_log {
    category = "csi-snapshot-controller"
  }

  metric {
    category = "AllMetrics"
  }
}
