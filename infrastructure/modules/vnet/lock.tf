# Lock the resource group
# resource "azurerm_management_lock" "vnet" {
#   name       = "CanNotDelete"
#   scope      = azurerm_resource_group.vnet.id
#   lock_level = "CanNotDelete"
#   notes      = "This resource group can not be deleted - lock set by Terraform"
#   depends_on = [
#     azurerm_resource_group.vnet,
#   ]
# }
