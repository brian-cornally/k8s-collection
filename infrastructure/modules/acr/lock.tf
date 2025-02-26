# # Lock the resource group
# resource "azurerm_management_lock" "rg_acr" {
#   name       = "CanNotDelete"
#   scope      = azurerm_resource_group.rg_acr.id
#   lock_level = "CanNotDelete"
#   notes      = "This resource group can not be deleted - lock set by Terraform"
#   depends_on = [
#     azurerm_resource_group.rg_acr,
#     azurerm_monitor_diagnostic_setting.diag_acr,
#   ]
# }
