# Create Diagnostic Settings for Application Gateway
resource "azurerm_monitor_diagnostic_setting" "diag_apptw" {
  name                       = azurerm_application_gateway.appgtw.name
  target_resource_id         = azurerm_application_gateway.appgtw.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
  # dynamic "log" {
  #   for_each = local.diag_appgtw_logs
  #   content {
  #     category = log.value

  #     retention_policy {
  #       enabled = false
  #     }
  #   }
  # }

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }

  enabled_log {
    category = "ApplicationGatewayFirewallLog"
  }

  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }

  # dynamic "metric" {
  #   for_each = local.diag_appgtw_metrics
  #   content {
  #     category = metric.value

  #     retention_policy {
  #       enabled = false
  #     }
  #   }
  # }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}
